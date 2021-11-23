Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7834598BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhKWADM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232090AbhKWADL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:03:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAC0C61002;
        Tue, 23 Nov 2021 00:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637625603;
        bh=VrIHNdICz10VyRFyRXO3RLq2Y8ZETUSMzSEpP0Ffoo8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l3JqfhsAyW3hGE51EDHarP+ODGx7QgwSkA/XqGGnrngyLfMbJlpDcJX+iFLOSIw4r
         /LloHVDw4uQ9+TW/dcbJXRm8vibHTifzXFk5MbOCF61kHHVgP6oczvJzVnqTqmjigR
         aTw8/EqTacbDe/pVEj1zUcj3Wd8nTAimPHqbX2FAaGI5l1m6t3jfSXsdnUgR0bxSYa
         D0HPK7KX4LdAQHB4TqAgpPecXqLNpmqB3sCF2/f1EgEokvXioDnUn/Hzh8eYC0z2AL
         +SToanKfl6B80t7R2CpGnwfBoXw3Y6pKMEMVUXqapCNakt3D+Dpmjjg2YGvZXuzaUC
         cUIwDQrZ6MTbA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     linux-imx@nxp.com, daniel.baluta@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        guennadi.liakhovetski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com
In-Reply-To: <20211116154613.57122-1-daniel.baluta@oss.nxp.com>
References: <20211116154613.57122-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 0/5] ASoC: SOF: Add PM support for i.MX8/i.MX8X/i.MX8M
Message-Id: <163762560143.2471742.10413030949229818973.b4-ty@kernel.org>
Date:   Tue, 23 Nov 2021 00:00:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 17:46:08 +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> This patch series adds support for System PM and Runtime PM with SOF for
> i.MX8 platforms.
> 
> First patch adds common code to manage clocks, patch 2/3 adds the actual
> PM support, patch 4/5 implement the DSP start / reset callbacks for
> i.mx8m.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: SOF: imx: Add code to manage DSP related clocks
      commit: 8253aa4700b37cef1ca3bbda0d986349357608d3
[2/5] ASoC: SOF: imx8: Add runtime PM / System PM support
      commit: 6fc8515806dfd5b7d3198c189b51e7624aadafdc
[3/5] ASoC: SOF: imx8m: Add runtime PM / System PM support
      commit: a73b493d8e1b37acad686c15321d2eaab45567ce
[4/5] ASoC: SOF: imx8m: Implement DSP start
      commit: 9ba23717b2927071ddb49f3d6719244e3fe8f4c9
[5/5] ASoC: SOF: imx8m: Implement reset callback
      commit: 3bf4cd8b747a222f0f454f3220199c99f1c03da6

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
