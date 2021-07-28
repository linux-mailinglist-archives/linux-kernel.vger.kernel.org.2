Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5E73D9965
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhG1X2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhG1X2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:28:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA21B60E9B;
        Wed, 28 Jul 2021 23:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627514893;
        bh=V3zJBaFzTHNYxbidYGufcLlftR+KGFH0ek4HfHUjcBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZ6UI2Evos2kGn60ionklymKHYjP60FqjpzLBozWzosPm661HOFUczbRptFkB0R1p
         LxPDdVLgpp9zbVGqRFGjkCQKTs4qS0+Vq5eFAYe8rkuniVqhDnmFwEKUdcXRCsdDxu
         kkRTFkh5JNr9oDp8+PyvXYAFjLy/2oTv1m7qEYgjbwjGr+8RfFznKvzwJIQZOUxeZF
         AFUjESw7E6H9T4DP3uICBQgaCtCZ5DweBkQp3GcQ8dHtIT6GQ3JQi0N2lNQmUDp/5R
         bcwQ8h6EZR1MEtEU16FlEcqP9GFhUes4I6OXoCjGXyi3SOIYY3S7Sq6G0Q7fc7Jpis
         M0udWRm9exdDw==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, sbranden@broadcom.com,
        Tang Bin <tangbin@cmss.chinamobile.com>, perex@perex.cz,
        rjui@broadcom.com, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: bcm: cygnus-pcm: Fix unused assignment about 'rc'
Date:   Thu, 29 Jul 2021 00:27:53 +0100
Message-Id: <162751391069.10122.16132233496782994388.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728124411.3168-1-tangbin@cmss.chinamobile.com>
References: <20210728124411.3168-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 20:44:11 +0800, Tang Bin wrote:
> Delete unused initialized value of 'rc', because it will
> be assigned by the function devm_request_irq().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: bcm: cygnus-pcm: Fix unused assignment about 'rc'
      commit: 14db5499d583e0952606fbca3eb37a0f28008d30

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
