Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4E73A6FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhFNT5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235708AbhFNT5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:57:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8FE461166;
        Mon, 14 Jun 2021 19:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700529;
        bh=7xDxmxG4Ta9fQN68e3Utug451ue+9mXqf6QY/N18kaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zssg79GRTB9L/oTyZXEXCGJyMP7orW2fEBsHcqmaA+t+7EIJFCMYekzSSriUsWXtA
         TTXkc/W5Qd0c2l63uxDcKV17znVYQ3zHjReD7nZcVZ4V6l4+7ys1AjHBq7zQ6arLI3
         ctFjT3NRuAUfIABB1hGSZqhiicTfDULDJNkrCDtM7yWC1uVxoYc3kIXdX9IPZUHmXo
         sNOTJq3Kushsff/jyzcceN8HXoJZqwSBe4qmmg3q1PuJkm5DEAeSGvWoMIOTRjJt2L
         cmn/FAo2FYzIbZRIPj18eTX8JqbXLmQHiy4LqCY8khbu2CfRfXQWdLiiLRrNuIB8Zb
         +1ELdi+C5jlWw==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, tiwai@suse.com,
        alsa-devel@alsa-project.org, perex@perex.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: codecs: wcd: Remove unneeded semicolon
Date:   Mon, 14 Jun 2021 20:53:56 +0100
Message-Id: <162369994007.34524.11243148752521690336.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623221171-105359-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1623221171-105359-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 14:46:11 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./sound/soc/codecs/wcd-mbhc-v2.c:990:2-3: Unneeded semicolon.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd: Remove unneeded semicolon
      commit: 03c0cbd946958af9cc10e55bdb047fd37d30735e

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
