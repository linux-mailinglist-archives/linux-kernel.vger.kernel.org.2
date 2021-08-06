Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ED53E203D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbhHFAsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243104AbhHFAss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:48:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B86D0611B0;
        Fri,  6 Aug 2021 00:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628210913;
        bh=STQ4jFjhT2tAmblc4n9G9SuqeStkebra6JvvzascIDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlqQV+LjV79/5T6Sgc9AYyJVBE7WqUD0pgceK4Wl3br44c5rO547dKLvO94s8BZMl
         V8xpSEK4DtZRj7RG9EWrRPAC25M2VHzrfTzF4UethXekitZLBdFiP0uyVpFRQROyUr
         ECao3mAf63mONRJfpwAolwuY+vWnwA0aJ5Krshz+ra0rhz117qRQyvIUm8+cf5aXgN
         IApP4ynfieNpBS4O0MLOFaCORNdLxiOe7lLm+WTiFagMY3KEs3Z2kxPj5C4UhZd8mv
         o1v89LuEAJ5HSillKDoFiekthSutAYruewBrs+bjs0SOtH+InZJXiP6uRAJ2GmFzVK
         sfGMqdAI3roGg==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: wcd938x: add Multi Button Headset Control support
Date:   Fri,  6 Aug 2021 01:47:52 +0100
Message-Id: <162821054282.18754.16317109735589826799.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210716105918.7301-1-srinivas.kandagatla@linaro.org>
References: <20210716105918.7301-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 11:59:18 +0100, Srinivas Kandagatla wrote:
> WCD938x has Multi Button Headset Control hardware to support Headset
> insertion, type detection, 8 headset buttons detection, Over Current
> detection and Impedence measurements.
> This patch adds support for this using wcd-mbhc apis.
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: add Multi Button Headset Control support
      commit: bcee7ed09b8e70b65d5c04f5d1acd2cf4213c2f3

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
