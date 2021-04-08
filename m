Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDE7358A3B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhDHQzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231752AbhDHQzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:55:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DB7C61056;
        Thu,  8 Apr 2021 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617900933;
        bh=UsVHxXwhtxO6C1oI6waKzeTDm3pWIG9eRG5PEkfaJsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3UZCM7JrYN3ubeZfioQX7f2h42ORE7juF8FqgeklugDqA2ixmes5UKy8d/zUQeO8
         b0GEC9VpdDNtPe0FxTtgNgxbH4AUG08AHJ7Z9keciqiu37FZDgelNnAWHJPDRkKDVD
         QBXMdXxArt6HrXStGx2lTYgXWqsiwfVHrTB6NW3hMFBfDeGmIXSIhjKlVdj+yd+hVn
         e4JDq9aRF5SqPxaxEpChryykf6pnuSuYpbU2AqS+1/5inPFgzlZgYuy/BF4e6OgQU6
         wqYKLr3R0aKlr23m1J3Kckjwl2OuM4EUMbHs5P8AQBmSnpX3p7E3RCh9C+uDV+wpyV
         Z4GLCo2SqAdlw==
From:   Mark Brown <broonie@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] [v2] ASoC: codecs: Fix runtime PM imbalance in tas2552_probe
Date:   Thu,  8 Apr 2021 17:54:39 +0100
Message-Id: <161790012550.16915.9175549460514503586.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408064036.6691-1-dinghao.liu@zju.edu.cn>
References: <20210408064036.6691-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:40:34 +0800, Dinghao Liu wrote:
> There is a rumtime PM imbalance between the error handling path
> after devm_snd_soc_register_component() and all other error
> handling paths. Add a PM runtime increment to balance refcount.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix runtime PM imbalance in tas2552_probe
      commit: 7b3f5b207da5116add56c335c5fb92cee140dc63

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
