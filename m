Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C68D422CA9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhJEPju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236049AbhJEPjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:39:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC24861131;
        Tue,  5 Oct 2021 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633448273;
        bh=NDqzyzVRCseVfehnZCfJwcwxRplzAv5y7xgVWiv5h6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRLB1i18yBikWXrcSr2dYUdfryincbW+qKniOtsmqO5zfQOl62P6VUBu/zWN9rLGe
         iA9L168JWk91b0fezdApNvNbMXDs8mvIcP25+SvInF8x4b6Cy/YKXbGdh8dSfQ3+X+
         mA6drQW9GOlHpV0vfF4/CnyvmTGgLSAFpofDBfiRWueO/p+f2DXvkjcU2vaRIfnSSo
         XRsSjIjZ7b5B39AFBZwg7bjCzoEjsRx5S9qmlKjd/xMSOgJGdHOM0uDJNBSo/FTIl7
         Vtc0RwNvbyJ20j0Ts06507gw5UkKavLwqE5Of3GsaNgoTt5J4dThzl8kAMi3fChM+K
         3WWZ5oRhihKTA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        ranjani.sridharan@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: SOF: OF: Add fw_path and tplg_path parameters
Date:   Tue,  5 Oct 2021 16:37:41 +0100
Message-Id: <163344779742.1075058.4675393648242065057.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005071949.1277613-1-daniel.baluta@oss.nxp.com>
References: <20211005071949.1277613-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 10:19:49 +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> This allows specifying an alternate path for SOF firmware or
> SOF topology.
> 
> This is particularly useful for i.MX when running Linux vs Android.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: OF: Add fw_path and tplg_path parameters
      commit: 7b84fd262d8a54ca609dd719c20c8a8e1a7ff759

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
