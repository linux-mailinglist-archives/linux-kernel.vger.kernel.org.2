Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C61341388
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhCSDg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhCSDgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:36:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BCBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:36:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l123so4927835pfl.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YThJXKoad88QyIUzJQjgHEKYHEHZlB/t9+1Xws9BWbo=;
        b=VD/B9cBb2K0S5lmYwaCJosnP9TGGztKB/20JQ/fkjVjsoPdByO4kUXUEqrDflhCX+C
         HPiW2HJantqBOkGpty+EeKd1wDi1qXyxhree4Xy3osahOFJDq2flVQZcRIg5vZKsnMI9
         Folr58pqKFC1vWRJZan8ui7JUGvSXLHCgcRVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YThJXKoad88QyIUzJQjgHEKYHEHZlB/t9+1Xws9BWbo=;
        b=IWGjsY98poY4hLVeyNouA//m7SJbESnxVfZJJkTN9t7udZiFEwLmto8shUzpNl/erX
         ra298jVP3AWbytKGa+MIxGOP0nG0mc331BrkaiuI4E/EGeM03RxpZR8oq8fasNBxKmi4
         WlMD6xU5cPSRcpqxCpLbQIjHuUEtZ6R9MUyLWhonZTzqfFuVlrM6wjsWz8h606BVXGU9
         xE7hjmKBEj6HwaE99u9PHt6CQSGZUvwUSPG/gvd1aiiJp6xu+RyvSygLKqpemiMmJV7a
         zOi0TPXpWv1MO2rwAVm455rtJtd4B3E0zwM8MJohn7HCfZWXic5lE25byY5znSnaJEkz
         m4Sw==
X-Gm-Message-State: AOAM533b5xnoYFVJvmW3e3HO66A8fm8ggophqTPjWS0w/yPWQgAgNJTM
        eKFAj8PkanHSuNmS/ni21XGZmg==
X-Google-Smtp-Source: ABdhPJxcgUFvELXlvjD3ZpIDWD4ma+4r1W70Db0GBPaVPBvvUcnVbbUp9j1C3AIHlM2Zid/+2jEi5g==
X-Received: by 2002:a62:5b43:0:b029:1ef:21ad:846 with SMTP id p64-20020a625b430000b02901ef21ad0846mr7206410pfb.51.1616125000617;
        Thu, 18 Mar 2021 20:36:40 -0700 (PDT)
Received: from evanbenn1.syd.corp.google.com ([2401:fa00:9:15:d0d6:1466:f005:1b0a])
        by smtp.gmail.com with ESMTPSA id z2sm3909741pfq.198.2021.03.18.20.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 20:36:40 -0700 (PDT)
From:   Evan Benn <evanbenn@chromium.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Evan Benn <evanbenn@chromium.org>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/coccinelle: Add script to detect sign extension
Date:   Fri, 19 Mar 2021 14:36:15 +1100
Message-Id: <20210319142952.1.I2c82789dba4e68d61595862188e8bf4d31a05d38@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am attempting to create a coccinelle script that will detect possibly buggy
usage of the bitwise operators where integer promotion may result in bugs,
usually due to sign extension.

I know this script needs a lot more work, but I am just beginning to learn the
syntax of coccinelle. At this stage I am mainly looking for advice if this is
even worth continuing, or if I am on the wrong track entirely. 

Here is an example of the bug I hope to find:

https://lore.kernel.org/lkml/20210317013758.GA134033@roeck-us.net/

Where ints and unsigned are mixed in bitwise operations, and the sizes differ.

Thanks

Evan Benn

Signed-off-by: Evan Benn <evanbenn@chromium.org>
---

 .../coccinelle/tests/int_sign_extend.cocci    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 scripts/coccinelle/tests/int_sign_extend.cocci

diff --git a/scripts/coccinelle/tests/int_sign_extend.cocci b/scripts/coccinelle/tests/int_sign_extend.cocci
new file mode 100644
index 000000000000..bad61e37e4e7
--- /dev/null
+++ b/scripts/coccinelle/tests/int_sign_extend.cocci
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Mixing signed and unsigned types in bitwise operations risks problems when
+/// the 'Usual arithmetic conversions' are applied.
+/// For example:
+/// https://lore.kernel.org/lkml/20210317013758.GA134033@roeck-us.net/
+/// When a signed int and an unsigned int are compared there is no problem.
+/// But if the unsigned is changed to a unsigned long, for example by using BIT
+/// the signed value will be sign-extended and could result in incorrect logic.
+// Confidence:
+// Copyright: (C) 2021 Evan Benn <evanbenn@chromium.org>
+// Comments:
+// Options:
+
+virtual context
+virtual org
+virtual report
+
+@r@
+position p;
+{int} s;
+{unsigned long} u;
+@@
+    s@p & u
+
+@script:python depends on org@
+p << r.p;
+@@
+
+cocci.print_main("sign extension when comparing bits of signed and unsigned values", p)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0],"sign extension when comparing bits of signed and unsigned values")
-- 
2.31.0.291.g576ba9dcdaf-goog

