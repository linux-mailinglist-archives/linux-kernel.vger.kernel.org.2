Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA944351F1B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhDASxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235584AbhDASnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:43:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B51C61375;
        Thu,  1 Apr 2021 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617293769;
        bh=Cnibmwj6f0ETV7KocKFsDxMa+XbFc5GMHnVOB7+uVj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpMAOA90TD5bN5u2X9vxHO3I3m86DnD/Y5ANwMziPl7/lpYCGRYjj8OsxIJuv6oa0
         JBkWvYBToj8InYMr3aXWqZGkvhA/LXviMznXaMRmllRz/X2oK7jUldkfIKu8TyKXqv
         pbNyrVUHKrjQ7b7uylBhIS5cRSyLQjxj8+IzTyJNaE5Rx0nkmZ9qd4u4qPJkXt8DjW
         ldPvVcQyhD0sN5RmOyn8FnEk47eAKj8Hti3MJE2RSCWjhUV9DNvgH2pau03lf2+0lj
         h/lWhEKVxpd/gJ6Z+pkvarhPtcR8WWtuTSCGy2y/XbaAVwopgHfa7nfLV9eBhE7FGK
         1ucnb582cLpJg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com,
        andriy.shevchenko@linux.intel.com, cezary.rojewski@intel.com,
        yang.jie@linux.intel.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com
Cc:     Mark Brown <broonie@kernel.org>, rdunlap@infradead.org
Subject: Re: [PATCH] ASoC: Intel: Fix a typo
Date:   Thu,  1 Apr 2021 17:15:48 +0100
Message-Id: <161729333652.31618.13965688976437699792.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210322065053.74022-1-unixbhaskar@gmail.com>
References: <20210322065053.74022-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 12:20:53 +0530, Bhaskar Chowdhury wrote:
> s/struture/structure/

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Fix a typo
      commit: ebf721fbbb6e077864783c8d0146021815bb1f24

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
