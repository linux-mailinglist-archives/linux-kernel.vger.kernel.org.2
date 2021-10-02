Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE041F8A5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 02:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhJBAS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 20:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232508AbhJBASy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 20:18:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDD4261A38;
        Sat,  2 Oct 2021 00:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633133829;
        bh=VAVHnoUfr1vHRk1CPnvhgVB1qv+vlUJG4BZ/csbPNkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pkf6hRKvY5FWkI3Rtxyro/ALYWAw3LcLBdP7tAGoxaDHhGlmHGpfa1vRUQ6e0E3sX
         0bQ8RW7Ss6NRTW425fZb7tj0V/xlxZ6/Z/VRcvs6DKm+RctHFGKGxK+kSotlDd0zcS
         4Glo9NlX5s15PT3gSlbxV3rRCBzgHAVccLBSiipBgZ0X6vuXq12ystMaU+8SOoK8dJ
         j7luMQ2I9vHSFv64D2fAwiv4GLtDXZHLc1FxzNs6Fp0gZ1vckJxDgM0+n0A//GOKCX
         pNiH1Ml6jzYicXweoZMPEDdlL3t1PLojI6qa+u0GV/7NTnfuJUpJVezm4DQjfsjTZK
         msAU5Dmfu1A7g==
From:   Mark Brown <broonie@kernel.org>
To:     Simon Trimmer <simont@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: soc-component: Remove conditional definition of debugfs data members
Date:   Sat,  2 Oct 2021 01:16:33 +0100
Message-Id: <163313339122.45396.9113357063584478110.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930142116.528878-1-simont@opensource.cirrus.com>
References: <20210930142116.528878-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 15:21:16 +0100, Simon Trimmer wrote:
> This simplification allows the use of the standard kernel pattern of
> static inline dummy functions for debugfs code. Most systems will only
> have a small number of snd_soc_components so the memory impact is
> minimal.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-component: Remove conditional definition of debugfs data members
      commit: 0a43c152ed0666dc837009bae031b898ced95e5b

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
