Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A37388193
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352238AbhERUpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhERUpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:45:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC73FC061573;
        Tue, 18 May 2021 13:43:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lg14so16645502ejb.9;
        Tue, 18 May 2021 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=33BN16VeAHRqAcsY7RQFPPp6i8GPb1KeBFPPEWfV/sM=;
        b=qdBmJqRjyQ89CuUhMIE3kMxhEkSxAj/qWayD/vJxLaZrrRAAofBwgeVoguDYT7lDjg
         /L+sVi7utKHWIw2/Woi/oU/eaVUB8rtKQtDaW7w2a0C10s8rbzeukUlkhKLhbp0uHkwY
         4AF4SBYlZWQuOAGO+GebwfTGSFa6gQZr/DFKjffJdEKPNgX1NdQa+dfgey1LqqTgU91a
         oebLGKGKnyUhcHrdH5WreudShIS+wf+VwHB4rUME/skC9shwi9KrQMDpNtnXRauh2/1r
         GYkptqNPVX6PLt3yYRUfe5irtAq+/lqqsYkbarpm9mqneKAldJgmW3p1VgsOadzQ20Hn
         cJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=33BN16VeAHRqAcsY7RQFPPp6i8GPb1KeBFPPEWfV/sM=;
        b=nm5bS1fhMEXE3d+K6nC7Rt6HlCYKmjbGH/QMmARtRtnJMJ4Uk4kY6Bmq+NskYYBAlj
         CuMhkgtavoEToFe/9t76xlRHTK+5XCV9Eo0u17LrxoF0VRe3j+/3Kv4vBxTc3N3k9f0b
         EHqDMhHHRyYceCd/iX9IhgFlag9rtYuT8Wv6gU96cW9t+tKwFUie9fwuYq7/bbtteSjt
         wAWy9j1Z+MgcKTjSlmjGQ1vy5bSqJcq3OQ9JuCu66AwQZ+U7/hEbx88fUfpws0AZx2vh
         okB54boXIfGs4peTS95bkNwzRl3/UVjVAIV7KwGCawvyhmc1oFOlZOwVCXD33F1/NnNE
         7vAw==
X-Gm-Message-State: AOAM532BQZyRv2xW7hiJ+C6pfxXo0DcpxlN3ukyXZgf+DCpNLyqnQVWy
        BQqGp2nFDyM9nA9LYZaS9aU=
X-Google-Smtp-Source: ABdhPJwdAaevwZzLtKGyXLAfDN58TkOA9LpUHcjzjqQtaGvZAi2nRMX9yzee1stOh4Wc+HGs8NcDUQ==
X-Received: by 2002:a17:906:2cce:: with SMTP id r14mr7803384ejr.38.1621370622417;
        Tue, 18 May 2021 13:43:42 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id y10sm10737046ejh.105.2021.05.18.13.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:43:41 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Tue, 18 May 2021 22:43:40 +0200
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
Message-ID: <YKQm/F+JIjf/YUHm@eldamar.lan>
References: <1243888060.510560.1612783497400@ichabod.co-bxl>
 <20210210150118.ly252i37eykayrcb@gilmour>
 <1719200956.433094.1613199092092@ichabod.co-bxl>
 <6612268.HtAl026vyE@jernej-laptop>
 <YKFPGC2qBMipQPbd@eldamar.lan>
 <87o8dawhy3.fsf@yucca>
 <20210518150652.zxj56bljjeq3ogln@gilmour>
 <YKQiws6yP35QIpJd@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YKQiws6yP35QIpJd@eldamar.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, May 18, 2021 at 10:25:40PM +0200, Salvatore Bonaccorso wrote:
