Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3515394119
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbhE1Kke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbhE1KkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:40:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABF5C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:38:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e24so4216498eds.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vgsncdvLmdHsU/1c1h0SAn08txT9+pvHmgBRKaZGxnU=;
        b=IFDNl+bkCPTU9VFjmEQVzJtoOUXxTdGrcvoh4ZkghtyCSSd6QpBWyPP+ipP2ZnE9xY
         ktUISvMojelg3q/Ic/kF8UBhMv1JbcVapoB5ui1m6lwhDARibd5EgbgGpUHoxCW3SN4o
         cfuVmxWTHeW3DV6V+6RZDwj/qG5BuylbVdlqWqR2+iBSMvWB7wxCYJtl6zOq7BcC49gk
         iva+0jYz+pjzZbNlDYY9hLS8AE3gM67czG2w3au4v4y6rllo12JfT3svY9QjRhkpoWI7
         5ak8cISYoF88blAuDmSYQRp8WgbzfvzI4Wd4ZNCAuVTD6/mc8AoPSQ3yCR8/l8fGGctG
         wnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgsncdvLmdHsU/1c1h0SAn08txT9+pvHmgBRKaZGxnU=;
        b=cmSHqS+uuSvBrvY7LPIeiaR6+8U8Wr/Au2LTWdovrYy3kvD73uEzQAxhM77I0I+F5Z
         bbGQIGlwuVajniRCx16bgJFhiAqn6yaEEUprvpXQ9Wv1Oqh+D+PCNF3mj1OKjZq/gQ93
         RbRZ8Pn2l+L6GMPU50QhXlDV9hmfX867mJm7BGwI0IgJhM+cv3VHWzAf55wYdbRp7ITH
         l6loSe2t/GVh8cCK3lFkDM4DbD0dteDPV8KQjwbvrK8Im+LOblqEpimXft7bVX/X3I47
         goJdrGrBEdA5LSBNUcd2HZrLOz4LtRz2WmiTFPwNqNNtVawJF+Ka9UTq4H8u6dQo8+NI
         EyBw==
X-Gm-Message-State: AOAM532EjHpl+C+yVe2oEBuYwgZHYipuhjoSwY8gKWUl7xBYIoaYlNLd
        KHMt4laNa9zLvrsLrDQN8vMbUg==
X-Google-Smtp-Source: ABdhPJw7JisvOE2+Yv6lHgO9ljENALdQC7jmU3t9ZedhvXjb4BMsYeLR6+8pU6TKiHCrm/7oFO2P1w==
X-Received: by 2002:aa7:d2d4:: with SMTP id k20mr8943279edr.384.1622198317365;
        Fri, 28 May 2021 03:38:37 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-158.xnet.hr. [88.207.97.158])
        by smtp.googlemail.com with ESMTPSA id jw9sm2192446ejb.77.2021.05.28.03.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 03:38:36 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Jonathan.Cameron@huawei.com,
        alexandre.belloni@bootlin.com, sst@poczta.fm, krzk@kernel.org,
        alexandru.ardelean@analog.com, devicetree@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/3] dt-bindings: trivial-devices: Add Delta DPS920AB
Date:   Fri, 28 May 2021 12:38:27 +0200
Message-Id: <20210528103828.53320-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528103828.53320-1-robert.marko@sartura.hr>
References: <20210528103828.53320-1-robert.marko@sartura.hr>
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

