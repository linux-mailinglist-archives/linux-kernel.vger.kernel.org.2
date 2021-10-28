Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA6743F270
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhJ1WOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhJ1WON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:14:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E67C061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:11:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso5901327pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0f/QZdJ1qrvvm2X8TGh++QhmZa42tRv4UTvK/ZCSuQ=;
        b=B7h5r8WgIRa7SNrNdv5poCao1B881yc9lpB/apy9LR7DB+bkNr307tWjYxHSzFsyzq
         lk+xUpoyTds/lxjDC/JNFSuVsGKd/6B0Bm4AoVgV9xwJHeqvW8NVQUXVlsMCFvg/UYtK
         1qyCFcmtFNTDgy/iqkO/57WNHH6pYGXvAnCuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0f/QZdJ1qrvvm2X8TGh++QhmZa42tRv4UTvK/ZCSuQ=;
        b=2qOhSbI/fcxZCXjDsY10H1rWG7K68ISq2hM0VrqP1e6qwvJh1IvxP4hy4r/hn3YEzp
         oOdkiKOPHP+PdUPdejdtcOonAy3S3enVzcXu/cHzHtGpvv9yoKZY5dPLc5h8+vL0lp3N
         LH/3qOdkOHzoCou8Y2lx9TxCNXNoKA5qk94th3OgXmuG0+7uwqvt3/TjjS87F7sw2pjm
         3jS+Wag/ZDmbmw+L8+6jWKXOyqF7KORHTPab5j2PxEsvp1Qg3KpCiNQPKA/lE9sfBOJI
         Ny6mHCcK1+Gi32NsWuO6SWbiRejJIGvM7Sbg8G2+Q5gdBvMBSp5y0NXG3kO66LHkhZLB
         LkpQ==
X-Gm-Message-State: AOAM530nmfFXelOvTsaCk0Mo4xulq7tVyEc/knfkvRW7hN/oGjMaCJD+
        z5mcrk7clSLBNYtO2ePfhsB1jP1/5W2gj1qV
X-Google-Smtp-Source: ABdhPJzw2Sj9zNcoXg7+/xcZEJWwdyl6rDmfrImf4aXeUsKtfklW/HEHPdG8jH874kmY4E/bVonj4Q==
X-Received: by 2002:a17:90b:350c:: with SMTP id ls12mr7434988pjb.36.1635459105427;
        Thu, 28 Oct 2021 15:11:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8610:b491:69a6:2965])
        by smtp.gmail.com with ESMTPSA id j6sm3521278pgf.60.2021.10.28.15.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 15:11:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts/gdb: Handle split debug for vmlinux
Date:   Thu, 28 Oct 2021 15:11:38 -0700
Message-Id: <20211028151120.v2.1.Ie6bd5a232f770acd8c9ffae487a02170bad3e963@changeid>
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

Changes in v2:
- Don't accidentally change the file permissions.

 scripts/gdb/linux/symbols.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
-- 
2.33.0.1079.g6e70778dc9-goog

