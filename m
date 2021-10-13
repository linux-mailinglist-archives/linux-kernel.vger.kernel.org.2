Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF24442CA86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbhJMUCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238928AbhJMUCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:02:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9393611EE;
        Wed, 13 Oct 2021 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634155206;
        bh=om0HazlAjz/5nUCLR5kLqslvvq5C7vKYnMkWeQTOsBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmI2cldZLk7dXlFCA6+ucpCFWa7lvxlNiJZYbWmw92AuUSrCbPFjjkciTpiDcIi2x
         4w17i9RqXDo6Ai1crmQVnvy0WmPbTGahMUV03YqK1H3ifwtkIpkFARIPGyxFkNBwKp
         y2VLt3mCy6NIy3eWKcMda9HgSEWEiRIqGbH/raO1kqGAD3L2GjVFJOJ2GuIogxquv0
         Qsac8OJXZLPOOFrOuq4d7EnQjbzuBLZzTe5UV/vf7fm0x9lP8vf+EzRHtc+fN1FdlU
         gxt4hqqYJ0eYO7Hsl90fSO52bLW1Y0n3RvXZxCDxGaeMyBfAc4kytdA2g3cH7S5RwW
         Ada7zRIhVddFA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Tzung-Bi Shih <tzungbi@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Takashi Iwai <tiwai@suse.com>,
        linux-mediatek@lists.infradead.org,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: mediatek: Constify static snd_soc_ops
Date:   Wed, 13 Oct 2021 20:59:48 +0100
Message-Id: <163415517073.1358186.16264637881632852203.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012205521.14098-1-rikard.falkeborn@gmail.com>
References: <20211012205521.14098-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 22:55:21 +0200, Rikard Falkeborn wrote:
> These are only assigned to the ops field in the snd_soc_dai_link struct
> which is a pointer to const struct snd_soc_ops. Make them const to allow
> the compiler to put them in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: Constify static snd_soc_ops
      commit: abed054f039a69579a21099dbb53aa008ea66d03

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
