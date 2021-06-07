Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257FB39E702
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhFGTDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231467AbhFGTDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:03:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0142361205;
        Mon,  7 Jun 2021 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623092472;
        bh=TqvQgPLw+SRotU9+5VQHB7MXw6yubtkFMcOggx44GO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cr2uIJbbpwj/zEHb8m+7IoQF/jDT1shTGqf1/prag2tGdzKoioJkN78TxtLSTmpHI
         sjHdskydyxDYAzhs8QTQn/YWW2so3TfQ557R9YJQlwTHqqsWCTevuHuF3+uSyE160A
         CeexD5w1Go8PsWhx2+RQQPOXrGMl3qwHmxaFYSKFrdIispdaGgwKkSzZmb2BhDHAde
         Qr+zr2tiCTV4j2ZXVQ+hZlzhmOMtfyqfDPkLdN30nzxfNW/1wEMUcA81vzTZAMHTpW
         jAOtBbQoKoOYhQVnggmuZY+ip2PpxsofQRIXsV8KK4V0/Xc+mJQvtBVzTEiCwflQM2
         AHZv7MxxRMf3w==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rk817: Remove unneeded semicolon
Date:   Mon,  7 Jun 2021 20:00:44 +0100
Message-Id: <162309220525.30523.10384429738666319055.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622802209-45031-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1622802209-45031-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 18:23:29 +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./sound/soc/codecs/rk817_codec.c:49:2-3: Unneeded semicolon.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rk817: Remove unneeded semicolon
      commit: 54f6731394520d706c3133aab17aa90434bcf1aa

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
