Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533C2365F83
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhDTSgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233640AbhDTSgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:36:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FA5861002;
        Tue, 20 Apr 2021 18:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618943770;
        bh=HKbpvXHLAM1t6ElsV1/iQQwWGgvzf7wQs80yEisnqXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDvBMfU/nYYjhMV1nzlTSo3wP+ReFOqoM1bWFCM5ZYJ5i8neT7NWtkTqvmS/8MYPq
         c38hXu4fB4EbgZhGNa16tfvSOGC33vwCwRGcwVI1lKa0fcQshaxot6RhHP4xkx2j4A
         DUNVpR3qad+OBffW9RTy8NjEh6DE2B1fB1Z3c8yBjo0PnIcu/cXIM5gO4MynyAwNhD
         2jcG2nl+xDGbJXfuIB3P0FFnlpqowQWa3r7YKTrDmVTnWsi3iuvuRsV8NzVorEYda6
         YpwIzWRcznIKsOVI0620zJDQIbpnCF1dsht5hYI3qU41zgFFdA/kWaxx09v0BPziCr
         BMa7/raGiXO0g==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4458: enable daisy chain
Date:   Tue, 20 Apr 2021 19:35:32 +0100
Message-Id: <161894359362.35105.6842999052342514382.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1618915453-29445-1-git-send-email-shengjiu.wang@nxp.com>
References: <1618915453-29445-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 18:44:13 +0800, Shengjiu Wang wrote:
> Enable Daisy Chain if in TDM mode and the number of played
> channels is bigger than the maximum supported number of channels.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4458: enable daisy chain
      commit: 7342db3cddcd1d8ff54f4dff8c942e04232f1d6d

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
