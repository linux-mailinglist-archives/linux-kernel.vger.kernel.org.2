Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F3D37A1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhEKI3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231299AbhEKI3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:29:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD14061944;
        Tue, 11 May 2021 08:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721688;
        bh=7C4N6xhr3iLJ06IpEWXsW6Mhbp8fwEkNVFfMBYJL4Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMLazoSVLczu9/tZp9358cwQQx7is/gIgfqItfeNED0/l9vyz3WWiixEcRLyRyGF+
         T4dJGl3TC6MYR0nu5j4D/brT9QowFo6as1cswCpldxk3DsNAWPR2VmE05OgVwTKB9p
         X9CZmjiEEJF2GTSwGj5M+oGbi4ZTNc0O3Cri0SKGObbNPelFgH8ed6etG1vDHArN5u
         6OIwtvBnQl2zTW9b9vUDnRjiD98mTgG7mf/QuDFCqMUhApoRJgY9t5UPL4KCZWQX+V
         KnnIFZuSpqdjLZa0gnX6EVlDWrkE1yUoo+DQ3C2Y0cz7lgwLy2frgqj23OuDiuC8Af
         ozX8P82HpQMJg==
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
        nicoleotsuka@gmail.com, timur@kernel.org, Xiubo.Lee@gmail.com,
        tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ASoC: imx-pcm-rpmsg: Fix warning of incorrect type in assignment
Date:   Tue, 11 May 2021 09:25:58 +0100
Message-Id: <162072058169.33157.6496454869060714703.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620268240-1005-1-git-send-email-shengjiu.wang@nxp.com>
References: <1620268240-1005-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 10:30:40 +0800, Shengjiu Wang wrote:
> The format in rpmsg is defained as unsigned char, there is warning
> when convert snd_pcm_format_t to it.
> 
> sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse: warning: incorrect type in assignment (different base types)
> sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse:    expected unsigned char format
> sound/soc/fsl/imx-pcm-rpmsg.c:164:43: sparse:    got restricted snd_pcm_format_t [usertype]
> sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse: warning: incorrect type in assignment (different base types)
> sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse:    expected unsigned char format
> sound/soc/fsl/imx-pcm-rpmsg.c:167:43: sparse:    got restricted snd_pcm_format_t [usertype]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-pcm-rpmsg: Fix warning of incorrect type in assignment
      commit: a387040ab401cc114d0b1a7a86431c5ae34b163b

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
