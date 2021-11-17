Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FCA45508B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbhKQWej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241356AbhKQWec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:34:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6783F61B51;
        Wed, 17 Nov 2021 22:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637188293;
        bh=82ceyM9vLIZ5d639AKquHRPRlsJyYThu0VLcLZrUCsQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=J3RSmq8f5DtAtBMTpQuFXsUkdjHMe8QUYV+p3x5v+xz796JdL3g8Uv2Nhdw+lwCo6
         C73plujiJiR6fLtvWWbGALyLIZBTrT5w1+nkAiehFjvKxBKKHBuQDRT4NSC+JFO4s8
         A14gNpycG6xF8KXIjYVL36OCwe5J//tayhYUdcNvnpTWFozdzZkIhS/j2N9hXV1RQc
         Vits96ivmEMqmFFtvXAuJdr3crlKtSIezTZFNjebb2eCfjCl/PQwCoxunQRc+qYbly
         iGdOHWMJNN/CtwamBhT+R2pI5n1hLncm7Bf2C9juyZF0lPF89DUK/EPJyzgfgwru5f
         +IB1LYwt8JUQg==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20211116163901.45390-1-rf@opensource.cirrus.com>
References: <20211116163901.45390-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/4] ASoC: cs42l42: Remove redundant code
Message-Id: <163718829216.136850.12619030505977686878.b4-ty@kernel.org>
Date:   Wed, 17 Nov 2021 22:31:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 16:38:57 +0000, Richard Fitzgerald wrote:
> - Remove field writes in regmap_update_bits() calls where the code
>   intends that the field value is not changed.
> 
> - Remove unnecessary complexity from reporting jack unplug event
> 
> - Remove a PLL config value member that was introduced in a bugfix
>   but made redundant by a later bugfix.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: cs42l42: Remove redundant writes to DETECT_MODE
      commit: 976001b10fa4441917f216452e70fd8c5aeccd94
[2/4] ASoC: cs42l42: Remove redundant writes to RS_PLUG/RS_UNPLUG masks
      commit: f2dfbaaa5404cadf70213146a5b4b89b647d9092
[3/4] ASoC: cs42l42: Simplify reporting of jack unplug
      commit: 3edde6de090617adea18f2068489086c0d8087e3
[4/4] ASoC: cs42l42: Remove redundant pll_divout member
      commit: bbf0e1d36519a5cd2c08dc1348f997cd5240eb2e

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
