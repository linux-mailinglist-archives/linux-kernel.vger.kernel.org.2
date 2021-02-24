Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697E2324022
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbhBXOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhBXNUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:20:42 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F65EC06121C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:18:45 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id n19so489128ooj.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QMkH64M8As4l+KSDTQdK+u4M5qrIN7PaZOHlR51wic=;
        b=QmN0FsJYiPxmCNa2Tha1APhsUK8o/7UaZLHeTlgpjASwj19luMRyZbWjrLxbXnOWSq
         QX3Widqm0McOoSM3HTXHxcQmOE55BROws/lIjp65Idz5F6TUFsQCip3AEZUVrDi4802W
         a1DgYxiomsD1lW1EmR4QuPaF4FxC5XnzYOdkw7NhBJMriRHA9/xsyO/aNXKB4gX+Akwl
         XZDq3lTBz1baGF2HPr2Zj2AtovQtHjgyajNkzw0upFslmhr/BtBhrG2tOL3fl4ZgMHp+
         eyKWP2uXQHTgp4Q/AvKzKs1YWSL4aGdSzROSCh8GqzzcYz7IiSTyQg3cPlVOLhACAypy
         MH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QMkH64M8As4l+KSDTQdK+u4M5qrIN7PaZOHlR51wic=;
        b=r+uK2+2sF/kUB4D4kkMjb39B0mZ+KONPlqeBFeWTwHObTUe+dQsx/PWarvsMD8pfs/
         +wwvtlZp68RDb9A1QxrXoYnKffUzYgGRbFbf/jW1dWXJbbtTYGi5Ea++wLTm03mj02Pt
         bqNNddTmQa8YJVJyERBENwOlG+cyy2/n+j+9FST2N5xO9G6G2x3fxuhX3pnMsTf6yBCn
         5brXBijL0AsHQHQmrBBQig9s2BEwP6ZVJRMI0iBLAEfPz3yTJgOcrIl1Y2jlKaWAm3zj
         iIqFGvtYYQO/c5/U9g3/C1GaF2B1vFa+ApvSOpjt8+N7TgaRyYhYP3ViDqxu8yNI5gic
         Se3Q==
X-Gm-Message-State: AOAM5332/d/wgzZ2VaFR1zErQ25zR2qxoC/42QJjfxiQTnayTWtQl4MG
        VGYxsbP3jyTQMrwZ9RdisQ7djQ==
X-Google-Smtp-Source: ABdhPJzZENaJ/w4FIbF/u86i6KIgI4boKlF8cypFxWZArBN+CEJ43ycBpfR7AD/CKXEZpGzOO2u34Q==
X-Received: by 2002:a4a:c44:: with SMTP id n4mr23749084ooe.62.1614172725035;
        Wed, 24 Feb 2021 05:18:45 -0800 (PST)
Received: from winterfell.papolivre.org (winterfell.papolivre.org. [198.58.116.17])
        by smtp.gmail.com with ESMTPSA id b21sm380149oot.34.2021.02.24.05.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:18:44 -0800 (PST)
Received: from localhost (unknown [IPv6:2001:1284:f016:4cfd:27e0:441e:870:6787])
        by winterfell.papolivre.org (Postfix) with ESMTPSA id 7BFBE1C2F43;
        Wed, 24 Feb 2021 10:18:43 -0300 (-03)
From:   Antonio Terceiro <antonio.terceiro@linaro.org>
To:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH] Documentation: cgroup-v2: fix path to example BPF program
Date:   Wed, 24 Feb 2021 10:16:31 -0300
Message-Id: <20210224131631.349287-1-antonio.terceiro@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file has been moved into the "progs" subdirectory in
bd4aed0ee73ca873bef3cb3ec746dd796f03df28, together with all test BPF
programs.

Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jiong Wang <jiong.wang@netronome.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index c513eafaddea..befe9425d028 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2094,7 +2094,7 @@ If the program returns 0, the attempt fails with -EPERM, otherwise
 it succeeds.
 
 An example of BPF_CGROUP_DEVICE program may be found in the kernel
-source tree in the tools/testing/selftests/bpf/dev_cgroup.c file.
+source tree in the tools/testing/selftests/bpf/progs/dev_cgroup.c file.
 
 
 RDMA
-- 
2.30.1

