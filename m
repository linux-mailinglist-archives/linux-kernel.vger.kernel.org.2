Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78E435F8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352611AbhDNQHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352604AbhDNQHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:07:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C19D061179;
        Wed, 14 Apr 2021 16:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618416410;
        bh=BPlhBuiYRkW4vB0YGvE5clIuOpYnoQwsKGoAS9ZehhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFQt6bK6bi9ufRvVIHDJ1FOwMBnGKV1FbdyJ/T/XiKircSoWb6ODOR7fZNcLIQlPu
         Zhucq1fRYHWUgwCdQRQj35kvk6Ir8RFZghNgmQ5rlY+ID4rJGBBdgDg8jpe8YnuO5X
         0cdeYtq8BzgNcVxl0kpLbQnN6FBC+rrcxskTNy3uyu5AOyfvQgSlPhGK2DEpBFiX3P
         T3pQ913H7UjG7bVK7XrMpaK7T+MP6WPyCDbcRBi9/MjgyzWCbItIbBCmoSFGg0SKuh
         MaeT5eABQZraoOzLJ9zeqscZg3CB9EGWL9lQ9/rKzQRu9GuFxiz5vZhugLWIcfO/8/
         1YAmEQpyytcpg==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>, james.schulman@cirrus.com
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        david.rhodes@cirrus.com
Subject: Re: [PATCH] ASoC: cs35l35: remove unused including <linux/version.h>
Date:   Wed, 14 Apr 2021 17:06:21 +0100
Message-Id: <161841601730.20953.11471604452451396638.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1618380883-114841-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1618380883-114841-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 14:14:43 +0800, Yang Li wrote:
> Fix the following versioncheck warning:
> ./sound/soc/codecs/cs35l35.c: 12 linux/version.h not needed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l35: remove unused including <linux/version.h>
      commit: e42b6e813f4231d3c38362fd800724bd41040ef9

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
