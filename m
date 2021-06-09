Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B163A1527
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbhFINMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFINMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:12:07 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 06:10:12 -0700 (PDT)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafb:ee01:a92e:8520:f692:3284])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id EAF9620B196;
        Wed,  9 Jun 2021 15:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1623244211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ymps/A9sbVQdtP+gKgpAHcNVZkzTczmwIt7HhIld00I=;
        b=US1KMsWEkI3CHt1whUPDIRkhSQDWAQGiHGNWfxQr4y+N1bR+Ujl533SUpQ87bWYKj1s5l3
        IHP430CidQXENctjeusNhNRvJN/wstkZ32oL3n12avgHrK9W/bOVq3ZHr7BU4lYDso6gNa
        mT0qsFexr8GGkA2e+VSc2s540WgowFyVVBwp1eSl4Q2/Kx9BMUUNSMK3eBPr6lblgQbuCU
        8Z7u6lPbedveAogMggL7a3lKF+9p8hHLU54x5bQF9rTD4vd7CQF9hYsGhMx+C4BlddXYlt
        HgyDK8e/hKlw36FWKs0sZiH2wQ9kDBgSa45+z5TQebD0JNvJsTGRUgsLDymcTA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrew Lunn <andrew@lunn.ch>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 0/2] Clause-22/Clause-45 MDIO regmap support fixups
Date:   Wed,  9 Jun 2021 15:10:02 +0200
Message-Id: <cover.1623244066.git.sander@svanheule.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A proposed patch to make C22 access more strict [1], was posted in reply to an
RFC series which also added C45 register access [2]. It appears that as a
result, the original RFC patches got merged instead.

Access functions are corrected to return -ENXIO, instead of silently ignoring
any invalid high bits in the register offset.
Additionally, a warning about a discarded const qualifier is fixed.

[1] Proposed C22 patch:
https://lore.kernel.org/lkml/20210605083116.12786-1-sander@svanheule.net/

[2] RFC series:
https://lore.kernel.org/lkml/cover.1622743333.git.sander@svanheule.net/

---
Changes since v1:
Link: https://lore.kernel.org/lkml/cover.1623238313.git.sander@svanheule.net/
- Keep C45 access code, but apply fix for discarded pointer constness
- Return -ENXIO for invalid C45 access too, as done for invalid C22 access

Sander Vanheule (2):
  regmap: mdio: Fix regmap_bus pointer constness
  regmap: mdio: Reject invalid addresses

 drivers/base/regmap/regmap-mdio.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.31.1

