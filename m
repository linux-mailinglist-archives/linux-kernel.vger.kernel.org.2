Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF844114B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhITMnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhITMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:43:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79889C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:42:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p29so66441597lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Jyaaz7vsLz5usd/SRKYitd1GGLRRfy3n82omug9pAA=;
        b=L/kr3gQxhCNlhY6qH1CLUHlheQzY/Uh+X/1bxbkbfOsRhN5fgPZdylx7AksknyVZx0
         ZavNwA4iIjTf8EcdStQfTAE/CRJna1NdH2D1H7fxIYHEiQ+0MHOPC7853nFtRKP48Vb1
         GJzyA8LSMUDfFgdLyXv74OeaA8br/7jymBKqKQKfeYRtMB2s0FkIFGGt5rTgnSKxV8mU
         X4NlHShLxa3rlaPq+R/xlNlW86R+vVxLpXI2xSERkAr/iLu0cn1PCrZkVQlCaSVrLeQt
         SndtPNzU3Ga5dMxXpv6OGJSxycuUZb6UBdv2g/0rC2zCOClhczAXcpdZBuLYOnmaI5kz
         GHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Jyaaz7vsLz5usd/SRKYitd1GGLRRfy3n82omug9pAA=;
        b=5Nc86vk7x6qF4GBc0Iq1mi1rr+2i0+ltKbdav77U3W1kpyIcvJOu1TinuIx580ZcVK
         Ce+mlYA5llNxrOJ2bZ+RkTACr+lOYHPOBhduisUg0DJAs6T9/j94EgK3+TEy3mQGLEP+
         wuM7T88+68kT9F6Q/W/+Mh24v+Cp8PIUCYlILT1FYWovD1z2iMPfTvlTWz5VnfbKzMkE
         OHydsrcYqBc/LrPz+iuXMBbxOgUgj74Yed8OSJ3o/UvTUMYZjOqTdAqC0HkRSHcQqpwk
         adjJZyoRV/CM316QMyC8IbBEmAOghoO7IIvrY6UfOfAbt/XiZkG4y0TxgeqQNy9Al7p0
         gjjg==
X-Gm-Message-State: AOAM5326C/uPbMV/Du8RzDp6uq71QkKoifWO/YqD4nDYOmMmWSOjtR/f
        v6EdvycQTx34UzIvT057dUz2fA==
X-Google-Smtp-Source: ABdhPJwptMV9N4Ai1/dhNdrr/uDN6aHZsMXxgGcaXehA6fzWLlCPes1ne4JSuGwqmkcUqu3FgLPPGw==
X-Received: by 2002:a2e:501a:: with SMTP id e26mr20763529ljb.57.1632141723926;
        Mon, 20 Sep 2021 05:42:03 -0700 (PDT)
Received: from grasshopper.googchameleon.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id v1sm630944lfo.308.2021.09.20.05.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 05:42:03 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        dinguyen@kernel.org, p.zabel@pengutronix.de
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tn@semihalf.com, ka@semihalf.com, jam@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 0/3] Add support for the Mercury+ AA1 module
Date:   Mon, 20 Sep 2021 14:41:38 +0200
Message-Id: <20210920124141.1166544-1-pan@semihalf.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add support for the Mercury+ AA1 with an
Arria 10 SoCFPGA, namely a device tree, and a fix regarding the
Arria 10 reset manager driver.

Paweł Anikiel (3):
  dt-bindings: mtd: spi-nor: add n25q00 schema
  dts: socfpga: Add Mercury+ AA1 devicetree
  reset: socfpga: add empty driver allowing consumers to probe

 .../bindings/mtd/jedec,spi-nor.yaml           |   2 +-
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/socfpga_arria10_mercury_aa1.dts  | 127 ++++++++++++++++++
 drivers/reset/reset-socfpga.c                 |  26 ++++
 4 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts

-- 
2.25.1

