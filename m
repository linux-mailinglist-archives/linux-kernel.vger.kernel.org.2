Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFACD44570A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhKDQVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhKDQVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:02 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E398C061714;
        Thu,  4 Nov 2021 09:18:24 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i9so6703470ilu.8;
        Thu, 04 Nov 2021 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lLrp2dpY6LYuH9Q0YveCLTWGjslIqfEizqHI6RtJBnI=;
        b=naargcuYU+PjHGywec7wUD34JYXhz7wE9qJYA9EVzvdAMqeKUr4jQSoPryyLU1zgX+
         FZ+Uun5vHr5izE9vW1TtT1688bTuMmnkk78w9z1aMw87W2azLgYmSCGAWAgSWpGeNeLG
         rKVjW4lt7ufyykDpoQpkU9s6KhiFfQ9gDC9p3GLrc+EsMQ6cOehNp1UoeNsmtBcbInxI
         gbCehyYQ1L9TLYsCVKUl6pLJ4dmrYgRrOzScyLRgZs/02BLm/kmfKGWtjVkp4y2xc7Vy
         u06XImS2wIfKR0qfnJTK9oYC9S4mYPZ0BtIvRa5A1Jv0ersCmSSIAIqMlPDFQZazeutD
         +xrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lLrp2dpY6LYuH9Q0YveCLTWGjslIqfEizqHI6RtJBnI=;
        b=4ykUc1OUgx8vqSOpLR9L3sdWMtCYyIHlpm1OAwSqPxeCd3/wDwoQTN4bJ+T4BQZZzr
         CtikjQQay0nt4Nvm5WA0Fb8jta1O6kVntTqEOgEWMxY/W1a9VIjQvIb7aMOHNU4LxGzB
         HJMmv5vuA7Y7OZqaJyeaClseJf7R4nb6wrPujxWTtceL2462a6F0r7xv2b+YgRdZnQ7D
         AljsbnN/zKNJFDWJMFSZIlC4Zmnw6PkpEKxpet8IYcAtpOIcuB6r9Pa979a8sZrnHX1r
         vjWszN6++HUxRx5adUkfrbsFOVbR31qzhFac/JxR9caOhgG2/R3635FRb4x5KPKIGqZA
         2KiA==
X-Gm-Message-State: AOAM530MYiX3/+v+I0SPHhbamm8u43wwu7jTq4f+VWg/X4P3TQcrqqbq
        uhwfp7oICOEuxPtIn6k91I8=
X-Google-Smtp-Source: ABdhPJwW2IEfYXJUHpPOD731IVhI4uaT5j4Nm9eE6ojC0HDrqcu1Rp6WUUIuj1tTHtlR80JQB8CbiQ==
X-Received: by 2002:a05:6e02:1bec:: with SMTP id y12mr2715870ilv.74.1636042703712;
        Thu, 04 Nov 2021 09:18:23 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e81d:737a:bb84:83ba])
        by smtp.gmail.com with ESMTPSA id e17sm3266326iow.18.2021.11.04.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:18:22 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, ariel.dalessandro@collabora.com,
        krzk@kernel.org, tharvey@gateworks.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/9] arm64: imx8mn: Enable more imx8m Nano functions
Date:   Thu,  4 Nov 2021 11:17:55 -0500
Message-Id: <20211104161804.587250-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano is similar to the i.MX8M Mini in some ways, but very 
different in others.  With the blk-ctrl driver for Mini in place, 
this series expands the blk-ctrl driver to support the Nano which
opens the door for additional functions in the future.  As part of
this series, it also addresses some issues in the GPCv2 driver and
finally adds support for enabling USB and GPU.

V3:  Fixes an the yaml example
V2:  Fixes the clock count in the blk-ctrl

Adam Ford (9):
  soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
  soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
  dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
  dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
  soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
  arm64: dts: imx8mn: add GPC node
  arm64: dts: imx8mn: put USB controller into power-domains
  arm64: dts: imx8mn: add DISP blk-ctrl
  arm64: dts: imx8mn: Enable GPU

 .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     |  97 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 103 ++++++++++++++++++
 drivers/soc/imx/gpcv2.c                       |  26 +++++
 drivers/soc/imx/imx8m-blk-ctrl.c              |  75 ++++++++++++-
 include/dt-bindings/power/imx8mn-power.h      |   5 +
 5 files changed, 305 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml

-- 
2.32.0

