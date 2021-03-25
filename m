Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3CB3494A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhCYOxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhCYOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:52:51 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92460C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:52:50 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id a2so2805379edx.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=STCmlN6hY8DEQEj8NFVnXDEzIL1GeEra4hxCSiYhbXY=;
        b=taC5jvh3MEbb3x/VpcyVnUS3GzEsskrjQBkhyFLV30MQ4LFf3yzzz/YJtsLTdFLLun
         r88T+m7Z7VF1FGbuY1jO1iOr0tcZSYdfVC4MNkEIJ5ykJFVIeKhfIm79GpIQxFDCo1uK
         rzGOvi2nsHDB5FRbgtvxAn4L4+PIaQ9nzGuUUAyw1BFFrdigBOEE2wBUgMuCJ8d1XpeI
         rA6WgbNFTJG+MNYYkR7SiYZI+vibj3Mb+s+di0nKviqVpyg/FOCEUTzm25ApV8lo7iUR
         fWSYWf/jIoJ9g0I56MVR8c4dA8INEfM7G2L0QE61UAeLgU/WHTlTqIbWm0nARqyWB/0x
         3Ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=STCmlN6hY8DEQEj8NFVnXDEzIL1GeEra4hxCSiYhbXY=;
        b=oCUFnKmLnVsh//gzidwdfCnen6KPFAUVjtpyG6U4WU1/4s9T8VjK0EiKGszQR+y1sj
         iBXNVaG2WEK8ytP8I61mL843Vm/XmyZVYO2pmDWT0HyXQRkiiM4ZC1bwIcEzOok3/+wO
         xxKLHgLdNk7xLwajHSNCnRCJmUUnpeqvkxQtVmb62l03S1jaKRr9oEYXORxIwpC9qnCI
         +bDaFjoOt6gEAR1MWqOL5gYGT+k1XYSNJveF9aqRJgtDoS7XZDaEtgvT9SwV0VcrMraX
         b9hRhjqA3Loweskv8l5tgQPA6jWy8DP9ym00gkOHkMSePCYRIKveqoZCcyqowd2T1Yz7
         b0hA==
X-Gm-Message-State: AOAM530oMAh7f1sVyX/nldmsI4elhz7IpJgwKhcUI1dDmjmrkXwp3vKN
        OvuG4YvD8Qq4rh+/Y7gW0645uX8xk+LD
X-Google-Smtp-Source: ABdhPJzPMq20S+OQH/A85v07sokOWto4Kz4w81RF3hg0Dh+DAdDletZLiRIbANYepwqvHntnpNuAOAMbtxOv
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:15:13:8903:2da7:c857:1a50])
 (user=dvyukov job=sendgmr) by 2002:a17:906:524f:: with SMTP id
 y15mr9740993ejm.65.1616683968822; Thu, 25 Mar 2021 07:52:48 -0700 (PDT)
Date:   Thu, 25 Mar 2021 15:52:45 +0100
Message-Id: <20210325145245.3160366-1-dvyukov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH net-next v2] net: change netdev_unregister_timeout_secs min
 value to 1
From:   Dmitry Vyukov <dvyukov@google.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     leon@kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netdev_unregister_timeout_secs=0 can lead to printing the
"waiting for dev to become free" message every jiffy.
This is too frequent and unnecessary.
Set the min value to 1 second.

Also fix the merge issue introduced by
"net: make unregister netdev warning timeout configurable":
it changed "refcnt != 1" to "refcnt".

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: 5aa3afe107d9 ("net: make unregister netdev warning timeout configurable")
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes since v1:
 - fix merge issue related to refcnt check
---
 Documentation/admin-guide/sysctl/net.rst | 2 +-
 net/core/dev.c                           | 2 +-
 net/core/sysctl_net_core.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 2090bfc69aa50..c941b214e0b7f 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -320,7 +320,7 @@ waiting for a network device refcount to drop to 0 during device
 unregistration. A lower value may be useful during bisection to detect
 a leaked reference faster. A larger value may be useful to prevent false
 warnings on slow/loaded systems.
-Default value is 10, minimum 0, maximum 3600.
+Default value is 10, minimum 1, maximum 3600.
 
 optmem_max
 ----------
diff --git a/net/core/dev.c b/net/core/dev.c
index 4bb6dcdbed8b8..7bb00b8b86c64 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10431,7 +10431,7 @@ static void netdev_wait_allrefs(struct net_device *dev)
 
 		refcnt = netdev_refcnt_read(dev);
 
-		if (refcnt &&
+		if (refcnt != 1 &&
 		    time_after(jiffies, warning_time +
 			       netdev_unregister_timeout_secs * HZ)) {
 			pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index d84c8a1b280e2..c8496c1142c9d 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -577,7 +577,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.extra1		= SYSCTL_ONE,
 		.extra2		= &int_3600,
 	},
 	{ }

base-commit: 84c7f6c33f42a12eb036ebf0f0e3670799304120
-- 
2.31.0.291.g576ba9dcdaf-goog

