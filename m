Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7A933982D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhCLUZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:25:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234750AbhCLUZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3700A64F85;
        Fri, 12 Mar 2021 20:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615580708;
        bh=PiAVnNdcv0wxF9iybfaUy8tQqGnHkVEy3c5oroa2KHM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o8FQyHkyzFenyo0UuWd6wh2j7bC0C04wtwqWUTHR4M6gmRaPuUJJ0NeDg8Fmlanw2
         KSYKf7p7QQ4SNM1I7HJv4xWx58gznLpo74xx6feJk9xU386bqRU9lIITw7CfVHOWsy
         atv/kXx9b2boDhplUT1gjRlcMjIBYFfbiOWt+ShunEcrGBnurneffMQ3cdnYcWIxZn
         1WWJbtunZwpJtk/Uk3tWK5yniysUib3d3ky5edhHFPQ4EIF8POI75wlUpIWCnXrbwY
         UfEyccrXQXTbzulEbsv30wi5hrAQFolBhUA1qMPIN5Uq/3ENnWwqwydP2M8FBG0fhn
         +WgQaR5gA8vKQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tzungbi@google.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Jiaxin Yu <jiaxin.yu@mediatek.com>, matthias.bgg@gmail.com
Cc:     shane.chien@mediatek.com, Trevor.Wu@mediatek.com
In-Reply-To: <1615516005-781-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1615516005-781-1-git-send-email-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8192: fix tdm out data is valid on rising edge
Message-Id: <161558062956.11113.8460883520488854945.b4-ty@kernel.org>
Date:   Fri, 12 Mar 2021 20:23:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 10:26:45 +0800, Jiaxin Yu wrote:
> This patch correct tdm out bck inverse register to AUDIO_TOP_CON3[3].

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8192: fix tdm out data is valid on rising edge
      commit: 8d06b9633a66f41fed520f6eebd163189518ba79

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
