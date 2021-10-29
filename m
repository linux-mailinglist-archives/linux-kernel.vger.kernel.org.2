Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3E43FED5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhJ2PB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhJ2PB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:01:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DB51610FD;
        Fri, 29 Oct 2021 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635519537;
        bh=R5FzHwmSwQfQlpdo5i1wIaXeUju+mJBwvASYAGgavDA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=taS8SPLPWZXwfIEGI+GHSRCUfwkkGDlzisA08qBpDDbzMh4i26Q40AH2HwqIzy/2Y
         CpXHCt5C5nkkDkr1lPEmsxJcw4rtAZplhC84oL06IAGqAcRIp7vqyPqNKawgcPR6h3
         0MesEC/uJrUi1y5M7ETPZ9xQ0z4pmZTDHNpv8RaRP2ipSqwQES70hgAIWotsy5wMmq
         fsPCMgpYBUsr23VpN5mZvQtl1IpNBQ0HwwCq/m1IDWn4hduLdGcf+McQ1ZehpTzRba
         dpYhUINIi1u6ryqXyfI6fRV5WB9sXLDslfv+keKKP+qx8Knalr33DkKDZ31qDNSCV7
         xOVcPcrrpmV1Q==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
In-Reply-To: <20211028140902.11786-1-rf@opensource.cirrus.com>
References: <20211028140902.11786-1-rf@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 0/3] ASoC: cs42l42: Fix definition and handling of jack switch invert
Message-Id: <163551953598.3555751.8698233177978916153.b4-ty@kernel.org>
Date:   Fri, 29 Oct 2021 15:58:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 15:08:59 +0100, Richard Fitzgerald wrote:
> Summary: The driver applied the opposite of the DT setting to the
> wrong register bit.
> 
> The jack plug detect hardware in cs42l42 is somewhat confusing,
> compounded by an unclear description in the datasheet. This is most
> likely the reason that the driver implemented a DT property for the
> wrong register bit, that had the opposite effect of what was
> described in the binding.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: cs42l42: Correct description of ts-inv
      commit: 2a2df2a755172afb25f0883a52aedba3b67d8a48
[2/3] ASoC: cs42l42: Correct configuring of switch inversion from ts-inv
      commit: 778a0cbef5fb76bf506f84938517bb77e7a1c478

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
