Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECBA3FA531
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhH1K5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhH1K53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:57:29 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E725C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:56:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 2so8025734pfo.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sg5nAiaktCH38kYoHhjO0RsLxXlGtuWfNhh8m5dH40k=;
        b=vIGFq/nkRjCbY+xdM6fhuIyFFJR7xNAZQuNAe8vpgD2rGr0gDiJDw0CEV68KGs6v7a
         h9ZyirGIui/6a71WPUcq290J8Hs2UewJyXy2xZ2WwVWYENYmAIKpuXluqThrOFt5XSwG
         sc9paQuTPUvsGPFRy1GlVALaHkOpqStmUCOHErevzA170p8UEpap+8doeorOxuVdDL6s
         7uxQYjEEl1xxqh75HJizVBwyrOytqKs6g2uPD/yTu5TCiZyEcnybqYCiNpwRRG+tShfi
         q4z/w0DEBvNc3NBKB+geTNbEUPv1DloTMNT2GezPYFPmtJEiCPTK9fZlMyB0vBAQloWn
         oFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sg5nAiaktCH38kYoHhjO0RsLxXlGtuWfNhh8m5dH40k=;
        b=b7kIpkCJTqrKGoXK8+ej/WBCd7is1munQS7FhpXoJemzp6kftKMj7Scw+87evPoped
         LUuQXUp7u9keRsgjUoMU8m4ib/JW+0qgoqLo+T3st67EKoweHJilW6LiOlLFLR1m7rMb
         cJCN8qaUAInrQcEQ+wWaVhtrmfuPFmk5I+/R3mH/10iPxt0Q9abmEoiQYrDvdLqZ+01A
         Z5pJE1RmSiZHyI/SSeGeUHgFx51QBC6lHkyZ/MTL1iYKbDPZs7Qvd1tyIISQJQL8oTwR
         ENm2bxNgl/1lWd4CGnks/seVGHzbQgQo1PhTR6XKrpJlcWoDd+eG1haBSbF4flRATavA
         S3ng==
X-Gm-Message-State: AOAM532Qazm54zJlR+KJYyTy6FO/3QrhrsreQGiwafgcLxDfyveiBkKE
        hvOdD5mBE1CwqDaHcb000eg=
X-Google-Smtp-Source: ABdhPJwtVWlZgKQWyIWMN62OlqGOn+xHS6RFTqHwF3WuY/Tdqr3ODww0gmIOhF76b6eNtLiDn+/7MQ==
X-Received: by 2002:a65:6648:: with SMTP id z8mr11978095pgv.418.1630148198879;
        Sat, 28 Aug 2021 03:56:38 -0700 (PDT)
Received: from localhost.localdomain (125-237-24-95-adsl.sparkbb.co.nz. [125.237.24.95])
        by smtp.gmail.com with ESMTPSA id 10sm9616470pjc.41.2021.08.28.03.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 03:56:38 -0700 (PDT)
Date:   Sat, 28 Aug 2021 22:56:33 +1200
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hello@bryanbrattlof.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: pi433: fix docs typos and references to previous
 struct names
Message-ID: <20210828105633.GA8421@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the comments there where some grammar mistakes and references to
struct names that have gotten renamed over time but not updated
in the comments.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
v2: revert identation that had been applied to the author's name (Req:
Greg k-h)
v1: https://lore.kernel.org/lkml/20210828000836.GA10188@localhost.localdomain/
---
 drivers/staging/pi433/pi433_if.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index d5c1521192c1..855f0bebdc1c 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -5,14 +5,13 @@
  * userspace interface for pi433 radio module
  *
  * Pi433 is a 433MHz radio module for the Raspberry Pi.
- * It is based on the HopeRf Module RFM69CW. Therefore inside of this
- * driver, you'll find an abstraction of the rf69 chip.
+ * It is based on the HopeRf Module RFM69CW. Therefore, inside of this
+ * driver you'll find an abstraction of the rf69 chip.
  *
- * If needed, this driver could be extended, to also support other
- * devices, basing on HopeRfs rf69.
+ * If needed this driver could also be extended to support other
+ * devices based on HopeRf rf69 as well as HopeRf modules with a similar
+ * interface such as RFM69HCW, RFM12, RFM95 and so on.
  *
- * The driver can also be extended, to support other modules of
- * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
  * Copyright (C) 2016 Wolf-Entwicklungen
  *	Marcus Wolf <linux@wolf-entwicklungen.de>
  */
@@ -33,8 +32,8 @@ enum option_on_off {
 /* IOCTL structs and commands */
 
 /**
- * struct pi433_tx_config
- * describes the configuration of the radio module for sending
+ * struct pi433_tx_cfg
+ * describes the configuration of the radio module for sending data
  * @frequency:
  * @bit_rate:
  * @modulation:
@@ -46,7 +45,7 @@ enum option_on_off {
  * @repetitions:
  *
  * ATTENTION:
- * If the contents of 'pi433_tx_config' ever change
+ * If the contents of 'pi433_tx_cfg' ever change
  * incompatibly, then the ioctl number (see define below) must change.
  *
  * NOTE: struct layout is the same in 64bit and 32bit userspace.
@@ -81,8 +80,8 @@ struct pi433_tx_cfg {
 };
 
 /**
- * struct pi433_rx_config
- * describes the configuration of the radio module for sending
+ * struct pi433_rx_cfg
+ * describes the configuration of the radio module for receiving data
  * @frequency:
  * @bit_rate:
  * @modulation:
@@ -94,7 +93,7 @@ struct pi433_tx_cfg {
  * @repetitions:
  *
  * ATTENTION:
- * If the contents of 'pi433_rx_config' ever change
+ * If the contents of 'pi433_rx_cfg' ever change
  * incompatibly, then the ioctl number (see define below) must change
  *
  * NOTE: struct layout is the same in 64bit and 32bit userspace.
-- 
2.25.4

