Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FF540DDB6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbhIPPQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239112AbhIPPQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:16:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27AFE60296;
        Thu, 16 Sep 2021 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631805333;
        bh=z+Swu9fngnnny68fKhXP7hyNI5xiB/rDMvMz/SuSfhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQFOimdhyJVVJu78eO/GPWfDdS+/6s1gKoW9iYVyGMgeZyUSn/MOpt24rordiG0FA
         Aga92tZi66mOrh7brYFIVfEYZW0toT4C9KtI8ghiuC1u1JFcZrUhMyUW8zjXuJPy/M
         aEQrVO+5auuHCsYMw4L2FnfDtxHWrPvYJGjwa3UDe3BjGCw7q1+xM5cGkXum3Dz6CJ
         Y5ybWs1mmce1plCz2XZL45OnHECxdraCCLfgxsNGI3v8LsqcRz+1qOBzhUNrqgly2X
         Au4SCnyHAGJjOzEFmDIw7Zs9ZsCldh4+IYyZwvW44po6+nYp6K3gC+5R7IFRHJ/5JE
         hvGwi3IchLnAQ==
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, daniel.baluta@nxp.com,
        Viorel Suman <viorel.suman@nxp.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com
Subject: Re: [PATCH] ASoC: SOF: imx8m: add SAI1 info
Date:   Thu, 16 Sep 2021 16:14:34 +0100
Message-Id: <163180495858.19842.9823230293550684001.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916073725.359561-1-daniel.baluta@oss.nxp.com>
References: <20210916073725.359561-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 10:37:25 +0300, Daniel Baluta wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Add SAI1 instance to imx8m_dai array.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx8m: add SAI1 info
      commit: 243442bcd98f11e21d9827c06a995acf9a6ddead

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
