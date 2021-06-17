Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD73AB0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhFQKCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:02:47 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:31354 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhFQKCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:02:44 -0400
Received: from [0.0.0.0] (unknown [116.24.57.254])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id CB342E02BA;
        Thu, 17 Jun 2021 18:00:30 +0800 (CST)
Subject: Re: [PATCH v1 6/6] mm/hwpoison: fix unpoison_memory()
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
 <20210614021212.223326-7-nao.horiguchi@gmail.com>
From:   Ding Hui <dinghui@sangfor.com.cn>
Message-ID: <94984984-f123-85ae-20bc-b40e90d536f6@sangfor.com.cn>
Date:   Thu, 17 Jun 2021 18:00:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614021212.223326-7-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0gZHVZCT0hCSR0fSBpDSRhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NE06ASo4HD8KAUwYAg9OMCpL
        ShAwCRJVSlVKTUlIQklPS0hKT0xKVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSk1VSU9VTkxVSU5PWVdZCAFZQUhCSUg3Bg++
X-HM-Tid: 0a7a196a3ece2c17kusncb342e02ba
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/14 10:12, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> After recent soft-offline rework, error pages can be taken off from
> buddy allocator, but the existing unpoison_memory() does not properly
> undo the operation.  Moreover, due to the recent change on
> __get_hwpoison_page(), get_page_unless_zero() is hardly called for
> hwpoisoned pages.  So __get_hwpoison_page() mostly returns zero (meaning
> to fail to grab page refcount) and unpoison just clears PG_hwpoison
> without releasing a refcount.  That does not lead to a critical issue
> like kernel panic, but unpoisoned pages never get back to buddy (leaked
> permanently), which is not good.

As I mention in [1], I'm not sure about the exactly meaning of "broken" 
in unpoison_memory().

Maybe the misunderstanding is:

I think __get_hwpoison_page() mostly returns one for hwpoisoned page.
In 06be6ff3d2ec ("mm,hwpoison: rework soft offline for free pages"), 
page_handle_poison() is introduced, it will add refcount for all 
soft-offlineed hwpoison page.
In memory_failure() for hard-offline，page_ref_inc() called on free page 
too, and for used page, we do not call put_page() after 
get_hwpoison_page() != 0.
So all hwpoisoned page refcount must be great than zero when 
unpoison_memory() if regardless of racy.

Recently I tested loop soft-offline random pages and unpoison them for 
days, it works fine to me. (with bac9c6fa1f92 patched)

[1]: 
https://lore.kernel.org/lkml/6af291a0-41fa-8112-5297-6a4cdf2337b6@sangfor.com.cn/

> 
> To fix this, we need to identify "taken off" pages from other types of
> hwpoisoned pages.  We can't use refcount or page flags for this purpose,
> so a pseudo flag is defined by hacking ->private field.
> 
> Sometimes hwpoisoned pages can be still in-use, where the refcount should
> be more than 1, so we can't unpoison them immediately and need to wait
> until the all users release their refcount.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---


-- 
Thanks,
- Ding Hui
