Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A3537EB76
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380506AbhELTby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344456AbhELRGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:06:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28001613AA;
        Wed, 12 May 2021 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620839138;
        bh=YaoevDFjIY17vi4buq0/qeIINbcaxR8hvpNDDt/Y8Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbz+PqaBWaFpLm9myFUoqe64Z8wyRkdgRvG8sHMKSrz/ZLna0a70Ve83f7iWuI9Rp
         yr4sVbDJG8RpVv9MzWvsVAul3Ibf1DMA3HbkURzgnPfUa5HBg4VdZ1TYlFXuIDzWA7
         EfLjl6IENXZ2cF+aQ2TzonAPJM8QQkxYVsFvfHHxVvtBKLQrGArNBi+mi4bzT7kpPP
         Dvyw9kiQa6GDVhQ0YVLUZaUFzfm7lAz3fCbRO6q3oPK9euDIuXCshqMDGhcrZnzLJR
         r4q35SIrOd+0p7whlE6wHo4lMb3NNhDEeuRiUIMHrcffmLDFdSBnCoSI6dLrBbg/uI
         NZxkRePE6tsBQ==
From:   Mark Brown <broonie@kernel.org>
To:     Simon Trimmer <simont@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: wm2200: remove include of wmfw.h
Date:   Wed, 12 May 2021 18:04:41 +0100
Message-Id: <162083892846.44734.12299613001191386332.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511171514.270219-1-simont@opensource.cirrus.com>
References: <20210511171514.270219-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 18:15:14 +0100, Simon Trimmer wrote:
> We want all wm_adsp clients to use the wm_adsp.h header as they
> shouldn't need to include internal sub-headers.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm2200: remove include of wmfw.h
      commit: 7fe0b0981a1764d665877fa5febc5e8e0e64d2ea

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
