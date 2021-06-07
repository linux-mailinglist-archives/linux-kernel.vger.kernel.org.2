Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70C439E706
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhFGTDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhFGTDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:03:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD52C610A1;
        Mon,  7 Jun 2021 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623092480;
        bh=UDTIqn2KhidWbOKg/cr23HiqjigP4ZQDXXl9Gsm9qWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRp8nhd5dBUXut+2oL7HuFUNbcIrA7cnm2NnkD4l9Z4YWNmJE5Ggnsyg/7rgc+Xp1
         t1O8C1n+YMZeNfyRCJHUlwiVg6xuxkZnsYbonoq2fk+t5J4ykfB7E6fodBv2SSod5d
         AxH5IoDkSS/HgghvF3sbRCE78E9nEIyRWnQ5X3G2gJQMOrseU9PiRfoNG6z5eVKrJ+
         RSmLisb0RoMgMjS5kiqzfEvATczFn2pOcJEIEmtjPnSS22aHA0Ol9dn2EPXWAvp8CZ
         Jp5jleVU6LZf94Kc23fdHz4AyRyGvpog7LnSuoTX54t8GDq30CMp3Zuyz6sc8sz8C2
         4VSa1wfe1+pnQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Colin King <colin.king@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][V2][next] ASoC: rk817: remove redundant assignment to pointer node, add missing of_node_put
Date:   Mon,  7 Jun 2021 20:00:47 +0100
Message-Id: <162309220525.30523.8337033233150694025.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210603113659.82031-1-colin.king@canonical.com>
References: <20210603113659.82031-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 12:36:59 +0100, Colin King wrote:
> The pointer node is being initialized with a value that is never read and
> it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> The function is missing a of_node_put on node, fix this by adding the call
> before returning.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rk817: remove redundant assignment to pointer node, add missing of_node_put
      commit: d50b86b3f6abc4ff8a35f706a6b8251a2d4cf58f

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
