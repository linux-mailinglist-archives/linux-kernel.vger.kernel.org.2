Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D573532BCBA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243838AbhCCOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842992AbhCCKX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337B1C08EB25
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:40:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l3so26150516ybf.17
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=XuDHw3O1srmLKsSoSJf7jMgqz2ffuZm3aO6BAJ189BA=;
        b=ua0Yw5zjlfjCqKHVLIv3cJaneXUfA3FK9C2+mEXp6+8xI9jMNNs4U49S+28oh4k3SE
         W5hkTE5GYypEGerM0kW8VGKF0kBPcPE+hxeLtMnwBrFmeridcwkZ2rJ/ocb56DXTVktl
         XEVRCwVrrKzo4hBIIA6GbVOMbm4/ncKaZAeuHt9zdBVg5rIR6PH0s0nACxj02ugUtAut
         Demfq0hUBFRQppiKfkoEsAtICHeqCWh5QDv61kPaQ9JqZpXwIhSL1dhjG+hiCbXCm5sq
         NgeLOwwvTYvWkGAgveyJlzSb9KaEpjN7GVDj+X0VU3L9l2PashFHORmezPHYOLalFgBa
         KS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=XuDHw3O1srmLKsSoSJf7jMgqz2ffuZm3aO6BAJ189BA=;
        b=jt/P2PwrjzWDSsc7Wic6f/GnmGZKf+uUtM+pcccUrZORry8p0ftqw8TCu4uVFNh3Xf
         pFWOXdx1e2VD7BUGNEXlaeKfr1gwMt8t5ET6BcISBHURrhIWn/hiKGiTMtpNmCSH66yA
         w9Behu5UPuYe8bTnh7lbYRfzg8qSkjGxVdgMMOd+pv2cfOiUkPACsdFadjR1aMKdnP0/
         RywiTi3d/NjPdfSftZFYGeECFAObytAVGe17a7Q3lcVC51hTK4rDX0DQm+tXwO2fPp9o
         7TrnbBL4cVH3i+GCgP49p+ItBIqGYYsYkIYNaIFj5xgb/AYwHI7Zriio3SjDMZGIE9F5
         lDRg==
X-Gm-Message-State: AOAM5328VcpuOKErRuF8q3xO44V9Tz/k2xGsngX1Lkpt+S873hu2wvfg
        kKqqs+TE1Bxz+f1uS9xo4/SJd0CRzCc=
X-Google-Smtp-Source: ABdhPJyRhUYTr6tzygLKQIL3hxEKRNYaM+RzAhBvDfbibZwl8U6wV8e2G/k94KHj2iFlyzJwPyRBDQYB5qE=
Sender: "raychi via sendgmr" <raychi@raychi.tao.corp.google.com>
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:d0b:ce1b:8f7e:f53a])
 (user=raychi job=sendgmr) by 2002:a25:cc46:: with SMTP id l67mr39991239ybf.16.1614764452378;
 Wed, 03 Mar 2021 01:40:52 -0800 (PST)
Date:   Wed,  3 Mar 2021 17:40:47 +0800
Message-Id: <20210303094047.2788465-1-raychi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Patch v2] usb: dwc3: document usb_psy in struct dwc3
From:   Ray Chi <raychi@google.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kyletso@google.com, Ray Chi <raychi@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new struct member was added to struct dwc3, but
a documentation was missing:

drivers/usb/dwc3/core.h:1273: warning: Function parameter or member 'usb_psy' not described in 'dwc3'

Signed-off-by: Ray Chi <raychi@google.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
Changelog since v1:
(reported-by Stephen Rothwell <sfr@canb.auug.org.au>)
- added Reported-by line.

 drivers/usb/dwc3/core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 6708fdf358b3..ce6bd84e2b39 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -988,6 +988,7 @@ struct dwc3_scratchpad_array {
  * @role_sw: usb_role_switch handle
  * @role_switch_default_mode: default operation mode of controller while
  *			usb role is USB_ROLE_NONE.
+ * @usb_psy: pointer to power supply interface.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
-- 
2.30.1.766.gb4fecdf3b7-goog

