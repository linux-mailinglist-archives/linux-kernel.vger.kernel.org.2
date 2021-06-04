Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E3539BD37
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhFDQek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhFDQej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:34:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13A5E610E7;
        Fri,  4 Jun 2021 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622824372;
        bh=9yhUSzn3yYDa5TaKiRajPiCZuGQ4F9eE3poqB/Isyu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcZnBfg6g5iLCndwauVfPagd4enk4nBl6ra1I7SCuggUVsSJN1s1kX/Spo2t9bgib
         d5Gy3VmAYmZwZM2mO2m2r+ZVvk2kgmDVwz7dX9guaSe5RcvNJWfgXLoNq1bAv9KPvI
         J8q8ZmqEt/Uf02JaBCY3Wq/2isASiVq2LM+DMBmJKR2y2gWWqEkmdZEVuIVfW0Df9P
         tgP4giBNrPI8YuzQG77qMrHpTqvkBmV7Wr696auQB2N0BIPdti4y3nng/sVK9pmtst
         32wTDETwHy76ByAyAxr2YDJJkkdw76EcuXZdOhqEQlencOENWi7BvU/W/Z6ba/uqlY
         p/QfkGmN9iOrQ==
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] ASoC: ti: davinci-mcasp: Fix fall-through warning for Clang
Date:   Fri,  4 Jun 2021 17:32:28 +0100
Message-Id: <162282419357.38836.16514328061509733520.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604072714.GA244640@embeddedor>
References: <20210604072714.GA244640@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 02:27:14 -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a fallthrough; statement.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: davinci-mcasp: Fix fall-through warning for Clang
      commit: 50d790012a48f0f2f1dc8e4c214054283e529ae9

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
