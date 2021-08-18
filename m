Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90B3F0912
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhHRQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230078AbhHRQ1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:27:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4B6D610CB;
        Wed, 18 Aug 2021 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629304021;
        bh=6acFwTMZIC6gk0x6yoAGFSCVjV5LISXXZQTTQAHwKxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hj41TU7kRliPxrAO5KkTX+iNLT3ONSLN3tmUyUUwGkQzp/k5Z5RKGT5oJHHkJNvbQ
         DQVOua9uo/QANQZGqFMr5798Mm28kGLlDcOKM4QwwIi0vEjAhFCbuI3uu+U15MuzZa
         462pDek0YTmlB2lI+wWlU9r4y7qB6/8Gyy2GgQo2iU8PZhbvVdni5dBEUjSliipc0o
         RAsDzmwvQSWSV0VIiDpLVcAv5Xi/etOGCw/ow3tzWp65T+m5SjXz8vyEBq8cJsnDlR
         dAxomcM0jWyJCWdYzDaU+YZ+bAJ8nUCri1EMQwHGYp9aZoFAa82N1RzQUJOpKrlCOj
         P6NqyraEZbKCg==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, timur@kernel.org,
        alsa-devel@alsa-project.org, perex@perex.cz,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_rpmsg: Check -EPROBE_DEFER for getting clocks
Date:   Wed, 18 Aug 2021 17:26:32 +0100
Message-Id: <162930349966.11010.7849823203473029819.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1629266614-6942-1-git-send-email-shengjiu.wang@nxp.com>
References: <1629266614-6942-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 14:03:34 +0800, Shengjiu Wang wrote:
> The devm_clk_get() may return -EPROBE_DEFER, then clocks
> will be assigned to NULL wrongly. As the clocks are
> optional so we can use devm_clk_get_optional() instead of
> devm_clk_get().
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_rpmsg: Check -EPROBE_DEFER for getting clocks
      commit: 2fbbcffea5b6adbfe90ffc842a6b3eb2d7e381ed

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
