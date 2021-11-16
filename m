Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC94538C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbhKPRvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:51:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhKPRvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:51:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B340761BE1;
        Tue, 16 Nov 2021 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637084894;
        bh=U0uJnmvVRMMo7C3x8GRHz3KXCbkWYuBn1tLvqBuIMCU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QbvhBld2HUmsHAaSlaInRRARLBF+2DdnIRPCgmfd/27vtUokL3wzeP3gR2OkgSNiy
         6X+eZUK9FqiOwJ/p+h0U5G0j0jnRj475XrBuIthzNHnaFnvTPV3NgtxPciGkGNFmdH
         f8YhlN/FqLdAqDJafSy4APSreq6Q8bKoBKPuxxlKjJ+SG5KX8gSl7k60LxUpSyfhty
         xa/5JGPeyoufrJP42aFtxF4IlhSSvjJAlOSVpl5vrUkia7+MkmhZfmT+kDr/HWOtoZ
         qHt/qTPCq7298/6yajRsv41EBWs/i0itjDnRsLToPswBUttwG8I4jm+gqhYYUtQ9g6
         V+vThZT8JG6rg==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com
In-Reply-To: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
References: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/5] ASoC: qdsp6: fixes and improve error reporting
Message-Id: <163708489246.808719.13508862895307481528.b4-ty@kernel.org>
Date:   Tue, 16 Nov 2021 17:48:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 11:47:16 +0000, Srinivas Kandagatla wrote:
> During testing on a laptop we found few issues with the existing q6dsp code,
> first 3 patches should fix these issues. Also during debug we found that
> some of the errors reported are not very useful, so update error reporting
> in two places.
> 
> Thanks,
> srini
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/5] ASoC: qdsp6: qdsp6: q6prm: handle clk disable correctly
      commit: 2f20640491edda3c03eb6b899d0b92630d3d4c63
[2/5] ASoC: qdsp6: q6routing: Conditionally reset FrontEnd Mixer
      commit: 861afeac7990587588d057b2c0b3222331c3da29
[3/5] ASoC: qdsp6: q6asm: fix q6asm_dai_prepare error handling
      commit: 721a94b4352dc8e47bff90b549a0118c39776756
[4/5] ASoC: qdsp6: q6adm: improve error reporting
      commit: 0a270471d68533f59c5cfd631a3fce31a3b17144
[5/5] ASoC: qdsp6: q6routing: validate port id before setting up route
      commit: 6712c2e18c06b0976559fd4bd47774b243038e9c

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
