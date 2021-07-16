Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7943CB961
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbhGPPJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240742AbhGPPJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C734613BB;
        Fri, 16 Jul 2021 15:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626447980;
        bh=+ughgdT7PQsxP8d/yuM4LkU674j7Jk0PcAMExfuRTV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvDYBTNIxGOZjUbFWtMOFIOFD25sfOMLHu+4np/Jxp5IWrlGJC4SX2FRir96+6Ub7
         Q3I8OEad0K2ZC+qhJRDCKcFVulh3E7Sp6Tm4Qy256bK/pSKUCdFgEHRj60kQfuWl7R
         5XxPsOf7Mq6wO0WAFJRt4m+OZz0nbrotTLrqKKDNCEGCGGp0hvmTFk5EnSFW96iZib
         3rjgJDvUb6TFLhIXebTSslrygm2yB3yI8e3vaOZvgNgBhy2FXjeWBHqeAVGFy1Ze1O
         Vsx3OVF+aeiZE7HC+MV9GxaGZ+B8wlATnQRlC8NX5Ko26ydNu/kpExE5uBdhaCq2wo
         isrHnmtHZNDCQ==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, amistry@google.com,
        Jaroslav Kysela <perex@perex.cz>, nartemiev@google.com,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Sunil-kumar.Dommati@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Basavaraj.Hiregoudar@amd.com
Subject: Re: [PATCH 1/2] ASoC: soc-pcm: add a flag to reverse the stop sequence
Date:   Fri, 16 Jul 2021 16:05:32 +0100
Message-Id: <162644746764.25983.7997176464978252855.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210716123015.15697-1-vijendar.mukunda@amd.com>
References: <20210716123015.15697-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 18:00:12 +0530, Vijendar Mukunda wrote:
> On stream stop, currently CPU DAI stop sequence invoked first
> followed by DMA. For Few platforms, it is required to stop the
> DMA first before stopping CPU DAI.
> 
> Introduced new flag in dai_link structure for reordering stop sequence.
> Based on flag check, ASoC core will re-order the stop sequence.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: soc-pcm: add a flag to reverse the stop sequence
      commit: 59dd33f82dc0975c55d3d46801e7ca45532d7673
[2/2] ASoC: amd: reverse stop sequence for stoneyridge platform
      commit: 7883490cba002121a5870e786a1dc0acce5e1caf

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
