Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7378535A7DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhDIUcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhDIUb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:31:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF18E61106;
        Fri,  9 Apr 2021 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618000305;
        bh=BeiGPQF4r8VyBzIQvZKqSDgXcCORBivkOVQHybx4D08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbDkesqLG4c480w9DAzuDLfUZtJHAsUeu8M3gib7hon0C4r2C6bnWymZbAhFaKJ8X
         lU54NOoe64w55zajnjZ58q+7yMdVkT77+ibKHjBmcE0iccy+h9H4WaYL4cxCPYq17A
         vi5VginjD8g7RIDcy1+aJF7YWU3DQjFNA2yveRs8fZmW80xvsJHIYKU1pDT5HPZpUB
         iJcxn8sa7cuIAirRL5zW7l+svlSWWZOvFjsptkzfmlhPS+RcCCe7ojb9uQn06Nm37M
         ycm9nR2qfd9LcvhQEopxkmsBVY8llefLj6Nagd2fYQUb53ujzQd8bRSfNYNAMQRz7o
         r1Nw70wo6qX2g==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        pierre-louis.bossart@linux.intel.com
Cc:     Mark Brown <broonie@kernel.org>, Basavaraj.Hiregoudar@amd.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.com>,
        Alexander.Deucher@amd.com, Akshu Agrawal <akshu.agrawal@amd.com>,
        Sunil-kumar.Dommati@amd.com, jack.yu@realtek.com,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, kent_chen@realtek.com,
        shumingf@realtek.com, flove@realtek.com,
        Tzung-Bi Shih <tzungbi@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: amd: Add support for ALC1015P codec in acp3x machine driver
Date:   Fri,  9 Apr 2021 21:31:26 +0100
Message-Id: <161800014171.27483.4701551511865013936.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1617886984-9500-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1617886984-9500-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 18:32:36 +0530, Vijendar Mukunda wrote:
> Add ALC1015p codec support for acp3x machine driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Add support for ALC1015P codec in acp3x machine driver
      commit: 26e33ed9f18475ebdc981d45150ac9a019e69f07

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
