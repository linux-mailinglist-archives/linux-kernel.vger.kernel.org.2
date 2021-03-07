Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5655330159
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 14:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhCGNqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 08:46:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231414AbhCGNqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 08:46:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBCEC650F8;
        Sun,  7 Mar 2021 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615124765;
        bh=1co50NjPL1MpdbAsROTZX7lUcqwvoBSj87RB1dQ/LDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VP85u86qQVJAwMoBrbGx3QgM/yz2L8AkmM+RO6RT8FXuhz+XXO1vcVfXZ12gvdlw7
         IJvDOJS2nVWjxk7PAtnahklIaauwhkVdaLxgY1Eeo+2Yla7bYKrejoLAOpdZo+IEKf
         TxARdo5iD28QgFI1J+2cuzExl8uK0GI7IwiAoZvizg0D1UkeJJCImoXZqVJR1XNlWO
         9nabOM3M8LepnHrYBI/oCqtlA9F5EKiVLz+GV9PqnTGRSZIbWsPjpbrgCUGDR/sXtL
         FjDE6t6TeSSNda5jk+AdugiG0Q4FDraEfDhyMsNgBEWideUS56damgQm5McQHQPtri
         yqokhytv0AL5w==
Date:   Sun, 7 Mar 2021 21:45:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] arm64: dts: librem5-devkit: Improve audio support
Message-ID: <20210307134557.GI543@dragon>
References: <cover.1613905396.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1613905396.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 12:07:05PM +0100, Guido Günther wrote:
> So far only headphone output worked. Thesse patches add support for the
> built in speaker and mic, allow a headset microphone to work and wire up jack
> detection so audio output can switch to headphones automatically.  They also
> adjust the card name to match the board not the codec, similar what's done for
> the Librem 5.
> 
> Patches are against next-20210210 but also apply against Shawn's imx-dt64-5.12
> 
> Guido Günther (6):
>   arm64: dts: librem5-devkit: Use a less generic codec name
>   arm64: dts: librem5-devkit: Add speaker amplifier
>   arm64: dts: librem5-devkit: "Drop Line In Jack"
>   arm64: defconfig: Enable asoc simple mux
>   arm64: dts: librem5-devkit: Add mux for built-in vs headset mic
>   arm64: dts: librem5-devkit: Move headphone detection to sound card

Applied all, thanks.
