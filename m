Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5ABD322E98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhBWQRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhBWQRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:17:32 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B1BC06174A;
        Tue, 23 Feb 2021 08:16:48 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a132so2980920wmc.0;
        Tue, 23 Feb 2021 08:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l17os7/7Cmdeypzws3CjPRBYiptpWoT6sGD6tB5zVB0=;
        b=Mk5JtHBPWldH1fduzHBFFZI7ligfBpyYzjL4Czj3XdNXBSf6bZEoPvO4Eyw68c+xpE
         wfchl0EmyqK2/qj8qoA/08YxC/jqw6q6sjRAjetXoH19Vlyr5/u7Glh0HZFWiTCZiUIM
         kRIF4U+PPgC69MysHck0XuJwir+dhfm0DPoqYydhITnwC9icBN6b9UjLNPSBBIHrcWSV
         Adx6E72akLgK/baeFgUDjfub5VtnwM9AX9SJGeS8nh0KacPx+Xvtzkw5wroLU7bLZwJq
         5ikWOsrxQ1oR4PTJZWsNr2ChWatRJ6Cq80F6hS6a2F+ktAMxo7BFBhe2JGg/N7LOZ+Ce
         32iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l17os7/7Cmdeypzws3CjPRBYiptpWoT6sGD6tB5zVB0=;
        b=ZMiDc0McqC6BknjDPwTRle3mlqgvsvwdE5L5hl3dOORNBvRy0L7Tb8hzwP8RrupnzT
         YO5CWP7ltMKX+BZpaHwd5M6kEcQTtLJpnm/1QuyI4lYmg4TCDX8qibiGmfSWN+FKBwld
         ufB4KZP9H2g1wU7Pis/0Sfh1oQqW7bb969Gi/If46ILR5CfTMiQf5Ev++QkykXJZu6HA
         Kc7SzcxFakFI1MUxuASE96fOlgSJXwljzW1XliQDUtW3h48J1xkke5GEPYJAgJPBpCgI
         uXfDIUrery4TPB0ELI3x2UdFozvbgEHtpzJUtGkjUY+X44s2sPT3yNteArJJxR+RnIzy
         XzYg==
X-Gm-Message-State: AOAM531anZebnUhDUbD99SgZxJOvSIHT3Syyx39LIQSzL59/CdQkOeyx
        N22WhYVXQjB0EUTm6A6MFozKfLIu6N0oWr/2
X-Google-Smtp-Source: ABdhPJzuL42u9wmgMzblrX0mcR0ulC/G2seksOMYMA+Kqq4WWU3HFzWic2TkxRQH8Ur9O8HIMlP1wQ==
X-Received: by 2002:a1c:c903:: with SMTP id f3mr25621536wmb.69.1614097007648;
        Tue, 23 Feb 2021 08:16:47 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id h13sm32699925wrv.20.2021.02.23.08.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 08:16:47 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: usb: generic-ehci: document ignore-oc flag
Date:   Tue, 23 Feb 2021 17:16:43 +0100
Message-Id: <20210223161644.6095-2-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223161644.6095-1-noltari@gmail.com>
References: <20210223155005.21712-1-noltari@gmail.com>
 <20210223161644.6095-1-noltari@gmail.com>
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

