Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA5143BA53
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbhJZTJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238524AbhJZTJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:09:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4D716103C;
        Tue, 26 Oct 2021 19:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635275218;
        bh=rkTbdhJreJu+/Dt15/a4V/IUMovkjM8fHEWaaAzawEs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g03LVhSkOLB1KkIYNHJUOmyzOY30+NPAZLdiPxvN+7SsfZLG8VF8rRQmnuE1HkMbR
         bMuuOPwrZNm3vzdl8njx68uqEbUCzEpmvvaoyC2IfWObnJyZ4mo45DOGNKFj3OsBTh
         pz9ntNrG1eyLo8AdjqRJk915YVoES7dKDZqDWCsE35WGxuX14w2bTxLDXgtfN8pw6a
         X8SJDxBswYUjwDIgTdZXfzryKjftAFdKXV3y4mgs1WWpRf/ysAOkPR5ELgwH/YuSkQ
         rgr3ZNxoko1GYPHk7X2btX+NkSXEtJ8TlN8tpdpci6tm3Grkvbv0JsJ1s3rGAI+xJp
         IKoyDq6iR4bXg==
From:   Mark Brown <broonie@kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1635260849.git.geert+renesas@glider.be>
References: <cover.1635260849.git.geert+renesas@glider.be>
Subject: Re: [PATCH 0/3] ASoC: amd: acp: Dependency cleanup
Message-Id: <163527521660.2033755.18271571479627858811.b4-ty@kernel.org>
Date:   Tue, 26 Oct 2021 20:06:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 17:11:20 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series cleans up the dependencies of the various
> configuration symbols related to AMD Audio-Coprocessor support.
> 
> Feel free to squash into a single patch if you prefer that.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: acp: Wrap AMD Audio ACP components in SND_SOC_AMD_ACP_COMMON
      commit: f41d2ece95e1b40a708d2f1d5170ebc594df6ca2
[2/3] ASoC: amd: acp: SND_SOC_AMD_{LEGACY_MACH,SOF_MACH} should depend on X86 && PCI && I2C
      commit: f31c9399738870d0ae8081a65f264f5d103fd180
[3/3] ASoC: amd: acp: SND_SOC_AMD_ACP_COMMON should depend on X86 && PCI
      commit: 4bf74f8e56054cf3521f646313301d19c331ba54

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
