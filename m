Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6DC3E494F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhHIPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235890AbhHIPzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:55:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A951361056;
        Mon,  9 Aug 2021 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628524502;
        bh=W3pO8W0KJSy21xkzS1pcJP2BKEiaIyTIyjakzt2o/Ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQ2j39Ajiy8hvDtZrnbFBe77bwYSpywu6kbo3bWaiwVvbZjb73PCxtcr0COshzwul
         5I3maLb0I6Fm1gV8IgTxyOgsRVQXlLIBGrfFJeNJmc8V/DgD3Vkwu4SYJgkMhwVGXz
         77MJMEwTT7ZaASkRKTTJ+HVb3/nBJ5xh9lgUoi4V7d+OdVY9ndSJOvuiBaAEGuedz9
         Gsh0aUu2qFu6Rt8u5D+M4WGNW7i/gknU5yIlggskG1qI9hw1SmWK+1EHdbQvUZlpca
         CQc8SeiBexX1WWcUnDvzam+FC45ryePDiBY8zbYdeA/QhCUtH/A04EPXi7q/AWqf+k
         3RL8fRtVdUNPA==
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org, Jack Yu <jack.yu@realtek.com>, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>,
        "Flove(HsinFu)" <flove@realtek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Derek=20=5B=E6=96=B9=E5=BE=B7=E7=BE=A9=5D?= 
        <derek.fang@realtek.com>, alsa-devel@alsa-project.org,
        =?UTF-8?q?Shuming=20=5B=E8=8C=83=E6=9B=B8=E9=8A=98=5D?= 
        <shumingf@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
        lars@metafoo.de,
        =?UTF-8?q?kent=5Fchen=20=40=20realtek=20=2E=20com=20=5B=E9=99=B3=E5=BB=BA=E5=AE=8F=5D?= 
        <kent_chen@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt1015p: add new acpi id and comapatible id
Date:   Mon,  9 Aug 2021 16:54:36 +0100
Message-Id: <162852418088.21716.15412811132955133865.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <22be83429956486f9f64b424c26be810@realtek.com>
References: <22be83429956486f9f64b424c26be810@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021 10:27:05 +0000, Jack Yu wrote:
> Add new acpi id and compatible id for rt1015p.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: rt1015p: add new acpi id and comapatible id
      commit: 6d0a764d418fb508119e129c73f39ecc66826675

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
