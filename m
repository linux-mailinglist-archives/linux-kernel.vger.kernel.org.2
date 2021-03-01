Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB732A056
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbhCBEPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:15:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346153AbhCAXiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:38:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CACBA61481;
        Mon,  1 Mar 2021 23:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641785;
        bh=VvLYvJ0aIkonlcmlC5Homj2udF5HvWgNbKU0ABVOuPE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q6kuBlTmclg6ZJDHh3R6WSs/uy43Oa/PTlEJEx62NxwJ6Hrg1wlfZYD6aITbK8Lmx
         pkvRlbXq2zRqDqiOYSGzlLOUq+OQKbhlDSPsgS9bycF2EW+92KnzaCytniLiZDsQv1
         IJ8V6ZR56rVb1iXjpBirW86Ts48pR2fRf3oEEFP9wePKKxQFAk0+FGUn5jSwc7XrIF
         Dvyj4DXIDwaT/mrjZQjDbQOb8LZ8BMXwsswpUb9nQ003v5KM9etA5vzNl+PmzjEuxK
         yyzE6hW+liY5NW1Zc8uQt4B+uf4ViIxo+aPFuQd6fQphQTrZT/BWV11SaLVi98mlcO
         ctf8/ua2IXiWw==
From:   Mark Brown <broonie@kernel.org>
To:     timur@kernel.org, Xiubo.Lee@gmail.com, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, nicoleotsuka@gmail.com,
        festevam@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1613984990-5534-1-git-send-email-shengjiu.wang@nxp.com>
References: <1613984990-5534-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: move reset assert into runtime_resume
Message-Id: <161464168098.31144.2631005760387940700.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 17:09:50 +0800, Shengjiu Wang wrote:
> Move reset assert into runtime_resume since we
> cannot rely on reset assert state when the device
> is put out from suspend.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: move reset assert into runtime_resume
      commit: 0f780e4bef4587f07060109040955d6b6aa179a2

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
