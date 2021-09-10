Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32F6406F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhIJQMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231991AbhIJQKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:10:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 122D0611F2;
        Fri, 10 Sep 2021 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631290165;
        bh=q4lntEh1mQD2RO96jVSsyccr0dssPljMXQSktMXKMNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOcnMIt0OTAiSqdHD8c/NnC5iy1GiRQcQg1NOBMvW2Pc9SDuK7yJrpcr0aCvXsDjp
         3pwr+3JbIa6stkeRAg7V0mbKqunNJIf0fMD8DdH9DLe2EaGtLBjYVIhFlxZTgja4+V
         XhWGGudG1L1ooV0mnhQivMluq+RVvS7e/5A7dfRETkYlizpaJgom0dYxhoqfI3YuBZ
         sf7tkYJZH+ft/WoUyKj2lIx/va1nYhwRPA5BGKVIa7veBJ1RE/bzqTprd9JNN/gXPj
         mFLPpp1jHfAqFCQkGkkh6RsPFBrH9EeUPPGoe+KL9TW2Pwb27Bd1ZYYgCAKEHHlIvx
         MQlezumKf13HQ==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@gmail.com, Trevor Wu <trevor.wu@mediatek.com>,
        tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        bicycle.tsai@mediatek.com, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: common: handle NULL case in suspend/resume function
Date:   Fri, 10 Sep 2021 17:08:44 +0100
Message-Id: <163128974013.2897.10752321808133485674.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210902082111.9287-1-trevor.wu@mediatek.com>
References: <20210902082111.9287-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2021 16:21:11 +0800, Trevor Wu wrote:
> When memory allocation for afe->reg_back_up fails, reg_back_up can't
> be used.
> Keep the suspend/resume flow but skip register backup when
> afe->reg_back_up is NULL, in case illegal memory access happens.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: common: handle NULL case in suspend/resume function
      commit: 1dd038522615b70f5f8945c5631e9e2fa5bd58b1

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
