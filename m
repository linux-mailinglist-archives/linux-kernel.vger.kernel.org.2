Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3218437A1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEKI3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhEKI2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:28:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91A6E61107;
        Tue, 11 May 2021 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721664;
        bh=aIbKrZTp+E6EVIDHCNWvzoJpW7zVJeecbnlZyRKFuck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jk/YdMVZ7Q5F4MdPuwZwTMDGhDedzAF3Uo4XIes00YTrJwb0XrjDrHlpKmk84n/aR
         xegkHek9ygsElz5tUP5BuVytq09QhG5kx249XL7QsPoGO6e653eQu/cgyS0jTX/MRh
         /wSPtlVWPG679y8pa8Bv4ES8Suo3UKobYQxGov3Km70EXsQ3rIzshR+IiTQk0g5yjs
         tbQml0CbcfEj7FowDU4KCz2ff31xi+YZAKnXGKWiFmpMTh9Pu0xFrVlGdGj4xktsOV
         wZBim14CTApR5Apquoih+LyUIfTdD8VoFG569CWfG2siHzt40OHYQ+JVxyHsrsHtbE
         ZtrhJNEu0hmvA==
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
        nicoleotsuka@gmail.com, timur@kernel.org, Xiubo.Lee@gmail.com,
        tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ASoC: fsl_spdif: add support for enabling raw capture mode
Date:   Tue, 11 May 2021 09:25:50 +0100
Message-Id: <162072058167.33157.3402941285699720192.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1619425444-8666-1-git-send-email-shengjiu.wang@nxp.com>
References: <1619425444-8666-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 16:24:04 +0800, Shengjiu Wang wrote:
> Since i.MX8MM SPDIF interface is able to capture raw data.
> Add support in SPDIF driver for this functionality.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: add support for enabling raw capture mode
      commit: 604e5178444ea1d8053cf073e2c68fbc73a4e142

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
