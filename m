Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2F8332A19
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhCIPRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhCIPR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:17:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B0FC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 07:17:27 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m9so20847731edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 07:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nGW7TufZfzy9c5sOFAlA5Vi3cYOyfNqU6896aNFaTR4=;
        b=T7XE9G+JF6ZU/s36dz5ilduT35ggpohB8J/BAi+9TWViYGTGUZGc3gQhmhLNLanQmN
         /KG4ptyjfx2HP9ZbysvYOag5mHoZ+V1n4DZsr12jfXQ+HnIILPbM4kpmiRvwIW+24wkd
         1364x7ulivB8JJ7iLsfRcrN1jLKeaCQgaCI/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nGW7TufZfzy9c5sOFAlA5Vi3cYOyfNqU6896aNFaTR4=;
        b=bcKM8vIzC9ZE5BlKZrzm/8GcR112kRngTqWWVAdtsiS0Ef6SLNyt1AZUfHqo0Tp/x9
         liQiuF8axPCB61gUxeeLeNXr+C6Irh/80ZFZW09+uhiSNrBe3XOIILJoJrt0ctDZowDK
         DMrxwCjTYjhP3war4hFjDk6RNrKSZmovACVv3maSJpe7+5N31v6jPX24IDC/AujJpdY3
         aelOhRfPY/V0P5SbK/770rkBE8VoAf7q0D+1uOhxtKKdsLj4GLmsOO2Nco6fOgcr3XZV
         rYq26Ia1d0ksxwvEJ/cx5QGaMRQer4xyQ3KvDJ/FJ48EJVNvWWXuRYNQtl/gMVs/n2fh
         HtpQ==
X-Gm-Message-State: AOAM531zNfmrZFf0Neq7RzuBLFGqJBXQms+Tro0+TFrkOTMYaR8W0WUN
        F+FXSTs43dsILJ6ct0wCyus1xg==
X-Google-Smtp-Source: ABdhPJwZicoHk4X9qyvxXxqZ/C1HZlp9ncmgDVKdErYqUM90tLDYFT+Z1gI4OUyNmX5UpzXXkwm+6Q==
X-Received: by 2002:aa7:d0d7:: with SMTP id u23mr4576825edo.255.1615303046657;
        Tue, 09 Mar 2021 07:17:26 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id v12sm8732217ejh.94.2021.03.09.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:17:26 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kernel/async.c: remove async_unregister_domain()
Date:   Tue,  9 Mar 2021 16:17:23 +0100
Message-Id: <20210309151723.1907838-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309151723.1907838-1-linux@rasmusvillemoes.dk>
References: <20210309151723.1907838-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No callers in the tree.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/async.h |  1 -
 kernel/async.c        | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/include/linux/async.h b/include/linux/async.h
index 0a17cd27f348..cce4ad31e8fc 100644
--- a/include/linux/async.h
+++ b/include/linux/async.h
@@ -112,7 +112,6 @@ async_schedule_dev_domain(async_func_t func, struct device *dev,
 	return async_schedule_node_domain(func, dev, dev_to_node(dev), domain);
 }
 
-void async_unregister_domain(struct async_domain *domain);
 extern void async_synchronize_full(void);
 extern void async_synchronize_full_domain(struct async_domain *domain);
 extern void async_synchronize_cookie(async_cookie_t cookie);
diff --git a/kernel/async.c b/kernel/async.c
index 4b5971142922..b8d7a663497f 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -245,24 +245,6 @@ void async_synchronize_full(void)
 }
 EXPORT_SYMBOL_GPL(async_synchronize_full);
 
-/**
- * async_unregister_domain - ensure no more anonymous waiters on this domain
- * @domain: idle domain to flush out of any async_synchronize_full instances
- *
- * async_synchronize_{cookie|full}_domain() are not flushed since callers
- * of these routines should know the lifetime of @domain
- *
- * Prefer ASYNC_DOMAIN_EXCLUSIVE() declarations over flushing
- */
-void async_unregister_domain(struct async_domain *domain)
-{
-	spin_lock_irq(&async_lock);
-	WARN_ON(!domain->registered || !list_empty(&domain->pending));
-	domain->registered = 0;
-	spin_unlock_irq(&async_lock);
-}
-EXPORT_SYMBOL_GPL(async_unregister_domain);
-
 /**
  * async_synchronize_full_domain - synchronize all asynchronous function within a certain domain
  * @domain: the domain to synchronize
-- 
2.29.2

