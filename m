Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C5D37A1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhEKI2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230480AbhEKI23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:28:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2C1B613C3;
        Tue, 11 May 2021 08:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721643;
        bh=yX814QtGmlEUeWuzc2cmSHioA1C9NjdHxkqLmgy5cKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5xIm9DM+030Fdr83Joy1qxFGvwXpAS2hTP40CQ1fNfYNNJGMxOAtyonkC1a3Iw/v
         eiTD0DIoy+H35+TeCSwENki8WroQChFQxRHnlVsnjZW3SQGbZoQr4+Z5K64LuYyPGM
         ndKgFUA7Pzahh3UJRC8dIcbtE3d2Eu2ZuIEHu26TsAHBgXG12XhvRZrwV9HY+nsVyP
         MlcgjnIlKf72qGar8T2bn9e+OaCEVQxn/Dr7LmaX+j+0HUzzx+VQZhoehfAmHY/gKA
         0PVxt8chNbeds9nGtU4By/c10hv5tSHq9EzwvqDIg5IKByjqyS2y8f4bVNVauXL4lx
         N7yXjfvtlBJAw==
From:   Mark Brown <broonie@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        oder_chiou@realtek.com
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com
Subject: Re: [PATCH] ASoC: rt286: Remove redundant assignment to d_len_code
Date:   Tue, 11 May 2021 09:25:43 +0100
Message-Id: <162072058170.33157.14418303282464363989.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620298735-31708-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1620298735-31708-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 18:58:55 +0800, Jiapeng Chong wrote:
> Variable d_len_code is set to zero, but this value is never read as
> it is overwritten or not used later on, hence it is a redundant
> assignment and can be removed.
> 
> Clean up the following clang-analyzer warning:
> 
> sound/soc/codecs/rt286.c:728:2: warning: Value stored to 'd_len_code' is
> never read [clang-analyzer-deadcode.DeadStores].

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt286: Remove redundant assignment to d_len_code
      commit: 1d122dd3b168f55e2e29982cff80f1c15f66ef26

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
