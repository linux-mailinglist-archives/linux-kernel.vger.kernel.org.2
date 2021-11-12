Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0ECF44EE92
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhKLVaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 16:30:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235702AbhKLVaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:30:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94C24610A2;
        Fri, 12 Nov 2021 21:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636752441;
        bh=mf1NFqehFwwHUnvV8Idqyi02NlZ+oErngaqk4fic4S4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aDvpP+DFJB4bvRNscJMY96pS4qYVLznkd7+8ok6kJBnfEWAG6Rs/zP85uScisafOM
         46pLOY/FFDOT/1wXZK0DaCEQyUsM12cnD+i/GLMayaIDICqfqGaaGZB4Qpg76yJSP+
         5rdDFu6I0kWG6wyXtucDnhxWYhLy9iqpx2x6P+AsjwLnvsapkiFso/9MKWas9CANA7
         8Vr2e9ZBgnUZaHkRgMcgfaUt8YWDmqRwznBQmt/SOktpPwpkkyri0OISTug1cJb5pL
         4IgWcF5po7zI6YEXX7bqZaR4C/cfd8+EMTnyUqKmnSFUKcVq+7agKp/uOACy7e8hBb
         F90d4kadE61lw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Bud Liviu-Alexandru <budliviu@gmail.com>,
        alsa-devel@alsa-project.org,
        Colin Ian King <colin.king@canonical.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        sound-open-firmware@alsa-project.org
In-Reply-To: <20211108111132.3800548-1-arnd@kernel.org>
References: <20211108111132.3800548-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: build compression interface into snd_sof.ko
Message-Id: <163675243834.742274.3363954435285911217.b4-ty@kernel.org>
Date:   Fri, 12 Nov 2021 21:27:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2021 12:11:14 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With CONFIG_SND_SOC_SOF_COMPRESS=m, the compression code is
> not built into a the main SOF driver when that is built-in:
> 
> x86_64-linux-ld: sound/soc/sof/ipc.o: in function `ipc_stream_message':
> ipc.c:(.text+0x5a2): undefined reference to `snd_sof_compr_fragment_elapsed'
> x86_64-linux-ld: sound/soc/sof/topology.o: in function `sof_dai_load':
> topology.c:(.text+0x32d1): undefined reference to `snd_sof_compr_init_elapsed_work'
> x86_64-linux-ld: topology.c:(.text+0x32e1): undefined reference to `snd_sof_compr_init_elapsed_work'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: SOF: build compression interface into snd_sof.ko
      commit: 1218f06cb3c6e2c51699998bc17c0d9a41ab37a6

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
