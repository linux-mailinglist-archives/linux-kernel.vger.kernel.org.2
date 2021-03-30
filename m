Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8234EBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhC3PST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:18:19 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:61289 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhC3PRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617117464; x=1648653464;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=i7hqXDBFMEOH344k9HghH3EKm0gmYqjjMoYYpOlfG7k=;
  b=sSpnUdxYkTcwakAyleNrtw+O6+Z2KHcsvxI0PrW1aAQ83xROdOJQ8NdV
   RoHVKjbi2RHi8UxOKx8mZjRZBLwG5gtSn45vccLCbaZPBKN7hyyQWr0F7
   sIlYwjP/6LQNd7egrI6Tk6rp2hYNXn5XPrWdyb9zJH3t1V3F97/Ur9EH6
   fQd9PG4Gwjv5VQqNlPVFOLVsYADIc0BYKDQBm/wYa/XCJNn/CVMcarLHR
   mMvucl33P30uYykh0dei07xloTB9novRlq+c7Nn7h226ITnPgHsEFuind
   VkMFm+0spOJdYRz9MwMnW4sJU3PIbtgJ7yO5oICmVgKRGJRRHK5smBlKY
   A==;
IronPort-SDR: U9O3kSBVfij23VJN3kWbJ3je+zz+RMiXR7LRbIi6o5gkhZu85AMJIZzFIvJ86U3HVPsOoxH7OM
 7znL/NhjmgEVChD9v1YsRi9ufEVAI9x5T5iWBkBUXAE2JMpjFTx7OflUa9Yw7YiNLCRMy2EMQK
 1q423DvIHQ7VPLqPsE+XtUXIgg0rdeTXGaRQ/Qmnk4Sjy6YnblAwCparZ9FzLIlxqWHEGozIFj
 2oJzICgm253FzpLTF4DsHvqQNxSk4aOmtfpWFZEMb4vBLIfw7+kfDtuIQebLN0Bb2OCXxWqLfJ
 AsA=
X-IronPort-AV: E=Sophos;i="5.81,291,1610434800"; 
   d="scan'208";a="121077763"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2021 08:17:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 08:17:31 -0700
Received: from dan-linux.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 30 Mar 2021 08:17:31 -0700
From:   Dan Sneddon <dan.sneddon@microchip.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Sneddon <dan.sneddon@microchip.com>
Subject: [PATCH] drm/atmel-hlcdc: Allow async page flips
Date:   Tue, 30 Mar 2021 08:17:20 -0700
Message-ID: <20210330151721.6616-1-dan.sneddon@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is capable of doing async page flips so we need to tell the
core to allow them.

Signed-off-by: Dan Sneddon <dan.sneddon@microchip.com>
---

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 871293d1aeeb..f6c3d8809fd8 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -686,6 +686,7 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
 	dev->mode_config.max_width = dc->desc->max_width;
 	dev->mode_config.max_height = dc->desc->max_height;
 	dev->mode_config.funcs = &mode_config_funcs;
+	dev->mode_config.async_page_flip = true;
 
 	return 0;
 }
-- 
2.17.1

