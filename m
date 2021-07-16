Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214EB3CB960
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbhGPPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240620AbhGPPJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:09:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADBD760FF3;
        Fri, 16 Jul 2021 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626447978;
        bh=pGMxukKZvH4Y7JZQ4mlY+aiYhpQxmOjH0aesN0E4GE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NHcomHnIzjnFE4Y7jk/4gnhGA99I4JQSRe7Kw7jNp6C8grwiKtxa2GqUbgTq25syZ
         wR0MvkvZfAuWzDmn689aVruliGBpRbPege7ISey4ge58lfYyW/g+vwu8DxYmM4x/+i
         PvPQjcPv07U2smtfSBj0N13SwwOgCPYpV749/Uub3UlbbSjD6S3evmW8fgyuRPn6PH
         vyyucqgTIrWev/QlKM89V4tHFpp+IJRsCS4qUFuAe8M3njR+NWE6iDoBBaHy5rF3Tq
         Cj7A+0HXcf07mvPKxnMIuEqAeVmTkKjUJYqYJDg5AkCves1THzlY9JlnP2VBBtaRDK
         96M43IFPM9Z3g==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: wcd938x: setup irq during component bind
Date:   Fri, 16 Jul 2021 16:05:31 +0100
Message-Id: <162644746764.25983.14228885456148612746.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210716105735.6073-1-srinivas.kandagatla@linaro.org>
References: <20210716105735.6073-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 11:57:35 +0100, Srinivas Kandagatla wrote:
> SoundWire registers are only accessable after sdw components are succesfully
> binded. Setup irqs at that point instead of doing at probe.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: setup irq during component bind
      commit: f99986c0fcad8e1d7d842e9a636f55bcc6748da5

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
