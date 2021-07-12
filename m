Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947773C5B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhGLKvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234541AbhGLKuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68DBD61106;
        Mon, 12 Jul 2021 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086867;
        bh=uRqilg7CCTiXiMk2e657oj18CYOzh/zfcgwLHSndPMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PKOxR9gVyRb/aKDarMb/OT2NEcDK9yFr2DEwpzFEDPFyQ/aQJAcIyCICNQRs/e8EV
         0SmE0cWC5yYdSb98+kyVV4/H9Xs9pycosczh12IikVberE9L3J20FbituhvfHI238v
         GzrkpG69UOm1Bes627oVpbIgkGJganlb7bdEwE7qLK5D4GLoR9a9qE4+rgU+fvoXxt
         u7JoTitIAku8r99u35O2Ncp2+Q5pT97h/QRE/sjYF1yWw/cyUP3lOjr4TUPy2iTenC
         kPv/gu3q2lZlTYv5YpRqIo2Lx0b2XiGq8lG4SPxdPb0QH1eaFiImLDfLcetDUNIVtm
         LJB7cHe0GukcQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v3] ASoC: atmel: ATMEL drivers don't need HAS_DMA
Date:   Mon, 12 Jul 2021 11:46:00 +0100
Message-Id: <162608623152.3192.2676358338088676059.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210707214752.3831-1-rdunlap@infradead.org>
References: <20210707214752.3831-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 14:47:52 -0700, Randy Dunlap wrote:
> On a config (such as arch/sh/) which does not set HAS_DMA when MMU
> is not set, several ATMEL ASoC drivers select symbols that cause
> kconfig warnings. There is one "depends on HAS_DMA" which is no longer
> needed. Dropping it eliminates the kconfig warnings and still builds
> with no problems reported.
> 
> Fix the following kconfig warnings:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: ATMEL drivers don't need HAS_DMA
      commit: 6c5c659dfe3f02e08054a6c20019e3886618b512

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
