Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE67A3C8BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhGNTjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhGNTjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:39:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9465D613D1;
        Wed, 14 Jul 2021 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626291393;
        bh=+iqpkm/0K4nuKXlZXVcZmdElgnXPYVY1LAS9lTfXG0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kearmtzoruo05Xf6AEoBNGVIXH5167+Cbnq9jreTvWfAzPjnKzDT3yWCXlf9Kcadp
         a5zEgnsudbJHEJlL7sppLPjUrRcnCekYqxrIVQ5VAbOe/mpfu7EhhY53kcfs+/GrAn
         GWU7BMNzb01XontcUuZ/dgnHrQUrjajZd3VQt95+LT7xAn535vdXUCg0ZKva9UfLA1
         q83HISJQKo7AwwtGBnKn+C4BEcq52OIoM0xjiamzLB0JEDY8vYeiD4KHJZsVyuKgGp
         l/hoiyslf1CiZ6UxLncTLyOeRDgnqYK23zljzhPCT5SBqE0X9xwOpiw0EVtYmKv4T3
         uRBdliHweLPmA==
From:   Mark Brown <broonie@kernel.org>
To:     vkoul@kernel.org, alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com,
        srinivas.kandagatla@linaro.org, bard.liao@intel.com,
        vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
        sanyog.r.kale@intel.com
Subject: Re: (subset) [PATCH 00/10] soundwire/ASoC: add mockup codec support
Date:   Wed, 14 Jul 2021 20:35:56 +0100
Message-Id: <162629086374.53311.4247206766252361294.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 11:21:59 +0800, Bard Liao wrote:
> Adding mockup SoundWire codec is useful to debug driver/topology changes
> without having any actual device connected.
> 
> Bard Liao (2):
>   soundwire: stream: don't abort bank switch on Command_Ignored/-ENODATA
>   soundwire: stream: don't program mockup device ports
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/10] ASoC: codecs: add SoundWire mockup device support
        commit: 81d3d3d0bf09e606dbc1e3daad1c7cef3976fca2
[02/10] ASoC: soc-acpi: cnl: add table for SoundWire mockup devices
        commit: 2694cda7a4393fbd436e28474832a053e70e0733
[03/10] ASoC: soc-acpi: tgl: add table for SoundWire mockup devices
        commit: 3025d398c436d313f9b6b5c1f53918efeafcf5dc
[04/10] ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests
        commit: 0ccac3bcf3564cbcba483dec20c7550939873f59

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
