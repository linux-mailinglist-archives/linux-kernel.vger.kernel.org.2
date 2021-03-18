Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274AC340D16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhCRSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232597AbhCRSdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B61C64F04;
        Thu, 18 Mar 2021 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616092426;
        bh=INUFglOg/4NcYEYdVHMwtMT3NNATeYQ4j3gJCSWjojA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3R990ppNuoRbWXVfdPAWYN7kFdyxisgukohmfd44/69zUv0fBG/E+KdswzEABoG9
         Pzp8UIas+g17K7ENA5aVBRKddCb1YW/kcSa9pFX2OFVw/KWqIz+RAClAByhetIPi6v
         vQXf9+XVPnyeJTUO/KeTkaveljtbiH52P1eonULRyCmE/XMWr4eEDvbKU3l3ZhGzbG
         Rumw4PqjX2ZzeUg208w/WhzmkG0EusavX+HAEVM9tzT/UvGGJO+D6Z9OCqbhOsdhOI
         0r90O8grcLG1If5sCnqjxixDeTjFV++ZOc+BE8N67EWrxkT3tODSNqdZz3cRyb5lYv
         U8OarjWKvwcXA==
From:   Mark Brown <broonie@kernel.org>
To:     Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org, guennadi.liakhovetski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        andriy.shevchenko@linux.intel.com, Julia.Lawall@inria.fr,
        tiwai@suse.com, mateusz.gorski@linux.intel.com,
        linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
        yang.jie@linux.intel.com, amadeuszx.slawinski@linux.intel.com,
        liam.r.girdwood@linux.intel.com
Subject: Re: [PATCH v3] ASoC: Intel: Skylake: skl-topology: fix -frame-larger-than
Date:   Thu, 18 Mar 2021 18:33:30 +0000
Message-Id: <161609213720.41838.16025137962653847892.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210315013908.217219-1-nick.desaulniers@gmail.com>
References: <CAHp75Vdy083+5K=4sViwg8uNJ1_6agECYbjMSFEGXX9VTO85WQ@mail.gmail.com> <20210315013908.217219-1-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2021 18:39:08 -0700, Nick Desaulniers wrote:
> Fixes:
> sound/soc/intel/skylake/skl-topology.c:3613:13: warning: stack frame
> size of 1304 bytes in function 'skl_tplg_complete'
> [-Wframe-larger-than=]
> 
> struct snd_ctl_elem_value is 1224 bytes in my configuration.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Skylake: skl-topology: fix -frame-larger-than
      commit: bef2897d31b97852d80b38e9376ed5ef3a90b309

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
