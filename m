Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DA537F1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhEMDpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhEMDp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:45:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3D56613FC;
        Thu, 13 May 2021 03:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620877459;
        bh=ZTKvkWEQTOlTTMRT6PkyxlnT2PHJ9UiQuuk+33hcGqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iH4laW1Q9IA/6svGaDX9CdR3tPfMDTibVXEGCKB2cIl5ZkS0AjBsoglS8vsieUOGg
         EK1Aa11wAf6knbwtv6kOuRVRpISdWMi5mjm+pvp5vK9Rh+yA4Xv0l0Idz02u4i2B0C
         ORkHxKA5mmuH+97C8SHIraoegLXCsSZOrC1poWqVqLXRlIW8Jv8rDlr8gPFGrXzHVZ
         qTsylXtKer3MZIs/bOvTYwvbrnzzo9gzegRwhW4xtLuJc18SMe4ZWLugAs5A21NHHO
         szpcMwe5X3km14z2x6JZRBENCwdonNjUBv4ijsKpfSGnWI8Qe5ErgLOLrD4HkirbcU
         qxTvgsdsxzv/A==
Date:   Thu, 13 May 2021 11:44:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Primoz Fiser <primoz.fiser@norik.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6: phyFLEX: Fix UART hardware flow control
Message-ID: <20210513034413.GM3425@dragon>
References: <20210412062450.1430199-1-primoz.fiser@norik.com>
 <20210412062450.1430199-2-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412062450.1430199-2-primoz.fiser@norik.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 08:24:50AM +0200, Primoz Fiser wrote:
> Serial interface uart3 on phyFLEX board is capable of 5-wire connection
> including signals RTS and CTS for hardware flow control.
> 
> Fix signals UART3_CTS_B and UART3_RTS_B padmux assignments and add
> missing property "uart-has-rtscts" to allow serial interface to be
> configured and used with the hardware flow control.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied, thanks.
