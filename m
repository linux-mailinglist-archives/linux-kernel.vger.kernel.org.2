Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4A322FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhBWRqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhBWRpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:45:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0480C061786;
        Tue, 23 Feb 2021 09:45:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v21so3237147wml.4;
        Tue, 23 Feb 2021 09:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPaM4EX6V47/9lZ1DVmPyYKV5xLEHFqT5NGooxhgdBI=;
        b=Ck5uCe8ERGA3i2QCmNtEOJkOmUI4YtcOO1UjGTDk3XG4XYOB2scOlknlkx5m1S3pVI
         fxT/yEXoKO/MShBCl1bOw7LWXLxCZRr2QpwMg6ppsy74pOiWyFZDsscokCdQYM3aKjhQ
         bqE8gZ3aODPefOObLf02p+d2+FY2myDETHM3siEvlBP3ZU1kyaWCsjJWuizNHfdY0j71
         k2GapB5rtkXrdv5OJkXNe7yjGgVQHrzu1TXGRqtc2kgmm/nNEE53s3xaEEraYNmW+Q/v
         c6AmGZyAqVkqTZHrpVXa43Z/gBzkfQLbobiLB6H/vkXY0Y6L2KZ9XaYaViAfS8xYTluV
         WWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPaM4EX6V47/9lZ1DVmPyYKV5xLEHFqT5NGooxhgdBI=;
        b=lS0tPsidSouuyGVJjv8SjOMlJNTcUaY2FLr94NyN+j/R7BA9SYKLnNdpb/lGAc+o2z
         ANo/wysG4CDKudhv5c6N9lm751dsltylm1nUnNcPz2RzsmF4SRIuDtSEDovfuL1m6nph
         7+F3NQe/91BjvcTVHOCNFlCLUBi0OdAMRDOTVvaKLbZVsLvQcHSMii7t7HvYYn45yneO
         TyYW8fyMAhpDfLJD3z6S+nfGANF8YiSiBQQwYwttmnZ67O7cY0mURtECftkvW1u8bgqA
         oKffOSr2+fsZEn6A8Zb80uC7h+Ei9TpuMHe9SGxwRKCBqYjvGH4GKpqiSW2XlEkD2F1a
         P63A==
X-Gm-Message-State: AOAM530uhmsgMg9IJlEg1x7kcRKlzl6vzmZVQrXIOEXJXVRNbah0bE8k
        6hr/bd3O+/BfUym63F9mBOQ=
X-Google-Smtp-Source: ABdhPJxQooaU+YomFGG2yb8vJWqmTMPGkVlCCIvt0VFUfBkO+2/hsbNm0MKWYrRs4EiUN/O7iEwToA==
X-Received: by 2002:a05:600c:35c4:: with SMTP id r4mr25425356wmq.138.1614102300688;
        Tue, 23 Feb 2021 09:45:00 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id u7sm32408428wrt.67.2021.02.23.09.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:45:00 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: usb: generic-ehci: document spurious-oc flag
Date:   Tue, 23 Feb 2021 18:44:54 +0100
Message-Id: <20210223174455.1378-3-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223174455.1378-1-noltari@gmail.com>
References: <20210223155005.21712-1-noltari@gmail.com>
 <20210223174455.1378-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over-current reporting isn't supported on some platforms such as bcm63xx.
These devices will incorrectly report over-current if this flag isn't properly
activated.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v3: no changes.
 v2: change flag name and improve documentation as suggested by Alan Stern.

 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index cf83f2d9afac..8089dc956ba3 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -122,6 +122,12 @@ properties:
     description:
       Set this flag to force EHCI reset after resume.
 
+  spurious-oc:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set this flag to indicate that the hardware sometimes turns on
+      the OC bit when an over-current isn't actually present.
+
   companion:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-- 
2.20.1

