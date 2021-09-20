Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A70411430
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbhITMVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237450AbhITMVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:21:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFBE661040;
        Mon, 20 Sep 2021 12:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632140377;
        bh=QxAExaGxihKcTgPo0jJzAE8GwQo2y6nXbRYW1Y75s5c=;
        h=From:To:Cc:Subject:Date:From;
        b=IQVrx+g/QBXjl0D3uO/uV+MMxkONBEA/M+sj8Hxt0KjRoXQ780nX0/KJTcl2XfvKJ
         ns2qp/T3ODQkUjWmJIhnX4JpOaZCTu1izqCGYYHzHtmnhnKifTub/Y4xjzD+5ubH6U
         he55VUrubzrSuoFTEt0qRa/8DwnQ7H6F4JBS0LDaQN1ovzEL6BaD1SNimGL+C5OTc8
         jqP7Ldad2fsQlsFlizy7mQSQ7aE0bd51VymT1eJxmEJhw5bLXHBR2KWqctl3UkDpJZ
         hfdQ0S/DuS/9dqL+0fpcvoPUoWMG2t2g6kmOZ8NuV2cA3zpbZE33dwOF6Vk57R9fK0
         X1ITOEkuqc1RA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.15-rc2
Date:   Mon, 20 Sep 2021 13:18:43 +0100
Message-Id: <20210920121936.DFBE661040@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 21e39809fd7c4b8ff3662f23e0168e87594c8ca8:

  regulator: vctrl: Avoid lockdep warning in enable/disable ops (2021-08-25 14:17:53 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.15-rc2

for you to fetch changes up to dc9660590d106bb58d145233fffca4efadad3655:

  regulator: max14577: Revert "regulator: max14577: Add proper module aliases strings" (2021-09-17 13:16:38 +0100)

----------------------------------------------------------------
regulator: Fixes for v5.15

A couple of small device specific fixes that have been sent since the
merge window, neither of which stands out particularly.

----------------------------------------------------------------
Dmitry Baryshkov (1):
      regulator: qcom-rpmh-regulator: fix pm8009-1 ldo7 resource name

Krzysztof Kozlowski (1):
      regulator: max14577: Revert "regulator: max14577: Add proper module aliases strings"

 drivers/regulator/max14577-regulator.c  | 2 --
 drivers/regulator/qcom-rpmh-regulator.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)
