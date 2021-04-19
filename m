Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F265A364912
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbhDSRe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhDSRey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:34:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8B6961246;
        Mon, 19 Apr 2021 17:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618853664;
        bh=sDWUj9habLD/i+iNJ5PqHCdn74WREZM2NfWjpP2MevE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zhm4RO4Ezt2EL6WeQXNwUpJFyexXIp81UI2WV/XGjZSSMtRbKXK9Bm5CPy1MywAh7
         grgf44F45dSKHaXO1J+F1W5LGTbnNLstkx53e8XwdM39Y3dSJvAYdFtKPfXboPM67D
         QPUM+dfqQWRKi9w3zvN3KLbiBCDHv2tdo39Z0Y0sbwoV8sGTP0jH6GyqVGD39ihati
         l/bjBzKjQtOjQjB8QEdbpfUQ16OMwhA/XlNuoR5pN77ctf2Zxw/gx/d02lGUTGw6Mt
         cLVx35EE5NN+TzH5kZ/JT+PxvSGql5xFh1H2INqtFJHotm1g5ViICp2X/qk8zrXRGn
         9LdhBGXarnbdg==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: ak4458: check reset control status
Date:   Mon, 19 Apr 2021 18:33:47 +0100
Message-Id: <161885301896.45150.16197357933362327027.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1618826072-29344-1-git-send-email-shengjiu.wang@nxp.com>
References: <1618826072-29344-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 17:54:32 +0800, Shengjiu Wang wrote:
> check the return value of ak4458_rstn_control.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4458: check reset control status
      commit: e86a53fb64ed0a4749eeac2eccc7a6412fd3c920

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
