Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDFC38934E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355129AbhESQMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355120AbhESQM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:12:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C0366135C;
        Wed, 19 May 2021 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621440668;
        bh=BpEWDeqg3R68V6T7566z6Bx/lzRY+Uvhv0u2064aDFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VklT4LdLJ+PBUxmGFfgtzzXe6jYVCAggFhWaAs+wa2r43gaJxOTwmD9TiMPtDGzag
         ujl+RiBrcRl9SQP1Fo1rwblXyIdcUj8x55tIV/aewwckkxtU+T+3Cr8m017RQMmHgI
         IBLJIio1Tv2tDu56k9jay7r9luxQoI2FLqrpVvx44nDFMOzXYhbWV2wnNMlB3Kkfa4
         Z1SuG9OkB3y/y9Limod3YjV9/brmptOBAAll9MTQO5WWaNB0+DqSZzkeIhXlvJwY1Z
         uhP/iF+C4EjHWQwj1I+mdAY4A3EG4IP38Rq7B67RVk23Qe6fPgy1JOiWjMhi5iPQS3
         xyqX0eVKGuuMw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH] regulator: Check ramp_delay_table for regulator_set_ramp_delay_regmap
Date:   Wed, 19 May 2021 17:10:12 +0100
Message-Id: <162144038078.37201.5668030083456156364.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519075024.1644990-1-axel.lin@ingics.com>
References: <20210519075024.1644990-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 15:50:24 +0800, Axel Lin wrote:
> Return -EINVAL if ramp_delay_table is NULL.
> Also add WARN_ON since the driver code needs fix if this happened.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Check ramp_delay_table for regulator_set_ramp_delay_regmap
      commit: 687c9e3b1a81d43b233482f781bd4e20561bc390

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
