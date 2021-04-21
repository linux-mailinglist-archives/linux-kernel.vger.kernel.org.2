Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1322A367320
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245477AbhDUTFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245398AbhDUTFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:05:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A85B161458;
        Wed, 21 Apr 2021 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619031874;
        bh=ZyDUAPH4Kb7Csms8OjB22FUGXxba8AST7W5zS12qq/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrbYrjYpQwo3Vjs/Nz+yKbOwxdXTMHJD7D7YZHNOV+8UNagjxFhjlLGPHk/bf34At
         wjfLM/NBLK4QZL5s0yYYeP/WFBEh4JjsONavE68ZcYkYwslrp+25Sw+fOPt9JJneI5
         X6C4Pmag7afEK+mAHBWHlcpserPFk2vz7mSZ2o+FMXufK0ewNCD/tYfNHGD339pyb1
         THsWEstdlVksqPdPYAhaDSe9sj3+EcCJu0rCllrT7CATbTgcrcEDvKBc/qO48SyNXi
         jHCLY8gOMzZPcRl6L4l0nR3ucHOhveSkM0JkhHiN/Bk7h/bb2WkVYaZlXYoBXvZ9CP
         XT3lUfRpBgrnQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        sanjanasrinidhi1810@gmail.com
Subject: Re: [PATCH] drivers: regulator: core.c: Fix indentation of comment
Date:   Wed, 21 Apr 2021 20:03:34 +0100
Message-Id: <161903035952.13561.1913032316850125430.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210420034718.t7wudu6xcfpahflv@kewl-virtual-machine>
References: <20210420034718.t7wudu6xcfpahflv@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 09:17:18 +0530, Shubhankar Kuranagatti wrote:
> Shifted the closing */ of multiline comment to a new line
> This is done to maintain code uniformity

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] drivers: regulator: core.c: Fix indentation of comment
      commit: 69b8821e293aa823ba8184c80370e7e21bde81e6

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
