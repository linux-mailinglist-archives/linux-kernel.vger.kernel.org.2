Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E48C3CAD6D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245662AbhGOUBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242702AbhGOT5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:57:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05C9661396;
        Thu, 15 Jul 2021 19:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626378882;
        bh=OzI5qhsw9AWhl+RWxjpuRTSWtsOMOBgBrux4E7l3Z2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NH+fs8MuRLsG1XRUSbfDBM8sdao0m6yKhpXexYBnFO8fjVUi5nLJRF8uG1fkRspDo
         NL4FCx7JB6WOMqxjeH6ZbhaUmCVbjbNgA+lU0Nbf05eYHogat2YAWwLpZmXCxthpGG
         xmWWdZT46YmgKYG+WJ2SIsMCca2zzLvyLY0dEwVBqknjGStVC4OBGclOvDKBHtSt6B
         zLAl1k3zTVp9+lHM8GBDG08TwKMHTF1YjtdKj+ZNZ1sqh/pK5N8N8HAzqikaLJJa5X
         fT0VrVqZVLI+CRLtWguNNm3nPE/2DYcH6f3uXLdzEHsRCyarghyo7KDE/czJSqZJ4j
         fyiBG2tycEQ1w==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: renesas: rsnd: Fix incorrect 'port' regex schema
Date:   Thu, 15 Jul 2021 20:53:58 +0100
Message-Id: <162637883862.27669.2616702519037982107.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715185952.1470138-1-robh@kernel.org>
References: <20210715185952.1470138-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 12:59:52 -0600, Rob Herring wrote:
> A property regex goes under 'patternProperties', not 'properties'
> schema. Otherwise, the regex is interpretted as a fixed string.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] ASoC: dt-bindings: renesas: rsnd: Fix incorrect 'port' regex schema
      commit: 9a3223b0713369e6258fd8656e0c0a5ed794d186

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
