Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C357418A82
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 20:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhIZSfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 14:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhIZSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 14:34:57 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B1BC061570;
        Sun, 26 Sep 2021 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9bGbTuhVgxASz0/GIsR8R81vyn3IulwgDbWd3Va3slM=; b=Z4A+TlrOwNgoKNaj29JbqyhIp0
        8KAHQbPhku6hGzPv7ge1MWOtSJy1aNXK3juYO4lPzmO/WpHo7Fn5KB30cgpsCWNWj+C2OS9g5on8h
        r8gxGLFOLFhk174HEaB20LyuXQUub81k2jn4rxOqFm+nbfE7s6b6k/Y6d9UEow37/Vws=;
Received: from p200300ccff49cf001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff49:cf00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mUYxf-0006FJ-FI; Sun, 26 Sep 2021 20:33:15 +0200
Date:   Sun, 26 Sep 2021 20:33:14 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <lst@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 4/5] ARM: dts: imx6sl: fix mmc compatibles
Message-ID: <20210926203314.7c187191@aktux>
In-Reply-To: <a5ec87f2-7e72-9c23-e13a-75498287b451@pengutronix.de>
References: <20210924091439.2561931-1-andreas@kemnade.info>
        <20210924091439.2561931-5-andreas@kemnade.info>
        <a5ec87f2-7e72-9c23-e13a-75498287b451@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

On Sun, 26 Sep 2021 08:54:35 +0200
Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> Hello Andreas,
> 
> On 24.09.21 11:14, Andreas Kemnade wrote:
> > Binding specification only allows one compatible here.  
> 
> This same change was NACKed by Lucas here:
> https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
> 
> I also think the schema should be fixed instead.
> 
well, that argumentation makes sense. Feel free to drop this patch. I
will not repost the series if it is just about dropping patches.

Regards,
Andreas
