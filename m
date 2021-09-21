Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5841362D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhIUP1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234093AbhIUP1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:27:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4739061186;
        Tue, 21 Sep 2021 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632237966;
        bh=jDRQXGf7gbvv7glyWY+HfhW+JY8gbICqnGlh6IrImGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBumJ/LmMXYS/Jzmek/MV0s4+Xwfg0CJ8SyfnLbcsNpGDlsevkr0K99DhGs3Z69dp
         MZrtXjdv4Iij9RLyIvguQObHDWPXZ8XVgr3kTdfYagbQbM+AulWv8mazC/fsN5+//q
         FgzL1cDEPBFRn859E4MboMinZNwQBCuPZ3D1VMhcPL8aylsIlcEfGn2y7UqU34B2f9
         2rJ6AIsAZR5/TW3ZCZMPq0hSLm7OKFaOehrDmUQm7fTHbkSC8A9ptvL4QEFMHeJi+J
         tRfBXErO17G3sP7evr6LTSEMWWvnJHPfEMuF1eSIAlbPAHeBd59Tk6Pmam2mDNHM7b
         d19KCuXHe8UJQ==
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, festevam@gmail.com, tiwai@suse.com,
        perex@perex.cz, alsa-devel@alsa-project.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_xcvr: Fix channel swap issue with ARC
Date:   Tue, 21 Sep 2021 16:25:11 +0100
Message-Id: <163223651319.32236.15669372544555545964.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1631265510-27384-1-git-send-email-shengjiu.wang@nxp.com>
References: <1631265510-27384-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2021 17:18:30 +0800, Shengjiu Wang wrote:
> With pause and resume test for ARC, there is occasionally
> channel swap issue. The reason is that currently driver set
> the DPATH out of reset first, then start the DMA, the first
> data got from FIFO may not be the Left channel.
> 
> Moving DPATH out of reset operation after the dma enablement
> to fix this issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: Fix channel swap issue with ARC
      commit: 74b7ee0e7b61838a0a161a84d105aeff0d042646

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
