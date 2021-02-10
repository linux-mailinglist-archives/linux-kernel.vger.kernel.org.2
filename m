Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC61316777
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBJNGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:06:52 -0500
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:43534 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231765AbhBJNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:04:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CD91318023912;
        Wed, 10 Feb 2021 13:04:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2525:2553:2560:2563:2682:2685:2691:2692:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6742:7652:7903:7904:9025:10004:10400:10848:11232:11658:11914:12043:12297:12438:12663:12740:12895:13069:13311:13357:13439:13894:14096:14097:14181:14659:14721:21080:21611:21627:21990:30012:30054:30070:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: fish41_140b27927610
X-Filterd-Recvd-Size: 2507
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Feb 2021 13:04:08 +0000 (UTC)
Message-ID: <5e1e5415dc1bcda37df3ce07a18827172c2a5b7f.camel@perches.com>
Subject: Re: [PATCH v4 3/3] vsprintf: dump full information of page flags in
 pGp
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>, Yafang Shao <laoar.shao@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Feb 2021 05:04:07 -0800
In-Reply-To: <YCPWypWctDMGWUpA@alley>
References: <20210209105613.42747-1-laoar.shao@gmail.com>
         <20210209105613.42747-4-laoar.shao@gmail.com> <YCKT8WCPGU+HBY91@alley>
         <CALOAHbBO6gXzbXjnH_EPsk4v-AdEQNhwNez7mbM6oTaut1pokw@mail.gmail.com>
         <YCPWypWctDMGWUpA@alley>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-10 at 13:51 +0100, Petr Mladek wrote:
> On Wed 2021-02-10 00:21:37, Yafang Shao wrote:
> > On Tue, Feb 9, 2021 at 9:53 PM Petr Mladek <pmladek@suse.com> wrote:
[]
> >  for (p = pff; p < pff + ARRAY_SIZE(pff); p++) {
> 
> This looks a bit non-standard. IMHO, Joe was not against using index.
> He proposed:
> 
> 	for (i = 0; i < ARRAY_SIZE(pfl) && buf < end; i++) {
> 
> , see
> https://lore.kernel.org/lkml/e5ea9e8b1190c2a397a1b84dd55bb9c706dc7058.camel@perches.com/
> 
> I am not sure about the (buf < end) check. It might be some
> optimization or it did fit the the old code.

I believe the buf < end bit was broken anyway.

I believe vsprintf is supposed to return the maximum possible length
of the output and the function should not restrict that.  The
function should not write beyond the specified end.
 
> Anyway, I like the currently used:
> 
> 	for (i = 0; i < ARRAY_SIZE(pff); i++) {
> 
> It is standard, easy to understand, and thus more safe. I am sure that
> compiler will optimize it very well.

true.


