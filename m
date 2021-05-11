Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7126737A1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhEKI3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhEKI25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:28:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 400DD613C3;
        Tue, 11 May 2021 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721670;
        bh=h3vnEgAyBU0stZMPX8DMF3+dsDL6cOb6KoeTnUb88bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NN57Sn+VQ3zGHzG2B57+k5HVHnZiJtl+ScnT+23ghenHrk7orXm/3lCoZ7pCNKlKm
         hSFQcx8O7Uk2612Bm/9cjWHnTQi2+bMOFqW5WK6Qa8wcbwUbH3Zzva+56yWatKVNjf
         OEHEi+FWfpxt8DBX3t3BQDnYNiWgeUeRSAseWYI3nb2/6JxK+Yi8hWLbO4MrcjSXmc
         y4AvE0QpPnuM3uefzRfwllUdv32UZ/N6or76K/9eHTKhQ9zuf1q2Y0Z0GOXG4PXZhe
         d0uuMHGVo1VYfD/qoMunxIG4RoCuvfrmG7YsvaNvA6Nk0dqi9Gl702MdKH3cIrgcsX
         JWT6nK/NkYNXA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        paul@crapouillou.net, Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoc: Fix unused define in jz4740-i2s.h
Date:   Tue, 11 May 2021 09:25:52 +0100
Message-Id: <162072058169.33157.15479595461412836048.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506131833.27420-1-tangbin@cmss.chinamobile.com>
References: <20210506131833.27420-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 21:18:33 +0800, Tang Bin wrote:
> Delete unused define of JZ4740_I2S_BIT_CLK, because it is unused
> in any files.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: Fix unused define in jz4740-i2s.h
      commit: 37c881cd18f428b08cf46c5a9d67cfd2db2c4a32

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
