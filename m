Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D083245CE78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbhKXU5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244546AbhKXU5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:57:10 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE44FC061748;
        Wed, 24 Nov 2021 12:53:59 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id k23so8128617lje.1;
        Wed, 24 Nov 2021 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IyNvYikGx/k9tdDU8szk4MiN32bXrdjaPGV4oWEMDs=;
        b=n18cstBkdjX7c+UShE1M0pp9AYFZa32iOb6HZ8rdrt8352PocjOxC7sjVmfskpFFXJ
         cP7FvZ6BWua0oznO+XQuZiW0mLUpmRy/h+zuw8dCqT/V+JNfFBCfu/u5oiBnVWhVtKiD
         R0+SnwDYwNlsoJhw/nYxYgSSU94QG+gmJGIwNvZB7CPivO3tHkuFA7PMxidgOT42knwb
         8+rQr70H2QlDBFrCqfUR21+P6rOWVBDezxc6r+nKLjN9Sgrj8z8x9gKvTIgM25fwD6pT
         f/T2ppOTcyjYvVgFEMcfRXKpWsQYSP/Q7CFluriF7V92BmHfr0hnGQmJkYIyOT12Uqji
         MVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IyNvYikGx/k9tdDU8szk4MiN32bXrdjaPGV4oWEMDs=;
        b=AWSZuN3I6txED+5x9JVsDApKURKJAGzqPqQS3C35Qcc0PgDcDU0ZFLeXdUUrSQaPm2
         V4ynaqb04EXiDCT8BrLkyxviBcKspS6d4XInQw3t9SMWGAyybGm5wqjaRgS/8Owr7uzd
         DLDNMFYu+NEx1z5vUvySFnqkTQuk1fXz/CC66e2IitmxGc96EoOnPrFq9pZJ/JcYn8G2
         MY2+i7k6pjfTbVPfKyr80niSbPdTJ5y2SvnilM3pwB0ZUnfY3C477dqf0D+5Sw75S4Jd
         0lUULkvvi6nJOknR/O5RCR2SuLY2bR+4Y6kGpOruANDv8cn5Ru2UGR5uvQ/a3Fu2H5Xb
         rnNQ==
X-Gm-Message-State: AOAM5331TA6NpYFWbnpqBhrStfJIWj+wI3HMpAMYSv9o8hlEVFpubRGM
        e+ilWTE7Q8iZ7Qz05UuXcjc=
X-Google-Smtp-Source: ABdhPJzbg9X4RTlpGwA/0nX9yg4bi5EiUdsWZuy6cXGIhElPKfsHllDQlnKAQo4feHXv3B9QBwXKpA==
X-Received: by 2002:a2e:3c0c:: with SMTP id j12mr19053688lja.402.1637787238288;
        Wed, 24 Nov 2021 12:53:58 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id j11sm97608ljc.9.2021.11.24.12.53.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 12:53:58 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V3 6/6] dt-bindings: xen: Clarify "reg" purpose
Date:   Wed, 24 Nov 2021 22:53:43 +0200
Message-Id: <1637787223-21129-7-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Xen on Arm has gained new support recently to calculate and report
extended regions (unused address space) safe to use for external
mappings. These regions are reported via "reg" property under
"hypervisor" node in the guest device-tree. As region 0 is reserved
for grant table space (always present), the indexes for extended
regions are 1...N.

No device-tree bindings update is needed (except clarifying the text)
as guest infers the presence of extended regions from the number
of regions in "reg" property.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
According to the recent update to Xen's guest.txt:
https://xenbits.xen.org/gitweb/?p=xen.git;a=blob_plain;f=docs/misc/arm/device-tree/guest.txt;hb=refs/heads/master

Changes V2 -> V3:
   - new patch
---
 Documentation/devicetree/bindings/arm/xen.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
index db5c56d..156fe10b 100644
--- a/Documentation/devicetree/bindings/arm/xen.txt
+++ b/Documentation/devicetree/bindings/arm/xen.txt
@@ -7,10 +7,14 @@ the following properties:
 	compatible = "xen,xen-<version>", "xen,xen";
   where <version> is the version of the Xen ABI of the platform.
 
-- reg: specifies the base physical address and size of a region in
-  memory where the grant table should be mapped to, using an
-  HYPERVISOR_memory_op hypercall. The memory region is large enough to map
-  the whole grant table (it is larger or equal to gnttab_max_grant_frames()).
+- reg: specifies the base physical address and size of the regions in memory
+  where the special resources should be mapped to, using an HYPERVISOR_memory_op
+  hypercall.
+  Region 0 is reserved for mapping grant table, it must be always present.
+  The memory region is large enough to map the whole grant table (it is larger
+  or equal to gnttab_max_grant_frames()).
+  Regions 1...N are extended regions (unused address space) for mapping foreign
+  GFNs and grants, they might be absent if there is nothing to expose.
   This property is unnecessary when booting Dom0 using ACPI.
 
 - interrupts: the interrupt used by Xen to inject event notifications.
-- 
2.7.4

