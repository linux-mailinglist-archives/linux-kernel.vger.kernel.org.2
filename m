Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE0F39BD39
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhFDQeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhFDQeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:34:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2802D6140C;
        Fri,  4 Jun 2021 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622824377;
        bh=4qXiY0ciKLP8LPX9zwj+/O79WshKW6bFYbB9k+rr5Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwtV6jPRg1YTWDq0sK7oOGwUqxTv8oLwHuJlg5wQrm6crM7l3QpmBhdzNszQzh2K1
         plxPgahDzBrwghBY4SkFclKkT5Kq+InJzrj5ytX7GYP3GD489FA73u9Z4QO32/ZTv+
         K5pgKN8zeR+HDvy8k6BnvFOdxoa4+axXETKSlHPFDLYAEEYiEgPgW6LaQYwyF627Zb
         YGtV/l7XVKjctgPDhu2Uvav96JjSZPK2u1TgLB2Uc6OWseKeo7RylZVQKSH7UAH7y8
         y3BNLWoc5YcPLeGwkvUE6GXnbcUih2dvotNcoHUKUy0mp1s2q2iv/j8c0RC0E17aVY
         tv/mhxIp9hp8A==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, robh@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 0/4] ASoC: codecs: wcd934x: add Headset and button detection support
Date:   Fri,  4 Jun 2021 17:32:30 +0100
Message-Id: <162282419357.38836.12886872942740552175.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
References: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 12:52:26 +0100, Srinivas Kandagatla wrote:
> This patchset adds support to MBHC(Multi Button Headset Control) block found in
> Qualcomm WCD codecs. MBHC support headset type detection, both Mechanical and
> electrical insert/removal detection along with 8 buttons detection,
> Over current interrupts on HPHL/R, Impedance Measurements on HPHL/R.
> 
> Eventhough MBHC block supports things like OverCurrent detection, Currently its
> reported as a kernel debug message. Should this be reported as an uevent to
> userspace? like the way USB reports?
> Any suggestions?
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: wcd934x: add bindings for Headset Button detection
      commit: c6d25d5786090edc7299b32160644bb2e468c25d
[2/4] ASoC: codecs: wcd: add multi button Headset detection support
      commit: 0e5c9e7ff899808afa4e2b08c2e6ccc469bed681
[3/4] ASoC: codecs: wcd934x: add mbhc support
      commit: 9fb9b1690f0ba6b2c9ced91facc1fc44f5a0d5c1
[4/4] ASoC: qcom: sdm845: add jack support for WCD934x
      commit: c15d4b72098ca3055d98ce0d66127fe37a6a6361

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
