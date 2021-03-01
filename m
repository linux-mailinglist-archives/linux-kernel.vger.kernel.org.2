Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A527632A04A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575611AbhCBD5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:57:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344105AbhCAXgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:36:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A464460C40;
        Mon,  1 Mar 2021 23:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641758;
        bh=U9KY075uL17cHjLwoFUiLbiSiP9SqIwNSTnM/y5bLxk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=soAfoHz23udT1nihIMXVoEl/L77zt8KvJoAzKKCODuzbMEu5IT+OVgyt1x+5Yq8wf
         K3cGs2JDA+ujba5QtnvOnPyL/Pc5pzjyTqPOVQ/hwzO9Pbh/69aEVgyZy/HjVMGagr
         Hl8ucZXw1YB7hI0UHumWDI4B6Y8FjdCKdRKERrCQtSdZHnhNWg6dw731UnIJ2Z+N7T
         PMUpSxHZLzHv2BagWK2BhxHeO9eek1Sj3qNT6mCR8bRUwlKbjea1Gs9ymNMXg6Ik2d
         ftxJvJyeNJHYflPEMbIv3KdCXmkZEKeOcU1Z+zIOc9fFeLMH31xit6If68+8bn5Snt
         bZaUK2DF9P3lg==
From:   Mark Brown <broonie@kernel.org>
To:     timur@kernel.org, Xiubo.Lee@gmail.com, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, nicoleotsuka@gmail.com,
        festevam@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1613983220-5373-1-git-send-email-shengjiu.wang@nxp.com>
References: <1613983220-5373-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add pm qos cpu latency support
Message-Id: <161464168098.31144.7601836731718414126.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 16:40:20 +0800, Shengjiu Wang wrote:
> On SoCs such as i.MX7ULP, cpuidle has some levels which
> may disable system/bus clocks, so need to add pm_qos to
> prevent cpuidle from entering low level idles and make sure
> system/bus clocks are enabled when sai is active.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Add pm qos cpu latency support
      commit: 6d85d770c171972c0f33f74b84bf0fedc111e89f

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
