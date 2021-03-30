Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8FE34E5FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhC3LCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:02:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52268 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhC3LCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:02:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UB1hNC118743;
        Tue, 30 Mar 2021 06:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617102103;
        bh=OMvuHxJr7BKv7RxoGD9YOG+EXTnCbM+J+kgdYHeSvLg=;
        h=From:To:CC:Subject:Date;
        b=TDIoDP0rgt4udmXhRuBVM9Rbm3Na5jj8lNoxyTa7z+4gHUQnqKydiDfenO/ClnL5f
         FvYbUCYZNu/OTJXTUeFwknE1gEgZ6BXKf8thH5J+zeLYtvowV+6Cl9VxSVfPLPOlf4
         1NF/MV3UvgHa6fXoXc59r4Qi2M0Z0APMqThrq4e4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UB1gXQ022730
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 06:01:43 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 06:01:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 06:01:42 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UB1dci094447;
        Tue, 30 Mar 2021 06:01:40 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 0/5] j721e-wiz/cadence-torrent: Support to skip SERDES configuration
Date:   Tue, 30 Mar 2021 16:31:33 +0530
Message-ID: <20210330110138.24356-1-kishon@ti.com>
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

v1 of the patch series can be found at [2].

Changes from v1:
1) Added a patch to wait for PIPE clock to be stable
2) Added reviewed by from Swapnil

[1] -> http://lore.kernel.org/r/20201103035556.21260-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20210310155445.534-1-kishon@ti.com

Faiz Abbas (1):
  phy: ti: j721e-wiz: Do not configure wiz if its already configured

Kishon Vijay Abraham I (4):
  phy: cadence-torrent: Group reset APIs and clock APIs
  phy: cadence-torrent: Do not configure SERDES if it's already
    configured
  phy: cadence-torrent: Explicitly request exclusive reset control
  phy: cadence-torrent: Add delay for PIPE clock to be stable

 drivers/phy/cadence/phy-cadence-torrent.c | 115 +++++++++++++++-------
 drivers/phy/ti/phy-j721e-wiz.c            |  21 +++-
 2 files changed, 95 insertions(+), 41 deletions(-)

-- 
2.17.1

