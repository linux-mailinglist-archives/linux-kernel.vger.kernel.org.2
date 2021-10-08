Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A480426A05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242605AbhJHLpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:45:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:53710 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243448AbhJHLoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633693330; x=1665229330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ByWoSgpOz8sZiCzoDYKtmBjQsscj636gJWSCmvlpJsw=;
  b=nsDx0CrbPMJDH3Gq9S24tY2z2DzyVR5nE3eydT8H177GLlLgjIYXVO/M
   z59oyX+w+yxiXYrt+fS6A08SIoL81l0935/gJ7ug0sCH0MZf+5bd9WTJM
   L21C4woD5FFtfBXQi/ufYiRgrY0LVF7kLrrq+R6SgJ6DMQ5c1mstVCqC6
   jur/NImVnWyMx0uNtlP/JWwPLkH09voq6WZTQx56mivGY12RZMjBIkfa2
   0U5bLxJ7Pa659/3ZZOqUPNoDEEUYAI3yI4BW2y8giVzmtP/PPyo9ERcRe
   5HS6BKy+Jo7P+KBz7P99O7FvSV5CtHmVxMnh/vu65ztgPAEo3snv1hZZf
   g==;
IronPort-SDR: ZLBJR5dA//EmvmIkINY3QlPyGblkuuvxSC04XImd/1fYUkbnv2Y9p3yd/QsYhn+5rE9WVJSKjO
 Wtd71M3X97SbxpdlK/3s3RXc3ldbaRfzQvZCLR/ANLpG6GN0SHXLQcF5ITLuqIIXbAI+s8IRUD
 17TE9lnCjNk/9+iO7nJnPB02ilD91l2vI62r2Bhrzuf7BeVsyHI3ejO/9PjC9ukBI9yXiwbpJ/
 nclISf2ZbGBu7oc+FdWJUkPVYlwXsD/xF9GFXjmKQNpL/T9pSmQ6/x/benbdvRWn9W4k2oxvIO
 3dzjcK8dL9fsdSgeX426UfX+
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="139528888"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Oct 2021 04:42:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 8 Oct 2021 04:42:08 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 8 Oct 2021 04:42:06 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 0/2] Extend Sparx5 switch reset driver for lan966x
Date:   Fri, 8 Oct 2021 13:43:28 +0200
Message-ID: <20211008114330.1328713-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie extends the Microchip Sparx5 reset driver to support
lan966x

Horatiu Vultur (2):
  dt-bindings: reset: Add lan966x support
  reset: mchp: sparx5: Extend support for lan966x

 .../bindings/reset/microchip,rst.yaml         | 10 ++-
 drivers/reset/Kconfig                         |  2 +-
 drivers/reset/reset-microchip-sparx5.c        | 62 ++++++++++++++++---
 3 files changed, 64 insertions(+), 10 deletions(-)

-- 
2.33.0

