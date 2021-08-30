Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD39F3FBE11
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhH3V0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:26:20 -0400
Received: from laubervilliers-656-1-228-164.w92-154.abo.wanadoo.fr ([92.154.28.164]:54092
        "EHLO ssq0.pkh.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbhH3V0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pkh.me; s=selector1;
        t=1630358723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=80dDbRn6s3xamLCNiQaZpQpNPHOe0dgBpx21E820VCc=;
        b=GJMSV+XbmrU20tdV0eonkDJXzerkk/8TS+odJm80wo/J2ZzdEAcLssoFk3si5lBAMuO5P7
        VWWpBN5pbhcDyMBflyeuN0WV6lfpsE8MbulQK4AYuB6SWS7lemVn43fpkotpLXHSga83OF
        byMDEsY3dEg1xb1QbdMVoMkk6uLoCwg=
Received: from localhost (ssq0.pkh.me [local])
        by ssq0.pkh.me (OpenSMTPD) with ESMTPA id 829422a9;
        Mon, 30 Aug 2021 21:25:23 +0000 (UTC)
Date:   Mon, 30 Aug 2021 23:25:23 +0200
From:   =?utf-8?B?Q2zDqW1lbnQgQsWTc2No?= <u@pkh.me>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Willy Liu <willy.liu@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sun50i: h5: NanoPI Neo 2: phy-mode rgmii-id
Message-ID: <YS1Mwz+fT9P2qskW@ssq0.pkh.me>
References: <20210830151645.18018-1-u@pkh.me>
 <116454729.UZi3dMzWh7@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <116454729.UZi3dMzWh7@jernej-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:49:37PM +0200, Jernej Škrabec wrote:
> Hi!
> 

Hi,

> Dne ponedeljek, 30. avgust 2021 ob 17:16:45 CEST je Clément Bœsch napisal(a):
> > Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> > config") network is broken on the NanoPi Neo 2.
> > 
> > This patch changes the phy-mode to use internal delays both for RX and
> > TX as has been done for other boards affected by the same commit.
> > 
> > Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> 
> This commit fixes DT issue, so "fixes" tag should be:
> Fixes: 44a94c7ef989 ("arm64: dts: allwinner: H5: Restore EMAC changes")
> 
> Here, a node with wrong phy-mode property was added to NanoPi Neo 2 board DT.  

Shouldn't I add it instead of replacing? I followed what I observed in
`git log --grep bbc4d71d63` where all the commits pretty much follow this
pattern: that commit is the one causing the actual observed regression,
while 44a94c7ef989 is much older, and while it's wrong, it wasn't causing
an issue in practice.

Or did I misunderstand something?

> Other than that, this patch is fine and once fixes tag is fixed, you can add:
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> For next version, you should:
> - change fixed tag
> - add my review-by tag right above your signed-off-by tag
> - mark patch as v2 (add "-v2" parameter to git format-patch)
> - describe change right under "---" line
> 

Will do.

> Note, if you borked something when sending, you should mark patch or patch 
> series as "RESEND", so recipients don't look for changes in two subsequent e-
> mails (--subject-prefix="RESEND PATCH").

Not sure I follow you so before I disturb everyone with more noise I'd
just like to confirm: you mean a git send-email in-reply-to=[broken patch
attempt] (the one where I borked the --cc), right? But with what patch?
I'm a bit confused here.

> Thanks for the fix!

No problem; I really think a scan of all the other boards would be
meaningful though, it looks like a lot of them got fixed but there are
many other candidates and the issue feels pretty critical to me
(regression, and no network at all).

-- 
Clément B.
