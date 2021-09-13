Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79B408992
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhIMK44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238934AbhIMK4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:56:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B1C961051;
        Mon, 13 Sep 2021 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530529;
        bh=kGs+OZXsbrIogk6381WUNP6EKwqGTAnYr3RIhU3WhAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDXyV3lIQc9EqHpNl20CDXwNBLMZImqhYXbqEmGkZMps+z+IpwxuijXlIyIk89VRN
         EV+dmoyy1eFCrNoZIWXNsDmdmT7jUYrA/klAUrM0aqA6CSGNiMF/XkXRxGqDqdsLyc
         xyXF1JIHbq+hcSd8z9FHrl9bH9KiSiWPS3YHVsJELy7EO1cns2uTeHT3CqADZgB0x4
         XMEar/d/bThNBNx39gGXiMXaE61TzyWoGaT+zN08ziyJyWS00PLjc1ja1dVIHnAKEw
         NNgj5uJjcYsEjE4ntf5tH4toXhq1yHs2nvxG/JS7/74FUUVo5LUZD6NgLDzEXMP3G7
         kGnMVkmoweHgA==
From:   Mark Brown <broonie@kernel.org>
To:     gearhead <ys3al35l@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: pcm5102a: increase rate from 192k to 384k
Date:   Mon, 13 Sep 2021 11:53:34 +0100
Message-Id: <163152996585.45703.8666875215162171211.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210907210130.116769-1-ys3al35l@gmail.com>
References: <20210907210130.116769-1-ys3al35l@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021 16:01:25 -0500, gearhead wrote:
> the pcm5102a is capable of 384k, but the current code limits it to 192k.
> This commit extends to 384k
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pcm5102a: increase rate from 192k to 384k
      commit: 0beeb330300f082e8b6849a9f83d34efa2578edd

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
