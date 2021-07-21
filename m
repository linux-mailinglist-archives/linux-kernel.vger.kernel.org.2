Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9BE3D1522
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbhGUQxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 12:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233799AbhGUQxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:53:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C04176023B;
        Wed, 21 Jul 2021 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626888824;
        bh=uewDra+cFkYZ2VimETNWlkhVuCFnLS3szDDCo3c1O1c=;
        h=From:To:Cc:Subject:Date:From;
        b=cU7U6nueFjNLLKHuI5F1yoqqsFUzaoDF1xJ8VWwFFnbqTG0MIn3JIwyQNlQxzMYLx
         BSyafbMKEsAimaMZS+fwZ5YCm2Prrpqu5fWqH7luRu31UKt3NtVtAIWxDZJJmKlAyc
         fmVnjxT9kQJCsZbinPpFFcEOXy1KUpUa+F62Wx1SesNeqa8nW03wtm2PJK2/LCfG8U
         qp2CHzEzumIS2ifztHenovaFdxoNqZVsp37e3rsWWVG+sQLobuPK2f74ji8LxoksdU
         qfKrIf2NusELVT5JpvXPxe/LiPIwVv+tKgmWL6JQjBNQUVHrRpP8qLP0mbfKf2isw9
         uYViNmxlGtTWw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.14-rc2
Date:   Wed, 21 Jul 2021 18:33:22 +0100
Message-Id: <20210721173343.C04176023B@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ddf275b219ab22bc07c14ac88c290694089dced0:

  regulator: bd9576: Fix uninitializes variable may_have_irqs (2021-06-23 12:34:42 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.14-rc2

for you to fetch changes up to 1c73daee4bf30ccdff5e86dc400daa6f74735da5:

  regulator: hi6421: Fix getting wrong drvdata (2021-07-11 23:44:37 +0100)

----------------------------------------------------------------
regulator: Fixes for v5.14

A few driver specific fixes that came in since the merge window, plus a
change to mark the regulator-fixed-domain DT binding as deprecated in
order to try to to discourage any new users while a better solution is
put in place.

----------------------------------------------------------------
Axel Lin (5):
      regulator: rt5033: Fix n_voltages settings for BUCK and LDO
      regulator: hi6421v600: Fix getting wrong drvdata that causes boot failure
      regulator: bd9576: Fix testing wrong flag in check_temp_flag_mismatch
      regulator: mtk-dvfsrc: Fix wrong dev pointer for devm_regulator_register
      regulator: hi6421: Fix getting wrong drvdata

ChiYuan Huang (1):
      regulator: rtmv20: Fix wrong mask for strobe-polarity-high

Ulf Hansson (1):
      regulator: fixed: Mark regulator-fixed-domain as deprecated

 .../bindings/regulator/fixed-regulator.yaml        |  2 ++
 drivers/regulator/bd9576-regulator.c               |  4 ++--
 drivers/regulator/hi6421-regulator.c               | 22 +++++++++++++---------
 drivers/regulator/hi6421v600-regulator.c           | 16 +++++++++-------
 drivers/regulator/mtk-dvfsrc-regulator.c           |  3 +--
 drivers/regulator/rtmv20-regulator.c               |  2 +-
 include/linux/mfd/rt5033-private.h                 |  4 ++--
 7 files changed, 30 insertions(+), 23 deletions(-)
