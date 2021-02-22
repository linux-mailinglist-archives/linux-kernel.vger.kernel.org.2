Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36704320ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 02:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhBVA7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 19:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhBVA7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 19:59:32 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9066C061574;
        Sun, 21 Feb 2021 16:58:51 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id f3so12352653oiw.13;
        Sun, 21 Feb 2021 16:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plm+Gqqif0nFmrHo7nyrM26fSa+6xQh6uBWBUDQ738w=;
        b=vS8uaQWR+01p0sDbKpunLTnIicqRfc2ldhcDcz7Gj//0kps2TdFb5bCJ2FaGhFUlun
         VPzHAacM8FBeLQ7tXVO9MAbHtZchak397POEBH2E2a/+hsy8u3D3vy46oLjTWY0DWRmQ
         ZH21NFk2f/JdRUCzn9Lpu5YE9JIkQLmrBv2pQ7P1wOS2IuIlyG9cpCvKpi1q6n/PRvN/
         XvatSqkKSunuGZ9Ig+6aLJjMJcSaNbFYhe5Bu/a3P+YU5QbQWwKYyy9kO3FmSXGwkN66
         B5Hwx8yREAfn2pb8rvSPfmhpZ0xvRkahE5ff0nPMgh8YFaiNBDDlPpBnKmkZe/LlSD+6
         2aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plm+Gqqif0nFmrHo7nyrM26fSa+6xQh6uBWBUDQ738w=;
        b=qEpSAzEAQY5wwHYGk2ZUckqGUten9nyNSk8bFQPwZFWPWSU6aSDClC4LEWfUSqIdCh
         466mrETsmwMDxOk7tXQdiR1Ri+N4WQFhYHjrU83UlfAMKiJQtXfS+cO+r2orTLQIpXjN
         dlMb1azYGeNbvqdOX3od2HVjSslskaWimUAdsX6+iq1umFhWE7UNzdoIQDjSBJE9lr0V
         FPQZes8dLqOTMcWdKUaoN+8CnBD6M4A5eBPpujV07GXXxR33alrNX3dGuhH7ceBQmOJU
         kGy7bx8x7D+uo1X0YJhqJ05lIBrFlbWWLQSNRWxSW9bmLHMOwppPVhU6FWfTaMWyKQNn
         O3aw==
X-Gm-Message-State: AOAM533kvFLwocx9q8lbMzIFyMzI9CqAKsO4kYJpK0jwVNaagZEr0hVg
        USuNIVLoCpsIjSwDh9u9bo792m6AEagUy22k
X-Google-Smtp-Source: ABdhPJwhQwMyR/GSjk5Jd6qKD0etUhUwiEkRjenpPURrS0rU5yYRi4Ja7VuaAP/Anri2IGPNaQVmbg==
X-Received: by 2002:aca:1907:: with SMTP id l7mr10194690oii.28.1613955531031;
        Sun, 21 Feb 2021 16:58:51 -0800 (PST)
Received: from localhost.localdomain ([194.110.112.30])
        by smtp.gmail.com with ESMTPSA id f15sm3359956oti.74.2021.02.21.16.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 16:58:50 -0800 (PST)
From:   Forest Crossman <cyrozap@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Forest Crossman <cyrozap@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Fix ASMedia ASM1042A and ASM3242 DMA addressing
Date:   Sun, 21 Feb 2021 18:58:29 -0600
Message-Id: <20210222005829.396968-1-cyrozap@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've confirmed that both the ASMedia ASM1042A and ASM3242 have the same
problem as the ASM1142 and ASM2142/ASM3142, where they lose some of the
upper bits of 64-bit DMA addresses. As with the other chips, this can
cause problems on systems where the upper bits matter, and adding the
XHCI_NO_64BIT_SUPPORT quirk completely fixes the issue.

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 drivers/usb/host/xhci-pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 84da8406d5b4..c1694fc5f890 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -66,6 +66,7 @@
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
 #define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
+#define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
 
 static const char hcd_name[] = "xhci_hcd";
 
@@ -276,11 +277,14 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)
+		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI) {
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
+		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
+	}
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 	    (pdev->device == PCI_DEVICE_ID_ASMEDIA_1142_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_ASMEDIA_2142_XHCI))
+	     pdev->device == PCI_DEVICE_ID_ASMEDIA_2142_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_ASMEDIA_3242_XHCI))
 		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-- 
2.20.1

