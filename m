Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF969422CA8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhJEPjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235942AbhJEPjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:39:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69245610EA;
        Tue,  5 Oct 2021 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633448270;
        bh=s8dscrrIAsTmIuDm+tx17i82rsTJNNFZ/mXmMzrR8a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V422fjGQ5XIVBiW3hGv4wEyMh5NPtAi1+IcycV9rfcvPIrDaRz0y+qXjnMCD00TTT
         u2sklFX6x9jdCrvu+6F/1j77FAraO7T5FVvbqmM7CtocIajF4ypxFUjXEPS/8SkjAx
         ZdUbiwuU99pWVRZg5HAjp6KYpoEuAhAHmr2vJuQd5UIpxF2T6P+FDJBMj8njgfYVnr
         V95Do6ZtHdk4ak1yaCUOhrTmQLH4zDbWb1hKJAlNtP9rYV1T3PsWnGRBlePU/JYnk/
         CN8qIJTegt13fRsKQo7YEZY/6vuBLpe/OXhsThYQyAY4YlT4vUHWQTrznNkGlSo7fL
         R6lar4nOFt6Tg==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Tero Kristo <kristo@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: (subset) [PATCH v4 00/11] Rectify file references for dt-bindings in MAINTAINERS
Date:   Tue,  5 Oct 2021 16:37:40 +0100
Message-Id: <163344802403.1141521.13995618381491807996.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 09:54:40 +0200, Lukas Bulwahn wrote:
> here is a patch series that cleans up some file references for dt-bindings
> in MAINTAINERS. It applies cleanly on next-20211001.
> 
> This is a v4 of the still relevant patches from the first submission
> of the patch series (see Links) send out 2021-03-15 and resent on 2021-04-19
> and on 2021-07-26.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[10/11] MAINTAINERS: rectify entry for SY8106A REGULATOR DRIVER
        commit: beb76cb4eebf9ac4ff15312e33f97db621b46da7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
