Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F016439D9BD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFGKge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhFGKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:36:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249A7C061789
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 03:34:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i13so19724659edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 03:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vgsncdvLmdHsU/1c1h0SAn08txT9+pvHmgBRKaZGxnU=;
        b=Y5+sYcP12AU9+nSL0rR24Tm+WCMD6ByYuo/k6ES3uomE0fKDJ/gtc+GnLCYf94OkVJ
         Pa/ZWB+1ueMshsQimx8jXXo0KRg+sJUVw06w70HBb8XxnsUIo/d3SR9Paj/RQl4iWHrh
         9v+my4x8gN/HM4sM4tYv43PL5E1eE+V0emvn7dwRmvES4wNzRE/nO7+YAkhfbHPsk456
         8OgFqIMuTToDbniBWzoBh0CfMmPnJ28IBjr+J55l7Pz+Qd8lNeyJQ/R9vHc1zY9fX+Z+
         o5HtIT965jQ5byQEsVpuShiPD3KUiomQeUeQ3OGw+Mk8VgvA3qlWZCb9cIlJetM7yoJP
         +0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgsncdvLmdHsU/1c1h0SAn08txT9+pvHmgBRKaZGxnU=;
        b=ZwjUKbvAdBXjUrOzStw6m5TThmu1ip4/h7DBLKmdbkDtUsSbnyG095J+qDRWYvj4uC
         0+YBDtMzCIiX/zg8OfJ9oehZcq7PA4t5JDHuM42xFXr3EGH8w20iicglySBrJbuIefV7
         RGrAQZ7mZJdUY90LTeqs5aeD1XXGqlHYjfRoH4FsRwUffEDCVJLwpURBrm/5mPmu0mhC
         tBA5DBejb2BJrnDgLoRGEiuON3XMsFEPy1st5CeLoFhuONPL4KaXYNhLp+Yu5NQy7tdi
         3pSAS03OCALy9BtfP8UFdtR9vKukPbvMFjDwLkdQxSLeww4QKA9JiJftD6CZTrt60mfY
         VOhA==
X-Gm-Message-State: AOAM533ZDW7E5x0ihoHBFrA0RTeDNqGsBDwK7+vjCr71jCKZxoHTDN96
        YGbnegj9zwMc48sujZXjnBSufg==
X-Google-Smtp-Source: ABdhPJz+jLvE5NKH5gEqXje/mFle1nM9LSCeJiOfsSqvHNWYSi82AU4IlfFsbyKOw0XIedpyBsljuQ==
X-Received: by 2002:a50:ee18:: with SMTP id g24mr19439130eds.11.1623062078574;
        Mon, 07 Jun 2021 03:34:38 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-76.xnet.hr. [88.207.96.76])
        by smtp.googlemail.com with ESMTPSA id b25sm7521037edv.9.2021.06.07.03.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 03:34:38 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        corbet@lwn.net, trivial@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 2/3] dt-bindings: trivial-devices: Add Delta DPS920AB
Date:   Mon,  7 Jun 2021 12:34:30 +0200
Message-Id: <20210607103431.2039073-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607103431.2039073-1-robert.marko@sartura.hr>
References: <20210607103431.2039073-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trivial device entry for Delta DPS920AB PSU.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Drop custom bindings file and use trivial-devices

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index a327130d1faa..1cb6c1fc0903 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -68,6 +68,8 @@ properties:
           - dallas,ds4510
             # Digital Thermometer and Thermostat
           - dallas,ds75
+          # Delta Electronics DPS920AB 920W 54V Power Supply
+          - delta,dps920ab
             # 1/4 Brick DC/DC Regulated Power Module
           - delta,q54sj108a2
             # Devantech SRF02 ultrasonic ranger in I2C mode
-- 
2.31.1

