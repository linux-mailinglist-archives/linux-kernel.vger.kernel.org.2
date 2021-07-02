Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD7D3B9C10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 07:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhGBFud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 01:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGBFub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 01:50:31 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22523C061764
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 22:47:59 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id x3-20020ac853830000b029025167dca6e0so4911398qtp.22
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 22:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wdon6WR16eVk/mXealjFOSo3Z4uiXRlZx0g446VrFWw=;
        b=fDu9N97ymY57BM+0wJqs9uTTgOPDZjR/iNU0x95In9zv46MlUsokrbdZ5al/uzdLUr
         M2umhfSwOg7sabn+6ep81QZx9ryvQAG+CTVcIuYTGhXD/hckq7dV1hr6OQGTL33+W2tV
         WRLTMhb4QmKUWk0ZjWznj5GEn8QkevQ/f4AwCxBzeLoQM5b/Ya6G9jUq23dhR3sjqRri
         72ohNfCxTln6gBhprE7V0msZ+o6pVAn59p4vywKjjV6DozZt3/bUxXbc1vY8Oz00b0AR
         91iERJ7GEH2E4L5P84At1jTEJkGgpjYIxwFWE4iRH0KEzHlY8T9ngnxNWmbsXWJqRlvZ
         2qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wdon6WR16eVk/mXealjFOSo3Z4uiXRlZx0g446VrFWw=;
        b=NtgpXHti93OzzTXyBQnR7OYBv/MFYCxztLaEtl6AEAmXPyVZYrobT2bZCl1wFhXIuB
         8WfxsqXr/QEcXJk6bpRAjF/l4g9udUaoVeKmvdjOPb+6Cl+yKfbgP0eRnpj7XmwKCCkX
         Zak0XWVvxg1QYorJiioXmPZC6KVGAU6+VsxxVfgF5McesQZyrWVk2U54JXGZH3HzU/DS
         CmkFkQffmMJS8HQDWRIEnnaMJDVZBnnWzr00Zk/YEPcUioThBU97qXAVTYGQ3t+Sm7NX
         5uEY0s3lXETQvE5JnnRikJkJTTkqR134FUsMbyj1VHpUu5NO+rRzQwnzc3m7ERptLPfd
         g0DA==
X-Gm-Message-State: AOAM532fZITgj2XM1GRKdcz90xMKkhgKbu77ec8H6T8jWvgfcfuvIcTF
        kg3usBDJ9IgGFtZITyaLzORgfZaSTHpO
X-Google-Smtp-Source: ABdhPJwls7dt2TFSw3P9uW4DpbRemJGgWLXcEiTKmODlVLFIf9gFpDYGRxiAqxTDRY//O+oDHZCUfK5iOlLa
X-Received: from gthelen2.svl.corp.google.com ([2620:15c:2cd:202:81c6:dd12:da9f:dd72])
 (user=gthelen job=sendgmr) by 2002:a0c:b450:: with SMTP id
 e16mr3511217qvf.25.1625204878247; Thu, 01 Jul 2021 22:47:58 -0700 (PDT)
Date:   Thu,  1 Jul 2021 22:47:54 -0700
Message-Id: <20210702054754.2056918-1-gthelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] usb: xhci: avoid renesas_usb_fw.mem when it's unusable
From:   Greg Thelen <gthelen@google.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a66d21d7dba8 ("usb: xhci: Add support for Renesas controller with
memory") added renesas_usb_fw.mem firmware reference to xhci-pci.  Thus
modinfo indicates xhci-pci.ko has "firmware: renesas_usb_fw.mem".  But
the firmware is only actually used with CONFIG_USB_XHCI_PCI_RENESAS.  An
unusable firmware reference can trigger safety checkers which look for
drivers with unmet firmware dependencies.

Avoid referring to renesas_usb_fw.mem in circumstances when it cannot be
loaded (when CONFIG_USB_XHCI_PCI_RENESAS isn't set).

Signed-off-by: Greg Thelen <gthelen@google.com>
---
 drivers/usb/host/xhci-pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 18c2bbddf080..cb148da7a789 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -618,8 +618,10 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
 /*-------------------------------------------------------------------------*/
 
 static const struct xhci_driver_data reneses_data = {
+#if IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS)
 	.quirks  = XHCI_RENESAS_FW_QUIRK,
 	.firmware = "renesas_usb_fw.mem",
+#endif
 };
 
 /* PCI driver selection metadata; PCI hotplugging uses this */
@@ -636,7 +638,13 @@ static const struct pci_device_id pci_ids[] = {
 	{ /* end: all zeroes */ }
 };
 MODULE_DEVICE_TABLE(pci, pci_ids);
+/*
+ * Without CONFIG_USB_XHCI_PCI_RENESAS renesas_xhci_check_request_fw() won't
+ * load firmware, so don't encumber the xhci-pci driver with it.
+ */
+#if IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS)
 MODULE_FIRMWARE("renesas_usb_fw.mem");
+#endif
 
 /* pci driver glue; this is a "new style" PCI driver module */
 static struct pci_driver xhci_pci_driver = {
-- 
2.32.0.93.g670b81a890-goog

