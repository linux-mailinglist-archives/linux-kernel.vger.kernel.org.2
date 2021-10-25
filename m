Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A34439BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhJYQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:42:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234023AbhJYQmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:42:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3356160F6F;
        Mon, 25 Oct 2021 16:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635179985;
        bh=ba9GtGPfNtOwMPCt3kSDkLI8frIBBx2rXSzFjOC3Wko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5Gwqn5lgSAH2matogN3LILhwEg8zK14FLpzvOwMCN1arYUGxiZ77UprXzwG/BEbg
         wqVJx/Ebmpd2zvi+XyfprGtoi0tFXJLu9NePXUi44OjevycnV933IFblW1/e4lLiQL
         C89ge7jwT9TpgLrbuZTXoivVSJddBj5mWlpYh7gbwD23K2P2hZIpgxCRoU5ClDi35Z
         iJehKwwgf8o3qsRDQf0d31Wy6w2z6j4GgnuNBqxUm8t8Qr3BJBRPRLPh2j29qTA6Cq
         3U8hbYFh/cgjUbTuxLCiOaNS5KSB2Lq9aNo2oDaJpm+1Bktu8ZHipDemZ3QjyYR+jA
         QUYP9rwf0pyAw==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: cs42l42: Prevent NULL pointer deref in interrupt handler
Date:   Mon, 25 Oct 2021 17:39:24 +0100
Message-Id: <163517996156.3558038.13466013835438231170.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025112258.9282-1-rf@opensource.cirrus.com>
References: <20211025112258.9282-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 12:22:58 +0100, Richard Fitzgerald wrote:
> The interrupt handling code was getting the struct device* from a
> struct snd_soc_component* stored in struct cs42l42_private. If the
> interrupt was asserted before ASoC calls component_probe() the
> snd_soc_component* will be NULL.
> 
> The stored snd_soc_component* is not actually used for anything other
> than indirectly getting the struct device*. Remove it, and store the
> struct device* in struct cs42l42_private.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Prevent NULL pointer deref in interrupt handler
      commit: 2003c44e28ac9759200a78dda20c5f695949e3f4

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
