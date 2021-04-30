Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEBC36F5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 08:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhD3GsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 02:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhD3GsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 02:48:07 -0400
X-Greylist: delayed 528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Apr 2021 23:47:18 PDT
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E0CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 23:46:55 -0700 (PDT)
Received: from iva6-6951b41b66a9.qloud-c.yandex.net (iva6-6951b41b66a9.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:610b:0:640:6951:b41b])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 300FD6742186;
        Fri, 30 Apr 2021 09:38:03 +0300 (MSK)
Received: from iva7-f62245f79210.qloud-c.yandex.net (iva7-f62245f79210.qloud-c.yandex.net [2a02:6b8:c0c:2e83:0:640:f622:45f7])
        by iva6-6951b41b66a9.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 5N2zMeQbUu-c0JekTBT;
        Fri, 30 Apr 2021 09:38:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1619764683;
        bh=OSUWNyoDwSwSlzocc2rtb85rgBPEIJvV7CLDYga9B8g=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=VhdTpXInNPf84/gSeTMBd4JRaOujt6TrG9MVNvWn5bdA/lyjvde5vnCBWeUcH1DLi
         fnZPpqT+/ILh6zSFsr7t7gpoWIr1tGWrNYhwQo+urhbdPsrDwaDjJvttoLTObrUk03
         8+MgeZw0uZRNZqxoV61Szyi0CNauM9L5/xP5X1uY=
Authentication-Results: iva6-6951b41b66a9.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva7-f62245f79210.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 3WbXfJvglC-bwL0109t;
        Fri, 30 Apr 2021 09:37:59 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <8ce5be3df2137e975d7333024b6120b71b214617.camel@yandex.ru>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org
Cc:     Alex Shi <alexs@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        page-reclaim@google.com
Date:   Fri, 30 Apr 2021 09:37:58 +0300
In-Reply-To: <140226722f2032c86301fbd326d91baefe3d7d23.camel@yandex.ru>
References: <20210413065633.2782273-1-yuzhao@google.com>
         <140226722f2032c86301fbd326d91baefe3d7d23.camel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, I noticed a fun thing, an improvement. I don't know yet if it can be
attributed to 5.12 (which I didn't try alone yet) or to the LRU patchset, but
I'd assume the latter, because 5.12 seems didn't to have had anything
interesting regarding memory performance¹.

I usually have Skype running in background for work purposes, which is only used
2-3 times in a week. So one would expect it to be one the first victims to
memory reclaim. Unfortunately, I never seen this to actually happen (till now,
that is): all skypeforlinux processes routinely have 0 bytes in SWAP, and the
only circumstances under which its processes can get into SWAP is after
experiencing many SWAP-storms. It was so hard for the kernel to move these
unused processes to SWAP that at some point I even tried to research if there
are any odd flags a userspace may have set on a process to keep it in RAM, just
in case that's what happens to Skype (A: no, that wasn't the case, running Skype
in a memory limited cgroup makes it swap. It's just that kernel decision were
lacking for some reason).

So, anyway, I am delighted to see now that while testing this patchset, and
without encountering even a single SWAP-storm yet, skypeforlinux are one of the
processes residing in SWAP!!

     λ smem -kc "name user pid pss swap" | grep skype    
    skypeforlinux            constantine  1151    60.0K     7.5M 
    skypeforlinux            constantine  1215   195.0K     8.1M 
    skypeforlinux            constantine  1149   706.0K     7.5M 
    skypeforlinux            constantine  1148   743.0K     7.3M 
    skypeforlinux            constantine  1307     1.4M     8.0M 
    skypeforlinux            constantine  1213     2.1M    46.1M 
    skypeforlinux            constantine  1206    14.0M    10.8M 
    skypeforlinux            constantine   818    38.5M    34.3M 
    skypeforlinux            constantine  1242   103.2M    46.8M 

!!!

1: https://kernelnewbies.org/Linux_5.12#Memory_management

On Fri, 2021-04-30 at 02:46 +0300, Konstantin Kharlamov wrote:
> In case you need it yet, this series is:
> 
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> 
> My success story: I have Archlinux with 8G RAM + zswap + swap. While developing,
> I have lots of apps opened such as multiple LSP-servers for different langs,
> chats, two browsers, etc… Usually, my system gets quickly to a point of SWAP-
> storms, where I have to kill LSP-servers, restart browsers to free memory, etc,
> otherwise the system lags heavily and is barely usable.
> 
> 1.5 day ago I migrated from 5.11.15 kernel to 5.12 + the LRU patchset, and I
> started up by opening lots of apps to create memory pressure, and worked for a
> day like this. Till now I had *not a single SWAP-storm*, and mind you I got 3.4G
> in SWAP. I was never getting to the point of 3G in SWAP before without a single
> SWAP-storm.
> 
> Right now my gf on Fedora 33 also suffers from SWAP-storms on her old Macbook
> 2013 with 4G RAM + zswap + swap, I think the next week I'll build for her 5.12 +
> LRU patchset as well. Will see how it goes, I expect it will improve her
> experience by a lot too.
> 
> P.S.: upon replying please keep me CCed, I'm not subscribed to the list

