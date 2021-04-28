Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6236D1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbhD1GEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:04:49 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:35482 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhD1GEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:04:48 -0400
Received: by mail-lf1-f44.google.com with SMTP id x19so66929172lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvKqJAsDp0hVwDeBdNNZxr3x2/ARRj4tE0SxrkqqX3k=;
        b=nIjabArMB6IQ6gwCjX3sYL/WQ8BG84kcQwJgXYpz5kYQMevtX0jWUth4D1o4OS4VBJ
         OPF7ZIZhnTsZV5n6TUR1ERBCmEzSWhLxKZElmjlI6qOJW05WxZdNz/Cih71EqklhXBju
         KVKegl6vvBntrZGfqMoNFJVMou/CXIr5qpPRJZb4ldF50q+a9qKi/gmGPcDS0hFyzwz/
         flvvLWKF0+7TR/MMq913L7OkuiM9IT3zx8O/gwngo955t7j0Wgv1N8qDHDL97oRUFGlJ
         Eh2x3QXl2wCzR7FGol35R7+S/PGwLAmFg2G+xObMTdZ5k8Be4LnT3qtma+XBSz2YQWgt
         Itbg==
X-Gm-Message-State: AOAM532tWj+vaN0in6rRJSkKbWmxZQba6apIfT03/f8O2FJL1gHoUOmv
        M/Z9E8yzXT64appu90IdfitA83mUjlY=
X-Google-Smtp-Source: ABdhPJw/nA6FH2uObm/AiJzOWE/0qdvWWBNoTXCn5Zk44FXeMnRESfOreomZJGLVLPz2Os3MNmty8w==
X-Received: by 2002:a05:6512:717:: with SMTP id b23mr6357504lfs.210.1619589841375;
        Tue, 27 Apr 2021 23:04:01 -0700 (PDT)
Received: from black.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id b29sm943745ljf.87.2021.04.27.23.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 23:04:00 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] coccinelle: misc: minmax: suppress patch generation for err returns
Date:   Wed, 28 Apr 2021 09:03:50 +0300
Message-Id: <20210428060350.57661-1-efremov@linux.com>
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

