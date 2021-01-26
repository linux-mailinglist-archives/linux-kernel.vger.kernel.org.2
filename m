Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD00D305C90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhA0NJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:09:55 -0500
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:36404 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S313748AbhAZWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:45:06 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 50796100E7B43;
        Tue, 26 Jan 2021 22:44:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:981:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2560:2563:2682:2685:2693:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:6120:7652:7901:7903:9010:9025:10004:10400:10848:11232:11658:11783:11914:12043:12297:12740:12895:12903:13069:13138:13231:13311:13357:13439:13894:14181:14659:14721:21063:21080:21433:21451:21627:21795:21939:30034:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:87,LUA_SUMMARY:none
X-HE-Tag: dolls97_4f0dac027592
X-Filterd-Recvd-Size: 2959
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 Jan 2021 22:44:21 +0000 (UTC)
Message-ID: <e5fcdc9ff8b165ed142340135e2124d013b79ac9.camel@perches.com>
Subject: Re: [PATCH RFC 1/3] checkpatch: add verbose mode
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Jan 2021 14:44:20 -0800
In-Reply-To: <CABJPP5Ap2=-suEZv+6OVONBPZjLEJEszG=O5ikDxHPiCcBRbFA@mail.gmail.com>
References: <20210126183521.26535-1-dwaipayanray1@gmail.com>
         <20210126183521.26535-2-dwaipayanray1@gmail.com>
         <9bfc9c21d93bb55419954114ed3a7e5cbdc84ddb.camel@perches.com>
         <CABJPP5Ap2=-suEZv+6OVONBPZjLEJEszG=O5ikDxHPiCcBRbFA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-27 at 01:57 +0530, Dwaipayan Ray wrote:
> On Wed, Jan 27, 2021 at 1:41 AM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2021-01-27 at 00:05 +0530, Dwaipayan Ray wrote:
> > > Add a new verbose mode to checkpatch.pl to emit additional verbose
> > > test descriptions.
> > > 
> > > The verbose mode is optional and can be enabled by the flag
> > > --verbose.
[]
> > > Documentation/dev-tools/checkpatch.rst:
> > > 
> > > .. CHECKPATCH_START
> > 
> > Nak on the keyword uses.
> > 
> > This should really just parse the input file whenever TYPE is found
> > via some fixed format and save the verbose description after that.
> > 
> > Use .rst Field Lists instead, and ideally, keep the list in alphabetic
> > order or group by similar use.
> > 
> > https://docutils.sourceforge.io/docs/user/rst/quickref.html#field-lists
> > 
> > e.g.:
> > 
> > :LINE_SPACING:
> >         Vertical space is wasted given the limited number of lines an
> >         editor window can display when multiple blank lines are used.
> > 
> > :SPACING:
> >         Whitespace style used in the kernel sources is described in
> >         ref:`Documentation/process/Coding-Style.rst section 3.1.
> > 
> > :TRAILING_WHITESPACE:
> >         Trailing whitespace should always be removed.
> >         Some editors highlight the trailing whitespace and cause visual
> >         distractions when editing files.
> > 
> > etc...
[]
> for the output part can we do something to make the text
> look a bit more nice? I think some of the verbose descriptions
> can go a bit long.

Which is why verbose should be optional.

> Also will the verbose descriptions be limited to say single
> paragraphs?

Ideally, no.

> If there are multiple paragraphs then the output
> does appear a bit messy.

I fail to see how that's a problem but play with it and see what
you can do.


