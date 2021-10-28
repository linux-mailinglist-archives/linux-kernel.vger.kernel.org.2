Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6871543DCB4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhJ1INX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 04:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhJ1INW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:13:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930FDC061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 01:10:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gn3so4119422pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:in-reply-to:references:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=ddY1h2eGYLfbs2x7Sg+P0Vwdzd/3/Mm7kKddSfpI7pQ=;
        b=DUvPh8Xd5T8wFYH1zVUVCJ77tvdGuvb+iXmn6kOQ7aW5vDVxBrtpAOMyJ/jRYNaqvW
         T78OBJ8SFHX0ZmvyDRQ6ORaj8Wzp9uK6yCzqVvqG3T9x7/D3+YTSQSBW5PpIniZl5qR0
         rBNq4uZtj4ssG0tHKCoKJVigPs6YBrJzeIFHvRhAehcRSHgyU9DsifHxa43jpWaNR8sn
         1hBV6iKqYQ/9fUU+n0/drBrXtRfImBf3oha79ZODfpnLmA5EX5671HMfXYyriyYrZJl4
         VdINEsEhjSTIfermakV86i0okoJ+uDWLiaQZ6WZH+ah82lB/kQ1gCGrtr9uIBtvKIcHq
         8K+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from:to
         :cc:subject:content-transfer-encoding:mime-version;
        bh=ddY1h2eGYLfbs2x7Sg+P0Vwdzd/3/Mm7kKddSfpI7pQ=;
        b=zS4QHVdACn9519VHJSbsIMJflfYmL0o7Bkq+rYBLeDZdm8vzXN81GppwCmY8oY9Bo+
         JTSZtjeyvfqA4b0logNitF6xShdXnfGvRTspDPKpQPSxSTMQQpscSGU6AUFAYNAnuGgo
         G/1wNSW5sxcASE3uaCXI4cMsm3YDiS3P16uqP5dIQ/U/pBImy7o/cEWO4wL1eW2j3cq7
         a24P2X5GiiO7iX442CcmfA1UosVbcAhOOJQaa6mI9qy26j/T4cJwdDQtBlMCIWGZTHyC
         W5sU3TLFVH29bsli2likbZJ1TBZ/WgN/zpLiOfFcFEPe90mePo8Avtz1ndrygA4TLn1w
         cElw==
X-Gm-Message-State: AOAM531TbA9UFioU1xgJ1pDb5DCdBz2wjIqpOe5VVpbfLg1KTp4GfUAF
        jKkkHFiu0KIFWR6PXN+kwOhHVg==
X-Google-Smtp-Source: ABdhPJwFBomYHQUa0fI5yRicRyniUTMMcWjV1ODy65ymj/xfbvQ4Rpt59WsZJXHuOpnmukd6J3SuEw==
X-Received: by 2002:a17:902:e5cb:b0:13f:25b7:4d50 with SMTP id u11-20020a170902e5cb00b0013f25b74d50mr2378524plf.38.1635408655162;
        Thu, 28 Oct 2021 01:10:55 -0700 (PDT)
Received: from [127.0.1.1] (117-20-69-24.751445.bne.nbn.aussiebb.net. [117.20.69.24])
        by smtp.gmail.com with UTF8SMTPSA id s2sm7327493pjs.56.2021.10.28.01.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 01:10:54 -0700 (PDT)
Date:   Thu, 28 Oct 2021 08:10:30 +0000
Message-Id: <20211028081030.719265-1-nathan@nathanrossi.com>
In-Reply-To: <20211028081030.719265-0-nathan@nathanrossi.com>
References: <20211028081030.719265-0-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: hwmon: ti,ina2xx: Document ti,ina238
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

Document the compatible string for the Texas Instruments INA238, this
device is a variant of the existing INA2xx devices and has the same
device tree bindings (shunt resistor).

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 6f0443322a..180573f26c 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -26,6 +26,7 @@ properties:
       - ti,ina226
       - ti,ina230
       - ti,ina231
+      - ti,ina238
 
   reg:
     maxItems: 1
---
2.33.0
