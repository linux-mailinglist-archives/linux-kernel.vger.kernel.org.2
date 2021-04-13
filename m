Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E764E35E250
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346516AbhDMPJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230327AbhDMPJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:09:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 230DF613B7;
        Tue, 13 Apr 2021 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618326563;
        bh=At7aWxWurGsIOSo+8oSLGvP7YMSoNoS+cSZVclvAi+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sHezMDzyBYh2KZVH8LKon8RUa8rnvLNN7JlnLyo7aQIIzQvpQb17LcukbteGDujM5
         jGuY836+pQOG/68bPAQ2nyI+7YHRvNKmoCJ4L6ylgb4pOQQ+1oXocCe+d3C2FzpFIq
         ZyuiUvjk4xTVSoc3q6vLkf9UhQ9hnthnAARlpy91FZ5LDaOA5TBIs0ON9PUnV7igRv
         lW57rhE2wvIke5sDRLE9VNuKiJ8XfwG0Pu75VyRM1qL2HGTTvlSOET5iTYzAdl3sb9
         cstftTkhl7b1Bu3SKeGRYw0wDBMSZkqI0PB0TOag0dX2m9T7XD4jqCSDG76tPk9OjD
         1bdVW3LPpUmRQ==
From:   Mark Brown <broonie@kernel.org>
To:     Chen Lifu <chenlifu@huawei.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: sti: sti_uniperif: add missing MODULE_DEVICE_TABLE
Date:   Tue, 13 Apr 2021 16:08:54 +0100
Message-Id: <161832446010.49152.17428685818110323930.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210409015953.259688-1-chenlifu@huawei.com>
References: <20210409015953.259688-1-chenlifu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 09:59:53 +0800, Chen Lifu wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sti: sti_uniperif: add missing MODULE_DEVICE_TABLE
      commit: 462c47c2fcc26d838c82646a31d6e3e8fc01ce68

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
