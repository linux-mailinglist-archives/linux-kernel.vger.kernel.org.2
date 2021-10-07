Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3961425F35
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 23:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhJGVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 17:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234005AbhJGVjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:39:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F1D161175;
        Thu,  7 Oct 2021 21:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633642659;
        bh=vu2amI2YqErugoUvzeHFDfUcGUP3aXhH4Mlch9Exq0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GuV4PdwgBQhf9yYlF1SPSaWzqiyQ63Av1yoi+Jslk2e68s4CZXySkdfye4ts0h1ur
         +LqAaWBwqxso3qZM36DVKD0m6tXqieC4LUaaer95C5lbmv5yWManC4/Wbo+UJnxwMY
         MwQnG7dAxZ9N4Ogx2jJEyk5x6zfBKLdQTjVdGfun5sUArLVnN8RZDpQghMVLfGWA4Y
         9+tbLFhxbNuGTc8E6Olo5liMjR9Sg5ayRlN7R8o1ZEOHt8ap7bKxTEJFUPFUrKa/rz
         M9UUSJUvDwCK8sCEq2V8MyzvlKNE5Rh+c6YBXTrdx7HV9u7f07Jox+OlWuCKGB+maU
         D/KxXOY+b5dRw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: maxim,max8997: convert to dtschema
Date:   Thu,  7 Oct 2021 22:37:22 +0100
Message-Id: <163364264749.649917.4943514785245266883.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001130249.80405-1-krzysztof.kozlowski@canonical.com>
References: <20211001130249.80405-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021 15:02:49 +0200, Krzysztof Kozlowski wrote:
> Convert the Maxim MAX8997 PMIC bindings to DT schema format.  Extend the
> examples with additional one copied from kernel's exynos4210-origen.dts.
> Also the binding descriptions are copied from old file, so license
> entire work under GPL-2.0.
> 
> This also adds previously undocumented 32 kHz clock output modelled as
> regulators.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: maxim,max8997: convert to dtschema
      commit: 1d2104f21618a4cea8555dd4683529e9fbb829a9

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
