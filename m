Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8BB31A36B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhBLRSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhBLRS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:18:28 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1F6C061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:17:47 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id jz15so214611ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4l3MNJF+SXf57n+5Mg8X+4vTNWZXYNx/l+EET96XFKg=;
        b=pNk3Ah0g0GYLSEunUSmdVP8RscQSAn1HhwsqUuT7r5vY1Y8RqkDk1di/VLWgjQ/4Cd
         wCZ7hF86oP2IsExA6IZZ90lKE7Fp5fRy+Vt3a1r03Tdh14IcHGz43IIAP4qAq23h7n2T
         viXjxA6kp7w5THDNZMZwkR6IkIug8LMDX658xh9gBmHHTv/gW9ymS7ERSrz/TIC01U+x
         eGljnWKXVLaTjgcupZm5qhM3p7BrcJYKeQDMZtsMhwxY6P1X9N2e2mWUA8C1EdFi9Qnl
         WQ67EsOiK/gSsmzOKmn8wd0Ap/od7JxeintJIfrM9VQaRC/GqtnGxKTgtR7ZSBmDIgYl
         xgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4l3MNJF+SXf57n+5Mg8X+4vTNWZXYNx/l+EET96XFKg=;
        b=jM6AdUzTNXtD/H4ZzzjAGTaOt9OVNfviydQ0jFqW/DgGbtNN1geupp5XbF61e829Gd
         blbQoDS9NN/nDWEUgPxN6Zjy88QcY8dalK9dnwYLJ9puSfkUZMREtV9V66hYwICq0T2X
         jz/1+3WCjKjYdofhYEzjpq6FkFJzG1VBqOcUCtGAybsTcOMD2YxxP/jeu1gIvcHUwPpL
         cbvS7VD9hY2Vv1rwwsRHiTKWNxx6b/BiXBnxj84shqkJDvmygQZRnleJs4Digh33IR4r
         nOcGDDA6thZ3hFuqikU4Fswh35E+WBb4dv+qRZi4C48tZ43d4ZHOmDUu+tWRYStJ+CSM
         8RZg==
X-Gm-Message-State: AOAM533O3h+CV0ORBnWtUqMADdwID8Esj19KXBvS1I/CXAte3D6DbZ8N
        J6WNuynjOTfFjTi/DraccF1XY8WK3ZMn5wiB
X-Google-Smtp-Source: ABdhPJwRQfSlN2ujSKav/wbqNHCOc1n+FKeTZhO9hiO0/OXHjHcEsyEDKum+dlo7CYKwc6n1YxmqOYdzVUax0bxj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:19dd:6137:bedc:2fae])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:38c3:: with SMTP id
 r3mr4065016ejd.193.1613150265987; Fri, 12 Feb 2021 09:17:45 -0800 (PST)
Date:   Fri, 12 Feb 2021 18:17:38 +0100
In-Reply-To: <7f9771d97b34d396bfdc4e288ad93486bb865a06.1613150186.git.andreyknvl@google.com>
Message-Id: <b0ec98dabbc12336c162788f5ccde97045a0d65e.1613150186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <7f9771d97b34d396bfdc4e288ad93486bb865a06.1613150186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 2/3] MAINTAINERS: update Andrey Konovalov's email address
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use my personal email address.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a58e56f91ed7..7b3d374c858d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9584,7 +9584,7 @@ F:	scripts/kconfig/
 
 KCOV
 R:	Dmitry Vyukov <dvyukov@google.com>
-R:	Andrey Konovalov <andreyknvl@google.com>
+R:	Andrey Konovalov <andreyknvl@gmail.com>
 L:	kasan-dev@googlegroups.com
 S:	Maintained
 F:	Documentation/dev-tools/kcov.rst
-- 
2.30.0.478.g8a0d178c01-goog

