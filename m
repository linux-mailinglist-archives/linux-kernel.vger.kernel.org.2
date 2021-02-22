Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5924F321F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhBVSrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:47:39 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34535 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhBVSpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:45:03 -0500
Received: by mail-wr1-f44.google.com with SMTP id n4so20189556wrx.1;
        Mon, 22 Feb 2021 10:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WMwCTPqIvolvJ4k3GJnXnqsgpX6SITbYIGEcInJtsN8=;
        b=ubvBOJjtJLT2EcuGWDYy2wZqbbLwqCJljkEzfHQIEw/taKKQECyLp4P3lkDoX1ZtRT
         CWoMuhnDem42AI0oANasbqiCg/tPZKKvU4J//J1iA4Twlg5RQEsoKGtYYGFHr4DQ8M+I
         amdixzkQsv19uHjhC9IVzgmMIoJH2HniJSQP1Y/c4kAYedHp/oT/ZtyiVb+egg9FnQBK
         nTIjx6ElP0KOy5cEL0pIq2x1UNhnj5rkvKdQXFhWkhPQKYiCcCeVOcHcbsWVZTBBnNnh
         Sj0Otd1wZI/0sgpnz/Ca+VsxgZrG74Sx+D7/LfNgfiGC+Rkbsrq5/Qaa9LQUdDUbe8wJ
         W8WA==
X-Gm-Message-State: AOAM532UgL+wgkaA3MzdvOG/DqH8YJa85RlwcpB92+xQm6unaA/Ub3K1
        hKYonX4RiwgDuQeHrh/rLco=
X-Google-Smtp-Source: ABdhPJyasyK+ldSeEjiN1NbKy1+letae1s/FCLPnubZtcS5+CTLcmogkhuR+mCLFSxbHRwTWwr+igw==
X-Received: by 2002:a5d:618a:: with SMTP id j10mr11151064wru.264.1614019460131;
        Mon, 22 Feb 2021 10:44:20 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k15sm197869wmj.6.2021.02.22.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 10:44:19 -0800 (PST)
Date:   Mon, 22 Feb 2021 19:44:17 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 2/2] arm64: dts: fsl: add support for Kontron
 pitx-imx8m board
Message-ID: <20210222184417.4nkmdjkgub73b2xd@kozik-lap>
References: <20210222140756.713-1-heiko.thiery@gmail.com>
 <20210222140756.713-3-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222140756.713-3-heiko.thiery@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 03:07:56PM +0100, Heiko Thiery wrote:
> The Kontron pitx-imx8m board is based on an i.MX8MQ soc.
> 
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
> v2:
>  - bring root nodes in alphabetical order
>  - remove pinctrl_gpio_keys for pciewake
>  - remove pinctrl_sai2 and pinctrl_spdfif1 since it is not used yet
> 
>  Thanks to Michael Walle:
>  - add pinctrl for regulator-v-3v3-sd
>  - add name for regulator swbst
>  - add comment about currently unused audio codec
>  - put usb_phy entry in correct alphabetical order
> 
>  Thanks to Krzysztof Kozlowski:
>  - use generic names for pcie-refclk, tpm, fan-controller, sensor
>  - remove empty line
>  - fix group name to match schema (ecspi2cs -> ecspi2csgrp)
> 
> 
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../freescale/imx8mq-kontron-pitx-imx8m.dts   | 641 ++++++++++++++++++
>  2 files changed, 642 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> 

Looks fine to me, also with the changes pointed out by Micahel in other
email in this thread:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
