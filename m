Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84ABC355A89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347017AbhDFRkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233683AbhDFRkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:40:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A730613C4;
        Tue,  6 Apr 2021 17:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617730797;
        bh=CJtEtoK6Usq5ZVb5Hps4tfMcaFeKs2V1/aok3sqZF6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sely41ji6TP0/R3c6YoHBD1oVxObFry/ghjfuP4g46aSa2lM+7GL3y8VppwzXUa6P
         M1AVKiu73EBR03gcSKD7+tJMcxV+PMbMcMp278v7umomzuzZ4xvhfnxoKHW7Yz3Cwx
         wfiQQo6HiAcPyDe/giuH7f/Uqv5yHLSEaK/51zO8OAPgHIjfTPQGW8gcfYjU2PYMwo
         jft0sTlwPXhhrsdH6QlfU/vymG4VJYXLpe0noR2tEP31G2MufrLMS0gvLyYizgau75
         jkd2ZPLV8oPiHIiAASzrzjyxzHtgNqun4VjkkXhgpJ2pPeqYxMPG3QiSEN3TO+eQjQ
         FG1dQCMzr2AXQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, ckeepax@opensource.cirrus.com, krzk@kernel.org,
        geert@linux-m68k.org, srinivas.kandagatla@linaro.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        rf@opensource.wolfsonmicro.com, lgirdwood@gmail.com,
        nuno.sa@analog.com, alsa-devel@alsa-project.org,
        jack.yu@realtek.com, shumingf@realtek.com,
        Steve Lee <steves.lee@maximintegrated.com>
Cc:     Mark Brown <broonie@kernel.org>, ryan.lee.maxim@gmail.com,
        steves.lee.maxim@gmail.com
Subject: Re: [PATCH] ASoC: max98390: Add support for tx slot configuration.
Date:   Tue,  6 Apr 2021 18:39:37 +0100
Message-Id: <161773049108.51713.10192288839186913998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210405143801.29770-1-steves.lee@maximintegrated.com>
References: <20210405143801.29770-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2021 23:38:01 +0900, Steve Lee wrote:
>  Update voltage/current tx slot configuration support.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98390: Add support for tx slot configuration.
      commit: e5870bd0e40c749fd96a4e565497c789bee456bf

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
