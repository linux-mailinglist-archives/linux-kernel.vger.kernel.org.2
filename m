Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25299411847
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbhITPdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241563AbhITPdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:33:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08B3A61107;
        Mon, 20 Sep 2021 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632151912;
        bh=kW5h4Wp87ZySDniC1nxTtzJqO7Y1LElsVScvvjvZqWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/h5ImWaDriQyw1F6OxleG+ut1hQLVNC9avWfgfw6oWKtcC8Q+MdFWKr4q80PXpFN
         bXU3gfXst8amN4xAFcfIh3P0k+ossMuvxriMTdNwrLuNZkc5E7klPkIXMIvBnrmoIn
         f5Xnj+dYq+0uRH9c/9RyGOQzkPvfLZWemiQXYL1ZK5CgCegz5MiJAkI0jYeEPs6tIV
         MeYHHPDettiCGGo8jV1X6kUmU723lau+S4QK88JK+x5EHYf2Dl/tFsB8X+Wkh+jojK
         eb+9aw1XyYlwasdsbWUD7ieC8R+v2Yhp6YcCBwMAJ2zIN+FXKf0nsFNZvJEN5vk15w
         ZzOVQnupicfiw==
From:   Mark Brown <broonie@kernel.org>
To:     Derek Fang <derek.fang@realtek.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: rt5682s: correct several errors
Date:   Mon, 20 Sep 2021 16:30:49 +0100
Message-Id: <163215150720.38322.16264774156845282309.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210920112106.140918-1-krzysztof.kozlowski@canonical.com>
References: <20210920112106.140918-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 13:21:06 +0200, Krzysztof Kozlowski wrote:
> Correct several errors in rt5682s dtschema:
> 1. The examples should be under "examples":
>     'example' is not one of ['$id', '$schema', 'title', 'description', 'examples', ...
> 
> 2. Missing type for vendor properties
> 
> 3. clock-names should be an array:
>     properties:clock-names:items: {'const': 'mclk'} is not of type 'array'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: rt5682s: correct several errors
      commit: a7a18abbd26caf22e40165eb734e67d338735f5b

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
