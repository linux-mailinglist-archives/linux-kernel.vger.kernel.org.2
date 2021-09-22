Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457AA415185
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbhIVUk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbhIVUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:40:25 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F739C061574;
        Wed, 22 Sep 2021 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UQKAs/9Wxgf8laYkEBMV0uzzzqr3J/31XrLtdGMgrN8=; b=ht3ibw9/CW8Odjx16lI2hnT2m+
        KmCjntMm65yhqJnP9wrMRpPBJcRTbUQUM0VGm+WxCXGVX44ERdoffFzkWd12yeb2TDKGgibo0QGaS
        j20nV14JkKvPbHAUQ8KHLxkHeUaHcBK5khhr7FRGh/kctohYT6qB6o+Xy0zOG+6hrrms=;
Received: from p200300ccff0c98001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:9800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mT90y-0007Yz-Af; Wed, 22 Sep 2021 22:38:48 +0200
Date:   Wed, 22 Sep 2021 22:38:47 +0200
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
Message-ID: <20210922223847.5efe6471@aktux>
In-Reply-To: <CAJKOXPfQrfOm=LWh97tq6q16v6aGXazksYF+kYxj5ghd0x7LUg@mail.gmail.com>
References: <20210918141627.2142457-1-andreas@kemnade.info>
        <20210918141627.2142457-4-andreas@kemnade.info>
        <CAJKOXPfQrfOm=LWh97tq6q16v6aGXazksYF+kYxj5ghd0x7LUg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 22 Sep 2021 09:41:39 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

[...]
> > +       pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {  
> 
> Thanks for the patch.
> 
> This does not look like passing the schema validation. Please run
> dtbs_check. The node names should use hyphens and end with "grp"
> suffix. This remark applies to other cases below.
> 
dtbs_check reports a lot of errors originating from imx6sll.dtsi and
friends. But nothing added by me. But yes, node names should use
hyphens, that is documented. I will fix that.

But having -grp at the end for these things with a frequency in the
name is uncommon.
$ grep -R :.*100mhz arch/arm/boot/dts/imx6s*.dts
arch/arm/boot/dts/imx6sl-evk.dts:		pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
arch/arm/boot/dts/imx6sl-evk.dts:		pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
arch/arm/boot/dts/imx6sl-evk.dts:		pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
arch/arm/boot/dts/imx6sll-evk.dts:	pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
arch/arm/boot/dts/imx6sll-evk.dts:	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
arch/arm/boot/dts/imx6sll-kobo-clarahd.dts:	pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
arch/arm/boot/dts/imx6sll-kobo-clarahd.dts:	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
arch/arm/boot/dts/imx6sll-kobo-librah2o.dts:	pinctrl_usdhc1_100mhz: usdhc1grp-100mhz {
arch/arm/boot/dts/imx6sll-kobo-librah2o.dts:	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts:	pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts:	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
arch/arm/boot/dts/imx6sl-tolino-shine3.dts:	pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
arch/arm/boot/dts/imx6sl-tolino-shine3.dts:	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
arch/arm/boot/dts/imx6sl-tolino-vision5.dts:	pinctrl_usdhc1_100mhz: usdhc1grp-100mhz {
arch/arm/boot/dts/imx6sl-tolino-vision5.dts:	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
arch/arm/boot/dts/imx6sl-warp.dts:		pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
arch/arm/boot/dts/imx6sl-warp.dts:		pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
arch/arm/boot/dts/imx6sx-nitrogen6sx.dts:	pinctrl_usdhc4_100mhz: usdhc4-100mhzgrp {
arch/arm/boot/dts/imx6sx-sabreauto.dts:	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
arch/arm/boot/dts/imx6sx-softing-vining-2000.dts:	pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
arch/arm/boot/dts/imx6sx-softing-vining-2000.dts:	pinctrl_usdhc4_100mhz: usdhc4-100mhz {

Regards,
Andreas

