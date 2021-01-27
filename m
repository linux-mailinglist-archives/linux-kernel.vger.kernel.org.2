Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B73C30624E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhA0Rl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:41:56 -0500
Received: from foss.arm.com ([217.140.110.172]:57062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236145AbhA0Ral (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:30:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E37A1042;
        Wed, 27 Jan 2021 09:29:56 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C7A93F66E;
        Wed, 27 Jan 2021 09:29:54 -0800 (PST)
Date:   Wed, 27 Jan 2021 17:29:14 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Subject: Re: (subset) [PATCH v4 00/21] arm64: sunxi: Initial Allwinner H616
 SoC support
Message-ID: <20210127172914.1ffac2a2@slackpad.fritz.box>
In-Reply-To: <161176773014.34911.3613594986317961710.b4-ty@kernel.org>
References: <20210125151811.11871-1-andre.przywara@arm.com>
        <161176773014.34911.3613594986317961710.b4-ty@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 17:15:30 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, 25 Jan 2021 15:17:50 +0000, Andre Przywara wrote:
> > an update from the v3 last week, to add support for the Allwinner H616
> > SoC. Still based on the (updated) sunxi/for-next branch.
> > I am omitting the MMC and pinctrl patches now, as they have been taken
> > by Ulf and LinusW already into their trees.
> > 
> > I addressed the comments from the list, though not sure if the HOSC clock
> > coming from the RTC is really a good idea (didn't change it).
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [13/21] dt-bindings: spi: sunxi: Add H616 compatible string
>         commit: 6589daf8bb98c75ad1065edad87c099ffb9f5d87

Thanks for that. I just sent a v5, just before seeing your email, so
this one still has this patch, but without any changes. So please
ignore [PATCH v5 13/21].

Cheers,
Andre

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark

