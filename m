Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517FB3FB676
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbhH3Mvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:51:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55976 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhH3Mvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Message-Id:Date:Subject:Cc:To:From
        :Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eYlxtLvPOSqJvso7yr7IRCTowiVKL3PAkQOLm7l1QbQ=; b=CL8FzmOAJQ1pXqEKqleWnzO0oK
        wXkXHFPHsPF/F6AeMT5nNJs7fK9JAXIhDlKJGpPtN23z2Ttmr2DukbDERAm1UbknZtvdI4bJot7qG
        cMRgy2cLq4enoFmk9z4uuTJCmk+aqdBM7ix9v7mbHPHQYMiXsd0c7Navri8JSrcuDAW4=;
Received: from jack.einval.com ([84.45.184.145] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1mKgkS-00H5GG-VV; Mon, 30 Aug 2021 12:50:49 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 919B3D1B482; Mon, 30 Aug 2021 13:50:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v5.15
Date:   Mon, 30 Aug 2021 13:50:34 +0100
Message-Id: <20210830125048.919B3D1B482@fitzroy.sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.15

for you to fetch changes up to ca5537c9be13c205492e704c5a3016f54b2fefec:

  Merge remote-tracking branch 'regmap/for-5.15' into regmap-next (2021-08-26 13:45:27 +0100)

----------------------------------------------------------------
regmap: Updates for v5.15

A few small fixes for regmaps this time, plus support for
allowing drivers to select raw spinlocks for the locks in order
to allow usage in interrutpt controllers.

----------------------------------------------------------------
Icenowy Zheng (1):
      regmap: allow const array for {devm_,}regmap_field_bulk_alloc reg_fields

Jeongtae Park (1):
      regmap: fix the offset of register error log

Jinchao Wang (1):
      regmap: Prefer unsigned int to bare use of unsigned

Mark Brown (2):
      Merge series "Use raw spinlocks in the ls-extirq driver" from Vladimir Oltean <vladimir.oltean@nxp.com>:
      Merge remote-tracking branch 'regmap/for-5.15' into regmap-next

Vladimir Oltean (1):
      regmap: teach regmap to use raw spinlocks if requested in the config

 drivers/base/regmap/internal.h       |  4 +++
 drivers/base/regmap/regmap-debugfs.c |  2 +-
 drivers/base/regmap/regmap-mmio.c    |  2 +-
 drivers/base/regmap/regmap.c         | 49 +++++++++++++++++++++++++++---------
 include/linux/regmap.h               |  7 ++++--
 5 files changed, 48 insertions(+), 16 deletions(-)
