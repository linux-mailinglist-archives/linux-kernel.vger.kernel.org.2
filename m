Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64B23A6F92
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhFNT5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235539AbhFNT45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F76061166;
        Mon, 14 Jun 2021 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700493;
        bh=9BrKXrQD+oi74tGWcEiEkzvbIWYd6bnHC+gYS3fPliA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODI9FQJYo22izIiQbHH8d6ufa0jnMTDljnAEcK2Gg/EfeOm2dKocNuE4FPZzNqT1T
         zUNVWg/lm/3+dYg+EKEI1+gu2873WF7ksIHhIP2gEoR5mxwhgJELN33pgEvUtcyyyT
         C/k1zOIVX2vg4uOjc3MfDWaztg80AQe0KTFm1I4YJBeDMYKk7eJ4gTMCoVlkJfIhlM
         BP7z6GjNQI4JLzuA5tt+QCOHfSPSgPoQCLyttWfNG1EDwv0eHCUwiWV8eZm0LAylPS
         fCnT+mVnAYx1WPWPVmIme5CVTCPG8nF5Qbo3/kG3f7AYMKBx23RjYeYNXJvV6JgqJs
         OLgERF4IEGRmw==
From:   Mark Brown <broonie@kernel.org>
To:     timur@kernel.org, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, nicoleotsuka@gmail.com,
        festevam@gmail.com, perex@perex.cz, Xiubo.Lee@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix error handler with pm_runtime_enable
Date:   Mon, 14 Jun 2021 20:53:44 +0100
Message-Id: <162369994009.34524.13362380080934583613.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623392318-26304-1-git-send-email-shengjiu.wang@nxp.com>
References: <1623392318-26304-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 14:18:38 +0800, Shengjiu Wang wrote:
> There is error message when defer probe happens:
> 
> fsl-spdif-dai 2dab0000.spdif: Unbalanced pm_runtime_enable!
> 
> Fix the error handler with pm_runtime_enable and add
> fsl_spdif_remove() for pm_runtime_disable.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Fix error handler with pm_runtime_enable
      commit: 28108d71ee11a7232e1102effab3361049dcd3b8

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
