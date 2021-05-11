Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C6D37AF62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhEKThR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhEKThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:37:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C825C061574;
        Tue, 11 May 2021 12:36:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e7so2733303wrc.11;
        Tue, 11 May 2021 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zb61gUgaL3LEdnegX0GBOgb+6mLeX4ulrXL5qskG4+g=;
        b=In/MxweFd1wuhOeM09PgVMVE2t7YFAQv/NtSlynYbgWM84+mphXM3toXZkPFs4FwlO
         dpNLhbodUcAqa/C6pEcN1dj9392kQxCxskfBgfOEDiatD+8GSlm8PRHzA1mQYt066Zqf
         0SJPTE/PGPYeEp4zKEXZwS8J07KSXkWa0nlGDXLfySh/o2QUCZ2F727PQR9aXsybHiOm
         zn7SU1KadhSehn01BVRhLV7BiO4LWjaSPiH8ZxB/x/lY6SX8/0EEqlhrWtp6kLkqTpMp
         VQeENa8Ya+i5RsSfprrE12iI3t7+l5ONH7/IMqMrhQMLVf+cogXD5gfNarIeCoo2EQ0d
         NtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zb61gUgaL3LEdnegX0GBOgb+6mLeX4ulrXL5qskG4+g=;
        b=e1nFqNCKss3IeFepGxnJIeZlzi/D48tIqHGDBgHnafKlf+0fHSH/r1/iI18ioVCHwU
         Z8vxwDXMf+dzy+3+2ExSaubqE6Kzrg7hu73EzI9b9kvROHSr45AouWz4d434TfgACrnz
         hm79rgElowetRxmCrzh5+Ovx3OtGTgDTf6Lqz5XSHJ4/3tn3WHYcE3eV5wtsR1bpKSZM
         7lD8EqWEbvoFYoNNC747nesturJbyjE69A7IbCRCnC1slVG16X26usjnfS+CKdXvIO9q
         YVsoHz5MBaIrbVyV42f6+WaRelohhBdhVa9cAdjzof7DIvyvfBYtMz0A+PbkW+Qs9NZr
         M2hA==
X-Gm-Message-State: AOAM532fiqtn5P+GlPh/oBMGmheNuXEp3ZyvRQAgA2vTbFyZM3qFjsJQ
        sUFcHIafvZrt7V3it/1Ltiw=
X-Google-Smtp-Source: ABdhPJxulE74mP9F02HdUX+dppv8ibsJDqXC7JTnuODn1Uilpvpgnkwom6VM4waMJ1GAMlGlmnjXEw==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr40792929wri.260.1620761766178;
        Tue, 11 May 2021 12:36:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:3e6:d280:2c6d:4527:c2ea:bb9a])
        by smtp.gmail.com with ESMTPSA id a76sm2604562wmd.16.2021.05.11.12.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:36:05 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 0/4] Add peripheral support to imx8mq-nitrogen board
Date:   Tue, 11 May 2021 21:35:57 +0200
Message-Id: <20210511193601.2584324-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch set aims is to add support of multiple peripheral of the
Boundary8M board:
  - USB Host;
  - USB device;
  - DB_DSIHD sub board for MIPI-DSI to HDMI output (via lt8912b chip).


Updates in v2:
  - Use a GPIO hog to handle the USB HOST reset line;
  - Remove useless GPIO hog for lt8912b.

Update in v3:
  - Fix bad squash in git commits.

Updtaes in v4:
  - Fix issues found during review (bad DTS style);
  - Fix comment for the USB HOST.

Thanks,

Adrien Grassein (4):
  arm64: dts: imx8mq-nitrogen: add USB OTG support
  arm64: dts: imx8mq-nitrogen: add USB HOST support
  arm64: dts: imx8mq-nitrogen: add lt8912 MIPI-DSI to HDMI
  arm64: defconfig: Enable LT8912B DRM bridge driver

 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 182 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 2 files changed, 183 insertions(+)

-- 
2.25.1

