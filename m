Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27558398FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFBQTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhFBQTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:19:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DF1861943;
        Wed,  2 Jun 2021 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622650650;
        bh=8NTOtVAUlWpijIjD+K59+VsdlOTTwWVBZEPEICpdQiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBjTIE9LH9twgKWQYnj4/GAKhRzPCNCrdnNFa9Xr6aOEZ1AFkPtayHjNw+AmqO/mi
         aBP+qQ2zlR4jaUg/g+wy4DyDTyc+C6XfdQ6rssF2nBHx3Gau5320aMLbTVENlwHDm+
         W2Hr0xmGUweNXSgS+Fq6WwC125ZIKFs20umhwNctDX7/jOW0TiklK+QVwW85BodTMq
         ZfjgTix5aLIYIwPzz/bmVwUKnZFmi/gt2UkJc3vQjJCD/d4Mgf0JAfiwU9nZCP7HmL
         YudRKOfIfyXq01Vd7yUfE+LpPEnknjtRkSGJP8obPh74rrJs2Un9Nc5k3xmkXZoBsx
         qm0Aafr3SW07w==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Mark Brown <broonie@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, alsa-devel@alsa-project.org,
        phone-devel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v1 1/4] ASoC: dt-bindings: nxp,tfa989x: Add tfa9897 support
Date:   Wed,  2 Jun 2021 17:16:55 +0100
Message-Id: <162265045454.22459.11419124227044779135.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210528105101.508254-1-vincent.knecht@mailoo.org>
References: <20210528105101.508254-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 12:50:58 +0200, Vincent Knecht wrote:
> Document TFA9897 bindings.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: nxp,tfa989x: Add tfa9897 support
      commit: 513df99993857863e42bf3d7d65d87c191ce9493
[2/4] ASoC: codecs: tfa989x: Add support for tfa9897
      commit: 1ba1d69d8aa938f64cb07604b320a5074c3bb107
[3/4] ASoC: dt-bindings: nxp, tfa989x: Add vddd-supply property
      commit: 9cf1a98e2b0171e2586a13197a9a1ad605336166
[4/4] ASoC: codecs: tfa989x: Add support for optional vddd-supply
      commit: 8e5607e9941ce915187785bd09805bf7df9f7349

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
