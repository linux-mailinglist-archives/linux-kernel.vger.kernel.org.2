Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46B33170EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhBJUNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:13:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhBJUNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:13:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A75E64E35;
        Wed, 10 Feb 2021 20:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612987971;
        bh=A1kfeid37u/WoghoCf3KlbXDtZBhqUtPSmHssGj2l1o=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=gWRI06LbIY4Y9owVVJzg+VEE5MbfUNK7IQFZkaXaHcItOAwZ2owqix+ohjZ9x3T7k
         ueQ+MlvYznZKJqradn9SF8QN38BE50uqid03xxx7jwPyMEZe30/4e95zDwhgM0N/GQ
         jYo0YDNqgnj8qOULqF3Yrk2lMtaA7gGbjeI//QqsEL/9LQYKXiygfumARn4jppoDus
         BvVm8Vhj4NXzZTmjmwGFLxpQNW7ej9xfMGZzX5tz+PZf8IWYzpALOGIrfXb+t6Mphx
         BMUW0PC9gwY4cMnwDrtNv6UmqrOpwauJ7wvWd6xj8i+LU4pjfRS920PrqVWkGEK2SL
         4+tg5bONLdifg==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Shengjiu Wang <shengjiu.wang@nxp.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, tiwai@suse.com
In-Reply-To: <1612771965-5776-1-git-send-email-shengjiu.wang@nxp.com>
References: <1612771965-5776-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: soc-pcm: change error message to debug message
Message-Id: <161298789619.5497.10810235891247531439.b4-ty@kernel.org>
Date:   Wed, 10 Feb 2021 20:11:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 16:12:45 +0800, Shengjiu Wang wrote:
> This log message should be a debug message, because it
> doesn't return directly but continue next loop.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm: change error message to debug message
      commit: b6eabd247db8bb2d013fb9a9451ecb04a44ee58f

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
