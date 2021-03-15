Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD1533C2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhCOQ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234697AbhCOQ63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:58:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2890B64F39;
        Mon, 15 Mar 2021 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615827507;
        bh=X9FXDjHHH0l74nuXFjYXBr5zguKiacAJ1oANBMdIGZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=duBgOd0ljdSkO8avX7XwWSobCC3nObKVXmpHaqjF8ge6/ueE/nayyuNDC2QsPpARu
         no4sZYRnR7VttD8SAFCu7vI9tS1X/13XivvNdX6qHKhJnfW0B1+w3THrzYzuTZ+l8h
         Ov2z5FEeHTt+eUDJa4HUnnB4gRwkk1XHYCh4caWGR1FcP3aQ9WZ2cpt+yxU1TSHNGl
         nJSxhgHMD++W/UVXSpeIxAOEJHaV//8aC2RZuYDD5+LXgjgiLdZ3ATDBoLo2+nC299
         RGVuTEg7dEg6Qr7zLKAC0ziGw+oWXKGmPmbcjP2RSOfkJMTrZfJqlxH1kPBpnAHQEH
         lFOJv5YIrExdA==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Wang Qing <wangqing@vivo.com>,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: codecs: Remove unnecessary THIS_MODULE
Date:   Mon, 15 Mar 2021 16:57:05 +0000
Message-Id: <161582734875.54882.47331867129357785.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615623786-16302-1-git-send-email-wangqing@vivo.com>
References: <1615623786-16302-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2021 16:23:02 +0800, Wang Qing wrote:
> As THIS_MODULE has been set in module_platform_driver(), so remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: soc: codecs: Remove unnecessary THIS_MODULE
      commit: a5e78cfbd50e33c19236f32693516380d1a61c34

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
