Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05763F5698
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 05:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhHXDTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 23:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhHXDTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 23:19:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B311C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 20:18:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y23so18485151pgi.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 20:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ljIRRfacT3qujdXpWiWXLGhvxuZKggz1kLiwmatqcXk=;
        b=ViKI8uTtaHrkAhPsH5f36f+JiQRf1mXDYC+4Q0v809GHlcYUhVgShIoa2PjCa9to0G
         RqfQGp4c0/rHz78JJD0iE8jwmgyGl02bXsrRPW1+ouP0AzQiUl/PvSy+D74a1aXwSQIT
         OwzR3LCuxB7e0ANnwc3fspJ6F8+yXpchA11dvWoWffkVjf9ezQg5AmfiiGdwAuG/MI3k
         al5VBSY0w3eOFpDoskhLx+PFgyF5nVVAi5yMrmEwK8pASRlODZdmvHt9MLt/HmahR+cs
         2iwpYQR5WplbmWEaVVpoqNMmlI2pGA37zr47zdvXN3SG76fCg+lMl3skX5fARM/MMB5o
         ADFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ljIRRfacT3qujdXpWiWXLGhvxuZKggz1kLiwmatqcXk=;
        b=Ds5BHaxHfrtz2VPVNZRWqZmVx5tNIJprBIA0gEVWUI5BTo4ZSyp7O9Rd0FPO47Qw8Z
         AsyVSBrvWZiyQ+ykKtWI9c29JKrSwBwmaHNaaJl9r8U8sOQJe49B0tFYNAlqNwID7vP1
         7ochx/kB7EZw45QWX7rrowxI1c2Dx9AOSfXVGo7JU+w5Cvk/xh2vJBqs2aVIiShd3/vn
         bJRTb5AbyusnpvxFPXAeyxLYEdEIMhjt+qffkgt3+Gqt7MbfZmF4L+ykqtjQIzFBmYCk
         LwM2UnUZiBnvWIh/KyKoq14Rji4QioE0yMOqIQMKOc6sqfro21sh14g4xSq1uVYlug6V
         GhKg==
X-Gm-Message-State: AOAM530CuNFRe8ouj6Yy46311TtpPv5cpzRbY4PBh+amDMJFYLM6EL0W
        MLnZWMvNixr2RpsCSrBnuG4=
X-Google-Smtp-Source: ABdhPJxNaVYoMT/jCr83lr4UZlxXdEa+xywTGpfGsALNu6xzjiZ5Sk5tOpjQld6h06NeMok2r6InNQ==
X-Received: by 2002:a63:6705:: with SMTP id b5mr35203852pgc.69.1629775131574;
        Mon, 23 Aug 2021 20:18:51 -0700 (PDT)
Received: from raspberrypi ([210.183.35.240])
        by smtp.gmail.com with ESMTPSA id i8sm17691949pfo.117.2021.08.23.20.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 20:18:51 -0700 (PDT)
Date:   Tue, 24 Aug 2021 04:18:47 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        austin.kim@lge.com
Subject: [PATCH] cachefiles: remove always false 'datalen < 0' expression
Message-ID: <20210824031847.GA23326@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

Since 'datalen' is declared as size_t, the 'datalen < 0' expression
is always false. Where size_t is defined as below;

   typedef unsigned long __kernel_ulong_t;
   typedef __kernel_ulong_t __kernel_size_t;
   typedef __kernel_size_t size_t;

So it had better remove unnecessary 'always false' expression.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 fs/cachefiles/daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 752c1e43416f..1cfed9e0812a 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -225,7 +225,7 @@ static ssize_t cachefiles_daemon_write(struct file *file,
 	if (test_bit(CACHEFILES_DEAD, &cache->flags))
 		return -EIO;
 
-	if (datalen < 0 || datalen > PAGE_SIZE - 1)
+	if (datalen > PAGE_SIZE - 1)
 		return -EOPNOTSUPP;
 
 	/* drag the command string into the kernel so we can parse it */
-- 
2.20.1

