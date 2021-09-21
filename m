Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB5413629
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhIUP13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233853AbhIUP11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4BC3611EF;
        Tue, 21 Sep 2021 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632237959;
        bh=MMbO/dp99d6AGhgnvypPqLozrpUzaCRHRwEsnb7xVcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zj/glYkLeYHvNm4rJBXMrstUrYxzgtl5fQlmUpnsy/JVmXmyeYK/ARNQ9YmJBZ8wb
         vS5g+AFFbz75mhq4UwHC+/hwt0oiva/SEPuekzCsNIiEL+AL5nMzx25vuFjHTQFehC
         CmxwdOlXJSJTdqdq8LDAkvE6Ysa0DBqwjOgEhRjfWElrM00vdezmOre3oPCWrBV41C
         IYYduHHmDocdWnYUI7IsdsPDEj7bsbxoi2x9A5NJzcC+HWaPzJjhlHSqjlQ22yBwhc
         O7yKp+VN79dbtryyel+kEnR8p7S3qiSd+iy+r3EGXhI6/XwuSyW5hSa9xWV1rt90LF
         P0KGMrYaZhb8Q==
From:   Mark Brown <broonie@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl: Constify static snd_soc_ops
Date:   Tue, 21 Sep 2021 16:25:08 +0100
Message-Id: <163223651320.32236.13916304424900961086.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210920193947.10237-1-rikard.falkeborn@gmail.com>
References: <20210920193947.10237-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 21:39:47 +0200, Rikard Falkeborn wrote:
> These are only assigned to the ops field in the snd_soc_dai_link struct
> which is a pointer to const struct snd_soc_ops. Make them const to allow
> the compiler to put them in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: Constify static snd_soc_ops
      commit: 815b55e1101f074e737c084e996d086dcb454399

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
