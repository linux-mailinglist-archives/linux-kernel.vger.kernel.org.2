Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F45415C55
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbhIWKzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbhIWKzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:55:42 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C8C061574;
        Thu, 23 Sep 2021 03:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mA5+4BDnTOddExtuUZSpetH01FEjK2I5iqrBG1DRuY4=; b=EomRy8M8ikbQVvqHHM31purJHv
        2QgzmAnILS9egknTlTlvl3HUdSEDyh2LH048iKg20y7KOG+KkDiDrwAuL3h//1PdlXp8ayhp46Tgm
        fI2J6o/MRhlexAfpTO5Ig9wbJPuA0btTMzc1RRKLduVKc+fOYIU338bxJEr2JzvAwq/I=;
Received: from p200300ccff12c8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:c800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mTMMf-0001ke-6C; Thu, 23 Sep 2021 12:54:05 +0200
Date:   Thu, 23 Sep 2021 12:54:04 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     robh+dt@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] ARM: dts: imx: add devicetree for Kobo Libra H2O
Message-ID: <20210923125404.0b367fb2@aktux>
In-Reply-To: <CAJKOXPeRBCXBAgaFTtuEFZV=HfcATSFRhGtgJxoSBfFU=Y8g5Q@mail.gmail.com>
References: <20210918141627.2142457-1-andreas@kemnade.info>
        <20210918141627.2142457-4-andreas@kemnade.info>
        <CAJKOXPfQrfOm=LWh97tq6q16v6aGXazksYF+kYxj5ghd0x7LUg@mail.gmail.com>
        <20210922223847.5efe6471@aktux>
        <CAJKOXPeRBCXBAgaFTtuEFZV=HfcATSFRhGtgJxoSBfFU=Y8g5Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 23 Sep 2021 08:26:58 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Wed, 22 Sept 2021 at 22:38, Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > Hi,
> >
> > On Wed, 22 Sep 2021 09:41:39 +0200
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > [...]  
> > > > +       pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {  
> > >
> > > Thanks for the patch.
> > >
> > > This does not look like passing the schema validation. Please run
> > > dtbs_check. The node names should use hyphens and end with "grp"
> > > suffix. This remark applies to other cases below.
> > >  
> > dtbs_check reports a lot of errors originating from imx6sll.dtsi and
> > friends. But nothing added by me. But yes, node names should use
> > hyphens, that is documented. I will fix that.
> >
> > But having -grp at the end for these things with a frequency in the
> > name is uncommon.
> > $ grep -R :.*100mhz arch/arm/boot/dts/imx6s*.dts
> > arch/arm/boot/dts/imx6sl-evk.dts:               pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> > arch/arm/boot/dts/imx6sl-evk.dts:               pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> > arch/arm/boot/dts/imx6sl-evk.dts:               pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
> > arch/arm/boot/dts/imx6sll-evk.dts:      pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
> > arch/arm/boot/dts/imx6sll-evk.dts:      pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
> > arch/arm/boot/dts/imx6sll-kobo-clarahd.dts:     pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
> > arch/arm/boot/dts/imx6sll-kobo-clarahd.dts:     pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
> > arch/arm/boot/dts/imx6sll-kobo-librah2o.dts:    pinctrl_usdhc1_100mhz: usdhc1grp-100mhz {
> > arch/arm/boot/dts/imx6sll-kobo-librah2o.dts:    pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
> > arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts:   pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
> > arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts:   pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
> > arch/arm/boot/dts/imx6sl-tolino-shine3.dts:     pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
> > arch/arm/boot/dts/imx6sl-tolino-shine3.dts:     pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
> > arch/arm/boot/dts/imx6sl-tolino-vision5.dts:    pinctrl_usdhc1_100mhz: usdhc1grp-100mhz {
> > arch/arm/boot/dts/imx6sl-tolino-vision5.dts:    pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
> > arch/arm/boot/dts/imx6sl-warp.dts:              pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> > arch/arm/boot/dts/imx6sl-warp.dts:              pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
> > arch/arm/boot/dts/imx6sx-nitrogen6sx.dts:       pinctrl_usdhc4_100mhz: usdhc4-100mhzgrp {
> > arch/arm/boot/dts/imx6sx-sabreauto.dts: pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
> > arch/arm/boot/dts/imx6sx-softing-vining-2000.dts:       pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
> > arch/arm/boot/dts/imx6sx-softing-vining-2000.dts:       pinctrl_usdhc4_100mhz: usdhc4-100mhz {  
> 
> I was fixing primarily arm64 boards and did not touch that many of armv7:
> grep -R :.*100mhz.*grp arch/arm64/boot/dts/freescale/* | wc -l
> 46
>
I will send a v2 with the 100mhz style used there. I will not clean up
dtbs_check issues originating from imx6sl[l].dtsi in this series. That
would be an issue for a separate series. 

Regards,
Andreas

