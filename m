Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6279C3E7BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbhHJPU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239937AbhHJPUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:20:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 729D160F13;
        Tue, 10 Aug 2021 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628608828;
        bh=kU8MFV7YslYW2xJNL20kvQgQdTi2xb/hQWirMa3PqBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rgYcDxXhoTo3MejFlwZdWMwaKtKkIaT1sACghr0IryQ6KdEMyhmsh6bSz3aNyM6pH
         7jHUIBmTbIP0hHs342xow7Bh5HgTbx73M/VlnSMT7NvPtuKa3rLjUGOHGL2ueBtoYi
         Ao3JVCJYyLIsJmAuOxImrxq16qOD+DvsJ18SOO/x6/XhZk58A5wLARyh0YeEtKHLsN
         m6OZ6q5hijai+2TueBP6esygdWTvvmGp8JkfjEMNXaczYBY9nH2nR3i6qkOwkCt+eu
         lPvRT7OZJRjZFqb/F6aSPfoDJxoHf2W2VKYqww8CeYcz/VrmoxEbElUG4gj9sCSrMu
         l1eI9HMq9tSlw==
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org, lgirdwood@gmail.com, Jack Yu <jack.yu@realtek.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kent_chen@realtek.com, devicetree@vger.kernel.org, lars@metafoo.de,
        kenny_chen@realtek.com, shumingf@realtek.com,
        alsa-devel@alsa-project.org, flove@realtek.com,
        oder_chiou@realtek.com, derek.fang@realtek.com
Subject: Re: [PATCH] ASoC: dt-bindings: rt1015p: fix syntax error in dts-binding document
Date:   Tue, 10 Aug 2021 16:20:02 +0100
Message-Id: <162860604513.6045.15119662311844913843.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810020834.32414-1-jack.yu@realtek.com>
References: <20210810020834.32414-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 10:08:34 +0800, Jack Yu wrote:
> Fix syntax error in dts-binding document.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: rt1015p: fix syntax error in dts-binding document
      commit: eb7ab747efd600382bc2e9406ea1fc2a867e9804

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
