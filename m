Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22BB3D4405
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhGXAAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 20:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhGXAAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 20:00:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382DEC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:40:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x7-20020a0569021027b029055b9b68cd3eso4261967ybt.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2ZqGElJzo4JauYJJ53FWpHklzKIo9vDXGGSwJmC7ZbE=;
        b=RShW2FY2N5iSlpFdpvUSjtmuRxtRW+BNJTEcFuwp3RSJISQMYC8nRmq7sK12L+QPyx
         9rdk6EbCQ/BV5F136n0a1FCpY0tTUSosl0OT/+pCLcxOdx2IbXZVx/Ej6K5dw5AiL4Ij
         P9DIEzEmpgEV6XNfUaHmMMuNJ/MzEKX6LGiZ3u07XCFuQR7y98gxwbfvOfF7uFGl1Clc
         BJXsMcSPMKAElIPw0DeSP/XwrTjGCHRWyqcI8HbjStOSYSt15u6ckxPhfTpbmN5CMmOH
         2C5K1f1HPuWb+10yXO7POQ8vHWZ8e/veaErsskSGjL9GS9usTw4oX4JywGWXh730cLDa
         ufVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2ZqGElJzo4JauYJJ53FWpHklzKIo9vDXGGSwJmC7ZbE=;
        b=VTl7oM2myugQdxfPXfwetwKGldFcQp24oPK0JVtZ/JuobInh3E7nMbtj4TVnWtiw0A
         LkvB4Haed6RN0v1eJn9OBQwTpvfFzFdaArCrGpoCD+aMWywE1bY0a2OXDV5fxg6Xvich
         xAknfuIv9tXTq9Cp5w6m+H+Cy8ZdIT2qL5mnKimMjC9iGuhWnt7RgqoNH5gqjnHiOOlu
         B/MRLaf59pcYg/cJsmLe5WTfHvTQV44oOdVommN2V4sHQtFwvWc3nR7D6BgskxVmGsEK
         RyYcc+7xBlsducKZo/rQ8TwM3GNfe7g/ptcYeF3btDx0t1DMFyKiNgxF9ytThXmmzaj2
         lCuQ==
X-Gm-Message-State: AOAM533XSAtwK4lL3cK3q7nC+FQGeqJypwwusMTSyv86QkmRMfIokzGP
        1XTElDNlnAkfr0L/AJ/yw5Le2Jlp8hiI
X-Google-Smtp-Source: ABdhPJzDwQUC6+PdiSfFGfbNhFDSKhgZmEBP1eGMtM7S8+HJi2bUg7r9L4JXgJuImDzcVDtqTtNnn9N+Rcsr
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:ec55:789:10be:69f5])
 (user=rajatja job=sendgmr) by 2002:a25:a065:: with SMTP id
 x92mr9818396ybh.466.1627087248396; Fri, 23 Jul 2021 17:40:48 -0700 (PDT)
Date:   Fri, 23 Jul 2021 17:40:43 -0700
Message-Id: <20210724004043.2075819-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2] thunderbolt: For dev authorization changes, include the
 actual event in udev change notification
From:   Rajat Jain <rajatja@google.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.or
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For security, we would like to monitor and track when the thunderbolt
devices are authorized and deauthorized (i.e. when the thunderbolt sysfs
"authorized" attribute changes). Currently the userspace gets a udev
change notification when there is a change, but the state may have
changed (again) by the time we look at the authorized attribute in
sysfs. So an authorization event may go unnoticed. Thus make it easier
by informing the actual change (new value of authorized attribute) in
the udev change notification.

The change is included as a key value "authorized=<val>" where <val>
is the new value of sysfs attribute "authorized", and is described at
Documentation/ABI/testing/sysfs-bus-thunderbolt under
/sys/bus/thunderbolt/devices/.../authorized

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/thunderbolt/switch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 83b1ef3d5d03..382128dfbdee 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1499,6 +1499,7 @@ static ssize_t authorized_show(struct device *dev,
 static int disapprove_switch(struct device *dev, void *not_used)
 {
 	struct tb_switch *sw;
+	char *envp[] = { "AUTHORIZED=0", NULL };
 
 	sw = tb_to_switch(dev);
 	if (sw && sw->authorized) {
@@ -1514,7 +1515,7 @@ static int disapprove_switch(struct device *dev, void *not_used)
 			return ret;
 
 		sw->authorized = 0;
-		kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
+		kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
 	}
 
 	return 0;
@@ -1523,6 +1524,8 @@ static int disapprove_switch(struct device *dev, void *not_used)
 static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 {
 	int ret = -EINVAL;
+	char envp_string[13];
+	char *envp[] = { envp_string, NULL };
 
 	if (!mutex_trylock(&sw->tb->lock))
 		return restart_syscall();
@@ -1560,7 +1563,8 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 	if (!ret) {
 		sw->authorized = val;
 		/* Notify status change to the userspace */
-		kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
+		sprintf(envp_string, "AUTHORIZED=%u", sw->authorized);
+		kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
 	}
 
 unlock:
-- 
2.32.0.432.gabb21c7263-goog

