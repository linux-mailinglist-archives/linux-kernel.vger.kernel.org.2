Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02229326193
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhBZKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:51:01 -0500
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:33516 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230223AbhBZKu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:50:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 05A37AF8C;
        Fri, 26 Feb 2021 10:50:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2693:2731:2828:2895:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:7514:7652:7903:7974:9040:10004:10400:10450:10455:10848:10967:11232:11658:11914:12043:12297:12663:12679:12740:12895:13200:13229:13439:13894:14096:14097:14181:14659:14721:19904:19999:21080:21094:21323:21325:21433:21451:21611:21627:21740:21939:30054:30062:30069:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: dime75_4c077ac27699
X-Filterd-Recvd-Size: 3638
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 26 Feb 2021 10:50:15 +0000 (UTC)
Message-ID: <a0f05bbd5880a7d498af21c5013fa5895d6e3ca7.camel@perches.com>
Subject: Re: [PATCH v7 0/2] checkpatch: add verbose mode
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Feb 2021 02:50:14 -0800
In-Reply-To: <20210225215501.2408c97b@coco.lan>
References: <20210222075205.19834-1-dwaipayanray1@gmail.com>
         <bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com>
         <CABJPP5AARO3h2mt-piPWuOD3kY_XzNfW-s2mi=btfOayVPURHg@mail.gmail.com>
         <20210225215501.2408c97b@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-02-25 at 21:55 +0100, Mauro Carvalho Chehab wrote:
> Em Thu, 25 Feb 2021 23:38:03 +0530
> Dwaipayan Ray <dwaipayanray1@gmail.com> escreveu:
> 
> > On Thu, Feb 25, 2021 at 11:03 PM Joe Perches <joe@perches.com> wrote:
> > > 
> > > On Mon, 2021-02-22 at 13:22 +0530, Dwaipayan Ray wrote:  
> > > > Add a new verbose mode to checkpatch. The verbose test
> > > > descriptions are read from the checkpatch documentation
> > > > file at `Documentation/dev-tools/checkpatch.rst`.
> > > > 
> > > > The verbose mode is optional and can be enabled by the
> > > > flag -v or --verbose.
> > > > 
> > > > The documentation file is only parsed by checkpatch.pl
> > > > if the verbose mode is enabled. The verbose mode can
> > > > not be used together with the --terse option.  
> > > 
> > > I don't have any real objection to this patch set, but as this
> > > might be added to the Documentation tree and in .rst format,
> > > perhaps Jonathan Corbet and/or Mauro Carvalho Chehab might have
> > > some opinion.
> > > 
> > > Also I do not want to be a maintainer of this .rst file and
> > > likely neither Jon nor Mauro would either.  Perhaps you?
> > >  
> > > 
> > 
> > I could take it up if everybody is okay with it!
> > 
> > > Ideally, the patch order would be reversed so the .rst file
> > > is added first, then checkpatch updated to use it.
> > >  
> > > 
> > 
> > Sure, if Jonathan or Mauro has no objections to it, I will be happy
> > to resend it so that it can be picked up properly.
> 
> I don't have any objections, provided that I won't be maintaining
> it :-)
> 
> -
> 
> Just my two cents:
> 
> IMO, maintaining this on a separate file can be a maintenance nightmare, 
> as this is the kind of thing that can become obsolete real soon.
> 
> One alternative would be to use Pod::Usage module, just like
> this script does:
> 
> 	scripts/get_abi.pl
> 
> with something similar to that, calling
> 
> 	$ checkpatch --man 
> 
> Could generate a man-page style with all options, while:
> 
> 	$ checkpatch --help
> 
> would print the current help page.
> 
> Yet, this would generate more work for Joe, as, for every new
> type, the corresponding help text would be needed.

Does this get integrated into the .rst output?

I see:
Documentation/Makefile:$(shell $(srctree)/scripts/get_abi.pl validate --dir $(srctree)/Documentation/ABI)

But no obvious mechanism that emits .rst files for Pod::Usage

And no, I'm not much interested in maintaining those docs either.


