Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807BD429BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 04:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhJLC4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 22:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhJLC4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 22:56:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF7DC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 19:54:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h125so6400197pfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 19:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKJnA5NF30yiSIOBJ/WFWfFlApvFg/r+hUnj4scm1Sc=;
        b=XhbSBK6BaqEC32ReNHa1khoCRrvtKhfJNbDAbw3pxmeHTSW1AQClTNlN+H/FXL6E7+
         2ZfHJxUdjEp1E35VqLU3yW61sCbnQpfCtcuOADqYi1CS6ZqKq5u3vS0LEDh1gfYEWuo0
         13xB4ijJweTVBKHYMd1FawYnq4xdeXQj1snSs65n1Q/MuuEfab3lb3MXjP6ZhtG66FI/
         1prhqYCX88mRtepUGBtJ0tfOua3YRZlS0yXTnPXMVuFZ5nNnzp5jfO8+acVJFEjcJKjN
         GXPx8rRGTdzCCVhqXIQdhM9zy6julTB+mDfqUag0a26ILn57sBWhVi/eiELFDHTNpL1P
         P67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKJnA5NF30yiSIOBJ/WFWfFlApvFg/r+hUnj4scm1Sc=;
        b=GL0C58wsz4FzFADQeKYzN3YjUp1KqUQrtNyVr828G3EamfPr6tVZw4k/aeELK5aVK+
         XeH3mQ45bk5UwoKi/AInEm/Or+vHPFzy62K8MJdWruEKMUxyv9vObv/s8cxAWDPAwQJg
         d0b310iBgWAws7jMnV6R/6oIFlly5IBu9cmhfJVX9d8qF08JHCEXGBJZg9DHpbgDma86
         qXkTdrGafHfv2ccP0s+Sg4N4J1CXnHl8XQ2ni+sEhrCd9+3PJYp4FlH8FbxzO99496m/
         Lzb4DZY9qShuO1665yLe8I3R18GMGNffloVqIoFRTNlRVRVIAkhhExxm0R0Evz9WFsRv
         jKuA==
X-Gm-Message-State: AOAM530c+tlBaPEhPTJY3MrZMIhByEMUCFXj8F+buec4LN+azrqqZNih
        nMebvzn8ijfCuLlSEz0x0vw=
X-Google-Smtp-Source: ABdhPJxLs1zzxAy73Uwm6hcUndLFmG68+MSHQYsxavP3S/vZn/IZ8IC8FrG6fE5gnUjquWng2+O82A==
X-Received: by 2002:a62:1450:0:b0:44c:7681:90b9 with SMTP id 77-20020a621450000000b0044c768190b9mr29428814pfu.42.1634007279717;
        Mon, 11 Oct 2021 19:54:39 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id b10sm8992490pfi.122.2021.10.11.19.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 19:54:39 -0700 (PDT)
From:   davidcomponentone@gmail.com
To:     Viktor.Rosendahl@bmw.de
Cc:     rostedt@goodmis.org, colin.king@canonical.com,
        davidcomponentone@gmail.com, vulab@iscas.ac.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] Fix application of sizeof to pointer
Date:   Tue, 12 Oct 2021 10:54:24 +0800
Message-Id: <20211012025424.180781-1-davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Yang <davidcomponentone@gmail.com>

The coccinelle check report:
"./tools/tracing/latency/latency-collector.c:1541:10-16:
ERROR: application of sizeof to pointer"
Using the "strlen" to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 tools/tracing/latency/latency-collector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index 3a2e6bb781a8..b131007e6c70 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -1538,7 +1538,7 @@ static void tracing_loop(void)
 				mutex_lock(&print_mtx);
 				check_signals();
 				write_or_die(fd_stdout, queue_full_warning,
-					     sizeof(queue_full_warning));
+					     strlen(queue_full_warning) + 1);
 				mutex_unlock(&print_mtx);
 			}
 			modified--;
-- 
2.30.2

