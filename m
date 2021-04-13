Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B25E35E24F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346523AbhDMPJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232120AbhDMPJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:09:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 417CF613B6;
        Tue, 13 Apr 2021 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618326560;
        bh=2mrmh7KWeWnO3AgGPTiEPrsluOYYVwNB/gzeJ2AAmJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bht0AWlKxDnXY7xXGf9zBminX8JaUxZmolH/VsR+q7RN72k80Z6js0ybi135ERVrk
         XI3zkfLXZ1uoCCBDFBWkemj37ULTNeb2lqytJZqdoPYpQ8oiDAogk9Wkzjf/sHFvCR
         U/qhJUdY4I8fHe3T9AOWSmxMgx1AKZj868Veh6Il5T1euBsklGTxXGQqZ94rbsfyYS
         t4RzcicjkmiosXa9MA8G3UQ1OXSrGfqi2Wsx7lPTCatn5+tIeYdr950mj34Dd78N+s
         ehI5+QfOQXBsMnMysXUDFr4wKylXzXy+wKaJu84MrR/4b8OLw9EFZFDg0FSKfoUrw/
         kVFomZsah9Qbw==
From:   Mark Brown <broonie@kernel.org>
To:     david.rhodes@cirrus.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
        james.schulman@cirrus.com
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs35l36: Fix an error handling path in 'cs35l36_i2c_probe()'
Date:   Tue, 13 Apr 2021 16:08:53 +0100
Message-Id: <161832446010.49152.18429371778012715101.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <9fec48e75bc1d3c92626e6f6aca2344bda223379.1618145790.git.christophe.jaillet@wanadoo.fr>
References: <9fec48e75bc1d3c92626e6f6aca2344bda223379.1618145790.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Apr 2021 14:57:13 +0200, Christophe JAILLET wrote:
> If 'devm_regmap_init_i2c()' fails, there is no need to goto err. We should
> return directly as already done by the surrounding error handling paths.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l36: Fix an error handling path in 'cs35l36_i2c_probe()'
      commit: cdf20c3ef0e90b962e62ae7d835d7f46333285bc

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
