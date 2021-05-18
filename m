Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10493388159
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbhERU1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbhERU1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:27:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1E1C061573;
        Tue, 18 May 2021 13:25:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lg14so16578619ejb.9;
        Tue, 18 May 2021 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WfuByvI0yZ8rv4MiEtXE4zgRGeaKIDoqLt8IPPHa/iY=;
        b=cZ8QAs2Z4uPF6wT2nzjEt8yJlwJW2BBXZPkKfdze2WEbuNkxaEdYOYiKVwyapYBONI
         4L3crtTJ71sg3nciynpm0hB8fS/ikDFPcFt7J4QR2Jw6kLfq5oETaaptkxXqYtXr5TnS
         z/i9sppRz98fiM8DsMArJG9qqw8B5RbxSm9KUEmP1LzbWgyEIPK8kVw6K1+ylnKZgsnF
         OPp33uUQzNWgLtJeAucyPsjoHam/7Zza0xJmZtQ5DhPJsW8RAFcyN/MtwB/XTPbwgjGn
         4ftOLXBqJMjrukCmtHLODmB0IAu4tE+guSf5kFEb6OF5dzGrjBhhKfUR4Xwt9RO2rx/V
         xlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=WfuByvI0yZ8rv4MiEtXE4zgRGeaKIDoqLt8IPPHa/iY=;
        b=Rt2mfHmiU66tpi1G4ACPM0BT5PIDKeQmVRTd2G5viMUKJ3okhRMB4y64EpY7xeOaGO
         dATwveJvbFNqJY4//Wpdya0KVbRIY7QAr1GBJL4YNG0zbzNRDM/H5YUlbKMFkCTIpkCC
         5Ub3BThXbljGbk9/+eblujGIjZZU3rONjBEvOU5QfZJjApq12IWNUnkFpmy+KF9dnOhs
         t8mHZmiwZrzpYOnUtVv2ivlQVFXRJWL98JXH8YgbG5Z+xyfnDXQ/jNWAwXZ/qx2ag11G
         bLkBl2xD1DPjQvAkDejUsstBNrv3+2jyVeyx2Ojgdtds2FzsXLz+fCliUQ/FgqtFCgqF
         Iazg==
X-Gm-Message-State: AOAM5328RzQQJPL6v2XXEXSjKDKDX75/gc4iodY25/vU7UTc6AGH9br2
        gvLJe+hq6MFwJvLaf03+MRo=
X-Google-Smtp-Source: ABdhPJxrpSxL77S7MxH0ugtPu7F1wCFx71Q/gdj+4h+bX+Z5o5NuIisTiYvAdgDlnmD8JHRqwWBi4A==
X-Received: by 2002:a17:906:7c82:: with SMTP id w2mr8005565ejo.448.1621369540218;
        Tue, 18 May 2021 13:25:40 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id q25sm10790253ejd.9.2021.05.18.13.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:25:39 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Tue, 18 May 2021 22:25:38 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Vagrant Cascadian <vagrant@reproducible-builds.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        "B.R. Oake" <broake@mailfence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY mode
Message-ID: <YKQiws6yP35QIpJd@eldamar.lan>
References: <1243888060.510560.1612783497400@ichabod.co-bxl>
 <20210210150118.ly252i37eykayrcb@gilmour>
 <1719200956.433094.1613199092092@ichabod.co-bxl>
 <6612268.HtAl026vyE@jernej-laptop>
 <YKFPGC2qBMipQPbd@eldamar.lan>
 <87o8dawhy3.fsf@yucca>
 <20210518150652.zxj56bljjeq3ogln@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210518150652.zxj56bljjeq3ogln@gilmour>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, May 18, 2021 at 05:06:52PM +0200, Maxime Ripard wrote:
