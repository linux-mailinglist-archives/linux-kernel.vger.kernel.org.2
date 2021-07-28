Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6157C3D9967
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhG1X2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhG1X2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:28:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5392F61039;
        Wed, 28 Jul 2021 23:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627514895;
        bh=jKs2vwb9o0xiN7GQKe677wZ1TLjF+DReuPPA1627SKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCz5915orU5hvygX87AGjmlSVI++7uSL3g0dV5MZ57maKXHPG/DcF6vQKy+ZlDZbv
         4+KT16bFNpGYkT9c9wuAunMVQORbcmeKaVhSJ+ephy/vpAoznDnqx6/OKZzAcage2j
         Irt0soX1fLgTHAm2tKVOtX06dsUZVa5JblABwo9pDDxfzSmXT2WQxEAYm/BpHP/0kG
         kwmuhaqmdcPVRpiwsCcFYwkVrReAOzaAo9GDNIOSjzZ4N9vKME2ivSiSFzPcLQzVDt
         qJCVpnEKPDBcrxSSULYYpQdyCMm3djFGHjAT4jYhxvgTJnaJXK06s+Cb6kQbNFQwmF
         c+9ipdflznJ0g==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add sound devicetree bindings for Wolfson Micro devices
Date:   Thu, 29 Jul 2021 00:27:54 +0100
Message-Id: <162751391068.10122.4445316157453147618.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727164948.4308-1-rf@opensource.cirrus.com>
References: <20210727164948.4308-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 17:49:48 +0100, Richard Fitzgerald wrote:
> Include all wm* sound bindings in the section for Wolfson Micro
> drivers. This section already includes the actual driver source
> files.
> 
> Also update the existing entry to match all wlf,* sound bindings.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Add sound devicetree bindings for Wolfson Micro devices
      commit: 830b69f6c059bc46451e7c4be8b796d483acb0bd

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
