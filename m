Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6941DCD8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352057AbhI3PBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352041AbhI3PBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:01:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4B5461994;
        Thu, 30 Sep 2021 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633013995;
        bh=sJWGYBZqf8BOTrR9dSgrjAtHv/8U3zZk2TqxtbmT4TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oyKVbQhI+wpI4I50CEi9giUcePcyqeIUJGG0tRVlo0Fy26bk/vJwvGQdWtHmbHHZj
         ckg4jrgIQ1JbuR/RD1fAEA3qP04fRvINMaS6sB0J5BB9aBnap+ri+kj4MLhnybrrxH
         PsCpoJ7v1Jt5x2Y+ZdQ/zoHwc962I+5y9tl5mEu5Ol0iXBu44YQwSilQILzdSjlt5f
         WTLbvwWhMTbC4kPJ1mij25RpF4aEM+iLKv2FjJb29G9dGvQHowDX90F9PDuvkBLNYK
         URO4GVzVk6zb0ysBgQV3NfSPsVrEfh0STbBuF0d1WcOxb4LAYc5+FSMUscOhdVE2It
         CTF7X1CSNWlNw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-kernel@vger.kernel.org,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@vivo.com
Subject: Re: [PATCH] ASoC: wm_adsp: remove a repeated including
Date:   Thu, 30 Sep 2021 15:58:51 +0100
Message-Id: <163301248178.43045.154919758702051466.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929123217.5240-1-guozhengkui@vivo.com>
References: <20210929123217.5240-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 20:32:15 +0800, Guo Zhengkui wrote:
> Remove a repeated "#include <linux/firmware.h>" in line 32.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: remove a repeated including
      commit: 626605a3dfb5c538256e737a7a7ae3e18f3368ec

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
