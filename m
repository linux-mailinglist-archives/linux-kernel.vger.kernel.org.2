Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F630AFC8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhBASvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:51:53 -0500
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:48556 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231226AbhBASvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:51:49 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B7187182CF668;
        Mon,  1 Feb 2021 18:51:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2198:2199:2393:2553:2559:2562:2693:2828:2899:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3874:4321:4605:5007:6119:6742:7652:7875:8660:10004:10400:10450:10455:10848:11232:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13148:13230:13311:13357:13439:14659:14721:19904:19999:21080:21451:21524:21611:21627:21939:30012:30030:30054:30056:30070:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: star51_2611fb9275c4
X-Filterd-Recvd-Size: 2725
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon,  1 Feb 2021 18:51:05 +0000 (UTC)
Message-ID: <9c475803276ea2b32cadc8f72d397c180475d0cc.camel@perches.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in
 pGp
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Yafang Shao <laoar.shao@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, linmiaohe@huawei.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 01 Feb 2021 10:51:03 -0800
In-Reply-To: <20210201141505.GR308988@casper.infradead.org>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
         <20210201115610.87808-4-laoar.shao@gmail.com>
         <20210201141505.GR308988@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-02-01 at 14:15 +0000, Matthew Wilcox wrote:
> On Mon, Feb 01, 2021 at 07:56:10PM +0800, Yafang Shao wrote:
> > - Before the patch,
> > [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> > 
> > - After the patch,
> > [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)
> 
> I would suggest it will be easier to parse as:
> 
> flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> 
> That should alleviate the concerns about debugfs format change -- we've
> never guaranteed that flag names won't change, and they now look enough
> like flags that parsers shouldn't fall over them.

Seems sensible and would make the generating code simpler too.

But is it worth the vsprintf code expansion for the 5 current uses?

mm/debug.c:     pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
mm/memory-failure.c:                    pr_info("soft offline: %#lx: %s migration failed %d, type %lx (%pGp)\n",
mm/memory-failure.c:            pr_info("soft offline: %#lx: %s isolation failed, page count %d, type %lx (%pGp)\n",
mm/memory-failure.c:            pr_info("%s: %#lx: unknown page type: %lx (%pGp)\n",
mm/page_owner.c:                        "PFN %lu type %s Block %lu type %s Flags %#lx(%pGp)\n",

Wouldn't it be more sensible just to put this code in a new function
call in mm?


