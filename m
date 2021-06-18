Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E113ACA9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhFRMKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234092AbhFRMK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:10:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 002FD613EB;
        Fri, 18 Jun 2021 12:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624018099;
        bh=7qgOWH+nPcb2n6CEaH8HR2FF25lTlE4tAE8bf61gk/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgWnRLDssZJpxPfygsD+SOhyfBaYcSuwZvA7pBGgiCVv2zqvo5aMG+lv4ahDHiGNQ
         VXydgXhDNzxmYKp+ATYVdKRQ+wuHUby2A237gLXe2LXbHjcfE0OtksCRhmKjJHCsHY
         ibhuTCN/YTSdHtRrhxeoh0btoHnh28h8+AskaLOZXd+61jwE/yCeKq8aTd53mnP7i+
         eHnQV3ociVgEBrbvBMR7Bnd0QksQuUTU3HDAP0s5d39YZNXBi+mUzKvuk3dKxNM/Y0
         HOkuPIehep6Cu7xzMTmSbeUS6mWPewaykw3CIfrY3fh71ziSj4woKJCl9OfV2bsPw4
         hJBECVMvJaupw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsi: fix spelling mistake
Date:   Fri, 18 Jun 2021 13:07:54 +0100
Message-Id: <162401758813.52682.15832699521448200223.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210618085324.1038524-1-f.suligoi@asem.it>
References: <20210618085324.1038524-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 10:53:24 +0200, Flavio Suligoi wrote:
> Fix "thse" --> "these" in struct fsi_stream declaration.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsi: fix spelling mistake
      commit: eb1e9b8f581a48943073c60adc3cd3cf63972580

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
