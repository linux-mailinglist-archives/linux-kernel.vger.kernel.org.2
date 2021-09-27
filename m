Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F92419D63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbhI0Rti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236851AbhI0RtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:49:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 755BD61058;
        Mon, 27 Sep 2021 17:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764862;
        bh=QCd1RE9uk5gfOWua6Z50eM66UhtO+cHtjefCVa26tZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5YU3lNkqn4n+vfFznu6hwo4pfhh9WFYiB+rPTlt1uJq9qedPSELaXeFggysiLxqV
         ZwLbrDItB86WZgaVXqsMYKUz2kbeWxrbqKbELmaaYEkvtRCfXnwFvxp+abCaHwgdsx
         ZJLBvO7BMy3VSz7hIWV9YAKzMg9mAtJtCZtNoWalaOghgRMy9t7G6Id/UbYbd1GvNF
         BLAmbLmXkHFQAV17ZLR0QHKRgYBV7ZW7AGlTR+qRxvHDtSwbXqPYHPg2CUvoUXq7/5
         pYw50HiWp35tgGPc2i0rIAC5DXQD6XqUk6xrFvD4SsMcUx5SlTqUJmKznbjV+gvANE
         C97ORyTubxc2g==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Masanari Iida <standby24x7@gmail.com>, lgirdwood@gmail.com,
        tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: q6afe: q6asm: Fix typos in qcom,q6afe.txt and qcom,q6asm.txt
Date:   Mon, 27 Sep 2021 18:45:38 +0100
Message-Id: <163276442023.18200.13893139404500279909.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210924070044.569541-1-standby24x7@gmail.com>
References: <20210924070044.569541-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021 16:00:44 +0900, Masanari Iida wrote:
> This patch fixes two spelling typos in qcom,q6afe.txt
> and qcom,q6asm.txt
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6afe: q6asm: Fix typos in qcom,q6afe.txt and qcom,q6asm.txt
      commit: d24d3f7288fb29d4cd05c6f005d8b123056fe618

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
