Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D553AA1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFPQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhFPQno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:43:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 634ED60E0C;
        Wed, 16 Jun 2021 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623861697;
        bh=Q/Uxz5ZlYjxyVUpoQp+FbryH36b5PBaPSvnLP+bgxi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ruUEKaFza775aU+5ehUtSULWAB4A+M7FuT6jsyWSsof8ny5pLS3Vt11NYprhfQBNr
         vINkGqU/92ukvy4LuS9LW8i3sAOjocq+iHfNjM35XPgwvb28HabiVJdbvbdF+6LIXE
         Zopon4H8+3dBCkcaRfXiBqZskUAM/1eE7Ec+X94JSzGW6XbbjACePEb68hcmFpXyge
         tdT4GjfHnUt9cJBLguz448ExRFPlvmi2664m6LYvD507QzWsy3vh3YbILi06I01gzS
         a7N18O1/TSR4zUWgYwdjRVDhDu33tLEwpAeowB0+xrMebuIem3QYoT7wasrk1In3IB
         Hd8wqFEFlWKow==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] regulator: sy7636a: Add terminating entry for platform_device_id table
Date:   Wed, 16 Jun 2021 17:41:10 +0100
Message-Id: <162386032647.25898.16073857531803041533.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210616034458.3499522-1-axel.lin@ingics.com>
References: <20210616034458.3499522-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 11:44:56 +0800, Axel Lin wrote:
> The platform_device_id table is supposed to be zero-terminated.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: sy7636a: Add terminating entry for platform_device_id table
      commit: 686f6b31bf6cea71ca941b6dbf9e1388d54222b6
[2/3] regulator: sy7636a: Make regulator_desc static const
      commit: 31a89d297e196472875dc7d4a8f5dd0aaefcc0b4
[3/3] regulator: sy7636a: Use rdev_get_drvdata at proper place
      commit: 830c364f4a2299e8215c40f0a2ba9229c0fdeede

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
