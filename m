Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0631C3AF56F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFUSt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232221AbhFUStT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:49:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FA4D61351;
        Mon, 21 Jun 2021 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301224;
        bh=7yUZDZlOIzDIa47OFbFJ/39Qwhe/+XOMMOCaPdtaBwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lD6c1pBHZwqs5eiQs8buzuuA9BfkqJolhjZ6EDv4VF4us1aV1CC0LUyTsb6VhIGp2
         E/becPsixhGwp4yQaCduiuDSkM/u6NQKgTxxGB+Gb+5l1ACSAQo9z+SUbO6AHK5wU8
         X35Wg2dinDz5gYfjdhPQPAcn+0z5czmkVkny/B828TD9H3VvA47bg9OSPoqp9nQuQI
         coxMZ68+/EyAh4aDiT0zJ68a6InuiFLM4sRM5KzBoYyeVu8s0vqXaciwdbVsUcTxNH
         gEgCasF2SK3G82tGxTq/RjJ854+IlLq7yVQYrjOCUJ9SPpaiBG7JDOM6U0YW5Nx5Wo
         2C7AKlzucp/Cg==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, timur@kernel.org, alsa-devel@alsa-project.org,
        festevam@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_xcvr: disable all interrupts when suspend happens
Date:   Mon, 21 Jun 2021 19:46:01 +0100
Message-Id: <162430055262.9224.10660705196927221469.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1624009876-3076-1-git-send-email-shengjiu.wang@nxp.com>
References: <1624009876-3076-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 17:51:16 +0800, Shengjiu Wang wrote:
> There is an unhandled interrupt after suspend, which cause endless
> interrupt when system resume, so system may hang.
> 
> Disable all interrupts in runtime suspend callback to avoid above
> issue.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: disable all interrupts when suspend happens
      commit: ea837090b388245744988083313f6e9c7c9b9699

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
