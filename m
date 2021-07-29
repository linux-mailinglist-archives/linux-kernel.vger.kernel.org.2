Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3E3DAC11
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhG2Ttj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhG2Ttg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:49:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5109260EE6;
        Thu, 29 Jul 2021 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627588172;
        bh=buhNMFI+9VCWjOMaoYdJ3hTev3sxHngfjErEthfv/3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IbWSsKQyObaCDnAy1A09HilVYchZ3N2y2asBTI+1Ab5ayFnhNaiZGMNNAvPbFkX32
         gyIJM3lj3mCu0v/b1ScWnWNPyKWjJVcfYr5+Uef9kFtrVyP/w2QBgMigzMbPHvLjH+
         HcjvrMYwjgGqUDE9Nj5t0ow1yo2jkn9nqDigSXgsxubNZnjWctg/GUhBFmrDJ9YVFI
         rPkaIRxLuGMy4hPuGq8IL4oWvySDNvavmZXwThjpJ9fs+p+cAviE6EmM72W161i1Z5
         5u3KUuqzElccdiFkKwmASQqpUrcLS8UVrQ8V1AbhDn+eUTQpjycthSMmoQq8tn4tlR
         BBZS+4GJSVbMg==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/3] ASoC: cs42l42: Correct definition of ADC Volume control
Date:   Thu, 29 Jul 2021 20:49:21 +0100
Message-Id: <162758812271.3952.13208728919315614383.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729170929.6589-1-rf@opensource.cirrus.com>
References: <20210729170929.6589-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2021 18:09:27 +0100, Richard Fitzgerald wrote:
> The ADC volume is a signed 8-bit number with range -97 to +12,
> with -97 being mute. Use a SOC_SINGLE_S8_TLV() to define this
> and fix the DECLARE_TLV_DB_SCALE() to have the correct start and
> mute flag.

Applied to

   torvalds/linux.git master

Thanks!

[1/3] ASoC: cs42l42: Correct definition of ADC Volume control
      commit: ee86f680ff4c9b406d49d4e22ddf10805b8a2137
[2/3] ASoC: cs42l42: Don't allow SND_SOC_DAIFMT_LEFT_J
      commit: 64324bac750b84ca54711fb7d332132fcdb87293
[3/3] ASoC: cs42l42: Fix bclk calculation for mono
      commit: 926ef1a4c245c093acc07807e466ad2ef0ff6ccb

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
