Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C802E37B2F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 02:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhELATl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 20:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELATk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 20:19:40 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD5BC06174A;
        Tue, 11 May 2021 17:18:32 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id v13so18739726ilj.8;
        Tue, 11 May 2021 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ITi3r5Sk3xjHS5bejnw6zCgTDqxpb5q4mGkKmUxd1DM=;
        b=vWbP78NMwE3T8JmfFp4s36sK/+i7v7xLPMGWtj+2kA8AvoYHmt83INZDx0up4Xd4QC
         B3aSpbLVmMk34VolopZeFugY28THv0nD4MH4zjjkay7gn4t8WQozRW3ZDElU8059RaeZ
         oX28+d32WYp/Chaada+JSWidliqK190G+TceqHHRVg81DujDoVtt5oKaTcBcX59GUtxz
         L9KflBGAPxBqEhm2G4h+hQEVK53HBzB+baoOD5LhmtgcPvvtnCcEYq6bd4m6ThV0fb/K
         jofnYt2/6Uf/dZ7NEAREsLc75dUYxip4E1tSaWAuusXmya/hiVvLE3kom4tFcAvWk+Kd
         blUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ITi3r5Sk3xjHS5bejnw6zCgTDqxpb5q4mGkKmUxd1DM=;
        b=gHzIcNEqIohfixCmRl6ec/C1NMp+j3endGxzNR2soyWtLc4Es/JUdbHmSf9AIw13cP
         PWqXwtmD98WFlTC7mfaA5QATCutv8reT9b74wkNdD9c0y7GfCTf1auQfBxdFo4gjafpV
         OdiEve/oHMTZ8K97IR137js9ngUHiJhCCr9DHsFR2UKGpwYFBpc13TcsWilWeuIJfJD5
         0DeZZJ+7rmrdd2hYYpCaQbNH9+7bDMnrMHTZZhJFoZdHCNHWrP7YzXKce5MDU4A+rzQt
         6tg+/2ZEnyO2m8WRmsPAdqhOfCusyknudDEZGZB8xqhD6MJm00o5M1QZEbC6JkDREUQf
         x2Yg==
X-Gm-Message-State: AOAM53175KhorB0K0v7cmQ85Q/GuuynUqwh1icOKcaZcaS0YSb9+CRI+
        Os6WZQs+euFunTbnskalSGo=
X-Google-Smtp-Source: ABdhPJzAnRBOne/bDfCqTIq6WlGLh8r+N1lZieC4W5kBCqqf/2oSXz+QMjlGKV7hfOzzVbYvZm7tQg==
X-Received: by 2002:a92:c5c1:: with SMTP id s1mr29521516ilt.295.1620778711693;
        Tue, 11 May 2021 17:18:31 -0700 (PDT)
Received: from localhost.localdomain (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id v4sm8241490iol.3.2021.05.11.17.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 17:18:31 -0700 (PDT)
From:   Connor Davis <connojdavis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Connor Davis <connojdavis@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usb: xhci: Notify xen when DbC is unsafe to use
Date:   Tue, 11 May 2021 18:18:21 -0600
Message-Id: <2af7e7b8d569e94ab9c48039040ca69a8d52c89d.1620776161.git.connojdavis@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620776161.git.connojdavis@gmail.com>
References: <cover.1620776161.git.connojdavis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running as a dom0 guest on Xen, check if the USB3 debug
capability is enabled before xHCI reset, suspend, and resume. If it
is, call xen_dbgp_reset_prep() to notify Xen that it is unsafe to touch
MMIO registers until the next xen_dbgp_external_startup().

This notification allows Xen to avoid undefined behavior resulting
from MMIO access when the host controller's CNR bit is set or when
the device transitions to D3hot.

Signed-off-by: Connor Davis <connojdavis@gmail.com>
---
 drivers/usb/host/xhci-dbgcap.h |  6 ++++
 drivers/usb/host/xhci.c        | 57 ++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h        |  1 +
 3 files changed, 64 insertions(+)

diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index c70b78d504eb..24784b82a840 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -227,4 +227,10 @@ static inline int xhci_dbc_resume(struct xhci_hcd *xhci)
 	return 0;
 }
 #endif /* CONFIG_USB_XHCI_DBGCAP */
