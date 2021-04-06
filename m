Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3592355A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347026AbhDFRkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233683AbhDFRkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:40:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25FB3613D2;
        Tue,  6 Apr 2021 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617730802;
        bh=qeca+b4H0nIapO5UzP/YbMsJrZpQiO+jgLRy/koUfyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RxlaIqbdu+c5tgETxhAEuDDllk3hQ+aY68reEb5SSpf9DHFe7FxoNFKFwM6Xvfx64
         C3Ga3Cm+WHhLRn0EG+q00K7s6kGSN21yau8FsCrKYVJoZ+MspTtj08/QoxLRdWTQUl
         +g9GdMyzLmTmHC485UiU5T69BkLgWvNqbgwQ40gKdR45ia4yoQKH9208wsW+aHJ5h9
         ZHuQMRR/pqjw3jc78ofJiVvOwplPw0TB4xzQx0q6Jfle7F4/RClXkcgEV79WJBTx7m
         ZLKR0HfBTkG9FiVsbdgJQTgLOTSbMO2ZKQwVbq997IpcHVpEiil4ekDy/dxhZmEgB9
         Gft/tBBSFZB0A==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak5558: Fix s/show/slow/ typo
Date:   Tue,  6 Apr 2021 18:39:39 +0100
Message-Id: <161773049108.51713.8947694519084093038.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1617458365-23393-1-git-send-email-shengjiu.wang@nxp.com>
References: <1617458365-23393-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2021 21:59:25 +0800, Shengjiu Wang wrote:
> s/show/slow/

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak5558: Fix s/show/slow/ typo
      commit: a43508995a913893c5f303e56415d06432b15619

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
