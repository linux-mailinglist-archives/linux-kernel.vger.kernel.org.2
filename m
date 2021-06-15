Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB133A83C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhFOPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231493AbhFOPRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:17:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CFF7611CE;
        Tue, 15 Jun 2021 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623770132;
        bh=LGwVPo0Y/aLPCEiDrC1crvd4LvwuYtE4FdfFxVWndSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgXwKoZMbnQccXof0lAWG6BImPv639MHdDL8jqBlZ927bZiyrnKASo3B9F41RpLoW
         aQi144EqOep3LuVJy2YSleQvrDK332SjvhywDNAe+qAaLYMLrq1CidINvtA0BVoTgk
         QaKpNb3w7r6A8DmufPsEzrnhulfv/sPZcl6xsdwOFfN1bAZeINC/HN/V24ZvoyWNzA
         uTljKZJTsNbqeaRVJTOaYFIGE+altl/ccr0mWV/kwUhQRqe6udVSvH/l6EgPz6HOKn
         bMKNqzHVmFyK9x02RdHWoWCGr4v4kB7h3gHBHuOwleyfhKFWhVkQk7NHJ6NcycHuh3
         c1XOUIax0yvrA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        sfr@canb.auug.org.au, Pu Lehui <pulehui@huawei.com>,
        lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, zhangjinhao2@huawei.com
Subject: Re: [PATCH -next] ASoC: codecs: wcd938x: constify static struct snd_soc_dai_ops
Date:   Tue, 15 Jun 2021 16:15:07 +0100
Message-Id: <162376540392.36156.3517885436389644399.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615113324.238837-1-pulehui@huawei.com>
References: <20210615113324.238837-1-pulehui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 19:33:24 +0800, Pu Lehui wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: constify static struct snd_soc_dai_ops
      commit: 355af6c0c09d4dd0d97fa1aca0ff797b64cd6187

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
