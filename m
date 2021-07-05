Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B03BB47E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 02:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhGEAVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 20:21:06 -0400
Received: from mailout-l3b-97.contactoffice.com ([212.3.242.97]:52976 "EHLO
        mailout-l3b-97.contactoffice.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhGEAVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 20:21:04 -0400
Received: from ichabod.co-bxl (ichabod.co-bxl [10.2.0.36])
        by mailout-l3b-97.contactoffice.com (Postfix) with ESMTP id B37D84E1;
        Mon,  5 Jul 2021 02:18:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1625444306;
        s=20210208-e7xh; d=mailfence.com; i=broake@mailfence.com;
        h=Date:From:Reply-To:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=3120; bh=Ax4QNYN5tvR1uoK8sl7hlTj/tl8LWQZAiUC+UV2BG+w=;
        b=JS+Ad924Bu1iNzmLQm7oZUUsbe+ph7nIEd60TdBVTIPdBASvqB/NKoNNjOD4jCeg
        tDwnIlgtiDsrPmPHD+Pu5Ie+bOO1phVfvYQ4B+afA/2Uk/s/EcXGg9Mo3WYesq9gHAt
        haLgrcD3qukn3tavMEcoVhzIaq9awOotLPoU9X19YP/IvoIdxWTTmmjGVFP9Fzl4DPW
        gaKtXWKDfrcJcxr6UmfY75fpiSbWx5F9F/Bu6FCEDYOMo0CC+7JRykofM8ojGMPBh0q
        bLO9qGaLApyoJAdPcckJ4bq14vnEmGr+Hdg55E2o2n5tCfDEj8bbVp8B2FYedyzPo5g
        t+FwrxiUBg==
Date:   Mon, 5 Jul 2021 02:18:23 +0200 (CEST)
From:   "B.R. Oake" <broake@mailfence.com>
Reply-To: "B.R. Oake" <broake@mailfence.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        Julian Calaby <julian.calaby@gmail.com>,
        devicetree@vger.kernel.org
Message-ID: <131830164.377678.1625444303416@ichabod.co-bxl>
In-Reply-To: <CAGRGNgVSze9yW6KTsC=KGCVOJLzck65J-f9v8y30iBw7k0KXQA@mail.gmail.com>
References: <1243888060.510560.1612783497400@ichabod.co-bxl> <20210210150118.ly252i37eykayrcb@gilmour> <1719200956.433094.1613199092092@ichabod.co-bxl> <6612268.HtAl026vyE@jernej-laptop> <206881200.203318.1622780349817@ichabod.co-bxl> <CAGRGNgVSze9yW6KTsC=KGCVOJLzck65J-f9v8y30iBw7k0KXQA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus:
 Fix Ethernet PHY mode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:276068926
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jun 04 08:49:28 CEST 2021, Julian Calaby wrote:
> While I completely sympathise with your points here, the issue isn't a 
> technical or social issue, but a legal one. 
> [...]

Dear Julian,

Thank you for giving your point of view on this issue, and sorry for not 
replying sooner. Thanks also for your work on the Atheros wifi driver, 
which I've used a lot. I think it's a particularly important one since 
it's one of the few wireless chipsets with open firmware.


> The DCO was introduced to provide a mechanism to trace the origin of a 
> piece of code for legal purposes, so my understanding is that the name 
> supplied needs to be your legal name.

Please could you say what you mean by "legal name"? For example, do you 
consider "J.R.R. Tolkien" to be a legal name?

Can you give an example of a legal purpose for which the DCO was 
intended and which fails when the DCO is signed with a name like 
G. Robinson or C.J. Newton?


> Whilst, as you've pointed out, there are a lot of ways that names 
> don't match up to the normal "Firstname I. N. I. T. I. A. L. S. 
> Lastname" format, that is the case for the vast majority of people and 
> exceptions to that are rare.

I'm not sure about that - for example, Mandarin names don't really fit 
that template. But even if exceptions were rare, would that mean those 
people and their contributions didn't matter?


> Your arguments against providing that 
> name haven't exactly helped your case [...]

Well I didn't actually argue against providing a name of the form you've 
specified - I have no objection to authors doing that if they want to. I 
just gave some reasons why an author might sign with a name of the form 
J.K. Smith. When a practice is contested I believe it does help to show 
that it has legitimate reasons.


> Your points about previous instances of this happening also don't hold 
> water either as we don't know the circumstances behind those cases. 
> Git's history is considered immutable once it makes it to an 
> "official" repository (generally one published publicly) so it's 
> likely they were oversights that weren't caught until it was too late.

Although the history might be immutable, offending commits can still be 
reverted. However, I have not found any examples of this happening to 
the commits by the authors I mentioned, which suggests there is no 
problem with having them.

And I think we do know a bit about their circumstances. To take one 
example, over an 18-month period I can see 72 commits authored by KP 
Singh which were variously committed, signed off, acknowledged and 
reviewed by Daniel Borkmann, Yonghong Song, Mimi Zohar, Alexei 
Starovoitov, Andrii Nakryiko, Martin KaFai Lau, Song Liu, Florent 
Revest, James Morris, Andrew Morton, Linus Torvalds, Brendan Jackman, 
Thomas Garnier, Kees Cook, Casey Schaufler and Randy Dunlap.

It doesn't seem very likely that these approvals were all oversights. It 
seems a lot more likely that there is actually no problem with names of 
this form.

Best wishes,
B.R.


-- 
Mailfence.com
Private and secure email
