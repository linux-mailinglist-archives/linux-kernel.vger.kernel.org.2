Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED53B6731
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhF1RE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:32846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhF1RE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:04:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 831D961990;
        Mon, 28 Jun 2021 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624899751;
        bh=9ukzXv50aGZmH9gGkHyr+ybrS/tH2apudR2p8o7uX2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkVv6/d52YYiTRAzD8hFtb9UcOkGCmPXUf7QZm2bb1bofrIkANjVRkdFC6DHQGcno
         zEF12yh72rLoM8f1/ITzZv4SCb8Vn53LqNxOg+kQ1U+Em09TewYhZD9rwBmMUno1Yk
         /UpgbhT7Ww8z9fNvb0tMu5UPK09v9idKJqC9TeipqHAhWz2QYHQpCMxT9iMy241sDa
         QgZ2mPUWzAZwdMiqZoqKKvLn0bFbIeFXca9Az4uLDAZM4zeOuehxhtv5oIP68Q0BkG
         jNfPWjWesYzB3mgBXtucZZh/CNi8AwavpPO+nRohhy0XZpLg1c2sKfLq+n4Zkk1dRr
         o+EyHBSfT5V9w==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>,
        Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH] regulator: rt5033: Fix n_voltages settings for BUCK and LDO
Date:   Mon, 28 Jun 2021 18:01:58 +0100
Message-Id: <162489955393.5196.4842441856639308115.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210627080418.1718127-1-axel.lin@ingics.com>
References: <20210627080418.1718127-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2021 16:04:18 +0800, Axel Lin wrote:
> For linear regulators, the n_voltages should be (max - min) / step + 1.
> 
> Buck voltage from 1v to 3V, per step 100mV, and vout mask is 0x1f.
> If value is from 20 to 31, the voltage will all be fixed to 3V.
> And LDO also, just vout range is different from 1.2v to 3v, step is the
> same. If value is from 18 to 31, the voltage will also be fixed to 3v.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt5033: Fix n_voltages settings for BUCK and LDO
      commit: 6549c46af8551b346bcc0b9043f93848319acd5c

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
