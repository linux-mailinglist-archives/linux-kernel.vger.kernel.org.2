Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB09387D99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350777AbhERQeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350758AbhERQdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:33:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DF00611AD;
        Tue, 18 May 2021 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621355555;
        bh=wY55NAYe5MkIZJCvMDNA5zES2hne44anMPpiK/g6bWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEiZoQ69e2NBS5/So98B8TA4eKdWZImfLSJ7nCEXYCTmJdy1G9/AN0jWBifCHqEe5
         FI2o+1wRoAL6bM/sUTql50FH9oqOaS7xw4igEUBh2pAm4X/ggemHGH64Onfg61G1FH
         SGRSYvUQErJ0eKLupR6GO/NpnJJ+OGxHmha723i9gIPCUi91MjfeMGgDOsquzD5ahh
         GZLVwlbgC9kXsHhuDe509vYgH5uLCu5oJA/mjLUIAsuIbAMgGQzM36ujw7wugcxIC2
         bZVGc8Vp6vceM4DCoBbSvWB/i+0BmooiSNXqAktBtnUE3VvHjCnQOTT/l4duZZcM5w
         9kRWbsKcf0/pQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rk3328: fix missing clk_disable_unprepare() on error in rk3328_platform_probe()
Date:   Tue, 18 May 2021 17:31:31 +0100
Message-Id: <162135531446.37831.5863010309474559267.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518075847.1116983-1-yangyingliang@huawei.com>
References: <20210518075847.1116983-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 15:58:47 +0800, Yang Yingliang wrote:
> Fix the missing clk_disable_unprepare() before return
> from rk3328_platform_probe() in the error handling case.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rk3328: fix missing clk_disable_unprepare() on error in rk3328_platform_probe()
      commit: d14eece945a8068a017995f7512ea2beac21e34b

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
