Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9DA310DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhBEO66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:58:58 -0500
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:46778 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232892AbhBEO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:56:04 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id E931418037BD4
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:07:16 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id F32E518020C47;
        Fri,  5 Feb 2021 14:07:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2892:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7514:7652:7875:7903:7974:10004:10400:10848:10904:10967:11232:11658:11914:12043:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:13869:14096:14097:14181:14659:14721:21080:21324:21325:21611:21627:21740:21773:21939:30005:30034:30054:30056:30060:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: color19_270d317275e5
X-Filterd-Recvd-Size: 3084
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri,  5 Feb 2021 14:06:59 +0000 (UTC)
Message-ID: <565bfe3cd09197903ae07a87aadd94d1117d4106.camel@perches.com>
Subject: Re: Small student project idea on appropriate integration trees in
 MAINTAINERS
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     devel@lists.elisa.tech,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        =?UTF-8?Q?Ba=C5=9Fak?= Erdamar <basakerdamar@gmail.com>
Date:   Fri, 05 Feb 2021 06:06:57 -0800
In-Reply-To: <CAKXUXMxxz7Lffre67uYKzuoXgcMXwv_36Od0UCwX50RPc9DkTg@mail.gmail.com>
References: <CAKXUXMyRAer=0S9pxiRs2iF3pdkU8zW=JZw2a+nJJ30iPLPhCA@mail.gmail.com>
         <20210128165447.3da0d98e@lwn.net>
         <CAKXUXMxxz7Lffre67uYKzuoXgcMXwv_36Od0UCwX50RPc9DkTg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-02-05 at 07:42 +0100, Lukas Bulwahn wrote:
> On Fri, Jan 29, 2021 at 12:54 AM Jonathan Corbet <corbet@lwn.net> wrote:
> > 
> > On Fri, 22 Jan 2021 09:22:24 +0100
> > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > 
> > > In this project, we can make use of:
> > > 
> > > - gitdm [git://git.lwn.net/gitdm.git]: gitdm includes some scripts to
> > > parse MAINTAINERS and obtain the integration tree patch of a commit.
> > 
> > Look also at the 'treeplot' tool there, which determines which tree(s)
> > each patch went through and makes pretty (OK, not hugely pretty) pictures
> > from the result.
> 
> Thanks, we are well aware, and that is a good reminder for Basak and
> me to get our gitdm treeplot patches in shape for proper submission.
> 
> > 
> > I suspect you'll find that the tree information is mostly correct.
> 
> Your suspicion, which is counter to my hypothesis, makes this
> investigation worthwhile just to see how correct that information
> really is.

I suspect the specific development trees listed in each MAINTAINERS
subsystems is mostly useless information.

Just like the number of subsystems listed and their nominal maintainers
is more vanity than actual.  MAINTAINER subsystems may be active for
a small window of time when submitted, but these mostly driver entries
are quickly aged out as the typically driver is completed.

The 80:20 rule when applied to MAINTAINERS I suspect is more like 90:10.

> > Developers need to know that to be able to base their patches properly; an
> > incorrect entry would lead to a certain amount of maintainer misery.

The -next integration tree works relatively well as the basis for
development.  If a patch doesn't apply, it's typically fairly easy
to rebase it in the rare occasion it doesn't apply to a particular
active tree.


