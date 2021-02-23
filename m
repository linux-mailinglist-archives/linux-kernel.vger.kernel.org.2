Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1278322BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhBWOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:12:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230268AbhBWOM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:12:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33FE364DE9;
        Tue, 23 Feb 2021 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614089505;
        bh=+JINFj2BPE5byrIfpTw8QQ0mFPqOXrcYF+2MPu/X51E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nYNLclt3aYnXo/uXYJYUbO3DNeNcflGBYWd5imEIlyGObH400D0zesBoG83XECPSZ
         rLeo2Nw8EO7a9fjrpLzrAfDqjmNoxEJpUUkfPEaZk1CGBWgHPZmljZ8tWEzIpTIbnP
         TfYbyjoq8aqOygl1fsXOrVRRXBYE2/LzAEGTgiRqrFTXgUxixcM2eI7TS+EsNfHQvV
         dCy6N4Zdq+7DXxmDKw78pIgsxKuAYRo9UNvPBSlhCDjJJje2XbWvciaH4uJxq/Il/E
         e1pUyRi0eZrMZ3cMcUrl1wA8GB/duBXa0DFl9Gde5mf0eIqVr+0Z082g+axgx4x4nL
         eT+puUbDHkghg==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210215163313.84026-1-colin.king@canonical.com>
References: <20210215163313.84026-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] ASoC: codecs: lpass-rx-macro: Fix uninitialized variable ec_tx
Message-Id: <161408943852.48131.13240298966962769896.b4-ty@kernel.org>
Date:   Tue, 23 Feb 2021 14:10:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021 16:33:13 +0000, Colin King wrote:
> There is potential read of the uninitialized variable ec_tx if the call
> to snd_soc_component_read fails or returns an unrecognized w->name. To
> avoid this corner case, initialize ec_tx to -1 so that it is caught
> later when ec_tx is bounds checked.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-rx-macro: Fix uninitialized variable ec_tx
      commit: 2d003ec15396cc8ffa2a887605c98a967de3078d

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