> On Sun, May 16, 2021 at 01:18:44PM -0700, Vagrant Cascadian wrote:
> > On 2021-05-16, Salvatore Bonaccorso wrote:
> > > On Sat, Feb 13, 2021 at 09:51:17AM +0100, Jernej Škrabec wrote:
> > >> Let me first explain that it was oversight on my side not noticing initials in 
> > >> your SoB tag. But since the issue was raised by Maxime, I didn't follow up.
> > >> 
> > >> Dne sobota, 13. februar 2021 ob 07:51:32 CET je B.R. Oake napisal(a):
> > >> > On Wed Feb 10 at 16:01:18 CET 2021, Maxime Ripard wrote:
> > >> > > Unfortunately we can't take this patch as is, this needs to be your real
> > >> > > name, see:
> > >> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de
> > >> > > veloper-s-certificate-of-origin-1-1
> > >> > Dear Maxime,
> > >> > 
> > >> > Thank you very much for considering my contribution and for all your
> > >> > work on supporting sunxi-based hardware; I appreciate it.
> > >> > 
> > >> > Thank you for referring me to the Developer's Certificate of Origin, but
> > >> > I had already read it before submitting (I had to do so in order to know
> > >> > what I was saying by "Signed-off-by:") and I do certify what it says.
> > >> > 
> > >> > Looking through recent entries in the commit log of the mainline kernel,
> > >> > I see several patches from authors such as:
> > >> > 
> > >> >   H.J. Lu <hjl.tools@gmail.com>
> > >> >   B K Karthik <karthik.bk2000@live.com>
> > >> >   JC Kuo <jckuo@nvidia.com>
> > >> >   EJ Hsu <ejh@nvidia.com>
> > >> >   LH Lin <lh.lin@mediatek.com>
> > >> >   KP Singh <kpsingh@kernel.org>
> > >> >   Karthik B S <karthik.b.s@intel.com>
> > >> >   Shreyas NC <shreyas.nc@intel.com>
> > >> >   Vandana BN <bnvandana@gmail.com>
> > >> > 
> > >> > so I believe names of this form are in fact acceptable, even if the
> > >> > style might seem a little old-fashioned to some.
> > >> 
> > >> Speaking generally, not only for this case, prior art arguments rarely hold, 
> > >> because:
> > >> - it might be oversight,
> > >> - it might be a bad practice, which should not be followed in new 
> > >> contributions,
> > >> - different maintainers have different point of view on same thing,
> > >> - maintainer wants to adapt new practice or steer subsystem in new direction
> > >> 
> > >> > 
> > >> > I would like to add that I have met many people with names such as C.J.,
> > >> > A A, TC, MG, etc. That is what everybody calls them and it would be
> > >> > natural for them to sign themselves that way. Some of them might want to
> > >> > contribute to Linux some day, and I think it would be a great shame and
> > >> > a loss to all of us if they were discouraged from doing so by reading
> > >> > our conversation in the archives and concluding that any contribution
> > >> > from them, however small, would be summarily refused simply because of
> > >> > their name. Please could you ensure that does not happen?
> > >> 
> > >> The link you posted says following:
> > >> "using your real name (sorry, no pseudonyms or anonymous contributions.)"
> > >> 
> > >> I believe that real name means no initials, no matter what people are 
> > >> accustomed to. From my point of view, CJ is pseudonym derived from real name.
> > >> 
> > >> This is not the first time that fix of SoB tag was requested, you can find such 
> > >> requests in ML archives.
> > 
> > I'm sure this isn't the first time this sort of thing has been brought
> > up on this subject, but I feel obliged to mention:
> > 
> >   https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
> > 
> > This seems to be blocked on culturally dependent perception of what
> > looks like a "real name" as opposed to any technical grounds.
> > 
> > What is the goal of the "real name" in Signed-off-by actually trying to
> > achieve?
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
> 
> I'm not the one making the rules, sorry

Would it be technically possible to do the following: Based on the
downstream report we receved in Debian in
https://bugs.debian.org/988574 wrap up the same patch (I guess I will
need to use another commit message wording) and resubmit with my own
SoB with my downstream hat on and say a Tested-by from Vagrant? So we
are not blocked on the SoB issue from this original post of the change
to apply to arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts ?

Regards,
Salvatore
