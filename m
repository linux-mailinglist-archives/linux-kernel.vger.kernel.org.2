Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA43C5B10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhGLKvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234781AbhGLKux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34DDF610A7;
        Mon, 12 Jul 2021 10:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086885;
        bh=OfCsL/7RpVFp05/C1nKOj2hRMQDufAbg1HrN1OGJNKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAoezly+sWLAn9iBVct3L0t64C+/zJewvAOiuDN5Hs7kGN2JxO1Geqjg33dN6wA1v
         tUI009PV8HOE15S3PAe/t4W6OHJK9aVPOji1fJJG9HJn0JoDYx060UNP4MdAp45ANz
         9+9QMHWWJ7DgsAp7z8jbqkBs1QuE+CBJJ3Uu1PT4MzUE8D26NHdAgzjeqR4GfqMRHs
         nwXYmIWahhU8Vq5Ldr6ByhY7Kjnlz2DZ+HYfH62d1an1sn9N/gGY3l6CsweBihhN2X
         rvDI9iS2OuSgnbu6E7P8L5cYLPFT96FKu37emVzS2TqBz3TDWFubM3g9pCUdDRwn/V
         nZg0WYCTGfGpg==
From:   Mark Brown <broonie@kernel.org>
To:     Gu Shengxian <gushengxian507419@gmail.com>, tiwai@suse.com,
        lgirdwood@gmail.com, perex@perex.cz
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Gu Shengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] ASoC: amd: fix spelling mistakes
Date:   Mon, 12 Jul 2021 11:46:07 +0100
Message-Id: <162608623152.3192.15004401232403083134.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210706064207.672491-1-gushengxian507419@gmail.com>
References: <20210706064207.672491-1-gushengxian507419@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 23:42:07 -0700, Gu Shengxian wrote:
> Fix some spelling mistakes as follows:
> descritor ==> descriptor
> descriptore ==> descriptor
> contiguos ==> contiguous
> initiailize ==> initialize
> descriptiors ==> descriptor

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: fix spelling mistakes
      commit: f7c4fe9cffb0b8afbcdf6db5d3289d5441056b52

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
