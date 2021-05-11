Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DFE37A1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhEKI26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231192AbhEKI2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:28:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8088961184;
        Tue, 11 May 2021 08:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721661;
        bh=bZwNskZK6whbVRkYR/FxCVOYr6eGNWoLmFHbNP1Bykk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQ4WpPWVjiT7lF4LPDtPbuZzKzy6jgdIZum25rFTpf9GbRYoL54DlXl7EdO6ytKrY
         3hacJ2IAxLFSRBEvswSz2DaGuWNQUpnzulpGqug7hIQI6BQSqTPJ+7unz4MZVeYIpy
         isUDQZOHV/D5FfB4ti95w+L6OOBVtSvTQ8j/4nDtOXUcOhzC/+kqPgXbnETuRvuw66
         go6tL/wnLR/wCEkewrMP1s4Xi0FuhKkPHq/tcNWRpXLVBn9gtLshkvZcMmCSMSHWHL
         h+sG8cC2M34IJ6matstAEeRxpaiDHmnVFKYw4PbTolUNVxn1pPw/or2Mh32XqXGyML
         SAKyjH7OH3ebA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, tiwai@suse.com
Subject: Re: [PATCH] ASoC: amd: renoir: Remove redundant assignment to pdm_ctrl and pdm_enable and pdm_dma_enable
Date:   Tue, 11 May 2021 09:25:49 +0100
Message-Id: <162072058170.33157.12138948493720742583.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620298590-29749-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1620298590-29749-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 18:56:30 +0800, Jiapeng Chong wrote:
> Variable pdm_ctrl and pdm_enable and pdm_dma_enable are set to '0x00',
> but they are overwritten later on, so these are redundant assignments
> that can be removed.
> 
> Clean up the following clang-analyzer warning:
> 
> sound/soc/amd/renoir/acp3x-pdm-dma.c:148:2: warning: Value stored to
> 'pdm_dma_enable' is never read [clang-analyzer-deadcode.DeadStores].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: renoir: Remove redundant assignment to pdm_ctrl and pdm_enable and pdm_dma_enable
      commit: 2fa74b31bb8170f34ec4dfa8455ff07d9ee9a7e6

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
