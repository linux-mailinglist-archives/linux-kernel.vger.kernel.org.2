Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C541397938
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhFARkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232225AbhFARkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54F4961042;
        Tue,  1 Jun 2021 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569109;
        bh=rUksboNQG8y1Py2gLViP3BCLhAheHswm5UXyJ6ClEME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+lMJS26Nli2xJEkJEHn/q9YZWfiFUCV66ZnY2Hzu9B6vEZazk2+nPZDxvQ3ZnQF8
         B+0NDL6+nIHlSBPiWKalJ3ifW69Hx2tLork8FZi4KUvLM1ZptrBBdiSqvCpDxnPT8O
         OtgcR7SVDXYhjIk6hsyaq+3ROgVnFhwNQJpf45igORcIcoCOV9+mUSeXIlsyV/0MSz
         I70s20d2cRddFg5w207BDIiytfKExjPqCzb9jv7KR1flg5PhQw9C6sbD2oHu8q8MI+
         JjbQRYh6SZqBF0LCIqoVGHRnHN6IZbl1RPqgdCFFexjcJb96xenqgYAMWN0I0yWeg4
         4KaiSZekvF+HA==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Andrei . Stefanescu @ microchip . com" 
        <Andrei.Stefanescu@microchip.com>
Subject: Re: [PATCH 1/2] regulator: mcp16502: Convert to use .probe_new
Date:   Tue,  1 Jun 2021 18:37:59 +0100
Message-Id: <162256901746.20048.473561109648335146.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210526125026.82549-1-axel.lin@ingics.com>
References: <20210526125026.82549-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 20:50:25 +0800, Axel Lin wrote:
> Use the new .probe_new for mcp16502.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: mcp16502: Convert to use .probe_new
      commit: 1d15b3e6f9d95865450c8856401b3166ed074c83
[2/2] regulator: mcp16502: Convert to use regulator_set_ramp_delay_regmap
      commit: 96ec5afeb3001dcb432b9c9e8738aa537c6cdb12

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
