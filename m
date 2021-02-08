Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7632E3140AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhBHUmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236308AbhBHT3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:29:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27B264DC3;
        Mon,  8 Feb 2021 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612812521;
        bh=s0JgrqQa+G0wPRwnpZnlE2dShxRomBj4t2pW7KWbP8I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JrUylQRrCmKmeeyowwSWrB44pt/GZjlrckJ/eNmUN1WqDzWej39YLeb+wAurhdk+R
         43QBk4f3OnrR0dX7CBEbYxjycsk3VFd9x6yNZUip8ymVL3qimGTQZ4KL36GQxltJb+
         IvV0heaGQ8w+fTMMsU5yt6Gp2MdcgLkCAQemUymwus547COdfzsANHY0/khGTc1v7F
         AbdR8oCs30javFffP7icwC9HQZrasdv2g197sZdygVrS3b8ohpi3b6tei9vdTiaZiB
         /S59GseQJuyqH8U/4lOT50dXeTamRjw4vq6gMVcmLjbwSAMnScQZPlU4//LPhZzk/E
         ISJRe6gMoyWbw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210120073414.69208-3-jckuo@nvidia.com>
References: <20210120073414.69208-1-jckuo@nvidia.com> <20210120073414.69208-3-jckuo@nvidia.com>
Subject: Re: [PATCH v7 02/14] clk: tegra: Don't enable PLLE HW sequencer at init
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com, linux-clk@vger.kernel.org,
        JC Kuo <jckuo@nvidia.com>, Thierry Reding <treding@nvidia.com>
To:     JC Kuo <jckuo@nvidia.com>, gregkh@linuxfoundation.org,
        jonathanh@nvidia.com, kishon@ti.com, mturquette@baylibre.com,
        robh@kernel.org, thierry.reding@gmail.com
Date:   Mon, 08 Feb 2021 11:28:40 -0800
Message-ID: <161281252000.76967.4881086496669699756@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting JC Kuo (2021-01-19 23:34:02)
> PLLE hardware power sequencer references PEX/SATA UPHY PLL hardware
> power sequencers' output to enable/disable PLLE. PLLE hardware power
> sequencer has to be enabled only after PEX/SATA UPHY PLL's sequencers
> are enabled.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
