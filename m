Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70A23B9CCC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 09:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhGBHPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 03:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhGBHPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 03:15:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F099C061764
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 00:12:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k11-20020a056902070bb029055a2303fc2dso9118390ybt.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 00:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UnsUVbnKrmyU1lgIL4DYjS7D/XYOp3W6UGWKGs+lUZA=;
        b=E+z6hu7lKYUyuWKm+szD1aJe1A0llfRSOkbyhTv9LsPXBWMIKDNzTe/u59jQkUbJFh
         jyZZg/9L8SYZjInggezn/F5Cb8+VP1Jw9uLJHCb8eg9asRZxpFElyTA2EG9yKv1UF09Y
         KQc7Vkjl+UJxA5J+N+4+BK9ycQWXJC8dfes0KpCRjP10T3QF/fWkH7Eu3mRAEJPrq0nd
         GbUr9FK6nHjrkBfskM0NPSgGrZy8wmcv9kF48t3fJclvv6PHsF37SLgA24YLtql6AazV
         VvpfRUkb56dN2rYblA7DcH7E+saT4TJE0fcDx98iHUaaDOydE4+q/xgPIy9D8QGg79FG
         xEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UnsUVbnKrmyU1lgIL4DYjS7D/XYOp3W6UGWKGs+lUZA=;
        b=knEE3x/0u3Bb+7qwaBd4MK4Co/PB+Dy0Iqo0bgqaq5fz2P1xUmnpv7aMWmjF05a038
         W4NwvbK722qE2hydAiiKAiwjlG0Phk9AHMI9Obzsk+NyWESV5/hFestkvX8QLtdH/YiX
         Nwjtweo3UFwRNDMwo0N4x2mRRd3IfbVxTcgQlSk/rQxQqXmmPiC+HbwpDcywLTBnevNf
         bNKr5zrkFSSSj/31YaQlJ7Rd8Jmuly/yqPGTYvB73ZmPvowYilcW/H7ZUalmARPcUN9W
         m6IxNYBgYWeVvYONHzhV3sZdiuHcI8onwtWhV0RSZabtriuINbKL+Yrv49pW2phd3vkp
         kLXQ==
X-Gm-Message-State: AOAM531mX1gevbhWK6E3xaeOJhkCTzwHLvfPSG2m4lx5kQp//OQ79KCN
        XHFTbkdtIz6Htv28R6gPSgR+5fUl2pxt
X-Google-Smtp-Source: ABdhPJzsH3mqEkh3V1kTNtE1Mz0ju8P5J6AfhJCXdPCem19ojYXCkcPxUSkNWenLGL/qZEITZPHxXzp1GDs3
X-Received: from gthelen2.svl.corp.google.com ([2620:15c:2cd:202:81c6:dd12:da9f:dd72])
 (user=gthelen job=sendgmr) by 2002:a25:c709:: with SMTP id
 w9mr4870053ybe.456.1625209951580; Fri, 02 Jul 2021 00:12:31 -0700 (PDT)
Date:   Fri,  2 Jul 2021 00:12:24 -0700
In-Reply-To: <xr93czs1p4uj.fsf@gthelen2.svl.corp.google.com>
Message-Id: <20210702071224.3673568-1-gthelen@google.com>
Mime-Version: 1.0
References: <xr93czs1p4uj.fsf@gthelen2.svl.corp.google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH V2] usb: xhci: avoid renesas_usb_fw.mem when it's unusable
From:   Greg Thelen <gthelen@google.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>
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

Fixes: a66d21d7dba8 ("usb: xhci: Add support for Renesas controller with memory")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
Changelog since v1:
- Smaller patch, only filters out MODULE_FIRMWARE()
- Added blank line
- Added Fixes footer to commit log

drivers/usb/host/xhci-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 18c2bbddf080..1c9a7957c45c 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -636,7 +636,14 @@ static const struct pci_device_id pci_ids[] = {
 	{ /* end: all zeroes */ }
 };
 MODULE_DEVICE_TABLE(pci, pci_ids);
+
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

