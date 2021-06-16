Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7263AA1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFPQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhFPQny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:43:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9E4F60E0C;
        Wed, 16 Jun 2021 16:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623861708;
        bh=ioeAO168Yh6yhhdj/iontbxxZY/BFU+tAk8S1ZGsojo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAbPyUBT3w9VRggAuQ/oknuxZC3/YWErAeRWyU1RX7UKKVz6nxZOVjZG91roWdL5O
         uRqt//NuLdPmE9b05fBdATZqNGcvFDcYZ9niacqhafmavWzoWSwsmtQlhXJM9dWFSZ
         gIEiBCr+w4sR3zzvDsqhQtrzsbCabvcp/XYL2EZxKfD1wORsLMO4bwzFqAXYZKWsJg
         7gwAP7Yva8pz3WCTWSGidPQl4K61KzqVy/1IChDJ3hbzqRBP0feaM2C3zMF05WR8SL
         g2D8Hv/yfzA3F1NnsNjZ8ugTOPp6SHCPsu1htqSeQU1pcb3g23WlCqTH5H/I5BPVEV
         iCpjGjK6EV59A==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com
Subject: Re: [PATCH] ASoC: hdmi-codec: make hdmi_codec_controls static
Date:   Wed, 16 Jun 2021 17:41:14 +0100
Message-Id: <162386001971.25644.6831890415877174309.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623822941-3077-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1623822941-3077-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 13:55:41 +0800, Jiapeng Chong wrote:
> This symbol is not used outside of hdmi-codec.c, so marks it static.
> 
> Fix the following sparse warning:
> 
> sound/soc/codecs/hdmi-codec.c:750:25: warning: symbol
> 'hdmi_codec_controls' was not declared. Should it be static?

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdmi-codec: make hdmi_codec_controls static
      commit: e99d7c69fd4c18e7319f8aab8e252b12130796bf

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
