Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA582359D2A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhDILTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:19:49 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:45715 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhDILTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:19:22 -0400
Received: by mail-qk1-f178.google.com with SMTP id q3so5342579qkq.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 04:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvKqJAsDp0hVwDeBdNNZxr3x2/ARRj4tE0SxrkqqX3k=;
        b=GpD5DgH14pvDjUu+E+sYNVNvwPKIEw7c0yh6sV/GslzIRJSn3THcUjWYOdUbw+APRS
         gh8dqEtVzPf5a0lat3VeTaGhAOEhIQl7LMj1ewHtYK0tmn4UjshJ5AnlWkmUxXycDkTK
         74ZLxHdPwMgWrY1r5T8LnjXciDWTcyovfNF3azlEJEw63U9Wt9rH8E0LuG7yEnsTc7sN
         vE9jQKZBU8Tq76fWMNIFBRJyZKVfSiyww3d/FD048b8y1TAWE9W7q7D/gUWB6l0ICir8
         opsxQqOijUyShEGMAkqF/2ysKgF0JbxN11ihXrIJME0OUlv+eCUr3JFl7x5otWti+SRu
         a0WQ==
X-Gm-Message-State: AOAM530w150Y3hn2YyD0liA6EKxA5dI7WKx0XfsyvMEB5sAOmr3wAiup
        S+Ri6knmjBN/SA0L07WzkYesJm07qo0=
X-Google-Smtp-Source: ABdhPJx+KIR2pImHfdK37dFBAEyNN/sPGbCe45SV/OTloTvqWRvC/EnbCBA1dDuJVN5TKUKRsQ/9Hw==
X-Received: by 2002:a37:5a46:: with SMTP id o67mr7305417qkb.240.1617967148999;
        Fri, 09 Apr 2021 04:19:08 -0700 (PDT)
Received: from black.ru.oracle.com (winnie.ispras.ru. [83.149.199.91])
        by smtp.googlemail.com with ESMTPSA id a8sm1578477qtx.9.2021.04.09.04.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:19:08 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     julia.lawall@inria.fr
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: misc: minmax: suppress patch generation for err returns
Date:   Fri,  9 Apr 2021 14:19:02 +0300
Message-Id: <20210409111902.7561-1-efremov@linux.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a standard idiom for "if 'ret' holds an error, return it":
	return ret < 0 ? ret : 0;

Developers prefer to keep the things as they are because stylistic
change to "return min(ret, 0);" breaks readability.

Let's suppress automatic generation for this type of patches.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/minmax.cocci | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
index eccdd3eb3452..fcf908b34f27 100644
--- a/scripts/coccinelle/misc/minmax.cocci
+++ b/scripts/coccinelle/misc/minmax.cocci
@@ -116,16 +116,32 @@ func(...)
 	...>
 }
 
+// Don't generate patches for errcode returns.
+@errcode depends on patch@
+position p;
+identifier func;
+expression x;
+binary operator cmp = {<, <=};
+@@
+
+func(...)
+{
+	<...
+	return ((x) cmp@p 0 ? (x) : 0);
+	...>
+}
+
 @pmin depends on patch@
 identifier func;
 expression x, y;
 binary operator cmp = {<=, <};
+position p != errcode.p;
 @@
 
 func(...)
 {
 	<...
--	((x) cmp (y) ? (x) : (y))
+-	((x) cmp@p (y) ? (x) : (y))
 +	min(x, y)
 	...>
 }
-- 
2.30.2

