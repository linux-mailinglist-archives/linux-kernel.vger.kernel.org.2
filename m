Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245F241A917
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 08:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbhI1GxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 02:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhI1GxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:53:02 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E99C061575;
        Mon, 27 Sep 2021 23:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FP5d4oGJafrFBg7wxHe/Fgsku6XDyxulL26lJvPMS2g=; b=U7t+Q5nzszvusxxrcfg0zROGVG
        U095xy6183R1hMWWlOHOj/F8PxWHLFnnlRUUhrhKZItUulskYtHyC0kqs6s9ftn1XpzNVQxpU95nr
        SSfBoHgr3ltjOThIK2aId9GkwFF62ofWhffnosIMqYnaAk6QMbaFow5KFPj9QLVVmLm0=;
Received: from p200300ccff1611001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff16:1100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mV6xU-0002oa-GV; Tue, 28 Sep 2021 08:51:20 +0200
Date:   Tue, 28 Sep 2021 08:51:19 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lucas Stach <lst@pengutronix.de>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 4/5] ARM: dts: imx6sl: fix mmc compatibles
Message-ID: <20210928085119.51547f2c@aktux>
In-Reply-To: <CA+Eumj50L-bbVBX99Q-6y1-o_R58JvJFsStck+O2-18qJSUT1g@mail.gmail.com>
References: <20210924091439.2561931-1-andreas@kemnade.info>
        <20210924091439.2561931-5-andreas@kemnade.info>
        <a5ec87f2-7e72-9c23-e13a-75498287b451@pengutronix.de>
        <20210926203314.7c187191@aktux>
        <CA+Eumj50L-bbVBX99Q-6y1-o_R58JvJFsStck+O2-18qJSUT1g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 27 Sep 2021 09:34:57 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> On Sun, 26 Sept 2021 at 20:33, Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > Hi Ahmad,
> >
> > On Sun, 26 Sep 2021 08:54:35 +0200
> > Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >  
> > > Hello Andreas,
> > >
> > > On 24.09.21 11:14, Andreas Kemnade wrote:  
> > > > Binding specification only allows one compatible here.  
> > >
> > > This same change was NACKed by Lucas here:
> > > https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
> > >
> > > I also think the schema should be fixed instead.
> > >  
> > well, that argumentation makes sense. Feel free to drop this patch. I
> > will not repost the series if it is just about dropping patches.  
> 
> The argument of using a new DTB with an old kernel, therefore
> prohibiting changes in new DTB, does not make that much sense, except
> when caring about other systems which would like to directly reuse the
> DTB... anyway it's not that important to fight over it.
> 
well, I have no strong opinion here, but I want to get rid of that
warning, unecessary noise which might hide real problems.

Regards,
Andreas
