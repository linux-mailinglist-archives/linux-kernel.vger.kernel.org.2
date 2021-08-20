Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548A63F3656
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhHTWWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhHTWWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:22:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDBEC061575;
        Fri, 20 Aug 2021 15:21:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bo19so15999602edb.9;
        Fri, 20 Aug 2021 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LmC4pHUKq1bqJlftV61OMuVHYGQCbfuueh2JF5yi9TA=;
        b=ovyShiamyiOOKaO+kY8Y+1SOVaMfGq366rwPSBcgC6eWNDAjfDeA8VlFMNaZQinpze
         ZVlP64A/8Tzk9QR18thEkyOKFZklNpL2AzDMhKLe1Ek2md52HHN3/0HGZE2NwE4cA488
         zX0ELrX1XbV8vbaviHXkdkBh9C9luvPwuO94lhlCAt2XvZmagJ0TBZhIXQ/5C/f5ouit
         X6Oxse010Ys5bYXoYKvFQNZL7repIk3VrtcLmz+nrxD0oTY9FjbcUzTwfjL/I4FmA7Y8
         BNMKzrOdxnXohF7+ONNneD9atus/SwFCd0yqfrI9IjRtAoo8Frvpjw3QEmj/XlfPA7Cs
         vr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LmC4pHUKq1bqJlftV61OMuVHYGQCbfuueh2JF5yi9TA=;
        b=HF6/KbaAJyGFeTaFGn6SNGzmVTSJvLh21OERUHWG7pnrHYg634SHLewken699Px9Q0
         g+qyMqWGHnoMfnSyRPw/BOOlRLELPK8o+J2U4HkDMoOiXP/pVFakxPHxKjypBBXPK9xe
         dpcSumHkMBXAC5qW8zB9AyTXW7xoKnTA4/TrtdcKTKjlSp3bV8dfnIF1ulWxbLWBpAC5
         Vdtewh8VSZ052+iKuQE8lLmT/AUbsXeu3yc5/ZZtxSxf8sDI9WXkJf5jH5byRYbQHLzJ
         Xl2VzFN/dlNSXI5pcd3A+ZL6P0ItPfn5y6EJStPZtA/YU41My8OEcPzmmrlk4+MtKbJK
         yYIw==
X-Gm-Message-State: AOAM530DlezOgRmAVIV2BMZ4ydomMXG+5gwN5NZWIQ8AKjikglWEcVPc
        QJX0upZta0cBlacNbKn60+Hdq4zHr/A=
X-Google-Smtp-Source: ABdhPJw2kkwdCHP3NrJ9AfF9cMtrmNlojXLT8wR2hVdeVpd28NqQsUUMFwU4jExa5+jmbTCUAqCcKw==
X-Received: by 2002:a05:6402:2926:: with SMTP id ee38mr24614073edb.95.1629498115688;
        Fri, 20 Aug 2021 15:21:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:21b0:9002:7dca:dea6:32ff:fe9d:5ad6])
        by smtp.gmail.com with ESMTPSA id l9sm4330166edt.55.2021.08.20.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:21:55 -0700 (PDT)
From:   Chun-Hung Tseng <henrybear327@gmail.com>
To:     corbet@lwn.net
Cc:     jmseyas@dit.upm.es, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, henrybear327@gmail.com
Subject: [PATCH v3] Documentation: Update details of The Linux Kernel Module Programming Guide
Date:   Fri, 20 Aug 2021 22:21:52 +0000
Message-Id: <20210820222152.971174-1-henrybear327@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, the content and examples of the book "The Linux Kernel Module
Programming Guide" are being actively maintained and added on Github[1].
Currently, the book is being regularly built into webpage and pdf
file using Github static page[2].

[1]: https://github.com/sysprog21/lkmpg
[2]: https://sysprog21.github.io/lkmpg/

Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
---
 Documentation/process/kernel-docs.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 22d9ace5df2a..dd911cf09b55 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -126,15 +126,17 @@ On-line docs
         describes how to write user-mode utilities for communicating with
         Card Services.
 
-    * Title: **Linux Kernel Module Programming Guide**
+    * Title: **The Linux Kernel Module Programming Guide**
 
-      :Author: Ori Pomerantz.
-      :URL: https://tldp.org/LDP/lkmpg/2.6/html/index.html
-      :Date: 2001
+      :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
+      Jim Huang.
+      :URL: https://sysprog21.github.io/lkmpg/
+      :Date: 2021
       :Keywords: modules, GPL book, /proc, ioctls, system calls,
         interrupt handlers .
-      :Description: Very nice 92 pages GPL book on the topic of modules
-        programming. Lots of examples.
+      :Description: A very nice GPL book on the topic of modules
+        programming. Lots of examples. Currently the new version is being
+        actively maintained at https://github.com/sysprog21/lkmpg.
 
     * Title: **Global spinlock list and usage**
 
-- 
2.25.1

