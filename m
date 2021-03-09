Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47AE332EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhCITIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:08:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhCITHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:07:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D709365230;
        Tue,  9 Mar 2021 19:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615316866;
        bh=hwI6kC4mBqrnC0CTov6gJku09IaTgZ+T/06Xvzo9GIw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CS43ATgXMarGu0GvJWBWlVVsyTKh5krHdovWQarBjU6g8WcGRimIgWThq+XGGhLU5
         qQaWSdStIszeJoLKHjzDNhUuMvviTC+0UgcOOnG4KzzMsWJT3jsx+M862iCUMJof4x
         VSfTw4b8Y1d7Rfcwxl+LVD8aqod8MWaiFFVFhXQv6Yvq4bQgSRXE0/wjHylu05ZK5G
         HilVqsE3Z9htt2PGxuyNLuJFICO+dYQ7rLxZDcJuEz/aSfveUofVbz6pmvPdfTtKu1
         g3FwH3J7lCG61iyLFcsyKGvgKS6WbfWBpou1Q9ekky9m0ZVvFVQGBgpMTYFusVSPJd
         2HBBOR8B7YAQQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Jack Yu <jack.yu@realtek.com>, Takashi Iwai <tiwai@suse.com>,
        'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20210309131458.1884899-1-weiyongjun1@huawei.com>
References: <20210309131458.1884899-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] ASoC: rt715-sdca: Fix return value check in rt715_sdca_sdw_probe()
Message-Id: <161531678411.49117.17895673664091013218.b4-ty@kernel.org>
Date:   Tue, 09 Mar 2021 19:06:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 13:14:58 +0000, 'Wei Yongjun wrote:
> In case of error, the function devm_regmap_init_sdw_mbq() and
> devm_regmap_init_sdw() returns ERR_PTR() not NULL. The NULL test
> in the return value check should be replaced with IS_ERR().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt715-sdca: Fix return value check in rt715_sdca_sdw_probe()
      commit: bcfb088e7686b45b1f323e92315954e97bf634bc

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
