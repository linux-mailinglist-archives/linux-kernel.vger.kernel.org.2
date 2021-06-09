Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C960A3A1338
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbhFILsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:48:17 -0400
Received: from polaris.svanheule.net ([84.16.241.116]:47140 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbhFILsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:10 -0400
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafb:ee01:a92e:8520:f692:3284])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id F3CEA20B12F;
        Wed,  9 Jun 2021 13:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1623239173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8zkpi5Qdro66eajeS3bGEGo6Xkt4MNhXmPkxW03khIY=;
        b=5+7puntTa5xh0wbfQp6Msuhe32v6FRI7Aup/EH3K0g0GRNw8bmJlE7ygkXDYITsm3WuPzv
        jD2Dsw0jx3cPgnv3n7C8017WS4vJnS7myzWlQmJXRQ4UWazWf8Fls+4A/Y3ZjtlQwlxaBI
        oIddfsMwLNDxXGdxKAb0F1wCBIpJ3umioshaJncbq8hQ8cUjDL/vgJsFeI1mR0dAAgWNM2
        heWUAeUWCt9Jawrvt1+Hc6PKaZAdFyUMLNZf9EH1h53z3KGjyJqVHYumzl/+YKXyQI1t9q
        nuPu38Vb7y/IfT5WyjCJUQAtpd5RrHJAN0lZI7AYmfFwSa+pH0B/E7i2ywCOow==
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrew Lunn <andrew@lunn.ch>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH 0/2] Clause-22/Clause-45 MDIO regmap support fixups
Date:   Wed,  9 Jun 2021 13:46:04 +0200
Message-Id: <cover.1623238313.git.sander@svanheule.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A proposed patch to make C22 access more strict [1], was posted in reply to an
RFC series which also added C45 register access [2]. It appears that as a
result, the original RFC patches got merged instead.

Since there are currently no (planned) C45 regmap users, this patch is
reverted. C22 access functions are corrected to return -ENXIO, instead of
silently ignoring any invalid high bits in the register offset.

[1] Proposed C22 patch:
https://lore.kernel.org/lkml/20210605083116.12786-1-sander@svanheule.net/

[2] RFC series:
https://lore.kernel.org/lkml/cover.1622743333.git.sander@svanheule.net/

Sander Vanheule (2):
  Revert "regmap: mdio: Add clause-45 support"
  regmap: mdio: Reject invalid clause-22 addresses

 drivers/base/regmap/regmap-mdio.c | 72 ++++++++-----------------------
 1 file changed, 18 insertions(+), 54 deletions(-)

-- 
2.31.1

