Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2555A42A391
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhJLLra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236197AbhJLLrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:47:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5898060EFE;
        Tue, 12 Oct 2021 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634039121;
        bh=yPmGfrIx5fsPNeovUyGC2nx0U7hr1ByxkC91ZqFvywU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kx+uAsyNqvX2hV5qn2Ah1xUjmbfU6xwJ7DONv8uVHgnvWHtBAkCV9aEzhb5AsbEER
         tl2VH/EC37fCYXfoDsN9M4Xi+6nDagAHm7CGCD31ZdyJJflOT63dUP8DOiCfYV0JIO
         hZrJKklagjh/utfDpW3x+PBcvE03pu+o+av00XIk+h5c6FURuroNKuVipaDaeidpox
         avkp/mwKY4mKT+fb9jxRmRu8mXUxmKweZ3DsjbAEIRG/hSO2odcIudcRkfJV7SddY3
         7BoMA0ZGoGeV2iD+PemNDskaE/gZBOMIF2UP4TRdQvVxFh9AohtxRnIIloA8PcNEgI
         W5dl1uCrXUB0w==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs42l42: Ensure 0dB full scale volume is used for headsets
Date:   Tue, 12 Oct 2021 12:45:18 +0100
Message-Id: <163403898174.2091644.6707785151456646793.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011144903.28915-1-rf@opensource.cirrus.com>
References: <20211011144903.28915-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 15:49:03 +0100, Richard Fitzgerald wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> Ensure the default 0dB playback path is always used.
> 
> The code that set FULL_SCALE_VOL based on LOAD_DET_RCSTAT was
> spurious, and resulted in a -6dB attenuation being accidentally
> inserted into the playback path.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Ensure 0dB full scale volume is used for headsets
      commit: aa18457c4af7a9dad1f2b150b11beae1d8ab57aa

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
