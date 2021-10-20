Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E66B43540A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhJTTxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJTTxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:53:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A52C06161C;
        Wed, 20 Oct 2021 12:51:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k7so608743wrd.13;
        Wed, 20 Oct 2021 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QfMvuq4K6cpLtRMk3KHGbMTXe8asjprh2K841Dtt1oA=;
        b=eKrR198UkLWE8Pj6Uegtd4wafbAXciypdyIk/hVInipJy/z1A0lb1Ao7qI8FNxOxqQ
         5jhLCE1OjQlSWrJ+UByzv+jgRz/W+XTWWXO5iuCl48k/QCCtMPQUl0lZNoA8W1jQK3Gd
         pSTtJbzQpLFvzlZi8/313qDegRXfztY/AR1Dc8ltLo3YIZx5rIeBnPUzld3S9JOK60YM
         xs64ChpCFBn1sdLw0TLh2o89vLVftx+UOrR1d6Jr5sIJsp1ggp909Rnj5NHizbX0G4gs
         j+cKIbf/D/ASpMphqy1soiV1NupoW+dalxdYiM8/f9e9HVft2YoGv2nL9+iUvcDtI11u
         i+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QfMvuq4K6cpLtRMk3KHGbMTXe8asjprh2K841Dtt1oA=;
        b=of9Nm9RLHTdO+MlD1zmm11lv3URNsGjoihGVEwyMGlIHHD1nhMZPQxt+zR/ltLi1ad
         pWXUBp0xYtSTiwKT+zKZp4ghAsBhoBAjQznJhl8/bVcNgHJS+w2PNCVF936S+3rVe6ua
         XOG18DB2JyNcK9mUdXQkNopuPo+brFEGKhTXmA/uGZhuvFM4uYnUQOcRgHHn12iwogit
         E5k9SDvAnnFLb9P416G767yyfs1vjbW2SndDZ/BI33JwIDYO6ggfGhI6andJtIqPQn4K
         D4Ov9zn/5eLdWwe6dNBYhG2LQW4ymLX1nYyi9msArutJOChDjY7ubqlh0PjaJAIXJbkE
         GJSg==
X-Gm-Message-State: AOAM530X59B39urIuClbrRPdA80wHBb/xIXU9pXuFu+Inc1rrDfT4N0h
        Jns/XofxZoTVAtbBJE0GQ98=
X-Google-Smtp-Source: ABdhPJzNxHFomcOViX4r7AOwWI5eIKmiLGy8O89pX8OtNiMEKNhsm2ixp+JrCw5VDyi89i6Tf32GIQ==
X-Received: by 2002:adf:f904:: with SMTP id b4mr1528664wrr.403.1634759487982;
        Wed, 20 Oct 2021 12:51:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-b9f5-df00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:b9f5:df00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id f3sm2741310wml.11.2021.10.20.12.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:51:27 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, kishon@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/2] phy: Add support for the HDMI TX PHY on Meson8/8b/8m2
Date:   Wed, 20 Oct 2021 21:51:05 +0200
Message-Id: <20211020195107.1564533-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson8/8b/8m2 SoCs embed a HDMI TX PHY. Unfortunately there is
no (public) documentation for this hardware. The best thing we have is
the 3.10 vendor kernel, which unfortunately doesn't document most
register bits (only a few are named there, the rest is all magic
numbers).
It is possible that this is a TranSwitch HDMI TX PHY based core, but
this is pure speculation.

Adding a driver for the HDMI TX PHY gets us one step closer to video
output on these older SoCs.


Changes since v2 at [1]:
- Use "amlogic,meson8-hdmi-tx-phy" as fallback compatible string for
  Meson8b and Meson8m2. This affects both patches in this series and
  it's the reason why I dropped Rob's Reviewed-by.
- Add a comment to the driver explaining that there no detailed
  register documentation (naming) is available and that's why we also
  use some magic values in the driver as suggested by Vinod.
- Hardcode the HHI_HDMI_PHY_CNTL* register offsets (from the HHI area)
  directly in the driver instead of using some incomplete "reg" property
  parsing code. This also makes it easier to compare the register values
  with the vendor kernel sources and datasheets as the offset doesn't
  have to be added/subtracted when comparing the values.


Changes since v1 at [0]:
- add a reg property to the dt-bindings
- parse the reg property (register offset) in the driver
- update copyright year to 2021 (spotted by Vinod, thanks!)
- drop "default ARCH_MESON" from the Kconfig entry


[0] https://patchwork.kernel.org/project/linux-amlogic/cover/20210604190338.2248295-1-martin.blumenstingl@googlemail.com/
[1] https://patchwork.kernel.org/project/linux-amlogic/cover/20210629182047.893415-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (2):
  dt-bindings: phy: Add the Amlogic Meson8 HDMI TX PHY bindings
  phy: amlogic: Add a new driver for the HDMI TX PHY on Meson8/8b/8m2

 .../phy/amlogic,meson8-hdmi-tx-phy.yaml       |  65 +++++++
 drivers/phy/amlogic/Kconfig                   |  10 ++
 drivers/phy/amlogic/Makefile                  |   1 +
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c      | 160 ++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson8-hdmi-tx.c

-- 
2.33.1

