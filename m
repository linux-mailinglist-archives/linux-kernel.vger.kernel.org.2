Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1638A429517
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhJKREJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233463AbhJKREE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:04:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A433603E7;
        Mon, 11 Oct 2021 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633971724;
        bh=XzLkYgb353iqv9hAK+ZGEMsAqi0vlTmlnZMBZRVRF7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwIPLJIL5kpqYVsrm/wIrAyPirFKYQQCKFGkJCZ+qVbyVevkyba5afceg2tbQeOP9
         WDb9Ai+fhiN7JCPefeixY+ZV3OOBqvVWXYTZH5SVHSJpj0IzROOCeHarAXQyDyLwvs
         18S6JCcXtBry0nSVHE0kPF0F0cE5jiEgCWYvTtz5G1BIDwp/HRCTj5LHt0IVhu4sKi
         cCyludQmqz6qsmh7GSv63KWjDyJEEDEdS6p6qYa6l/S6ctP7305F02htFMtoQFsNh9
         93o/LI0IFHI0gRM9LC9wDQ6eNlhC++S2EfUogq5e6R2l+ft7f3zpuhEs5IgHl+ovpk
         n+/YnBtxr3lTg==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, tiwai@suse.com,
        lgirdwood@gmail.com, perex@perex.cz
Subject: Re: [PATCH] ASoC: soc-core: fix null-ptr-deref in snd_soc_del_component_unlocked()
Date:   Mon, 11 Oct 2021 18:01:44 +0100
Message-Id: <163397094549.6567.13611605791777369681.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211009065840.3196239-1-yangyingliang@huawei.com>
References: <20211009065840.3196239-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2021 14:58:40 +0800, Yang Yingliang wrote:
> 'component' is allocated in snd_soc_register_component(), but component->list
> is not initalized, this may cause snd_soc_del_component_unlocked() deref null
> ptr in the error handing case.
> 
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> RIP: 0010:__list_del_entry_valid+0x81/0xf0
> Call Trace:
>  snd_soc_del_component_unlocked+0x69/0x1b0 [snd_soc_core]
>  snd_soc_add_component.cold+0x54/0x6c [snd_soc_core]
>  snd_soc_register_component+0x70/0x90 [snd_soc_core]
>  devm_snd_soc_register_component+0x5e/0xd0 [snd_soc_core]
>  tas2552_probe+0x265/0x320 [snd_soc_tas2552]
>  ? tas2552_component_probe+0x1e0/0x1e0 [snd_soc_tas2552]
>  i2c_device_probe+0xa31/0xbe0
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core: fix null-ptr-deref in snd_soc_del_component_unlocked()
      commit: c448b7aa3e66042fc0f849d9a0fb90d1af82e948

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
