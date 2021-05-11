Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F76D37A1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhEKI3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhEKI33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:29:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44C106147E;
        Tue, 11 May 2021 08:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721702;
        bh=eEtBAlCzd+59ejK63RAyKXFMKRoDf6dGtGXy/1g8kRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jx9WYSj+aqHv7LtdfiOExF0K/TdQ/I+e5BrrKTQbtJZeYpncvauQDkrsf6YfoMxks
         gNin9AYrwHcDgOXkq4q6BcwVF7W4xrlhP6xAVXt2lAab1hru8I70I1bW1LYNo+1nBe
         ZoV7XzgWdKR4Vi+ciafH+07YkcO4muwwqkoAd2k+Z8+NWyIiDLYCSF5qd41t42ubmK
         XInSi8hlyAwIztw14M6E9wdJT7HWww/4tKcYdefTv488eKAgjORdvMhRsyMtw8KADH
         5pLq93pOn+WiAZggdo3dKl1J/dSSxjpTawK4mebWQSZVUhl0RrGU3BRRJh7zaYLrU2
         M9CnEg48YiISA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Wan Jiabing <wanjiabing@vivo.com>
Cc:     Mark Brown <broonie@kernel.org>, kael_w@yeah.net
Subject: Re: [PATCH] ASoC: fsl_xcvr: Remove unneeded semicolon
Date:   Tue, 11 May 2021 09:26:03 +0100
Message-Id: <162072058169.33157.16301306834523283874.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506022452.5762-1-wanjiabing@vivo.com>
References: <20210506022452.5762-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 10:24:52 +0800, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> 
> ./sound/soc/fsl/fsl_xcvr.c:739:2-3: Unneeded semicolon

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: Remove unneeded semicolon
      commit: 223875a6fb8e26bbde3de675552d27b62e3ed0de

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
