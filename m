Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2E931920D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhBKSRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:17:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhBKRxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:53:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FD0164DEE;
        Thu, 11 Feb 2021 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613065971;
        bh=2ckM0Itoe8KHQDayjUMGE113zQzsTAROmq2TaKb3RZ4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N3WOvXdWJTec/f248/MJlsN5vDROuvvvIHkH/qIuLvyCt20E/DGl8cLqnF8nWoSUr
         WSJWP/gG2+/13PlPinIy/SufQhClbFn6glTdKWkfjkxxTk1WrZHaj0JzbUH/3DQj3J
         y/gAd8X67QUlMKhCWoQyOhfY2TXKPl6+ZkgLULMmwduz3skpd5n2w+VuFM5C1jujJy
         596kX8yIpBUiLSvd05hUvMnmEEbYqt+FCEz8h7tmCSpJb6a1M8kzTQoQYoGg6Sp4hc
         PHn+W9OrLDZLxQQx+9kCAyoXkI16ryMklXklnINj5QNN2Es2NqGXoQL1aIQgIMoydI
         zWBwFNJmnmWXw==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
In-Reply-To: <20210211172106.16258-1-ckeepax@opensource.cirrus.com>
References: <20210211172106.16258-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Remove unused control callback structure
Message-Id: <161306591793.11031.17865587228297741167.b4-ty@kernel.org>
Date:   Thu, 11 Feb 2021 17:51:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 17:21:06 +0000, Charles Keepax wrote:
> This callback structure has never been used and it is not clear why it
> was added in the first place. Remove it to clear up the code a little.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Remove unused control callback structure
      commit: 6e9586361e145cd688e525880e1f84c0ccf57566

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
