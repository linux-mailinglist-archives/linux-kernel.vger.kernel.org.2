Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF7542FC54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbhJOToY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238197AbhJOToX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:44:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB25461181;
        Fri, 15 Oct 2021 19:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634326936;
        bh=F/qhtQq884fDhoH6bClRl635RI5UPxO4klw1oW2Avd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1fGPf/iD9Yt34acPBNN0wz3lnqB1pa1NyvXU39zOD4BWEEhxYB1F/omV0s+hiEf0
         V8M+DMJU+I/ysApG1kqHzOS7nT6eWdTUksVKtWkwkorXcTDkUlfAOlh12gLbjG/R7V
         TsTnDIiHV5FgLjfhQOrNY3tPGNaEoaRFNtjoZm/+b5wuHK+y63udXCe7J+tto97JQf
         sfNNDatk5pjQ1oAE/GqJI8x2N4TflWpH8Fz+nnpxikY46ELTjICjEj14e6XgY3XPNC
         +P0CaNaRroce6aa5k2nkAY27d1yqEc9BCg3MTsbjzFUgiImakoFAa2GYCgthNTtu6e
         989nFUZWMY7mw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, wtli@nuvoton.com,
        open list <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sunil-kumar.Dommati@amd.com
Subject: Re: [PATCH V2 1/3] ASoc: amd: create platform device for VG machine driver
Date:   Fri, 15 Oct 2021 20:42:02 +0100
Message-Id: <163432688461.1314975.2857186739241189327.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014071714.836410-1-Vijendar.Mukunda@amd.com>
References: <20211014071714.836410-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 12:47:08 +0530, Vijendar Mukunda wrote:
> Create platform device for Vangogh machine driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoc: amd: create platform device for VG machine driver
      commit: 832a5cd2d3d9e195af2fe272999af8948383ce9b
[2/3] ASoC: amd: add vangogh machine driver
      commit: 34a0094b9ff7b7544591a6841f9b61747033f292
[3/3] ASoC: amd: enable vangogh platform machine driver build
      commit: 96792fdd77cd19fcf2368e7c19bb8b78557ae425

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