+
+#ifdef CONFIG_XEN_DOM0
+int xen_dbgp_reset_prep(struct usb_hcd *hcd);
+int xen_dbgp_external_startup(struct usb_hcd *hcd);
+#endif /* CONFIG_XEN_DOM0 */
+
 #endif /* __LINUX_XHCI_DBGCAP_H */
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index ca9385d22f68..afe44169183f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -37,6 +37,57 @@ static unsigned long long quirks;
 module_param(quirks, ullong, S_IRUGO);
 MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");

+#ifdef CONFIG_XEN_DOM0
+#include <xen/xen.h>
+
+static void xhci_dbc_external_reset_prep(struct xhci_hcd *xhci)
+{
+	struct dbc_regs __iomem *regs;
+	void __iomem		*base;
+	int			dbc_cap;
+
+	if (!xen_initial_domain())
+		return;
+
+	base = &xhci->cap_regs->hc_capbase;
+	dbc_cap = xhci_find_next_ext_cap(base, 0, XHCI_EXT_CAPS_DEBUG);
+
+	if (!dbc_cap)
+		return;
+
+	xhci->external_dbc = 0;
+	regs = base + dbc_cap;
+
+	if (readl(&regs->control) & DBC_CTRL_DBC_ENABLE) {
+		if (xen_dbgp_reset_prep(xhci_to_hcd(xhci)))
+			xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+					"// Failed to reset external DBC");
+		else {
+			xhci->external_dbc = 1;
+			xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+					"// Completed reset of external DBC");
+		}
+	}
+}
+
+static void xhci_dbc_external_reset_done(struct xhci_hcd *xhci)
+{
+	if (!xen_initial_domain() || !xhci->external_dbc)
+		return;
+
+	if (xen_dbgp_external_startup(xhci_to_hcd(xhci)))
+		xhci->external_dbc = 0;
+}
+#else
+static void xhci_dbc_external_reset_prep(struct xhci_hcd *xhci)
+{
+}
+
+static void xhci_dbc_external_reset_done(struct xhci_hcd *xhci)
+{
+}
+#endif
+
 static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 {
 	struct xhci_segment *seg = ring->first_seg;
@@ -180,6 +231,8 @@ int xhci_reset(struct xhci_hcd *xhci)
 		return 0;
 	}

+	xhci_dbc_external_reset_prep(xhci);
+
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "// Reset the HC");
 	command = readl(&xhci->op_regs->command);
 	command |= CMD_RESET;
@@ -211,6 +264,8 @@ int xhci_reset(struct xhci_hcd *xhci)
 	 */
 	ret = xhci_handshake(&xhci->op_regs->status,
 			STS_CNR, 0, 10 * 1000 * 1000);
+	if (!ret)
+		xhci_dbc_external_reset_done(xhci);

 	xhci->usb2_rhub.bus_state.port_c_suspend = 0;
 	xhci->usb2_rhub.bus_state.suspended_ports = 0;
@@ -991,6 +1046,7 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 		return 0;

 	xhci_dbc_suspend(xhci);
+	xhci_dbc_external_reset_prep(xhci);

 	/* Don't poll the roothubs on bus suspend. */
 	xhci_dbg(xhci, "%s: stopping port polling.\n", __func__);
@@ -1225,6 +1281,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 	spin_unlock_irq(&xhci->lock);

 	xhci_dbc_resume(xhci);
+	xhci_dbc_external_reset_done(xhci);

  done:
 	if (retval == 0) {
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 2595a8f057c4..61d8efc9eef2 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1920,6 +1920,7 @@ struct xhci_hcd {
 	struct list_head	regset_list;

 	void			*dbc;
+	int			external_dbc;
 	/* platform-specific data -- must come last */
 	unsigned long		priv[] __aligned(sizeof(s64));
 };
--
2.31.1

