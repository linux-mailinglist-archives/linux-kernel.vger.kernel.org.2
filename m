Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F8143EA01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhJ1VLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhJ1VLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:11:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D26FC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:09:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x66so7104433pfx.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvAgJOQfEFVzMNJ6pTpRCk6uJkv/+zqVfPOtnbD69lw=;
        b=T3kuMS/O8/lUDGCfBIG/ABIs/JPDjd8Dlwy6GWV0UeYUyRUMymB6bHnvLb7irrsWSg
         1qdW+hQvByvBN0llKhbp0H+qMMCuXG1RQjA0Ahi1Et+CytmpcQCRnq5VwlOd01OiPccH
         BFgwDS1OdQlw4VVpprGBTX7cwPI4SxAqCsVO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvAgJOQfEFVzMNJ6pTpRCk6uJkv/+zqVfPOtnbD69lw=;
        b=leSTEQUojzv1ZV+pOVRmub8ZO/r8GHxTecr/6ufu0zhMHewErbvnPpmTh/HrEfFVgK
         t0oPp24l0FtqHnSubLydwSaM9lKVtqpjQGT90m318qMa5bM6qqLb2hRYfp3rAoTjPT6Z
         5DZI5Iqp+OtsiGYI/qymo+CVHx2qDLiQM8CvEXu0s8LtY/XDutqr2o7v+DSQ+YV+IoF+
         hO5Tst0QuDh4Zpf1WCAy/XqPBEDufi/uLhRZ8gWoVm9v0kT19ms0EJWNIGEijdQYvmR5
         qRPi6LlJf5j+yLM9o9B08Qq11LtNlZlF+QlMM8jXqr0WYeUQ0HIxpLafYuy496iSWmyt
         pBXA==
X-Gm-Message-State: AOAM533uyxUW49Mc3Lzqnd4qe2nKD7Fv24qn7VrC+eMvIIRzRsxu1zMd
        Gj3WmwFQWCqietTt7uC6zbmRPg==
X-Google-Smtp-Source: ABdhPJzCuzs0IWvAfIZuo81IgdXZIewO4Ry0D+OV4ERP/f3cPOiPXl/H5Zs82T6KJMNxRNNEVQvwWA==
X-Received: by 2002:a63:3d8c:: with SMTP id k134mr4973634pga.394.1635455350039;
        Thu, 28 Oct 2021 14:09:10 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8610:b491:69a6:2965])
        by smtp.gmail.com with ESMTPSA id z2sm4694248pfh.135.2021.10.28.14.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:09:09 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/gdb: Handle split debug for vmlinux
Date:   Thu, 28 Oct 2021 14:08:49 -0700
Message-Id: <20211028140833.1.Ie6bd5a232f770acd8c9ffae487a02170bad3e963@changeid>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is related to two previous changes. Commit dfe4529ee4d3
("scripts/gdb: find vmlinux where it was before") and commit
da036ae14762 ("scripts/gdb: handle split debug").

Although Chrome OS has been using the debug suffix for modules for a
while, it has just recently started using it for vmlinux as well. That
means we've now got to improve the detection of "vmlinux" to also
handle that it might end with ".debug".

Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 scripts/gdb/linux/symbols.py | 3 ++-
 scripts/gdb/vmlinux-gdb.py   | 0
 2 files changed, 2 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 scripts/gdb/vmlinux-gdb.py

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 08d264ac328b..46f7542db08c 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -148,7 +148,8 @@ lx-symbols command."""
         # drop all current symbols and reload vmlinux
         orig_vmlinux = 'vmlinux'
         for obj in gdb.objfiles():
-            if obj.filename.endswith('vmlinux'):
+            if (obj.filename.endswith('vmlinux') or
+                obj.filename.endswith('vmlinux.debug')):
                 orig_vmlinux = obj.filename
         gdb.execute("symbol-file", to_string=True)
         gdb.execute("symbol-file {0}".format(orig_vmlinux))
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
old mode 100644
new mode 100755
-- 
2.33.0.1079.g6e70778dc9-goog

