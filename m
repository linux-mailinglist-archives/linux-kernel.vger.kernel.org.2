Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4E6389350
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355150AbhESQMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355135AbhESQMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:12:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00E0B6135A;
        Wed, 19 May 2021 16:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621440676;
        bh=5Z2EkaMzIYpeGUT62HgHaddi7bvGhthOk/v+yW7+/10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YRfTV5p+1y7+MAObTjKCrRdDlIj8YnB+EyixBLNMaj16Ts9vXv0oxE8p1RIiZeRbR
         EZ3lHTfTgKeLGv0XVPprXAX3MY0MJrZoChe3TY9xBc5kumfP5bzZOXA/RbGh8eCyxk
         fiUwyer3vv2zCGWoxw4eimVy/VSfkOeXjgCLHWUI3HM1SNrfjALdEk3ZuhdneOlErD
         5y2lsorCZKYbNpwMQB8YVqWSBIKbCb1LKltrLS28ioAF2IW3ZN2Uz+/vWyqG21R7T0
         92rICEXxlJQEbsJSH5juE9Eco+dBfLAnIHX1jjsXAUq9OLFPIMrSh8BRu2fd8iZg3X
         TCZuhMIbY6dbw==
From:   Mark Brown <broonie@kernel.org>
To:     jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: meson: g12a-toacodec: add support for SM1 TOACODEC
Date:   Wed, 19 May 2021 17:10:15 +0100
Message-Id: <162144027316.37060.16685114129646097481.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429170147.3615883-1-narmstrong@baylibre.com>
References: <20210429170147.3615883-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 19:01:47 +0200, Neil Armstrong wrote:
> This adds support for the TOACODEC found in Amlogic SM1 SoCs.
> 
> The bits are shifted for more selection of clock sources, so this only
> maps the same support for G12A to the SM1 bits.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: g12a-toacodec: add support for SM1 TOACODEC
      commit: 7487238c5f530b418745ce134d1b0a7fba3a0d8d

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
