Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8393E494C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhHIPzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235828AbhHIPzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:55:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 585C161040;
        Mon,  9 Aug 2021 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628524496;
        bh=vcdfpziR404S9Inxgldn37afl9+I3dbup99eK9aqxGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNhK56xUZLtUfoniWZUVjzUT91PTJeFQugmf6HM4iT3EcyaJweL7JIqkzRS4cDohB
         MAK2gigZ58SQ1tPT2yAWNLc6pg4KHpImDVAnhkKR7MssVjlgbBsCJ5FV36mKWSbHIe
         MnO7kSgVeDkcs8YCd5pN8xfNOCzPpj8ZNDRbqoLeOEJ2P1ZQLWnNUbxcAV441Z3jQu
         97D/1eVQE8ieQsXURdwdb8dUda82TvM+KVhZeKEq0gdrVza7BQABaqqP0Y1h4UCbjq
         rW3fjSKU5LA5xDEZxDiaa56Ra2e53/mEwAhRDeEczKs6uFvU8JorYiZA1zKMyc25Am
         dhhN8G96dwWiQ==
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org, Jack Yu <jack.yu@realtek.com>, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>,
        "Flove(HsinFu)" <flove@realtek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        =?UTF-8?q?Shuming=20=5B=E8=8C=83=E6=9B=B8=E9=8A=98=5D?= 
        <shumingf@realtek.com>,
        =?UTF-8?q?Derek=20=5B=E6=96=B9=E5=BE=B7=E7=BE=A9=5D?= 
        <derek.fang@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
        lars@metafoo.de,
        =?UTF-8?q?kent=5Fchen=20=40=20realtek=20=2E=20com=20=5B=E9=99=B3=E5=BB=BA=E5=AE=8F=5D?= 
        <kent_chen@realtek.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: rt1015p: add new compatible id
Date:   Mon,  9 Aug 2021 16:54:34 +0100
Message-Id: <162852418088.21716.5893582085716795538.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <ce9e2f298f0c4fc59f756c39736a297a@realtek.com>
References: <ce9e2f298f0c4fc59f756c39736a297a@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021 10:27:14 +0000, Jack Yu wrote:
> Add new compatible ID for rt1015p in dt-bindings document.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: dt-bindings: rt1015p: add new compatible id
      commit: 064478e4877c76b0c1fd1155934f226f1561aab3

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
