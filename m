Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B6380A66
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhENNcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhENNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:32:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C0AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 06:30:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t11so2628653pjm.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wT0Jn1b/5R6Ec7FJe0n8ikzXhLXxiAZMKP/g+ykPRbA=;
        b=EISTQhVOD5WNxvecVI4DpooL7Jp91OKE+PI+cpXcJP1pNBTjS7pmw+5PZZLOs0yZnF
         o8lbgm+ot7YFXWLN3metN2l9e81zTd0i9Ok4V8Ndclm+ax59GIgr5Bvpb9rIVTLJu08/
         reqeWEoq2rMVjr+u3nyH/7F+ElAx7R6Ci5sfZckE6wNc3r2G1qWSDgkos/K1GEpLAhBX
         e21YttJ8qqGRcMYWS4Bj2hCLDQOL69VfQTLX39zlhAdjW01UD0JwkanFxnwYbzjYbVPS
         MXFItjeBT2VIHud8fNXG95CUege2suTcNpk99hPnSvUdvvPXpjhtyodYQS+EO9lGtnj8
         paIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wT0Jn1b/5R6Ec7FJe0n8ikzXhLXxiAZMKP/g+ykPRbA=;
        b=dpGHu2Vp2j2+EfBGmL8ix1ULZcZewlzcgzPsh7kSmGztA9V7EUvVuczKv67wt8KLWK
         WncXdN3DFLoTANut87toL210XqOpa4UC/9PUHOWOySCKbcHYcEZkFFHYODWccRBbJaf/
         0dc3Ukl1X9KJS1zam3DvnsBZB2uw80XdGL7ScUpYFqoameD0fKhGywqDTrNIqbqObRnp
         etc//P1RtGYfc7tXDQmSqqEexJ2gG8nO1ZEGsy4POKvPLHSsgx2QYXNQ8dvgh7JRJII+
         UAYP206LLnHg7/BxQ9hd7S5MCF0fbA0oRBh39ImXOw3S6EQOQAncWIfnDbL4MGlNzA+w
         bLXw==
X-Gm-Message-State: AOAM531sRgTNGaMP7rtANp9v4TASBmiHscDODs7Hu8rj0eX7guqR5cDb
        qgUdiD48nuwXzdvpDXgLbCg=
X-Google-Smtp-Source: ABdhPJzD0kDjvXw4UTqhdxFfDieKbztEW02uxQJEMRqNtSY5aqeam8PR80RsZ21mhavlxffYq3noZQ==
X-Received: by 2002:a17:90a:d909:: with SMTP id c9mr2754554pjv.190.1620999048263;
        Fri, 14 May 2021 06:30:48 -0700 (PDT)
Received: from fedora.. ([2405:201:6008:61b4:4e16:5348:d963:c66d])
        by smtp.googlemail.com with ESMTPSA id ei9sm5176527pjb.2.2021.05.14.06.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:30:47 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: fix gb_loopback_stats_attrs definition
Date:   Fri, 14 May 2021 19:00:39 +0530
Message-Id: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gb_loopback_stats_attrs macro, (defined in loopback.c,) is a
multiline macro whose statements were not enclosed in a do while
loop.

This patch adds a do while loop around the statements of the said
macro.

Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
---
 drivers/staging/greybus/loopback.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 2471448ba42a..c88ef3e894fa 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
 }									\
 static DEVICE_ATTR_RO(name##_avg)
 
-#define gb_loopback_stats_attrs(field)				\
-	gb_loopback_ro_stats_attr(field, min, u);		\
-	gb_loopback_ro_stats_attr(field, max, u);		\
-	gb_loopback_ro_avg_attr(field)
+#define gb_loopback_stats_attrs(field)					\
+	do {								\
+		gb_loopback_ro_stats_attr(field, min, u);		\
+		gb_loopback_ro_stats_attr(field, max, u);		\
+		gb_loopback_ro_avg_attr(field);				\
+	} while (0)
 
 #define gb_loopback_attr(field, type)					\
 static ssize_t field##_show(struct device *dev,				\
-- 
2.31.1

