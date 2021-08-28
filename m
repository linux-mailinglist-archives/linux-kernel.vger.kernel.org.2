Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAD93FA4F1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhH1KNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbhH1KNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:13:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EB2C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:12:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m26so8006525pff.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wi+p9bw6dkKYhPSdA0Q7/4wAJUQFVkCW+fYz4vuAze0=;
        b=KXAHjkJTYCeZAPn0OJx/05v5ZeIkUqqxbr0h06fKBo27oeTTJowIQxcNIllg4PpN02
         x4jP36Vp6lRFFuqbMFmRmtGkWntyI6mVJXds+chIMJmfrK4+UqSTtR5VKuzPckK5PCpW
         DzqBAaPOOrfwxQsB5xN0yU4RORw1DMLI5T8CRXYNVfFch/HYIr+VrPsPFPLBgR09TWqz
         KwNv/3OZl6DEduS53hfQdol2pXe6jP7CQSqelpYAifh+/2po6o0zruagTMAhNMsULO6b
         C+elwnPzPaBVe9EZMnof6T5UgvuIfwSsDM88CaCM2mnf08dQso+lrUsAnLE+bZMYQY5h
         ahdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wi+p9bw6dkKYhPSdA0Q7/4wAJUQFVkCW+fYz4vuAze0=;
        b=fTXoYKkpF/OLjJ9/uCCs+gRqTsqXKDmevaxNMiCLTl4ZjgzWVwFQsrs9hvEQsCCfC+
         zWSktgeNE7cOlbRaJeusHYWI6TCV7IXi0hjvYBrr0xd9MuN71/Qk4GMuAarhCwt5GrO6
         aGsTnvA1dqp5yuwscifqVnfnyPBzJjSVUYR2GW53WFfrLpEEzlQ/SV2B33S9h2xnxFH2
         T2l+FRftZznph8Fv+gZ8/8OjeSQvvFvwa54ouSB82IV5Af8PnkJnx7Wmy/VapskAYZiY
         5qNU9/wenn+V0whXKXYcWdFSLty0qQ8iNp28nDIXEi+HBuLA4djSc/X4KQFLMTQcan7l
         1Q2A==
X-Gm-Message-State: AOAM532Hjh7k01dOSSYXo1H8tjzdAUMWJgJ5Qo4venRPZkMugcjb6OB6
        xw/oJRdy6IH70zCRI6eEWjRD1T8zYb5esQ==
X-Google-Smtp-Source: ABdhPJysTnh/XCpUc5ceFM2NQuwvu+94lLUqryPPA7I8CZ303wQJJHizo+E/ShhRsW6vEriBoOV4rQ==
X-Received: by 2002:a65:6213:: with SMTP id d19mr11476237pgv.110.1630145567331;
        Sat, 28 Aug 2021 03:12:47 -0700 (PDT)
Received: from localhost.localdomain (125-237-24-95-adsl.sparkbb.co.nz. [125.237.24.95])
        by smtp.gmail.com with ESMTPSA id k22sm8561874pff.154.2021.08.28.03.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 03:12:46 -0700 (PDT)
Date:   Sat, 28 Aug 2021 22:12:42 +1200
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hello@bryanbrattlof.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: fix docs typos and references to previous
 struct names
Message-ID: <20210828101242.GA6841@localhost.localdomain>
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

