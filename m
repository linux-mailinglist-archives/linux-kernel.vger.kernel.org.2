Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC7B31AA51
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 07:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBMGwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 01:52:20 -0500
Received: from wilbur.contactoffice.com ([212.3.242.68]:56712 "EHLO
        wilbur.contactoffice.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBMGwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 01:52:17 -0500
Received: from ichabod.co-bxl (ichabod.co-bxl [10.2.0.36])
        by wilbur.contactoffice.com (Postfix) with ESMTP id C5F80827;
        Sat, 13 Feb 2021 07:51:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailfence.com;
        s=20160819-nLV10XS2; t=1613199094;
        bh=c7eHNOeudtFYB2ia1pCjZOnK2D0HGHskQSrZBEiyRZA=;
        h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From;
        b=n3zxpQcBif6MD7GWsE6xsAt54uBoHMOtgRrnnbnt1t8MObHLQhJmqHZxLMOKvURMd
         P5mcTW2OmdcYJavjSQJngJRGWjQ2Ligb7QDr/YQqbXC0ZI99TejVnld0m/U6yQsXsE
         6tRsCqayWn8WU5hHXxkMgEUALtjv8ZK3cvA9EMAMnIvMRuADyh+YAj5hM8Z3jymGzs
         UTV1G4JDGHMetoISGdc+Mt9zU01EakFxNFusNRk/1GnWC3Dc0sa/Zk9imOhbc51yhH
         PlMotha88JKufV7XefyY4JJoaaA2CJe5+K45v0YbITekCJUgn3TopQwVVLHQqkVTQG
         JkSR4CbXdEi9Q==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1613199094;
        s=20210208-e7xh; d=mailfence.com; i=broake@mailfence.com;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=1807; bh=c7eHNOeudtFYB2ia1pCjZOnK2D0HGHskQSrZBEiyRZA=;
        b=haxJ6a6w2Puj2RiKYXykGyc/9dmbEeuWX4ddxFSCX45AlIr+Boz02pJNdCInMINK
        vLB7IBx3lRMjROH2Y37loSnfGn/SVxkKtujtfXyZaKp3M8Qw3rSmnIyGDqOl2SeYw3J
        WqMwrBI/k0qHfaSEh3zvMANOfw962a8e7QRQojVwPWbqVD1zG/VimTRCOHYu5QRebmX
        1XVBI/621PvJrCtw2sW03zRy6HQ8NsNJdLCuOvdrRozqEzlfsOQAyknjHPW4eF3Tu75
        fADMNIKDhGzC4761+2Sse6kroe/1NdB+o9BaUwFnLcUEq2e9qGtBCwJch/xH0iLQk1H
        93npB9bBOA==
Date:   Sat, 13 Feb 2021 07:51:32 +0100 (CET)
From:   "B.R. Oake" <broake@mailfence.com>
Reply-To: "B.R. Oake" <broake@mailfence.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@kernel.org>, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Message-ID: <1719200956.433094.1613199092092@ichabod.co-bxl>
In-Reply-To: <20210210150118.ly252i37eykayrcb@gilmour>
References: <1243888060.510560.1612783497400@ichabod.co-bxl> <20210210150118.ly252i37eykayrcb@gilmour>
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY
 mode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:276068926
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Feb 10 at 16:01:18 CET 2021, Maxime Ripard wrote:
> Unfortunately we can't take this patch as is, this needs to be your real name, see:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

Dear Maxime,

Thank you very much for considering my contribution and for all your 
work on supporting sunxi-based hardware; I appreciate it.

Thank you for referring me to the Developer's Certificate of Origin, but 
I had already read it before submitting (I had to do so in order to know 
what I was saying by "Signed-off-by:") and I do certify what it says.

Looking through recent entries in the commit log of the mainline kernel, 
I see several patches from authors such as:

  H.J. Lu <hjl.tools@gmail.com>
  B K Karthik <karthik.bk2000@live.com>
  JC Kuo <jckuo@nvidia.com>
  EJ Hsu <ejh@nvidia.com>
  LH Lin <lh.lin@mediatek.com>
  KP Singh <kpsingh@kernel.org>
  Karthik B S <karthik.b.s@intel.com>
  Shreyas NC <shreyas.nc@intel.com>
  Vandana BN <bnvandana@gmail.com>

so I believe names of this form are in fact acceptable, even if the 
style might seem a little old-fashioned to some.

I would like to add that I have met many people with names such as C.J., 
A A, TC, MG, etc. That is what everybody calls them and it would be 
natural for them to sign themselves that way. Some of them might want to 
contribute to Linux some day, and I think it would be a great shame and 
a loss to all of us if they were discouraged from doing so by reading 
our conversation in the archives and concluding that any contribution 
from them, however small, would be summarily refused simply because of 
their name. Please could you ensure that does not happen?

Thank you again for your consideration.

Yours sincerely,
B.R. Oake.
