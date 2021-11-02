Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711CE4428C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhKBHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKBHsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:48:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801C8C061714;
        Tue,  2 Nov 2021 00:45:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g11so7370770pfv.7;
        Tue, 02 Nov 2021 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbB02tYMjQ6ue9qGZBRJ8S9gr/0EkY+iFqk7/OfhdSU=;
        b=BhFbnPPiVL90b5KhHYM2HP+eTEZRg062PnJWkTw56i6SZ9dZG8pz9cEVMuN1DU0Yw9
         Kob+UwPBg3n8umm2QjxQI//s2gfLZeiJLR/4IhK7tgK/tXtLj1F6ifRhZh23rUQNOhTB
         DW8y9ATuZdvOiE1sbhe1hRY15PsVTfCgKwanoNXGlg9QuUBM72QJzsBVZeRn4YuZ1gZ3
         VgJOod/ukGHDVfmv+V1bb3ttPprBgV9rCZS6SEgagegTjb+webyJUmVR53hbcDAVRWCW
         akb34oEic5Dwb2a27l0U/FhIGfRzgewCkng96l4Gzd6hfQNqPyKcZ+o5hM8mtBqFgffT
         mjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbB02tYMjQ6ue9qGZBRJ8S9gr/0EkY+iFqk7/OfhdSU=;
        b=6gIUeWG+sZQwgrHi+cBfMbeGvkzb4cz08+pkAWV3MvjQHL8cfcJZT1nvoXT5ecRgG+
         EIM9jCJgvH8Mh+T84qSVB7XY7lMB/cJhXegt5rFB5Dvs58yNafuwoBXYUPdmTvVy9sfZ
         S4DBfk5RSlQpFkyyQWTI0OzxQZu6NBBpy2LT6VJz7jDfn1KgmYBbFuKVxo6U0r2NCj95
         /nVGkVbyMCzwq2UeaVLOmPp3EFSxuhdNRZWZaCZzlFj01ZRVMKjf92NUg65BioDvyER5
         EWIrvF6lrKiC7G/Vs7lUrlGUqakdI+OcQirISlTR4g0v2BRXHA7N7oq8FkRHay+s5Fqz
         gVWQ==
X-Gm-Message-State: AOAM531m+5iPiWLAo1FYRjrzA5zArMDKqGDCYLoRZyxjAlFTi+W7gvbz
        JCuPF/WaIvfaAngTDPATsgJmJ22vAzo=
X-Google-Smtp-Source: ABdhPJwT9OpxlXsOQ18uXTAetKiDu8ic53T4TTtMxfVe5F7MqWrLeowkvJI2AfmFHl923Lstqz3IRQ==
X-Received: by 2002:a05:6a00:15ca:b0:47f:59c4:dcf6 with SMTP id o10-20020a056a0015ca00b0047f59c4dcf6mr25978760pfu.63.1635839157626;
        Tue, 02 Nov 2021 00:45:57 -0700 (PDT)
Received: from ELIJAHBAI-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id u13sm14668281pga.92.2021.11.02.00.45.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Nov 2021 00:45:57 -0700 (PDT)
From:   Haimin Zhang <tcs.kernel@gmail.com>
X-Google-Original-From: Haimin Zhang <tcs_kernel@tencent.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: [PATCH] USB:  array-index-out-of-bounds in ehci_brcm_hub_control
Date:   Tue,  2 Nov 2021 15:44:46 +0800
Message-Id: <20211102074446.87107-1-tcs_kernel@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't enough check parameter `wIndex` in the function 
`ehci_brcm_hub_control`;due to the size of array `port_status`
is 15, so it may lead to out of bounds.

Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
Reported-by: TCS Robot <tcs_robot@tencent.com>
---
 drivers/usb/host/ehci-brcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
index d3626bfa966b..4ca3eb9fcda9 100644
--- a/drivers/usb/host/ehci-brcm.c
+++ b/drivers/usb/host/ehci-brcm.c
@@ -63,7 +63,8 @@ static int ehci_brcm_hub_control(
 	unsigned long flags;
 	int retval, irq_disabled = 0;
 
-	status_reg = &ehci->regs->port_status[(wIndex & 0xff) - 1];
+	if (wIndex && wIndex <= ports)
+		status_reg = &ehci->regs->port_status[(wIndex & 0xff) - 1];
 
 	/*
 	 * RESUME is cleared when GetPortStatus() is called 20ms after start
-- 

