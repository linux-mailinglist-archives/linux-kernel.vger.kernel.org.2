Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434C3337925
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhCKQVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:21:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234538AbhCKQU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:20:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61EC164F97;
        Thu, 11 Mar 2021 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615479627;
        bh=d1SfHC9ERCHv1FJS48LlGyJSarikd6qR7aiqliJxVYE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bvFpZ93e1IgePYiLiG5qK9sH9KuAIfVWbO19+3y9I4emWmw/KFHyrWF02/sdBOIg0
         Jd3BeUud6HyWzZ5iQwQCbDU25PgJ7ZAjwf/3psIdv7pvXIRUliSC8273WfqcVY1mpX
         nu5ejz/Jph0e0XEJOw0bA8Add3kzEWs+R0kbdhljubhhBU9PGMKj+hhiFW1T2wIpCI
         wxApBoRERA3Y+CQv7NQgOEYUaBgNvGvy3WZO1JaiYkkY6S0tgv1Y1Pll7lrjsAqmNg
         fbKVI9NiukTp3NnQEQS4ngz/nq7kgn/JNQ+SaEnV3PadBsNXd5ltYm9hFAKVARgq/v
         WFdrNY1FFQESg==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20210311020558.579597-1-axel.lin@ingics.com>
References: <20210311020558.579597-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: mt6315: Fix off-by-one for .n_voltages
Message-Id: <161547955418.51732.7639052812148728093.b4-ty@kernel.org>
Date:   Thu, 11 Mar 2021 16:19:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 10:05:58 +0800, Axel Lin wrote:
> The valid selector is 0 ~ 0xbf, so the .n_voltages should be 0xc0.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6315: Fix off-by-one for .n_voltages
      commit: d450293c55005a3b0a25d209e981ac425483fead

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
