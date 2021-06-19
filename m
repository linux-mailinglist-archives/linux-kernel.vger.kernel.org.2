Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F343AD9F8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 14:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhFSMZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 08:25:54 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:46848 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbhFSMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 08:25:53 -0400
Received: from 2CD-RMPB.local (unknown [113.118.120.96])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id DEC93E01C3;
        Sat, 19 Jun 2021 20:23:36 +0800 (CST)
Subject: Re: [PATCH v1 6/6] mm/hwpoison: fix unpoison_memory()
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
 <20210614021212.223326-7-nao.horiguchi@gmail.com>
 <94984984-f123-85ae-20bc-b40e90d536f6@sangfor.com.cn>
 <20210618083625.GA2215283@hori.linux.bs1.fc.nec.co.jp>
From:   Ding Hui <dinghui@sangfor.com.cn>
Message-ID: <a2162c28-78ce-1ce7-327c-e8c4dce164cd@sangfor.com.cn>
Date:   Sat, 19 Jun 2021 20:22:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210618083625.GA2215283@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGhpJS1ZCH0xMHU4fSUpDS09VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBA6GBw5ST9DUTpKPyk6ODpW
        HigaCi9VSlVKTUlPSktOT0pMTkhCVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSkhVSkpDVUpJS1VCTVlXWQgBWUFPQ01PNwY+
X-HM-Tid: 0a7a2439fa1f2c17kusndec93e01c3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/18 4:36 下午, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Jun 17, 2021 at 06:00:21PM +0800, Ding Hui wrote:
>> On 2021/6/14 10:12, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> After recent soft-offline rework, error pages can be taken off from
>>> buddy allocator, but the existing unpoison_memory() does not properly
>>> undo the operation.  Moreover, due to the recent change on
>>> __get_hwpoison_page(), get_page_unless_zero() is hardly called for
>>> hwpoisoned pages.  So __get_hwpoison_page() mostly returns zero (meaning
>>> to fail to grab page refcount) and unpoison just clears PG_hwpoison
>>> without releasing a refcount.  That does not lead to a critical issue
>>> like kernel panic, but unpoisoned pages never get back to buddy (leaked
>>> permanently), which is not good.
>>
>> As I mention in [1], I'm not sure about the exactly meaning of "broken" in
>> unpoison_memory().
>>
>> Maybe the misunderstanding is:
>>
>> I think __get_hwpoison_page() mostly returns one for hwpoisoned page.
>> In 06be6ff3d2ec ("mm,hwpoison: rework soft offline for free pages"),
>> page_handle_poison() is introduced, it will add refcount for all
>> soft-offlineed hwpoison page.
>> In memory_failure() for hard-offline，page_ref_inc() called on free page
>> too, and for used page, we do not call put_page() after get_hwpoison_page()
>> != 0.
>> So all hwpoisoned page refcount must be great than zero when
>> unpoison_memory() if regardless of racy.
> 
> Hi, Ding,
> 
> Thanks for the comment.  I feel that I failed to define the exact issue in
> unpoison.  Maybe I saw and misinterpreted some random error as unpoison's
> issue during developing other hwpoison patches, so please don't take serious
> my previous wrong word "broken", sorry about that.
> 
> Anyway I reconsider how to handle this 6/6, maybe it will be a clear
> description of the problem, and will be simplified.
> 
>>
>> Recently I tested loop soft-offline random pages and unpoison them for days,
>> it works fine to me. (with bac9c6fa1f92 patched)
> 
> Thank you for testing,
> 

Hi Naoya,

I'm afraid of my description about testing is ambiguous for others, let 
me clarify that I ran stress soft-offline test case from mce-test 
project (https://git.kernel.org/pub/scm/utils/cpu/mce/mce-test.git) for 
days to verify my modify about NR_FREE_PAGES (bac9c6fa1f92), without 
your current patchset, the case is loop soft-offline random pages and 
unpoison them, and it works basic fine to me.

-- 
Thanks,
-dinghui
