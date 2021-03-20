Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4528A342D4B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 15:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCTO3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 10:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhCTO25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 10:28:57 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7346C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 07:28:56 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id f9so20209755edd.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZJIhDl3dbfmuJaK3uoX7aKesDYTkhJ/dpFprfzrrMMQ=;
        b=iekiG38RMHMqotvnjsWADzkjN8LBZy0T5PdAh2/x4zxQG+/gnSDXsQbaHLg157U03g
         MK7BqYXwa9Z5YExdy1JA9WhBQxV5iWiY3PjtF1D7k9FJpAFVczlqUWT5Ygo/N3jcVHQK
         kltkdr55DkCbVjC6N+dU2Ylkab6+7Z8EfE2QN6UXUlmzLd4HUik6Ygo+KqdvJzPdZSMP
         46Q/GrrvOsa3okgJmBjij3e8EfhVwCtYR5xLOAlUqhSAtSyxIn1iFaHHiJy9eTAl68pX
         KyW0aHGVXzexYr8eD027p6CGsaOHDJYasQsfVa4lKTXqnz01ooDZJmOsJHeUBfnuTIEv
         zWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZJIhDl3dbfmuJaK3uoX7aKesDYTkhJ/dpFprfzrrMMQ=;
        b=o/j/kMB5Wk5zvrLndUzL0p7G2kYeeBeWEhIrJ++Qw20sHsvT4XB2cgXA23t6cXSsiw
         aYwOk4cPTBYF5ydLoN6IHN6JA2VIM+6da8WoKqD7UGKu4Yl4RJNXyAZdSNqRBZC1bYT9
         XchkiYiJjffcvNAY+BgQWoMHlD1oA8szNyXARPhbGPoyo+C/Tne/FLX2LtkPXe2mpzzt
         SVby9CCl3L/IKWKA0JdLMUoQ/ag9bd9fSejXaRdIyY6i/D1QhDjgR+tsm1eRKRuZDweN
         cxdcvUxtCr5d9xgP7alpkI/ECDaBstUa6P04AQmcRwft1vSQpOPUKZIlcSqbT6uzkO+F
         MYhQ==
X-Gm-Message-State: AOAM53327U51F+HGQwXFTS1nhEnjC84cDNeLZxrMo8Y+39qm1dPpwThI
        26krfPYpf7hHgQVUvVPPgzXUiBcCrLCi
X-Google-Smtp-Source: ABdhPJwHmgIAdnlzw2k/d9RrWtIKW6/663KxRbUPItmuN/KgAczpxnymtpmzJaPiLAr9CkkdlUsfCCjUWQRX
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:15:13:84f2:bf18:7ada:738e])
 (user=dvyukov job=sendgmr) by 2002:a17:906:b159:: with SMTP id
 bt25mr9871210ejb.364.1616250535324; Sat, 20 Mar 2021 07:28:55 -0700 (PDT)
Date:   Sat, 20 Mar 2021 15:28:51 +0100
Message-Id: <20210320142851.1328291-1-dvyukov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] net: make unregister netdev warning timeout configurable
From:   Dmitry Vyukov <dvyukov@google.com>
To:     davem@davemloft.net, edumazet@google.com
Cc:     Dmitry Vyukov <dvyukov@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netdev_wait_allrefs() issues a warning if refcount does not drop to 0
after 10 seconds. While 10 second wait generally should not happen
under normal workload in normal environment, it seems to fire falsely
very often during fuzzing and/or in qemu emulation (~10x slower).
At least it's not possible to understand if it's really a false
positive or not. Automated testing generally bumps all timeouts
to very high values to avoid flake failures.
Make the timeout configurable for automated testing systems.
Lowering the timeout may also be useful for e.g. manual bisection.
The default value matches the current behavior.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=211877
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 net/Kconfig    | 12 ++++++++++++
 net/core/dev.c |  4 +++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/Kconfig b/net/Kconfig
index 8cea808ad9e8d..ebb9cc00ac81d 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -461,6 +461,18 @@ config ETHTOOL_NETLINK
 	  netlink. It provides better extensibility and some new features,
 	  e.g. notification messages.
 
+config UNREGISTER_NETDEV_TIMEOUT
+	int "Unregister network device timeout in seconds"
+	default 10
+	range 0 3600
+	help
+	  This option controls the timeout (in seconds) used to issue
+	  a warning while waiting for a network device refcount to drop to 0
+	  during device unregistration.
+	  A lower value may be useful during bisection to detect a leaked
+	  reference faster. A larger value may be useful to prevent false
+	  warnings on slow/loaded systems.
+
 endif   # if NET
 
 # Used by archs to tell that they support BPF JIT compiler plus which flavour.
diff --git a/net/core/dev.c b/net/core/dev.c
index 0f72ff5d34ba0..ca03ee407133b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10405,7 +10405,9 @@ static void netdev_wait_allrefs(struct net_device *dev)
 
 		refcnt = netdev_refcnt_read(dev);
 
-		if (refcnt && time_after(jiffies, warning_time + 10 * HZ)) {
+		if (refcnt &&
+		    time_after(jiffies, warning_time +
+			       CONFIG_UNREGISTER_NETDEV_TIMEOUT * HZ)) {
 			pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
 				 dev->name, refcnt);
 			warning_time = jiffies;

base-commit: 5aa3c334a449bab24519c4967f5ac2b3304c8dcf
-- 
2.31.0.291.g576ba9dcdaf-goog

