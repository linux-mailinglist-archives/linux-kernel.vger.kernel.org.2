Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA8E33DE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhCPTuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:50:25 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:44590 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhCPTty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:49:54 -0400
Received: by mail-io1-f50.google.com with SMTP id 81so38511836iou.11;
        Tue, 16 Mar 2021 12:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yh/qd7H4DMimh5ox1ZN0BCRVL0CQ79BD6/260FHVjDg=;
        b=XdDuWkVfrYMXnGqKOPQ5ZOzrDUA01A+Mg8RhaYYTjpFw7GLFA+X4TIBi163/fnBm5P
         Q1hb3paSt6/RA9gCU3FB3C3ceXQT51UEiIHKvPrEVm+tb9f7zYwO+7m4E+UJhntpDtg3
         nDVNZvdUsZV1E0Fk6yXj7gSnSwy/XUa7XOi+gf6pn8k+LmAd6ZZ9t7mYgh4X4puNCPTd
         n8NF+bu95NUaD2rClct4wtfMG4dhnjg0hbOnwHd8ryLBiqnN5b0P/hLazlagu+SOmttv
         dhaI3DdG+lS6u9cHVjwKPhNxYRloNEKPBsMAX1WSzmrOqIvQoDa5T7t882ukoknfbvah
         Jh4w==
X-Gm-Message-State: AOAM530PBBNAnXlaqH26Z6oHM+I+XRzMaMn0NsGwTikKBhhSmaHDHaI4
        wAcnxHiCk/UcsY7m9gSI0hnuIiLJlg==
X-Google-Smtp-Source: ABdhPJwqC1+ICzy4cXJafQxuMJz7PbdUkFlWdXWj4klObndv8Q9oYvRBEqJpXYwMkNRTEHCGSJRRow==
X-Received: by 2002:a02:7f0e:: with SMTP id r14mr297217jac.112.1615924182270;
        Tue, 16 Mar 2021 12:49:42 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id r203sm7777706iod.13.2021.03.16.12.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:49:41 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: trivial-devices: Allow 'spi-max-frequency' property
Date:   Tue, 16 Mar 2021 13:49:39 -0600
Message-Id: <20210316194939.3529018-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial SPI devices can also specify 'spi-max-frequency' properties, so
allow it in the trivial devices schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index a327130d1faa..c751326a593d 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -23,6 +23,9 @@ properties:
     maxItems: 1
   interrupts:
     maxItems: 1
+
+  spi-max-frequency: true
+
   compatible:
     items:
       - enum:
-- 
2.27.0

