Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44ECC40C838
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbhIOPYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238147AbhIOPYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:24:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3738611C6;
        Wed, 15 Sep 2021 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631719367;
        bh=wfCrkPF9uiip+dMt9hQgVwVQGgywxVqYrYAQt4PemHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uS+lULv9jwBDnz23rHC++bq3uxzQPTAOTeaM7Hvgi2cgl/5P9k5vGozDCXPjHhLvF
         oIz+FfbTEOYlfUYzuXXYMDgcsAjpfUilNTPlG+MSHOoZZ+b1rtIbWFKOsVG1NNUd8Y
         gEOtXaFuEIIZf5MkKeo5BFSAHDFcrgIg5joODAAQrPlLrkFplB/4YysjMa2ZRHnhdM
         Fy1hIRyMsYXW0WH3sI9tLTVismpNYEDDU6+V45+XLoy3ebV9KsZwmjdcZS6kFzGgAF
         LXG3QnezUEE6r9R6YvVr20JIZNWznKObj2yiW7xQ9fYWz5Nz0a0AWTzdi2xNDSfe6e
         JiRsmbq6kp6NQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, Colin King <colin.king@canonical.com>,
        linux-mediatek@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ASoC: mediatek: mt8195: make array adda_dai_list static const
Date:   Wed, 15 Sep 2021 16:21:47 +0100
Message-Id: <163171901943.9674.10990878164291138218.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210915105027.10805-1-colin.king@canonical.com>
References: <20210915105027.10805-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 11:50:27 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array adda_dai_list on the stack but instead it
> static const. Also makes the object code smaller by 33 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   28271	  11640	      0	  39911	   9be7	mt8195/mt8195-dai-adda.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: make array adda_dai_list static const
      commit: ce3f9357638720f4a78f6a6e481941c37f33bceb

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