> Hi Maxime,
> 
> On Tue, May 18, 2021 at 05:06:52PM +0200, Maxime Ripard wrote:
> > On Sun, May 16, 2021 at 01:18:44PM -0700, Vagrant Cascadian wrote:
> > > On 2021-05-16, Salvatore Bonaccorso wrote:
> > > > On Sat, Feb 13, 2021 at 09:51:17AM +0100, Jernej Škrabec wrote:
> > > >> Let me first explain that it was oversight on my side not noticing initials in 
> > > >> your SoB tag. But since the issue was raised by Maxime, I didn't follow up.
> > > >> 
> > > >> Dne sobota, 13. februar 2021 ob 07:51:32 CET je B.R. Oake napisal(a):
> > > >> > On Wed Feb 10 at 16:01:18 CET 2021, Maxime Ripard wrote:
> > > >> > > Unfortunately we can't take this patch as is, this needs to be your real
> > > >> > > name, see:
> > > >> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de
> > > >> > > veloper-s-certificate-of-origin-1-1
> > > >> > Dear Maxime,
> > > >> > 
> > > >> > Thank you very much for considering my contribution and for all your
> > > >> > work on supporting sunxi-based hardware; I appreciate it.
> > > >> > 
> > > >> > Thank you for referring me to the Developer's Certificate of Origin, but
> > > >> > I had already read it before submitting (I had to do so in order to know
> > > >> > what I was saying by "Signed-off-by:") and I do certify what it says.
> > > >> > 
> > > >> > Looking through recent entries in the commit log of the mainline kernel,
> > > >> > I see several patches from authors such as:
> > > >> > 
> > > >> >   H.J. Lu <hjl.tools@gmail.com>
> > > >> >   B K Karthik <karthik.bk2000@live.com>
> > > >> >   JC Kuo <jckuo@nvidia.com>
> > > >> >   EJ Hsu <ejh@nvidia.com>
> > > >> >   LH Lin <lh.lin@mediatek.com>
> > > >> >   KP Singh <kpsingh@kernel.org>
> > > >> >   Karthik B S <karthik.b.s@intel.com>
> > > >> >   Shreyas NC <shreyas.nc@intel.com>
> > > >> >   Vandana BN <bnvandana@gmail.com>
> > > >> > 
> > > >> > so I believe names of this form are in fact acceptable, even if the
> > > >> > style might seem a little old-fashioned to some.
> > > >> 
> > > >> Speaking generally, not only for this case, prior art arguments rarely hold, 
> > > >> because:
> > > >> - it might be oversight,
> > > >> - it might be a bad practice, which should not be followed in new 
> > > >> contributions,
> > > >> - different maintainers have different point of view on same thing,
> > > >> - maintainer wants to adapt new practice or steer subsystem in new direction
> > > >> 
> > > >> > 
> > > >> > I would like to add that I have met many people with names such as C.J.,
> > > >> > A A, TC, MG, etc. That is what everybody calls them and it would be
> > > >> > natural for them to sign themselves that way. Some of them might want to
> > > >> > contribute to Linux some day, and I think it would be a great shame and
> > > >> > a loss to all of us if they were discouraged from doing so by reading
> > > >> > our conversation in the archives and concluding that any contribution
> > > >> > from them, however small, would be summarily refused simply because of
> > > >> > their name. Please could you ensure that does not happen?
> > > >> 
> > > >> The link you posted says following:
> > > >> "using your real name (sorry, no pseudonyms or anonymous contributions.)"
> > > >> 
> > > >> I believe that real name means no initials, no matter what people are 
> > > >> accustomed to. From my point of view, CJ is pseudonym derived from real name.
> > > >> 
> > > >> This is not the first time that fix of SoB tag was requested, you can find such 
> > > >> requests in ML archives.
> > > 
> > > I'm sure this isn't the first time this sort of thing has been brought
> > > up on this subject, but I feel obliged to mention:
> > > 
> > >   https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
> > > 
> > > This seems to be blocked on culturally dependent perception of what
> > > looks like a "real name" as opposed to any technical grounds.
> > > 
> > > What is the goal of the "real name" in Signed-off-by actually trying to
> > > achieve?
> > 
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
> > 
> > I'm not the one making the rules, sorry
> 
> Would it be technically possible to do the following: Based on the
> downstream report we receved in Debian in
> https://bugs.debian.org/988574 wrap up the same patch (I guess I will
> need to use another commit message wording) and resubmit with my own
> SoB with my downstream hat on and say a Tested-by from Vagrant? So we
> are not blocked on the SoB issue from this original post of the change
> to apply to arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts ?

Here is an attempt to do that and coming from
https://bugs.debian.org/988574 for the change change submission.

Regards,
Salvatore

From 93c335c997d6386fc5cb7b9c5621b9b9725de20e Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Tue, 18 May 2021 22:33:49 +0200
Subject: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix ethernet phy-mode

Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
config") sets the RX/TX delay according to the phy-mode property in the
device tree. For the Orange Pi Plus board this is "rgmii", which is the
wrong setting.

Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
the Ethernet working again on this board.

Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
Reported-by: Vagrant Cascadian <vagrant@reproducible-builds.org>
Link: https://bugs.debian.org/988574
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index 97f497854e05..d05fa679dcd3 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -85,7 +85,7 @@ &emac {
 	pinctrl-0 = <&emac_rgmii_pins>;
 	phy-supply = <&reg_gmac_3v3>;
 	phy-handle = <&ext_rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 
 	status = "okay";
 };
-- 
2.31.1

