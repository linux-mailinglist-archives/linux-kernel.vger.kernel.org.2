Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C5838E60F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhEXMCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232849AbhEXMB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:01:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B9936128B;
        Mon, 24 May 2021 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621857629;
        bh=I/AnOl07xJ78/MlMBrSL4ZrBn/VkAl/y+yaLeCLFMGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvkNw20K223eZiCt9lDwQbruNbPbC126q+a7an9hF/N2qZwgV03A5DoBemDvFntN7
         TdavodDp4gl8ZZeysenWiG/rFwFVvZuiD2ucvjc9s6ghrFT5VKwyov2camHoQSvVBc
         4qV11Ugwj87M5vlPKiQlzwEMploNia+14zLDjGHTrhTbfGouGcnim4w1pMzSoCWzlw
         hncJuw39vN4rrMHTd1ZGv3jKeBApYZvB/qdMqFWa+RRXUCDxPNADAzjDpep5yww9Tr
         oKg+dQJuMZmp7Pt9kY0la8pOAzWw5eEAzHzBs2hOTUzsgE/KxZSZd+3d7G72eB1JIc
         KDyRHmbC7GRgQ==
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Mark Brown <broonie@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        phone-devel@vger.kernel.org, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH RFC 1/2] ASoC: dt-bindings: codecs: Add bindings for nxp, tfa989x
Date:   Mon, 24 May 2021 12:59:56 +0100
Message-Id: <162185746496.49382.12917440362021007479.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513104129.36583-1-stephan@gerhold.net>
References: <20210513104129.36583-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 12:41:28 +0200, Stephan Gerhold wrote:
> NXP/Goodix TFA989X (TFA1) amplifiers are controlled via an I2C bus.
> Add simple device tree bindings that describe how to set them up
> in the device tree.
> 
> Right now only nxp,tfa9895 is supported but this will be extended
> to at least nxp,tfa9897 in the near future.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: codecs: Add bindings for nxp, tfa989x
      commit: 17ba36b704692a433d38cb230e99ec333ecd14a2
[2/2] ASoC: codecs: Add driver for NXP/Goodix TFA989x (TFA1) amplifiers
      commit: af00978a0a06bab60bd5adf54a65ea69d19ce35d

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
