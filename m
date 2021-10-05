Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41027422CAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhJEPjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236107AbhJEPjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:39:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A133760F9D;
        Tue,  5 Oct 2021 15:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633448276;
        bh=dMaNVcV9n/AsE7FV5OdxX7BiQfijv6VpA9Xu4cdrapw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eS3PMGo5W7Dc/urhyhwMEbNZZrjk0emog2jLwrNLzjbAbGwKy718OEWvAJ+8gOKnv
         7UMz28kvv3b9Qqh7e+Vj1/TCdkJZZ0KIQS9TecjV1ykv3ZEnbI9V3O22v4eFjSSfut
         7lycsS63Do4K1eFjpMkINsSb4Qn1tKQdkVUFnpj5TOQtxJT7uq5ffsjSajJNXfN+Eh
         ED6zqWBGxYor6+RDAcwHzlMNpw0geAQJmRbIMDGqgIytPJW40RMXMORuScNvyrMdjz
         Q77siaMvFkQnEvhpFef03HsWcFCPSTIz5XxRYbSn9X7UYYndSIwrEnf8Gc0AiphShZ
         D+r66FQd0mvIw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: acp-rt5645: Constify static snd_soc_ops
Date:   Tue,  5 Oct 2021 16:37:42 +0100
Message-Id: <163344779742.1075058.2948246848855482699.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004224514.8783-1-rikard.falkeborn@gmail.com>
References: <20211004224514.8783-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 00:45:14 +0200, Rikard Falkeborn wrote:
> The struct cz_aif1_ops is only assigned to the ops field in the
> snd_soc_dai_link struct which is a pointer to const struct snd_soc_ops.
> Make it const to allow the compiler to put it in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp-rt5645: Constify static snd_soc_ops
      commit: d54aa2aeaa70237f4482336e86195235ea1de032

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
