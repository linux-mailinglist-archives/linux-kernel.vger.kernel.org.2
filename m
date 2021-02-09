Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64683314E9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBIMDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:03:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:41712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhBIMBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:01:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38780AF2B;
        Tue,  9 Feb 2021 12:00:51 +0000 (UTC)
Subject: Re: [PATCH v4 3/3] vsprintf: dump full information of page flags in
 pGp
To:     Yafang Shao <laoar.shao@gmail.com>, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210209105613.42747-1-laoar.shao@gmail.com>
 <20210209105613.42747-4-laoar.shao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0393a2c1-6cc6-418a-9548-572620eb9098@suse.cz>
Date:   Tue, 9 Feb 2021 13:00:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209105613.42747-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 11:56 AM, Yafang Shao wrote:
> Currently the pGp only shows the names of page flags, rather than
> the full information including section, node, zone, last cpupid and
> kasan tag. While it is not easy to parse these information manually
> because there're so many flavors. Let's interpret them in pGp as well.
> 
> To be compitable with the existed format of pGp, the new introduced ones
> also use '|' as the separator, then the user tools parsing pGp won't
> need to make change, suggested by Matthew. The new information is
> tracked onto the end of the existed one.
> 
> On example of the output in mm/slub.c as follows,
> - Before the patch,
> [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> 
> - After the patch,
> [ 8838.835456] Slab 0x000000002828b78a objects=33 used=3 fp=0x00000000d04efc88 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> 
> The documentation and test cases are also updated. The output of the
> test cases as follows,
> [  501.485081] test_printf: loaded.
> [  501.485768] test_printf: all 388 tests passed
> [  501.488762] test_printf: unloaded.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

The 'pfl' array should be even useful in kernel crash dump tools!

