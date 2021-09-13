Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF45408990
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbhIMK4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239441AbhIMK4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:56:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B31660F12;
        Mon, 13 Sep 2021 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530524;
        bh=jjg6yzmoYmrgF/kupfGziCDMx2GVtuJGY7oPruMvnVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrrT8olopk85eVfPt+B6eBAre8D1nMrLOz9HALE8hjM1WyJcVSwNt+Kf6t6xrnj0y
         jv5CgAfOMv2lTIPy5fypia/YhLZ00ixv0yTwrq4qnB52NKJy0WEvD8r/28yBLArUa6
         umHdxhSjwMzLteVcJPngl1UPpeU7GQfd+nxm/R1/ojOES7h0Hcqlswt/nOmPeQMGR5
         ngfw5HoaafYETLg3fsNsp0+eee/FQ5X/cmb60qqR/PZF+cQ0+yL8xj1BczkK0yt/RW
         Uia9w7RCdtQIGtSgCQdPvK6iaiHcjLLKWdqbVeBMG/uzZkzjpCYXSFFZW0gWck8CN0
         r/ObDk9j3MdVw==
From:   Mark Brown <broonie@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Make use of the helper function devm_platform_ioremap_resource()
Date:   Mon, 13 Sep 2021 11:53:32 +0100
Message-Id: <163152996580.45703.9693182447056291147.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210901132742.31714-1-caihuoqing@baidu.com>
References: <20210901132742.31714-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2021 21:27:41 +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Make use of the helper function devm_platform_ioremap_resource()
      commit: c6b1b57469b4768b83e9ccc9bc3e5c2c7eb93013

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
