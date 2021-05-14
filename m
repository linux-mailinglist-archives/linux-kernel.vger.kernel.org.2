Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20E1380153
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 02:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhENA6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 20:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbhENA6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 20:58:44 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2349EC061574;
        Thu, 13 May 2021 17:57:34 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d11so6153893iod.5;
        Thu, 13 May 2021 17:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73bCew6rTmXHX45d4vmDXZwsqCa9qTPna/Qeda9j70Q=;
        b=OWiu1eeiDjY/XbCbDJVr3kheFbNnpd+b6JgU9t/vkdpI9pGe9e642trB1IIKCogmK6
         2x3rnx6FAZeb0kzyLMXFZPeLzSU8UFDfAYEQl1IZSXrP0mt9lYpM11u6gIbfv/L4jb2T
         7FTU4qK8dsedPAjW6QjpAKdFoRCG3tL/6UIBmKtGX0PG9ha6n9eBVwmEOYdhmBRaqfDl
         OBMfukolCkeSB+D5mH7KBhLRUYIREf9Hjo7NBudYTWWFFNzUAFvWWvEur5T+Rgs+5ptt
         CvqVph2XwLV5G+Ihq02r2AuxTAEPjp5mUDItT72UIbq9S4e/uX7eaIntRpyDIcDzBIPx
         fZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73bCew6rTmXHX45d4vmDXZwsqCa9qTPna/Qeda9j70Q=;
        b=YQ7DWTl3X6hAfW4DidXaOfTOJla5D8bAS1OvhIKKj7vqqnmC1jI7A+uk9d/1Ua0Phh
         UHy15KC+DlMDbOg+cnFKDoEiqOESm76m4uVw+xy3hzGYoIfe4pbtcKeRBne1KYZCRGLk
         iRtbR3ykUVb86RUyBvZiT61Hc+vWuj5PJqo114a0C2wAUqTCDleicbhmUjGZSDwxASMM
         c91jbf2Drbu1wSYdsgYU1L1ex3LpkU1FGIIYq/pjj39whmNqfOoyHJDTzbZX8SFhgqJL
         7gVC4KWCX7rQJ33m9iKAj0i9aGUUGhyoIfzI9dJZGfkFCCpDc84F1YftqvVUc4xPukk7
         SLyQ==
X-Gm-Message-State: AOAM531pvqymqCEILsWTfAixNzkHA9YwyQQlt428vDPJqZo21wicqk4m
        u0rad1Rzcfmte9SeIW7IHhE=
X-Google-Smtp-Source: ABdhPJyc14f+idUQGuxzMTRpgDqLeTm6a2MTtRB9zAQhuQxUvXuWK89n1nBtt5rmwV5lQMRfJff/UQ==
X-Received: by 2002:a02:b057:: with SMTP id q23mr18689622jah.25.1620953853645;
        Thu, 13 May 2021 17:57:33 -0700 (PDT)
Received: from localhost.localdomain (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id g25sm1981538ion.32.2021.05.13.17.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 17:57:33 -0700 (PDT)
From:   Connor Davis <connojdavis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Connor Davis <connojdavis@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] usb: xhci: Notify xen when DbC is unsafe to use
Date:   Thu, 13 May 2021 18:56:51 -0600
Message-Id: <5c4a8a65a038563f2d20a734d74d2ed4a0f2d69e.1620952511.git.connojdavis@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d160cee9b61c0ec41c2cd5ff9b4e107011d39d8c.1620952511.git.connojdavis@gmail.com>
References: <d160cee9b61c0ec41c2cd5ff9b4e107011d39d8c.1620952511.git.connojdavis@gmail.com>
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
 drivers/usb/host/xhci-dbgcap.h | 19 ++++++++++++++
 drivers/usb/host/xhci.c        | 47 ++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h        |  1 +
 3 files changed, 67 insertions(+)

diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index c70b78d504eb..332be531bebd 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -227,4 +227,23 @@ static inline int xhci_dbc_resume(struct xhci_hcd *xhci)
 	return 0;
 }
 #endif /* CONFIG_USB_XHCI_DBGCAP */
+
+#ifdef CONFIG_XEN_DOM0
+#include <xen/xen.h>
+
+int xen_dbgp_reset_prep(struct usb_hcd *hcd);
+int xen_dbgp_external_startup(struct usb_hcd *hcd);
+
+void xhci_dbc_external_reset_prep(struct xhci_hcd *xhci);
+void xhci_dbc_external_reset_done(struct xhci_hcd *xhci);
+#else
+static inline void xhci_dbc_external_reset_prep(struct xhci_hcd *xhci)
+{
+}
+
+static inline void xhci_dbc_external_reset_done(struct xhci_hcd *xhci)
+{
+}
+#endif /* CONFIG_XEN_DOM0 */
+
 #endif /* __LINUX_XHCI_DBGCAP_H */
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index ca9385d22f68..3ff7879069ec 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -37,6 +37,47 @@ static unsigned long long quirks;
 module_param(quirks, ullong, S_IRUGO);
 MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 
+#ifdef CONFIG_XEN_DOM0
+void xhci_dbc_external_reset_prep(struct xhci_hcd *xhci)
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
+void xhci_dbc_external_reset_done(struct xhci_hcd *xhci)
+{
+	if (!xen_initial_domain() || !xhci->external_dbc)
+		return;
+
+	if (xen_dbgp_external_startup(xhci_to_hcd(xhci)))
+		xhci->external_dbc = 0;
+}
+#endif
+
 static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 {
 	struct xhci_segment *seg = ring->first_seg;
@@ -180,6 +221,8 @@ int xhci_reset(struct xhci_hcd *xhci)
 		return 0;
 	}
 
+	xhci_dbc_external_reset_prep(xhci);
+
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "// Reset the HC");
 	command = readl(&xhci->op_regs->command);
 	command |= CMD_RESET;
@@ -211,6 +254,8 @@ int xhci_reset(struct xhci_hcd *xhci)
 	 */
 	ret = xhci_handshake(&xhci->op_regs->status,
 			STS_CNR, 0, 10 * 1000 * 1000);
+	if (!ret)
+		xhci_dbc_external_reset_done(xhci);
 
 	xhci->usb2_rhub.bus_state.port_c_suspend = 0;
 	xhci->usb2_rhub.bus_state.suspended_ports = 0;
@@ -991,6 +1036,7 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 		return 0;
 
 	xhci_dbc_suspend(xhci);
+	xhci_dbc_external_reset_prep(xhci);
 
 	/* Don't poll the roothubs on bus suspend. */
 	xhci_dbg(xhci, "%s: stopping port polling.\n", __func__);
@@ -1225,6 +1271,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
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

