Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A63DE98F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhHCJNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbhHCJNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:13:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2901BC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 02:13:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso22224749ybq.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 02:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EyxbSnCrZkW0D1s78hoRTHvz/RIPrLxVkHp3d0qMYgk=;
        b=Tip0r9HZ671jd/AbUl0qtLrYjIM8OpobmN6ubxWvSCfyGqfVj22QX+PlODtilbf1n0
         tS9OXdzgxqqXTdXvYtJUMtktil0qOkeVid1+sQnY8w2rTdIR+PvU7xBi3l31o+xQ4Pu2
         L3rJX0F4oPLugu8oRh6XDu7jc1w7261jW5FNlSdPxhS1sxsnGTSMFH4A5jywV3Wt7EUA
         KIsOUF2xY+EGNsD/gEJxs63Vcrah1/pfwYa1KpkHVri9QMsI13spa60/drhxx+r54oEB
         AEvLFKbn/NNAG1/mAwoCj0rmmeYXllnxNibL+wg3rPSh/bwzwGuF1f/y9gyrJ37VQ1Dk
         SZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EyxbSnCrZkW0D1s78hoRTHvz/RIPrLxVkHp3d0qMYgk=;
        b=boPilbAMHiVgdw94wXPHT90FL679d6dJMly9UyrlONwm6y/J5Kfaax0xKfvP/cBZRq
         ysmkD9qPTxInfiCgaDyIetzT9s1FdKleLzHDgKxCN+ajlvOAh85yXBeJ8cR/5hYBwT2e
         CbioriQlJi4/+h4UviBH+bbdXT8sUTHeBplpPg7UN17FZKgZo+DZruxNiHP/w2VM2iud
         3Ha7Qocvku08ryxi1v87vBUPjj/migh6OaPe02hhv4brHSmqlNPm1pkEVtIE6oPokBKu
         JEW1Z0cw6/ulqAsYlFtjSzCSRls9S2WtoKv8BJLJlPHjI8L3817I2c0gDuyTYwxMqtga
         STCg==
X-Gm-Message-State: AOAM530ewEz68y+FV2dxZIah4um4OrZLRtoNaXLBd6sMyLbfPXZReE34
        f/uQgwt0XvkS4c3k8SiQTwuUt3cla9pG
X-Google-Smtp-Source: ABdhPJyhMAsZAhTtNcT8YEFz6by+CTq1x8B6Q2rumYtSxq9s5GjGUf7228/L1NrdbR4kuIl4GvvZ8fQzSioz
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:2c1f:318f:d55f:e51b])
 (user=kyletso job=sendgmr) by 2002:a5b:58e:: with SMTP id l14mr27198466ybp.143.1627982000390;
 Tue, 03 Aug 2021 02:13:20 -0700 (PDT)
Date:   Tue,  3 Aug 2021 17:13:14 +0800
Message-Id: <20210803091314.3051302-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH] usb: typec: tcpm: Keep other events when receiving FRS and
 Sourcing_vbus events
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When receiving FRS and Sourcing_Vbus events from low-level drivers, keep
other events which come a bit earlier so that they will not be ignored
in the event handler.

Fixes: 8dc4bd073663 ("usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)")
Cc: Badhri Jagan Sridharan <badhri@google.com>
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5b22a1c931a9..b9bb63d749ec 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5369,7 +5369,7 @@ EXPORT_SYMBOL_GPL(tcpm_pd_hard_reset);
 void tcpm_sink_frs(struct tcpm_port *port)
 {
 	spin_lock(&port->pd_event_lock);
-	port->pd_events = TCPM_FRS_EVENT;
+	port->pd_events |= TCPM_FRS_EVENT;
 	spin_unlock(&port->pd_event_lock);
 	kthread_queue_work(port->wq, &port->event_work);
 }
@@ -5378,7 +5378,7 @@ EXPORT_SYMBOL_GPL(tcpm_sink_frs);
 void tcpm_sourcing_vbus(struct tcpm_port *port)
 {
 	spin_lock(&port->pd_event_lock);
-	port->pd_events = TCPM_SOURCING_VBUS;
+	port->pd_events |= TCPM_SOURCING_VBUS;
 	spin_unlock(&port->pd_event_lock);
 	kthread_queue_work(port->wq, &port->event_work);
 }
-- 
2.32.0.554.ge1b32706d8-goog

