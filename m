Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52766331709
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhCHTMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:12:51 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:36169 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCHTMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:12:34 -0500
Received: by mail-lf1-f54.google.com with SMTP id f1so22801885lfu.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 11:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afP4kefJJSWnfkTP8BQ+r54P2vlw+syUq9XfIeAB8YE=;
        b=iZGvwnkw188Y1qfp8Dr5JLjSV7c1DcV/moG7E36v0fLZkGibmMLIn9MNvoJQyL19TY
         e7KTSZJCiRicJAlZM/F3nn+qAPEAcrUN8o6B/2NEZ8NccsKBk8KFFKHCppadK5ItUUpv
         4aUCR28/XVpxAe/vkMGxXZ5A0NKE8kwtJaQ5PuM9IT3QCLpwdRAhfxg9KiCH+AX/u07J
         fOoXLgX6B+WZ4/tDgeSspEv73O6Ew8q4waHC7QZCRiS8hV2HyCMwTM0UkqZNwcAe5Ibe
         vmrbiqA9oqLAFu+5XwYIb9Mr+exhGCk1k772iF+MTj5wdmBIHJdKJuRmKXtJTDH+VCz2
         6RsA==
X-Gm-Message-State: AOAM533aZ7VjJymVnjpCIhps0BJlRU6keR5gcRo+K9YeoBwQAnFQk81z
        5AURbjhCDIPrW+y4BiIAGFY=
X-Google-Smtp-Source: ABdhPJyqo5t9w7K5r1yW96oN4dU+gW41inH3X6zO8ESg5vkEij9UFT340CdfCZ0k0aEBrPFSQTmqVg==
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr16001088lfg.140.1615230753711;
        Mon, 08 Mar 2021 11:12:33 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id p9sm1603298ljn.16.2021.03.08.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 11:12:33 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: misc: restrict patch mode in flexible_array.cocci
Date:   Mon,  8 Mar 2021 22:12:15 +0300
Message-Id: <20210308191215.1362498-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip patches generation for structs/unions with a single field.
Changing a zero-length array to a flexible array member in a struct
with no named members breaks the compilation. However, reporting
such cases is still valuable, e.g. commit 637464c59e0b
("ACPI: NFIT: Fix flexible_array.cocci warnings").

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/flexible_array.cocci | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
index 947fbaff82a9..f427fd68ed2d 100644
--- a/scripts/coccinelle/misc/flexible_array.cocci
+++ b/scripts/coccinelle/misc/flexible_array.cocci
@@ -51,21 +51,40 @@ position p : script:python() { relevant(p) };
   };
 )
 
+@only_field depends on patch@
+identifier name, array;
+type T;
+position q;
+@@
+
+(
+  struct name {@q
+    T array[0];
+  };
+|
+  struct {@q
+    T array[0];
+  };
+)
+
 @depends on patch@
 identifier name, array;
 type T;
 position p : script:python() { relevant(p) };
+// position @q with rule "only_field" simplifies
+// handling of bitfields, arrays, etc.
+position q != only_field.q;
 @@
 
 (
-  struct name {
+  struct name {@q
     ...
     T array@p[
 -       0
     ];
   };
 |
-  struct {
+  struct {@q
     ...
     T array@p[
 -       0
-- 
2.26.2

