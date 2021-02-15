Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8631C329
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 21:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBOUpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 15:45:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhBOUp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 15:45:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B59CF64DEC;
        Mon, 15 Feb 2021 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613421888;
        bh=IhUxIYqRrWYJupUnp4eR0qui80CTtQp2sirMBcAUedU=;
        h=From:To:Cc:Subject:Date:From;
        b=u5aasvplMnehNunu7qVl0rS+nmDmJ/s+a06mO098K18cM0ZHUDqbkP35uqhAErii6
         1aa28bgwS+2XOYie8JXzojCStb3SqSXH6su6tYaFSL2DNtoY0Uqfu8SyJP+gZtOwvI
         ak2JXDWm6ZOlWu2NSzBXY6oap7/ijQYIyO7Med9o8/siHMnuFFH0tGI6Vy3ZXQ9/G2
         5E2AnXub81wQRKmLC3uQNfmVcvkXXFrTNXKnhXqysvY401YbN7Ipc7dYdTPq6vaBbk
         b7+4y3F37K6YKjV0mKPlHXwa/LUVkxTJ4kNSVYiETDFvdZ4cfcPHTHLLtFcVdzThiD
         cdgI6mGUj9ztw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v5.12
Date:   Mon, 15 Feb 2021 20:43:39 +0000
Message-Id: <20210215204447.B59CF64DEC@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.12

for you to fetch changes up to aa3233086b48e5269cd0b5c16fb9711ce9341244:

  Merge remote-tracking branch 'regmap/for-5.12' into regmap-next (2021-01-21 19:38:21 +0000)

----------------------------------------------------------------
regmap: Update for v5.12

Just one simple code style improvement this time, no features.  There is
an addition to add a new SoundWire regmap type but that should be coming
via the SoundWire tree as the support for the underlying bus features
was only added this cycle.

----------------------------------------------------------------
Jiapeng Zhong (1):
      regmap: Assign boolean values to a bool variable

Mark Brown (1):
      Merge remote-tracking branch 'regmap/for-5.12' into regmap-next

 drivers/base/regmap/regcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
