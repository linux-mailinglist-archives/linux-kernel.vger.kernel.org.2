Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9819D39AA41
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFCSoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhFCSoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D825F613E3;
        Thu,  3 Jun 2021 18:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745750;
        bh=OhDeH7wWzA5gNUXZDplIugn3Ka5ziot0S7byMHURK6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SptbDN1CA+4o0pXZinDmdNi4hmt9q6XW8bgl+xZOSU4nIiMGC+bJkB1+AR3do6E3g
         Ffwkz7K1fmZTvjoLBWD1t/NoHacjsY90aS/xVTjc9uT2D+kYe4Zwp1gzEq+eNJw7UK
         lCOM7BSpbp3RMXgYQOmmFKbMsArqEvA5VRHaQP/siJs5f7soh4ff3ry8yS76XL13Vi
         4AKoYzgAotZSJN4l9I/K4I3OZVayBo3icmsLs0gOcBi2YoElFj/GQir7aZUOMh+UjG
         pWVzlWbMq1JiSLg6uIOf5wpDZ5RQTOumhcGoTbCatEkc2bs6YEx6gkHNvJHLaqWcir
         xNNJrgR62l44w==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: max77802: Remove .set_ramp_delay from max77802_buck_dvs_ops
Date:   Thu,  3 Jun 2021 19:41:49 +0100
Message-Id: <162274566701.14958.716535450165078033.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210523072320.2174443-1-axel.lin@ingics.com>
References: <20210523072320.2174443-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2021 15:23:19 +0800, Axel Lin wrote:
> max77802_set_ramp_delay_2bit() returns -EINVAL when id > MAX77802_BUCK4.
> This was a leftover in commit b0615f1da543
> ("regulator: max77802: Split regulator operations for BUCKs").

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: max77802: Remove .set_ramp_delay from max77802_buck_dvs_ops
      commit: 8f4ef0788c68bf99370a91df5cb83f90d707583e
[2/2] regulator: max77802: Convert to use regulator_set_ramp_delay_regmap
      commit: 8cdded982a6cf95d5ed7e3a014fb3d8dde6b3a94

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
