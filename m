Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A0C334236
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhCJPzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:55:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46336 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhCJPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:55:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AFsuA7120873;
        Wed, 10 Mar 2021 09:54:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615391696;
        bh=8AYrDZ9YTwYsvVYi/Y4U5QHZjjUnhc9h3+C5pzcRwqo=;
        h=From:To:CC:Subject:Date;
        b=Si4a9pP87FSkTc9KvUXBQBpMdJ0uHnykTc5C+FFVf79oYMjzIxLCKvJD4HF9ojtXV
         Fpqn0f4fKKiVKL8TOOwl1cj2+Lq9IqyrBqttqHU8eUVJUPCdRV+fHrXeOmBhxtUNLe
         D5TBAD1Vn8X/u78N21JoH+guFFw6bDZnUGE3me/4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AFsuab029139
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 09:54:56 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 09:54:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 09:54:56 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AFsq5h082613;
        Wed, 10 Mar 2021 09:54:53 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH 0/4] j721e-wiz/cadence-torrent: Support to skip SERDES configuration
Date:   Wed, 10 Mar 2021 21:24:41 +0530
Message-ID: <20210310155445.534-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to skip SERDES configuration if it's already configured in
bootloader.

The wiz part was initially sent in [1] but that was sent more in the
context of Sierra but this is in context of Torrent. The Sierra part
would be sent later.

[1] -> http://lore.kernel.org/r/20201103035556.21260-1-kishon@ti.com

Faiz Abbas (1):
  phy: ti: j721e-wiz: Do not configure wiz if its already configured

Kishon Vijay Abraham I (3):
  phy: cadence-torrent: Group reset APIs and clock APIs
  phy: cadence-torrent: Do not configure SERDES if it's already
    configured
  phy: cadence-torrent: Explicitly request exclusive reset control

 drivers/phy/cadence/phy-cadence-torrent.c | 106 ++++++++++++++--------
 drivers/phy/ti/phy-j721e-wiz.c            |  21 ++++-
 2 files changed, 86 insertions(+), 41 deletions(-)

-- 
2.17.1

