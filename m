Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D938934A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355116AbhESQM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240705AbhESQMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:12:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 918196124C;
        Wed, 19 May 2021 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621440666;
        bh=KZ3PBbJvCT9PsdmZ99Z+rW9vnFNfVQMzX5GvSd0as4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvS4YHoTS4W+Ef1k5bhocwmdw5yluGrL64YdxFXgsjpMixF6Cz+omhlC05jFN8hzT
         y/Pi34sVyP3WA+NR3jV3cgCUdv7SiGYIo752J/oOUiUlkXoD4Y5p9RlkNo5zZ7EH+O
         7gt0OYyRhlMte0D4aRohyIFKhbGSjxC3BRqYuYFewZyzLY+4tAWkhhOt/mEtxcizKC
         Dkb2LSjf3kUOzKHPEsxFlhtLB2YgDM+mU3uDSIAjuxfoHJcagBLevkwY4zv/bFiYrk
         4sfpMGSmY6jfZmkReKaj5nz2kzHpfTOff5m0a26VV3QOZHJF7JjISf9ZAFPj6lH8uX
         Yh6Y+rL767Kzw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 1/2] regulator: fan53555: Fix slew_shift setting for tcs4525
Date:   Wed, 19 May 2021 17:10:11 +0100
Message-Id: <162144038077.37201.15751073126291468056.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517010318.1027949-1-axel.lin@ingics.com>
References: <20210517010318.1027949-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 09:03:17 +0800, Axel Lin wrote:
> Fix trivial copy-paste mistake.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: fan53555: Fix slew_shift setting for tcs4525
      commit: a7f003147b785d9780ceeac13a8e344927a3b9ea
[2/2] regulator: fan53555: Cleanup unused define and redundant assignment
      commit: 79c7e1447c1c998e2571191e3cad12f9285ee22e

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
