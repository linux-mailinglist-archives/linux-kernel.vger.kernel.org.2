Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141A9406F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbhIJQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhIJQKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:10:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A12E6120E;
        Fri, 10 Sep 2021 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631290168;
        bh=6iwvSZ8jp5kA04e1JPK/6mq3OGC3NvF1BQ05VjMVO44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcC5QJb8RtxJmQaU4B5d5Mdkn6sEJg/KPx0G91ox3184J8N9EzSFWxk1eXPcICBee
         5lf5KiqJ4ZGpyLfB9y4kmS1RDe1WrgMXHcvTgNxxhK/efnCZlLHkJ3hIKBmQWcJEIq
         rhW/CKt+6BNFS5Ag+AT3v2njZlt8s2Qq+w8uswkVawHiDsBYHyR7KI9yVvbR+HYWn0
         36TfFaWGnw9VSy83g2InmoTMWH+YX6o0/Y224ROLV844IKkTqdGfXcygRq7SrJQp+4
         9mTUQwhdbb/hUZkwEXUyiBcH6+eB+64m72ZG2vma4t0LBvc+/vTohNZPz+hMQ5f/Hu
         x8AqofQYhapoA==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@gmail.com, Trevor Wu <trevor.wu@mediatek.com>,
        tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] ASoC: mediatek: common: handle NULL case in suspend/resume function
Date:   Fri, 10 Sep 2021 17:08:45 +0100
Message-Id: <163128974014.2897.15699318985041527361.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210910092613.30188-1-trevor.wu@mediatek.com>
References: <20210910092613.30188-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2021 17:26:13 +0800, Trevor Wu wrote:
> When memory allocation for afe->reg_back_up fails, reg_back_up can't
> be used.
> Keep the suspend/resume flow but skip register backup when
> afe->reg_back_up is NULL, in case illegal memory access happens.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: common: handle NULL case in suspend/resume function
      commit: 1dd038522615b70f5f8945c5631e9e2fa5bd58b1

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
