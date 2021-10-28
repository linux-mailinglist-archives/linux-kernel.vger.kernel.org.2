Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F543DCB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhJ1IN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 04:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJ1IN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:13:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22CC061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 01:11:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v20so3874435plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:in-reply-to:references:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=lJnV+kITEwNEZxgW0EEwkSDW1MfbZOcjYoFW6kKKYcY=;
        b=WdUa3xEv8wcFkKvVzQpqipmMrzkrRLFM+c4Y6JHhZNtxTnTHWSj54s0FpR3pA4Nngq
         ZxcSFcPDbzX3JI4DiyfqoF3kQpvpJFKgBlRlNpqlcIOIxUXivu3YQCZ/rZVkEhWgNwU2
         T0yMZJNtIhHazOQtuYBl3kgDoJIBDSAUr92TWVf37v//8Bvmz7BamVjWJZ7Y8RjQaBuT
         O+99mkja+NLj6WiuUtngttw5GNaagXJwq68sZ/NGLOTEgzzBkOoU9rVa33k9ggx/Ncj4
         su9EgKqjIWcgb+jX7im7L5jkfhzBypmDRJcpPa3r/1m7nnG1+cMO7Npl/VS7nVdN0Ne9
         vU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from:to
         :cc:subject:content-transfer-encoding:mime-version;
        bh=lJnV+kITEwNEZxgW0EEwkSDW1MfbZOcjYoFW6kKKYcY=;
        b=m+RfP3gtCTJQczSrxwuIhVQK7uaR22bcsWJ0oO+lA9GwuCC0nHUV8P6PLDJ4CsGaVS
         4PmH+UgnOsTlhI6qXXrpDl/HZEM4n3SCRv1+LVx/Wqj2Q55/GMPH1GdHQtB1jP2h0W3i
         FZtcgTZCM0BhXD5l2i0GN44C9vy1fU5t3mLAb6JFLyulTxFMHeSqehsLeLn+UgVYa0Ax
         dUoRxkC1NlsSXbBexrthpCAd7KmhrG2AgN3ymZL2XKki7rPOdHRnGnhnUZyhUDnfmteh
         ZPkPEpYps8NpcvguhPcEcPsaJB4mGM5Tpc7A0NWuWP6VqnAzDm1pKvkJxKFCyEFcLyBs
         CwYg==
X-Gm-Message-State: AOAM531b+HrEmxe8SXjhhOZmRXMNpJVp/uG+OD+zA+DaZ5CeBaa+tVtR
        cn5BKs+lhxoC5AZvvp4MU4nNqg==
X-Google-Smtp-Source: ABdhPJyxn/egEB9dkHCO6DjrmyYEckW/uwEHvbaZK6WC+OfXoKl6HgNeP4spca904tP78GKSOyG6Qg==
X-Received: by 2002:a17:90a:f195:: with SMTP id bv21mr2879398pjb.203.1635408660677;
        Thu, 28 Oct 2021 01:11:00 -0700 (PDT)
Received: from [127.0.1.1] (117-20-69-24.751445.bne.nbn.aussiebb.net. [117.20.69.24])
        by smtp.gmail.com with UTF8SMTPSA id y4sm2442059pfi.178.2021.10.28.01.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 01:11:00 -0700 (PDT)
Date:   Thu, 28 Oct 2021 08:10:30 +0000
Message-Id: <20211028081030.719265-2-nathan@nathanrossi.com>
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
Subject: [PATCH v3 2/3] dt-bindings: hwmon: ti,ina2xx: Add ti,shunt-gain property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

Add a property to the binding to define the selected shunt voltage gain.
This specifies the range and accuracy that applies to the shunt circuit.
This property only applies to devices that have a selectable shunt
voltage range via PGA or ADCRANGE register configuration.

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
---
Changes in v2:
- Added binding for shunt-gain

Changes in v3:
- Fix schema error, setting $ref to uint32
- Improve the description to detail exactly how to define the property
  and how the property affects initial device configuration and
  calculation of values
---
 .../devicetree/bindings/hwmon/ti,ina2xx.yaml        | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 180573f26c..47af97bb4c 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -36,6 +36,27 @@ properties:
       Shunt resistor value in micro-Ohm.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  ti,shunt-gain:
+    description: |
+      Programmable gain divisor for the shunt voltage accuracy and range. This
+      property only applies to devices that have configurable PGA/ADCRANGE. The
+      gain value is used configure the gain and to convert the shunt voltage,
+      current and power register values when reading measurements from the
+      device.
+
+      For devices that have a configurable PGA (e.g. INA209, INA219, INA220),
+      the gain value maps directly with the PG bits of the config register.
+
+      For devices that have ADCRANGE configuration (e.g. INA238) a shunt-gain
+      value of 1 maps to ADCRANGE=1 where no gain divisor is applied to the
+      shunt voltage, and a value of 4 maps to ADCRANGE=0 such that a wider
+      voltage range is used.
+
+      The default value is device dependent, and is defined by the reset value
+      of PGA/ADCRANGE in the respective configuration registers.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8]
+
 required:
   - compatible
   - reg
---
2.33.0
