Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3785734B918
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 20:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhC0TP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhC0TP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 15:15:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28349C0613B3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 12:15:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l83so14292905ybf.22
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 12:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=D4BSvyULDIvQhM59Eq/aBYRm8DPbWmDg1808r3m/Wf4=;
        b=BnG8cw3ifTkS8jEwoTI35vUaDckSYmj2tZJ6miykb3li++zpgwt4/XBzq0NZtq2FHV
         NVfKlZ2hiwWeHlY0QkaYLPAlTNNLPxxrXuOiuoApYHtIdgVzZ/l0ViFd+1x4DLHqLEcz
         x81MXek+RJ5Ny2+EhB2zjoupHV1hmUgyDw6DJpo4pndlvLG9O9DkTLWy6xfEjFbaLu3u
         c8qqejYDPdAtxYzY3E/S/M9JYPmJ53CahKV44MjnkS4/M9V6X/9aKweQkefBtEFZdrJ2
         agLTjDWulCRWrKzsqu31ZdpnvPzieZBfj6Yv0cUr2VCTU2yJ6GH79BBLlICCdcy5MvZa
         18xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=D4BSvyULDIvQhM59Eq/aBYRm8DPbWmDg1808r3m/Wf4=;
        b=Zgwzff5nSg2g8rxAyzmr/EcZUUPfWVZhhCnOY6UtKT5rGeuKiexgc7EyLdI6iRAT34
         3+cstEe//GtdYcWTXgTVQLGP3ESLemcMmWqPKP0mvxMkDPN0+UBMPRRtUYPu3ue9pDDc
         bJvFfBHwZmn8DkAfYxRxlplpMfAcdu8Fg9vAxyfytFhnUSdH6u6nErQvIQaoa4bEvRX9
         BDOs4m1VNaX2FOyC9b82CSTGrWW5O/gXcyboXeCfF1+pVJ1X0dMA12RE8OciE/JU+5wz
         GDC5DLz6fonwowqow38+OVkqdzA2w2Vz8WdfbgWUYlGmOg+NCFPLco2gv81FSuv5xM+d
         8TfQ==
X-Gm-Message-State: AOAM532FiDXLWUcOhso/AC+anVvMOhS6E+j9mPb/a5WHCPYNHVuhv4+V
        4FdqBU6AxYxxtGn1EverkhZOwDO/uGY=
X-Google-Smtp-Source: ABdhPJxk73Jxat1DtHJiVFtbG+2RDBMwpE7ccTi3X8BLFbdEGElL1whuRHyYuAcFqTEKdJhDNXxHRajvcoY=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:493c:e5b:69c:54cb])
 (user=raychi job=sendgmr) by 2002:a25:af49:: with SMTP id c9mr28974925ybj.335.1616872525346;
 Sat, 27 Mar 2021 12:15:25 -0700 (PDT)
Date:   Sun, 28 Mar 2021 03:15:20 +0800
Message-Id: <20210327191520.1824466-1-raychi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] dt-bindings: usb: dwc3: Add usb-psy-name string
From:   Ray Chi <raychi@google.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org, balbi@kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kyletso@google.com,
        badhri@google.com, Ray Chi <raychi@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds documentation for usb-psy-name string.
The string will use to find the power supply interface.
And then, DWC3 can use the interface to control charing
current with USB state and USB speed.

Signed-off-by: Ray Chi <raychi@google.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 2247da77eac1..ad62f4552fad 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -301,6 +301,13 @@ properties:
     items:
       enum: [1, 4, 8, 16, 32, 64, 128, 256]
 
+  usb-psy-name:
+    description:
+      Contains the name for power supply interface. To follow
+      BC1.2 specification, DWC3 could use power supply interface
+      to control current with corresponding USB state and USB speed.
+    minItems: 1
+
 unevaluatedProperties: false
 
 required:
-- 
2.31.0.291.g576ba9dcdaf-goog

