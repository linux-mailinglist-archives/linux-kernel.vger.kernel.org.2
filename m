Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56EB33B2AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhCOM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhCOM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:26:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B651C061574;
        Mon, 15 Mar 2021 05:26:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v4so5592860wrp.13;
        Mon, 15 Mar 2021 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGsQp5GmOmkLFtn8H/yFZ1lX9b0lB9nbj1NVQJIXgeA=;
        b=o7cb5Rd4KQ9bPCpiezaOtY8rJGytjNnwtKQI0idEeM4H8JBsmzSBWTzhm7bP9frOhy
         Ja94fIAr5vxeUPscEiWQC/fWoUTRJi8yN6iul4fXmw1EPRhFFRFmpO5dj/YMIJi79NG2
         YQbfvmiSiI0vVFHL1ddH7ccuNpsH/bdK/D8h1ul3WnuJdRpxtz8f40LSb4Ne+lRLuJ9b
         NkJUspUI4H/Gf9AAgXFQvvxBWTXv1jPvgfhhsQxKVbRbVHcQiOePfBvl9EQ+ipR7kiHn
         rsZRjZBg/mtDwH5AaoB//QXEx03boBVhz09s81btuVdCtJ4/C/l8aByUR9oZzpKT3zPb
         5jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGsQp5GmOmkLFtn8H/yFZ1lX9b0lB9nbj1NVQJIXgeA=;
        b=IPGg03KsTtjL7S2s35WMAhwc9kQVtYgVwp8iMXwh4iRhmxHDTpjwR3Y6pkvbN/NQwU
         QJcK/1jfr4LiDYE8qN4T18GzViLAiJgcGiUb15MlliAI4Isf5smQn45k/URbnAgoCuOO
         erXXVXjch3XAAGS5bhWUKWpuF8PUdhAgIbupRZq6ProGfscctiXRL9NUPoo4rGJyDKmc
         8dQTX4UhNWttrwwbM5xmyP9P8MyzagWMZll1zVTtt/FYW/cwNCpEKlrqDO7tqBVhSUjk
         e2YTFhKM9JqluQIr93tnxxLOysycLjpRWiyVDJ5xvbxAfv5BL0WmWmkmhUQ0dWs2NNc1
         H1iQ==
X-Gm-Message-State: AOAM5301X5ERfPNJSeRXXfD1SV9TTlrCBkPkcIMYGviWQTN2RPj0frHf
        UKPSO+fECSPLoAeGA4ZiZbA=
X-Google-Smtp-Source: ABdhPJzdV+fOihdMIfEKHYtiwdUVCV9zitjwsw24jgpVmK4iK+WtKG6nMx1zPOTVOHfdMB/9dthUjA==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr27587236wrt.294.1615811167220;
        Mon, 15 Mar 2021 05:26:07 -0700 (PDT)
Received: from skynet.lan ([80.31.204.166])
        by smtp.gmail.com with ESMTPSA id o7sm18317851wrs.16.2021.03.15.05.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:26:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] clk: add BCM63268 timer clock and reset
Date:   Mon, 15 Mar 2021 13:26:01 +0100
Message-Id: <20210315122605.28437-1-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcom BCM63268 has a timer clock and reset controller which has the
following layout:
  #define POR_RESET_STATUS            (1 << 31)
  #define HW_RESET_STATUS             (1 << 30)
  #define SW_RESET_STATUS             (1 << 29)
  #define USB_REF_CLKEN               (1 << 18)
  #define UTO_EXTIN_CLKEN             (1 << 17)
  #define UTO_CLK50_SEL               (1 << 16)
  #define FAP2_PLL_CLKEN              (1 << 15)
  #define FAP2_PLL_FREQ_SHIFT         12
  #define FAP1_PLL_CLKEN              (1 << 11)
  #define FAP1_PLL_FREQ_SHIFT         8
  #define WAKEON_DSL                  (1 << 7)
  #define WAKEON_EPHY                 (1 << 6)
  #define DSL_ENERGY_DETECT_ENABLE    (1 << 4)
  #define GPHY_1_ENERGY_DETECT_ENABLE (1 << 3)
  #define EPHY_3_ENERGY_DETECT_ENABLE (1 << 2)
  #define EPHY_2_ENERGY_DETECT_ENABLE (1 << 1)
  #define EPHY_1_ENERGY_DETECT_ENABLE (1 << 0)

v2: add changes suggested by Stephen Boyd.

Álvaro Fernández Rojas (4):
  dt-bindings: clk: add BCM63268 timer clock definitions
  dt-bindings: reset: add BCM63268 timer reset definitions
  dt-bindings: clock: Add BCM63268 timer binding
  clk: bcm: Add BCM63268 timer clock and reset driver

 .../clock/brcm,bcm63268-timer-clocks.yaml     |  40 +++
 drivers/clk/bcm/Kconfig                       |   9 +
 drivers/clk/bcm/Makefile                      |   1 +
 drivers/clk/bcm/clk-bcm63268-timer.c          | 231 ++++++++++++++++++
 include/dt-bindings/clock/bcm63268-clock.h    |  13 +
 include/dt-bindings/reset/bcm63268-reset.h    |   4 +
 6 files changed, 298 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
 create mode 100644 drivers/clk/bcm/clk-bcm63268-timer.c

-- 
2.20.1

