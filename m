Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2976837EB7A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380596AbhELTcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239597AbhELRIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:08:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43602613BE;
        Wed, 12 May 2021 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620839152;
        bh=37b6sYm47fj9tJA5pTEY7KlL0GHnz0MhaTe/CechS7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XcSm6+p3hy+PvvTg8/wLohTQBoLS8yJlYN2iqkYRmpImlZ3XtsOcp53Fji26Y2ADc
         NeTkQwIrSzD7TGVcWTASkL3BrSZ0qscMK3ddoS3V38aaGoVfmOPVIhhFjtjBPC6mRz
         R56qyynzQmbMlLhwGpHL1TO8JAZMOvGqQ+8xJ2X2KPvfCN+j6ntN3e/C/1KvXJqA2y
         u0+AeBDZM7xPdN3eZV61vkwLnt3SWeqAExhc9+j4MLTURbSIcokksQG5ZOAPPd1++c
         I/v6HfSdBLofCKWfQg5U2cejU7c5FovHIPw74c9Z8RA5z6s64reHKzTTNgN4LqI2Iq
         QIpBw30ZAQDJQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        clang-built-linux@googlegroups.com,
        kernel test robot <lkp@intel.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] Revert "ASoC: q6dsp: q6afe: remove unneeded dead-store initialization"
Date:   Wed, 12 May 2021 18:04:46 +0100
Message-Id: <162083892845.44734.12776647391535930277.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511190306.2418917-1-nathan@kernel.org>
References: <20210511190306.2418917-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 12:03:06 -0700, Nathan Chancellor wrote:
> This reverts commit 5f1b95d08de712327e452d082a50fded435ec884.
> 
> The warnings that commit 5f1b95d08de7 ("ASoC: q6dsp: q6afe: remove
> unneeded dead-store initialization") was trying to fix were already
> fixed in commit 12900bacb4f3 ("ASoC: qcom: q6afe: remove useless
> assignments"). With both commits in the tree, port_id is uninitialized,
> as pointed out by clang:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Revert "ASoC: q6dsp: q6afe: remove unneeded dead-store initialization"
      commit: 9b7493468fa7eeef2e86b8c646c0535c00eed3e2

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
