Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6723C9EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhGOMko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhGOMkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:40:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E549161374;
        Thu, 15 Jul 2021 12:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626352670;
        bh=eygR12Zdi4ElhBZVM5qdhbNeXAWJEMurkn3VmUfmNMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S89AydWSeZpSkU1HLhdBBZGD1m9n7VH/3oaCFnnKvhd8FoLUQKhx5Vfuot0LWzyth
         SLpW7OElZ6nWTa5rUrMqBq6tc7Bs+6U8r1Big7lW2qwH48nnkfS8djUSCkfmRf6t5h
         do2+XPFKaGKgOL0Ov4Dk3PhaCgq/x3JSqeAUuY3sTcvveYDl7FGM4xBdbrwLLQd0M+
         DaTofYWjNQEsD5/aqT+h/uzG6qTp03if+4n+WOGrCNb5fm2KdLkDMoejj8HJk35juI
         om561lWxHxCdCT1FS/b+ySrWZwyJ9WH4Jvj8OPcV6itnGDPcWRH3wCRM5YPluBxDay
         2i2R5VdejQWoQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: regulator: Convert UniPhier regulator to json-schema
Date:   Thu, 15 Jul 2021 13:37:13 +0100
Message-Id: <162635247078.14929.7474046739493187418.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1624413137-17453-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1624413137-17453-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 10:52:17 +0900, Kunihiko Hayashi wrote:
> Convert the UniPhier regulator binding to DT schema format.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: Convert UniPhier regulator to json-schema
      commit: 442a9d105e61591b36b653ba1ee0c02b0482b639

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
