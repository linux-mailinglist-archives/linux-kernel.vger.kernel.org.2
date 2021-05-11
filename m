Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835B437AE60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhEKSXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232122AbhEKSXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:23:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D6E76186A;
        Tue, 11 May 2021 18:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620757350;
        bh=tzQI48qc4TkUQ9zo4+5oAMZas2lYgB+Myx5nBcxQpTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=httCx7EG90o9MOPSzN/WR939X0OGMA8jnVChiuZ9cPRtXtAsRDtbhQu42Cv7icpz3
         IQgLaigUM87hzAXUVHsXY98IWez+N47v+KAFFMbJjWiFZp79yx61+WvPbV0hJziWtG
         ouRFyLItoAgvRzDc5ncY5BRSQlhIST4zgcnzd2BTmNpLwWkLLMDLi4PbDH8CFSKekf
         LgLukSN+bb4R7XEoiCEJEp91DagsGI1cD7ddV5op4IwJByDqVRvCAAyFR+W6K1YGGd
         9+rEORLV0xiy+JGbXGKvqI5vhJzpdBl+cOFLZp6vV3X28gRjd/nqTP3TLop9UDGTB/
         /RIqA+AXpYJIQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: cs42l42: Regmap must use_single_read/write
Date:   Tue, 11 May 2021 19:21:29 +0100
Message-Id: <162075713910.17925.13540340521558879999.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511132855.27159-1-rf@opensource.cirrus.com>
References: <20210511132855.27159-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 14:28:55 +0100, Richard Fitzgerald wrote:
> cs42l42 does not support standard burst transfers so the use_single_read
> and use_single_write flags must be set in the regmap config.
> 
> Because of this bug, the patch:
> 
> commit 0a0eb567e1d4 ("ASoC: cs42l42: Minor error paths fixups")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Regmap must use_single_read/write
      commit: 0fad605fb0bdc00d8ad78696300ff2fbdee6e048

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
