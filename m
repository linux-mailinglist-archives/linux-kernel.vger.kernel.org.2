Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2A3D01EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhGTSJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 14:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhGTSHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:07:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6139D60720;
        Tue, 20 Jul 2021 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626806905;
        bh=rCMKjEq6C3ShAT0LkuSu2FyDBlSMQ9aLoYabnytcWZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhauWUxMX8UMxiVxECw0b5xOU30vcxuoRz8kZFSzcp3D2YpplLjr3pppEg7BQb1jM
         VJedVNkYQkkFt3RMgnvse68VOrwG1MEojIbmsHUvKLfSoFcRGwi5a9gr2fGIfQ/Aeh
         SkTEwSQJ+NDuZO3Qsk7q4szxB/cMsCkxSM3Y+JHMTbXNqfT7AHHR3T20iwCbVo9qcr
         Sk4/mu8geal5aTTa0xaALnR9IdBAM6bJBuAtBjq/JKF0naMPnG0p3nFGOaSpOrx0B+
         qKezjftxZlj0C93g1yIZJeM5+f/7pamKd3lMj9G+wEigETrHKStX0kInyHP4VUIOHq
         JM52IZX0Q2lqQ==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org
Cc:     Mark Brown <broonie@kernel.org>, cy_huang@richtek.com,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: rtq2134: Add binding document for Richtek RTQ2134 SubPMIC
Date:   Tue, 20 Jul 2021 19:48:17 +0100
Message-Id: <162680666036.11349.4601537863555148106.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1626422636-29458-1-git-send-email-u0084500@gmail.com>
References: <1626422636-29458-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 16:03:55 +0800, cy_huang wrote:
> Add binding document for Richtek RTQ2134 SubPMIC.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: rtq2134: Add binding document for Richtek RTQ2134 SubPMIC
      commit: 4c922fd3d6fa4d51e1f5bb845548cbefd5de3d14
[2/2] regulator: rtq2134: Add support for Richtek RTQ2134 SubPMIC
      commit: 0555d41497de66d2f07ae36dcb46a32f0ff90d8d

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
