Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE38B3A878B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFORcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhFORcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:32:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F06B861414;
        Tue, 15 Jun 2021 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623778201;
        bh=Rdz4u0dD548hQlAPF6EISilDnI1Xwl3Uw2h8hinLM6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2Kv5yC7k6iBREpyDqDVXPPe6gYHQi39CacItMwVySP3KNhQa8DnYoBgne/cX5RrF
         Og5g53RTE84HX/N9iLRo2ozeW8piIgjbn+j5Bl+jGl/Yk1KPVDrcGEE+USGoLUq3Vl
         ywPoBFiPBrStz56ttumZTtF/8tbN78zq7jmJtjzLIV6Lkgq8oTaNh5fc+NTF7xX1Sq
         MkYb2HYbJ/0rjes1HstDk1nAlM3yPcvVwTB+2BuOTfAChUEUCzaPwMR4jomA8baWbo
         UPVAUgn8G9ajv1wja79aTs3HgzelSgS3H7/vAGbmP25sQa754qoT8nk+1btQnAfycM
         XTJPuQcLCrmww==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: codecs: wcd938x: remove incorrect module interdependency
Date:   Tue, 15 Jun 2021 18:29:23 +0100
Message-Id: <162377763943.21612.12264093680635019137.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615094839.27237-1-srinivas.kandagatla@linaro.org>
References: <20210615094839.27237-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 10:48:39 +0100, Srinivas Kandagatla wrote:
> For some reason we ended up with cyclic dependency between snd_soc_wcd938x
> and snd_soc_wcd938x_sdw modules.
> 
> Remove this cyclic dependency by handling them in respective modules.
> Without this below error is reported during make modules_install
> 
> depmod: ERROR: Cycle detected: snd_soc_wcd938x -> snd_soc_wcd938x_sdw -> snd_soc_wcd938x
> depmod: ERROR: Found 2 modules in dependency cycles!

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: remove incorrect module interdependency
      commit: b90d9398d6ff6f518f352c39176450dbaf99e276

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
