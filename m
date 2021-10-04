Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1284215C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhJDSAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233615AbhJDSAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:00:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 650A26115C;
        Mon,  4 Oct 2021 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633370333;
        bh=xb/bgTrnfX4eSX7hBa71k4X8vWp4UJbNe5GWQjQtIsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zr/4H7dMoLxDba891yZytgqF9ipgvOh2Q18c8zllo9Mgk0z8MnybmQ+pxZgSBiGvX
         DR7dLWdtm+8w9A0dPVxH4VPuumLGzIvlJ2V0J6SQjI+eG8jsqL2qYau5xW+FIvh2CJ
         EwMqDbBl7crAnqfQCjoDsV2fYDFE/jZfKKcbXMhJHrk3v8JGreL/H1DeqqUwPYmkA9
         047ry1L5Nq46XXr430KURg3Oxoe6pcCfKAxkVCbRFGQMrptP/Z9QcIm4znUtJOUrcp
         HMXL2mOEyZabhd3meunSFVGTDHYN1lZByuOEtK7uebusES+sd3Zhzc/tDeT9DbBnZT
         C5peD6ODLdTyQ==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: maxim,max8952: convert to dtschema
Date:   Mon,  4 Oct 2021 18:58:51 +0100
Message-Id: <163336889338.4019169.5976191844435491586.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930140327.196232-1-krzysztof.kozlowski@canonical.com>
References: <20210930140327.196232-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 16:03:27 +0200, Krzysztof Kozlowski wrote:
> Convert the Maxim MAX8952 regulator to DT schema format.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: maxim,max8952: convert to dtschema
      commit: 5f4b59f7e640108512aa2afbabec5b02420eaebb

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
