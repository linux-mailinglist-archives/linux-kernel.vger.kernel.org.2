Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F8737A1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhEKI3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhEKI30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:29:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D68361943;
        Tue, 11 May 2021 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721700;
        bh=4cFqGgBdAbBe0GybCv/aBA0bJnpRTZe4yHbphP7wiXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jynQ+wBdyHTV4wColpT3K+33k7SQI3CioTON0DCXJwQJEViOyc3uRkuJJJDqAWREz
         fg4ZP7cLfys3Ae0ECK6wNl1odn36jCmHpiMw6HXFfreWLli2uzQgJgR7y1KIjgzAD6
         +BEIFhfv3rSAAV2d3vW05YqHK406NVllKk1lY7qh+il6+07D+dcnRdsjLno5mmMQ0x
         O58cDdY303fXyULGaX+b3IZn5GMYtmJ+2vkkbSQPbu0QvkFY8J3P+m4gIgnpDEA+Io
         Ys76PY5EDXTJ2nwRImeke+iug2nQcDtJeYhRchHqOTuv+qPmlTw0XRxeELQFkGhYw2
         ceWbH3NKRodZg==
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: (subset) [PATCH v3 0/7] PinePhone BT audio bringup
Date:   Tue, 11 May 2021 09:26:02 +0100
Message-Id: <162072058168.33157.16217732000222184745.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430035859.3487-1-samuel@sholland.org>
References: <20210430035859.3487-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 22:58:52 -0500, Samuel Holland wrote:
> This series uses the additional DAIs added to the sun8i-codec driver to
> add hardware routing for BT SCO (headset) audio on the PinePhone.
> 
> The BT audio connection is represented by the "dummy" bt-sco codec. The
> connection to the Quectel EG-25G modem via AIF2 works as well, but I do
> not include it here because there is no appropriate codec driver in
> tree. We have been using an out-of-tree "dummy" codec driver for the
> modem similar to bt-sco, and I'm not sure if such a driver would be
> desired upstream.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: dt-bindings: sun8i-codec: Increase #sound-dai-cells
      commit: 880e007f15a31f446b9e1713720c6ae5a539f3f4

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
