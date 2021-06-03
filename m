Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A1C39AA53
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhFCSow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230055AbhFCSov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0B4A613F3;
        Thu,  3 Jun 2021 18:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745786;
        bh=D4DdthttHQjPVVs8bcnSgzo5dFG2p7WOD3KmPPtd4OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgTxqJdowlsIODNjcTy8QVgVY1OuYQAmzrk+p7zRF4+P+QfYylER636fqD7ywKGS0
         vppY0gcr9/pJAgDVpEUUDEU72N8p+0un1M9u3jurrylMCtpPDknvDZ6oe31zP+HsUh
         4zXHBbIPR5QhJqk9G93ND+zb8dPdjXQmu42/4OAUNHAOEGBuW1EVMohSoPklI3Ohy7
         EZhj1JzNpesxDneDSvs+2//B/FP5tKL6HJVgGg116SoQ8OAq2Kx6GCqmzjmCQ74FsI
         nPPXVYbjVVRIJJg/lZnWAyiXJYxLAzIGLjuhYHcV6TkxLc73BVRo3WukgFwKZMGCfx
         XN3iBrYlKHM2Q==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: fsl: imx-es8328: use devm_snd_soc_register_card()
Date:   Thu,  3 Jun 2021 19:42:03 +0100
Message-Id: <162274557552.14795.6312030258048348306.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210602133359.310647-1-yangyingliang@huawei.com>
References: <20210602133359.310647-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 21:33:59 +0800, Yang Yingliang wrote:
> Using devm_snd_soc_register_card() can make the code
> shorter and cleaner.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: imx-es8328: use devm_snd_soc_register_card()
      commit: 28b170110a7683ee12af7e81f1b5868bc7fcb62f

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
