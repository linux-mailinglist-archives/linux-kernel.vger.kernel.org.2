Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0399E33E289
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 01:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCQALZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 20:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCQALX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:11:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B02FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:11:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a186so43273378ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ICdrQPj3j/fsoTlcia/t0IEP5mlGt/tFAffDvI3wY5s=;
        b=ZBwHO4IRmRZBNuefDfsO2XQgsHuvbKBzMGOv1/804ysqN1IJXNQwCcBdAygXME7XxZ
         c2aUbYJnMfO/BJSrtCZGWLALJgfcitStAFG0koBGfDr8Jj18xkc8HkXOdoXdjyPiq/61
         DO+QtxUbKbhPcmFpJlf9biCi1ITwSXgF0pwRo8/PTVZQ8D/JbmXSk10+qVVg8pkU9Z6q
         L9TLKFtpLJKG/4rOjUuU7U77GTzz9/bA9xYeDzVfNODVXkPdnyfUfQ5mzkV360M6MerE
         9XDrqRIcrv0FdN6rf/sZc1VdrfCacsgpXB6bjfehpT4mPc2BBK7YAbejSE4tYV7QDT6Z
         6KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ICdrQPj3j/fsoTlcia/t0IEP5mlGt/tFAffDvI3wY5s=;
        b=hiVdQvLI+YdK1TqbU/42g9I9zu6LshDMwAxfO8nvzTOXGaMdBKtmjLGHLVLtujBSK6
         4ZJUHPeieaMSGy25vFfkydYktvA48jrZbcyALjmysgD4Q4BVTHhWOBdds+wbP+3+ObFR
         LiD1bc5NH6YQhBY6WSpfMWxbr329o/CZDG6lIhkMFfFL34cVMxT3B811i36utd46iztC
         BqUT+2ZcuEtjUq8FkncMejXjzZsAK1EZEuWcf5txVpqfYmKva803H6DabgdS4vqtK94N
         qrw1NeE18A8R9mp+NADlPwIFJgXhDosfOBcyNvAELjt1jyokjJ5gHTKKzaJcrWP7gJNg
         1BBw==
X-Gm-Message-State: AOAM533bvPSCe6/4+EHH+sv1tR/OnGWT1+F+Tp7mF4BMGpHtHelSJ8hw
        Dt0tWoZJtzIvve3Zu9G8dkI8aSU0EigHFgF/
X-Google-Smtp-Source: ABdhPJzDuCdU2E6K4E1qDZk2y8cwsZYR6uLSlM11Vh7iSnxa9BoAywPB6zktEURbFLlaPo/lFwURMJyCcn2kYjs0
X-Received: from ryanoleary.svl.corp.google.com ([2620:15c:2c5:3:403c:58cd:b7e4:47af])
 (user=ryanoleary job=sendgmr) by 2002:a5b:e8e:: with SMTP id
 z14mr1761765ybr.352.1615939882798; Tue, 16 Mar 2021 17:11:22 -0700 (PDT)
Date:   Tue, 16 Mar 2021 17:10:36 -0700
Message-Id: <20210317001036.1097763-1-ryanoleary@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 1/1] ipmi/watchdog: Add WDIOC_GETTIMELEFT ioctl
From:   "Ryan O'Leary" <ryanoleary@google.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Ryan O'Leary" <ryanoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the same ioctl the rest of the watchdogs support. GETTIMELEFT
returns the number of seconds in the countdown -- useful for testing
whether the watchdog is functioning.

Signed-off-by: Ryan O'Leary <ryanoleary@google.com>
---
 drivers/char/ipmi/ipmi_watchdog.c | 75 +++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 32c334e34d55..f253c8667395 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -456,6 +456,71 @@ static int ipmi_set_timeout(int do_heartbeat)
 	return rv;
 }
 
+static unsigned int __ipmi_get_timeout(struct ipmi_smi_msg  *smi_msg,
+				       struct ipmi_recv_msg *recv_msg,
+				       int                  *countdown)
+{
+	struct kernel_ipmi_msg            msg;
+	int                               rv = 0;
+	struct ipmi_system_interface_addr addr;
+
+
+	addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	addr.channel = IPMI_BMC_CHANNEL;
+	addr.lun = 0;
+
+	msg.netfn = 0x06;
+	msg.cmd = IPMI_WDOG_GET_TIMER;
+	msg.data = NULL;
+	msg.data_len = 0;
+	rv = ipmi_request_supply_msgs(watchdog_user,
+				      (struct ipmi_addr *) &addr,
+				      0,
+				      &msg,
+				      NULL,
+				      smi_msg,
+				      recv_msg,
+				      1);
+	if (rv) {
+		pr_warn("get timeout error: %d\n", rv);
+		return rv;
+	}
+
+	wait_for_completion(&msg_wait);
+
+	if (recv_msg->msg.data_len < 9) {
+		pr_warn("get timeout response size: %d (expected 9)\n",
+			recv_msg->msg.data_len);
+		return -EIO;
+	}
+
+	if (recv_msg->msg.data[0] != 0)  {
+		pr_warn("get timeout completion code error: %d\n",
+			recv_msg->msg.data[0]);
+		return -EIO;
+	}
+
+	*countdown = WDOG_GET_TIMEOUT(recv_msg->msg.data[7], recv_msg->msg.data[8]);
+
+	return rv;
+}
+
+static int _ipmi_get_timeout(int *countdown)
+{
+	int rv;
+
+	if (!watchdog_user)
+		return -ENODEV;
+
+	atomic_set(&msg_tofree, 2);
+
+	rv = __ipmi_get_timeout(&smi_msg,
+				&recv_msg,
+				countdown);
+
+	return rv;
+}
+
 static atomic_t panic_done_count = ATOMIC_INIT(0);
 
 static void panic_smi_free(struct ipmi_smi_msg *msg)
@@ -729,6 +794,16 @@ static int ipmi_ioctl(struct file *file,
 			return -EFAULT;
 		return 0;
 
+	case WDIOC_GETTIMELEFT:
+		val = 0;
+		i = _ipmi_get_timeout(&val);
+		if (i)
+			return i;
+		i = copy_to_user(argp, &val, sizeof(val));
+		if (i)
+			return -EFAULT;
+		return 0;
+
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog

