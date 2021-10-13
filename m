Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C551042CA88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbhJMUCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239096AbhJMUCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:02:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2105611F0;
        Wed, 13 Oct 2021 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634155209;
        bh=jnF9fcRu7yXZHVCLu2T4kmJ5wS9Wn3iOmYmY9ymBctk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlU91my6+As/ZlrtRFPb33MOJr04ueUWqpj04zpTzp9jpFLNwk65SvrefXTyGzguV
         dA79iV3/WT45uvvq6bwLVQDU81/0INNX94+hQ2H2DgIX2+0PgZnpY7f7vYVl+r1guF
         +4mxdNE36lW2F+IFgmKYSCchYbph6yMn3JtzdlyD7o3+4r9VO8e23VMvVHLWMbAIl2
         FC+IdC98SMG64v1gMcoqJm3hiZ9zXlklN4FAo3qTxLcHHgEbnis+TIGNwjXJ4Aa7QF
         b5TkXUsF1OVRD/XDVK/lzFvwhciXu2Q0s+bb11VIN/FuCVGRc/EMlqvB/e6vvK0qWn
         5/OJro8dxL9dQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: amd: vangogh: constify static struct snd_soc_dai_ops
Date:   Wed, 13 Oct 2021 20:59:49 +0100
Message-Id: <163415517073.1358186.17967517863564230911.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012211506.21159-1-rikard.falkeborn@gmail.com>
References: <20211012211506.21159-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 23:15:06 +0200, Rikard Falkeborn wrote:
> The only usage of acp5x_i2s_dai_ops is to assign its address to the ops
> field in the snd_soc_dai_driver struct, which is a pointer to const.
> Make it const to allow the compiler to put it in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: vangogh: constify static struct snd_soc_dai_ops
      commit: bd6e4b992bb0580232e900762c131d95a73808b7

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
