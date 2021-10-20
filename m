Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED69434713
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJTIlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:41:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAA4C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:39:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso1954959pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JF15sfNwwfEwBQ657gkVDcUexVAn9CVFnFmWMtipM6Q=;
        b=P1tV1TfA4vmWXVaZ0Llmy0WJERW8JbVK/ln6qsE2H8MgMDDOtR2rAW933nZXfB6col
         9OuvFhvdVmYmukXoDtJd4nFfdzORniU43GaHVeV7TPP/9THRQ5XdAuQ1crLwz7dKnJl0
         4PCzh95+CQQKnVjqPQkku3WHbF31xb4T6LFVmF6uuRal9Rg6c97F+U9lT8T+jwLIFTh/
         8dZrYwOOWgRRP3DJknWBKJidXB7iI/VPCjSmTGohvBPmgSzXxtPLJtgh+9HS9F3XWTgw
         sSPhJu9vENLTIZYFsmlp6B/tU0GBcwrbhaoLLSN6QfdvgzUR+98aFZvoXsAXs0V6JOE8
         Zr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JF15sfNwwfEwBQ657gkVDcUexVAn9CVFnFmWMtipM6Q=;
        b=v+fP9QdkN/w0Rz3txHksVFUwIn4ChjmQTOKnpVaH7kZ2m39EMomMVLZfsWXvKPiE11
         txHoalOeMjG6AyasDJ0k1IYV1N8EzovhYlXgQGkD9O4b1rWcO0PCD4KW4nHR76reAQvm
         gVXf9TUzt1HYIAXe1w/LinA7FREJNXY8LtGhLHMPcU+xKNlt+uyuqxq9i3zuagR2eB/N
         yoe9oRJZRP4Y9fra4dohQgMCDyprjDS3NSozt9d/RhyR2T7z2deHrBR0qDJuXhiotaty
         RKWHVhjQuxxtIwmHlEkA7R677L2/C8fI8PnzcwCMvYUeWP6FqIGiZDaFjuPn7Y1T1MW+
         fcnw==
X-Gm-Message-State: AOAM5307KkBNf6fKjaQ8sU9mY+0XrpSjR7p9VlfwjNhOeOTlCo0ZFdWE
        Y4W2FRh53jVbIEM+ZG+YfA8=
X-Google-Smtp-Source: ABdhPJytxS0qxFzspNFMS7HKZpEy/bvN5PjqcW1VR0yPRotcrtVw0k2PA1KbH2SdsJ8pNXS4QdB8qw==
X-Received: by 2002:a17:90a:c595:: with SMTP id l21mr5838635pjt.188.1634719161666;
        Wed, 20 Oct 2021 01:39:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l29sm1477375pgc.47.2021.10.20.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 01:39:20 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     dyoung@redhat.com
Cc:     bhe@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] crash_dump: fix boolreturn.cocci warning
Date:   Wed, 20 Oct 2021 08:39:05 +0000
Message-Id: <20211020083905.1037952-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

./include/linux/crash_dump.h: 119: 50-51: WARNING: return of 0/1 in
function 'is_kdump_kernel' with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 include/linux/crash_dump.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 0c547d866f1e..979c26176c1d 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -116,7 +116,7 @@ extern void register_vmcore_cb(struct vmcore_cb *cb);
 extern void unregister_vmcore_cb(struct vmcore_cb *cb);
 
 #else /* !CONFIG_CRASH_DUMP */
-static inline bool is_kdump_kernel(void) { return 0; }
+static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
 
 /* Device Dump information to be filled by drivers */
-- 
2.25.1

