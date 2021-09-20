Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3DC411849
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbhITPd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241635AbhITPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:33:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0863F61159;
        Mon, 20 Sep 2021 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632151917;
        bh=8BrvNywnL/2fizTFpg68l//vyzBPBhEWeaGUMITqrRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RP3R7lsn7smRECTj02UEz2ApNXU3sjarbt1Sk+JzBJpFEuqSrNQKPYycY9IfONZG2
         EhljzTZvaXMdKWrPuDpytZKdrALkRuoSY7HIikNDk0xJJqgUkse+bZ3affVNDX6b2l
         w+FvAX5g4kNKlK5/k+PyNoW0PsD3V29kdDBP3teY3Igp3mca/hmT/IFcw8RFRkFuBf
         iMGkGLi3QOK2/4NZ/hu9lZ0kwke49nbWTLlxaZdNCQZuUBn72sOdygdEk/AqmoEuG/
         aeowRqgyxzrTOexhvOsyq1Z4hsygO0eFcSAkSH5wCnpGnnBhIbfjtOrNWRB6ySYqi/
         BPJKn8XmyTFmQ==
From:   Mark Brown <broonie@kernel.org>
To:     oder_chiou@realtek.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        perex@perex.cz, tiwai@suse.com
Subject: Re: [PATCH] ASoC: rt5682s: make rt5682s_aif2_dai_ops and rt5682s_soc_component_dev
Date:   Mon, 20 Sep 2021 16:30:51 +0100
Message-Id: <163215150720.38322.7115113856653513250.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1631955726-77693-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1631955726-77693-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 17:02:06 +0800, Jiapeng Chong wrote:
> This symbol is not used outside of rt5682s.c, so marks it static.
> 
> Fix the following sparse warning:
> 
> sound/soc/codecs/rt5682s.c:2848:39: warning: symbol
> 'rt5682s_soc_component_dev' was not declared. Should it be static?
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682s: make rt5682s_aif2_dai_ops and rt5682s_soc_component_dev
      commit: cf21e114f6f44fdb06b7ceaaee5f2c360883bd74

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
