Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D43D2AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhGVQaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233947AbhGVQ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:29:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CDAA610CC;
        Thu, 22 Jul 2021 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626973830;
        bh=+rD2PKxj01stiGTanUKjIRztANneYKa/SZ3LruXgchc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icYx9b0swGiJQNxMBllLxkWlkhl++ExfWLPz5vQOGR9WLXdxQAY02thuCHIfRVy2v
         gXqWAbdIQXqcTlMfcYUuhAmvynD5aXJXIAGPwl2rDX2xSCSumgaAJU7Kj9xIKosw2w
         6ocfM7krt4dYE0PCoOUcl4yEYApADuYyIt5rIz8Jq036axqDSZEIXSlL5ypQ1ILKvE
         LzEQC/CZCb4dnscCSgMUUJHX3c+tlMmtcOX2fZSySbR3zFzRBBlxMd5YiN4uOs3COu
         G5mh0+mQfDc7tg4n14iXreSByLHP7dUMtpWa8w9JWKMDyc3JBlQ05cdoWtotz1AdIN
         lwKVMjej/wt6Q==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Mark Brown <broonie@kernel.org>, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, amistry@google.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        nartemiev@google.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chuhong Yuan <hslester96@gmail.com>
Subject: Re: [PATCH] ASoC: amd: enable stop_dma_first flag for cz_dai_7219_98357 dai link
Date:   Thu, 22 Jul 2021 18:10:02 +0100
Message-Id: <162697068327.1747.17528885369683390221.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722130328.23796-1-Vijendar.Mukunda@amd.com>
References: <20210722130328.23796-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 18:33:15 +0530, Vijendar Mukunda wrote:
> DMA driver stop sequence should be invoked first before invoking I2S
> controller driver stop sequence for Stoneyridge platform.
> 
> Enable stop_dma_first flag for cz_dai_7219_98357 dai link structure.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: enable stop_dma_first flag for cz_dai_7219_98357 dai link
      commit: 5434d0dc56bce4510109a431a7eb71ec5131ef0f

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
