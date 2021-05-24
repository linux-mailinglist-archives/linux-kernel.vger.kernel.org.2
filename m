Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710C038E611
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhEXMCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232858AbhEXMCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:02:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 830856135D;
        Mon, 24 May 2021 12:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621857635;
        bh=deELojG0GVOR5hOrGRpvoLD+MzpRTxuHnqd7MioDR54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HI3ZjinZnin5VKhEyzrUgr1pZ5MBv4W7Iu8XYLIxFefCJ6BYfD+0FYTCffBq81d+Z
         njfqY3/2k2FkceSSN8lhS6HeECtCtOgBBFyaAuc+3RcK5lspwmlSJ+Zto0ALr8HBKX
         4D648BFpTi2y/CO53plelwKFeTG76Q9AdA1ePGJ9/ZRhbly4PP11ZFhIcqRH6rIZLO
         IrnWzPbf/B2qVI3YmloX8DjSM2Vsd8lgxvpB07QsHaJPc8DhrSrDClHdA57hGFF7Hc
         jzhCmuoJjQkA5/UM8jKfMHn+dNlSpDkrwVrWgTEMhfhY0qBqq+94/1FnYvzZVSkTfu
         cljJwMnlmOCkw==
From:   Mark Brown <broonie@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, Hulk Robot <hulkci@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] ASoC: core: Fix Null-point-dereference in fmt_single_name()
Date:   Mon, 24 May 2021 12:59:58 +0100
Message-Id: <162185746497.49382.14192167282801063293.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524024941.159952-1-wangkefeng.wang@huawei.com>
References: <20210524024941.159952-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 10:49:41 +0800, Kefeng Wang wrote:
> Check the return value of devm_kstrdup() in case of
> Null-point-dereference.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: core: Fix Null-point-dereference in fmt_single_name()
      commit: 41daf6ba594d55f201c50280ebcd430590441da1

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
