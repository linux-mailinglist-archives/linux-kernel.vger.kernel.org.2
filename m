Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0553D3148
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 03:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhGWAsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhGWAsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:48:05 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4B4C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 18:28:40 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so734355qvt.20
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 18:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Fn5O5gWOb6Ru+LgHgcwaMCAMb3hgNOKe/ej//OWLhcM=;
        b=SACaWikoFPHWSTRsJ/h66/PZO6BUBliibjg3zOEZAYY7VRQaAW82XlbRTYz5A/JOha
         k/M7KnmITZ7HdVTF4UvNOEj68TJ1JSD+U20oqmhiJIe/dTBf5WZgc6nejCksKWED2ewO
         kHXYhB82pYLxnYV5NAT1CgUSZARRTvgAV3vF5Up+Hcxvj/vJLxn2oiyZglThnZAWfjrd
         3PtDNgquIXrP9JmH6u4aq9fB7F9o9qdsnj1XLN1xJv7jY8ToLlDfQKnfQBhrgWDf4HPQ
         VjCWqyruBWEYdFzeU5vm41QLutmGIPsm8mzmlwZkAdZpAHx277xx1ek32QLJqVbhNOD8
         MEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Fn5O5gWOb6Ru+LgHgcwaMCAMb3hgNOKe/ej//OWLhcM=;
        b=ko7lpWVwe7ZbOAg52qQ91GF0kq9WgcbGyFMRavQELTJqiUw4dm77crz+P8SliyVjv5
         VrpqR3cOLxlcyT7mVx9rMOkoQLddagJA6MeSj+QzK8aaB9tbyPfku3zx3ozdZgdhq9It
         945MVfH23fcz9AnznWxkeGT79Hd0W6Qy0jlS/gyzqoPmHrmdOhkJvZEIKebtGGiQyEbC
         0LR4kSXQKlOujDR3XdGM9cYO3PF95OSQBGfrjwIc8dFjenSDGpLqtvQD5HJgB5FWceWO
         soWMHxauolnM7zSe1rZVy0qmAGuxpSYIniU63b7et/+EjQh9TaHhdvebchaLQ8XZdGh0
         aooQ==
X-Gm-Message-State: AOAM532EuPHr1Rb/v0wNwmUAUubHQPVDzauTRq+Ctmh6k7HDSOJn/hpO
        rVE0LxcCtT9LXrBJR/akutWbOBzXyG9N
X-Google-Smtp-Source: ABdhPJz0qvqTMvCA4BIQ8mqve6awrI3mV5qSACM5ttL2tUHu17DzK2adJxKKurAI2NkQAHEhY96IsESVkZ9l
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:fdff:bbf6:d7ec:d92e])
 (user=rajatja job=sendgmr) by 2002:a05:6214:767:: with SMTP id
 f7mr2583972qvz.16.1627003719133; Thu, 22 Jul 2021 18:28:39 -0700 (PDT)
Date:   Thu, 22 Jul 2021 18:28:34 -0700
Message-Id: <20210723012835.1935471-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] thunderbolt: For dev authorization changes, include the
 actual event in udev change notification
From:   Rajat Jain <rajatja@google.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For security, we would like to monitor and track when the
thunderbolt devices are authorized and deauthorized. Currently
the userspace gets a udev change notification when there is a
change, but the state may have changed (again) by the time we
look at the authorized attribute in sysfs. So an authorization
event may go unnoticed. Thus make it easier by informing the
actual change (authorized/deauthorized) in the udev change
notification.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/thunderbolt/switch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 83b1ef3d5d03..5d3e9dcba44a 100644
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
+		sprintf(envp_string, "AUTHORIZED=%u", val);
+		kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
 	}
 
 unlock:
-- 
2.32.0.432.gabb21c7263-goog

