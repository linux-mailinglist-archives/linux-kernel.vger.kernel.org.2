Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2803C37EB79
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380570AbhELTcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236403AbhELRIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:08:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C8F6613A9;
        Wed, 12 May 2021 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620839155;
        bh=VzxBT94nToLkx0ahHMWShZ90PbCWTBEmjUklc4r41LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WycaM/cIP85Uy61AfmmjNsmzgyhD94oL9G6r+1jJFOsa5EEazWYFhNjxbbBWBNYK3
         5h/C4TGPbUogJ6FYDs6UsYkag7JQd44DoUApGzkCUTdDTKg72mUke4ebgGlpCyETM2
         Nwhm51WtWt3+F4NsyC8TeVrucFYyXUwP0ZLdkQ6thM6NwrZqTOxpz3KuYMhaiF1F+1
         OuBO+px9lfC+N7H0uvb+sKbTtpsfkDCIaVTtuTD4ygovtSSpjS8ImXBEapxAbP/XSC
         FmPoZ//144UZ9YwWlxmylFHZIoEmd5Gspenfp/SKqKezC2Nx/ny0mGLM8k/lB7H2gM
         Y0l7xGOof5m2w==
From:   Mark Brown <broonie@kernel.org>
To:     Simon Trimmer <simont@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: wm_adsp: mark more data structures with the const qualifier
Date:   Wed, 12 May 2021 18:04:47 +0100
Message-Id: <162083892846.44734.3319712782666419395.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511171459.270169-1-simont@opensource.cirrus.com>
References: <20210511171459.270169-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 18:14:59 +0100, Simon Trimmer wrote:
> The callback structures and memory region type table can be marked as
> const as they will not change during use.
> 
> Fix checkpatch warning against wm_adsp_find_region function by moving
> const keyword to form the 'static const struct' pattern.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: mark more data structures with the const qualifier
      commit: 130dbe04d42817b62577a48346837122a00e794f

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
