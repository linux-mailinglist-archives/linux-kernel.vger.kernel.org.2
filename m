Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968F63AF581
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhFUSuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232051AbhFUStJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:49:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 548896124B;
        Mon, 21 Jun 2021 18:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301214;
        bh=sLgWN4s8GNDPO25dfpT1/TNRtfd/uI79Qq9d1BCDPn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okFEYST20zwXUCNHRYwS5D1ZL6h6+goigd12M/UhFB8z0WGZvIYE2YfCUKswCfqAG
         G+fx5IkxaPouvVCVuUGYLTTr3x1y70Wkha5xwjuoT5abJebF41ydOjjJfPJfxCHJI8
         +dI8DnXosBpO7kDuF0rrFo//Xbx6ACEr3cMgT0plEDmpNo0IjQUATivQAPdxqTCEOV
         hxf9aX8MbNUknFshx9/+tJ+7Q6uKPJX56F7N4ol+13+LiUSxQlKhaTXLsx5JaxngBo
         896sqShMb4LaYG9GyYgySi89N2LuRxt1rO9LWTJQhR+Wi9iY/bH8t6N/IHXwALZ4ly
         Byu/hFZPltQ7w==
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, tiwai@suse.com, perex@perex.cz,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH 1/2] ASoC: atmel-i2s: Set symmetric sample bits
Date:   Mon, 21 Jun 2021 19:45:58 +0100
Message-Id: <162430055264.9224.7571690631298505549.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210618150741.401739-1-codrin.ciubotariu@microchip.com>
References: <20210618150741.401739-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 18:07:40 +0300, Codrin Ciubotariu wrote:
> The I2S needs to have the same sample bits for both capture and playback
> streams.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: atmel-i2s: Set symmetric sample bits
      commit: 489a830a25e1730aebf7ff53430c170db9a1771b
[2/2] ASoC: atmel-i2s: Fix usage of capture and playback at the same time
      commit: 3b7961a326f8a7e03f54a19f02fedae8d488b80f

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
