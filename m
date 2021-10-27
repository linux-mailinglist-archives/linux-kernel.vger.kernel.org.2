Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F030543C434
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbhJ0HpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbhJ0HpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:45:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA263C0613B9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:42:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m14so1910963pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:in-reply-to:references:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=w0Qt4eFFwAV7HcPbIJckv7BKVj7qNf4ejTN1sCpeG30=;
        b=UbPwgJTc946dOVq5jTaNYlYCHv0eOuNRiP++AZ8m9Dw3EXuDRR4yuZGJxj4W8vtd1a
         T/CRlq3JFwu3rv3z1uB5jBge696GLrhwLdoMy/sorRvUz3la4xZGtF+g1gtm6Gb3Spc0
         oFSPqEwj6yUONrsFLUHPd/rdFqt++rkdL4WP41QLSK5GOfdf3cOiC4tw71XHWLOTzHId
         Yuun6XStccBer4daVa3Zqi78BEhf8KqiL4SrHIHbjAmw3c8sDshKcYhk4kGGol7NZYCJ
         tqjLfOR3lgCfcBZ+hnUoCXtSF3Wo3nRCB0DeIY/rksWIYzZ3VnTNCxIKamHBLFn0te8W
         8+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from:to
         :cc:subject:content-transfer-encoding:mime-version;
        bh=w0Qt4eFFwAV7HcPbIJckv7BKVj7qNf4ejTN1sCpeG30=;
        b=vMpg4Q1qKTh1PQjG90FspWOV5gx5+BpYnUUTAgXXnjtjvzy/efd3gBhZtxyuEBYO9H
         j5K09uLKhzXdZ30hvKA8DPCoAD0GL5R5MJcqENnGDhBpfkSp2Xb04UCjP64sMQTDPS4X
         ZqA133foxDdndL4XZHE0wdm8EkCFtuhvyO+KbK8KwfeSzfT46AGtUwbOIIdguB3IZiFo
         gYCy2E4Vaxc8GQPekgyoEswOr4oEaSr1cqx8u/wn4gYxZdR0mFIHy+5DMEprvhuaZ7N4
         WQVnaNZ0+YDthpM/RM4M9EEZ0Nqii+mdBuQ+sJNaOZMi85LrLQJ03vzqiP9P7uCNLcMh
         cizA==
X-Gm-Message-State: AOAM5315CqmIZSNXaet27ENCfcZHoTWjNqyObCs04iZUTCH4hWwZLG/E
        CDGokpoqVJM2qo2dDnYYhQKOdQ==
X-Google-Smtp-Source: ABdhPJx/aRtvNvnPWp91+GXD506pEy8D8VUk2JvB6N0dvhp3lHYeUPvYnB3Zgd9UbBI6KWsYDe3gzQ==
X-Received: by 2002:a05:6a00:14c2:b0:47c:2c90:df4f with SMTP id w2-20020a056a0014c200b0047c2c90df4fmr2236201pfu.63.1635320557436;
        Wed, 27 Oct 2021 00:42:37 -0700 (PDT)
Received: from [127.0.1.1] (117-20-69-24.751445.bne.nbn.aussiebb.net. [117.20.69.24])
        by smtp.gmail.com with UTF8SMTPSA id p14sm3334498pjb.9.2021.10.27.00.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:42:37 -0700 (PDT)
Date:   Wed, 27 Oct 2021 07:42:12 +0000
Message-Id: <20211027074212.690611-2-nathan@nathanrossi.com>
In-Reply-To: <20211027074212.690611-0-nathan@nathanrossi.com>
References: <20211027074212.690611-0-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: hwmon: ti,ina2xx: Add ti,shunt-gain property
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
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 180573f26c..6a70e2fe9d 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -36,6 +36,12 @@ properties:
       Shunt resistor value in micro-Ohm.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  ti,shunt-gain:
+    description:
+      Programmable gain divisor for the shunt voltage accuracy and range. This
+      property only applies to devices that have configurable PGA/ADCRANGE.
+    enum: [1, 2, 4, 8]
+
 required:
   - compatible
   - reg
---
2.33.0
