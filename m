Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C030E315B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhBJA3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbhBIU47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:56:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3026C061794
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:03:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d2so2227351pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delphix.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3O/mqypFsO3O218VUQ7AaVDZ9919y4ACFmjTnjCZTqU=;
        b=dMOEzna3+iazmZ7hOhH5wTI57l3vPWBgjjhR0ERX4wB2uI9yQwzXvvpwDSyNrk4kAS
         Ike6XHQPYvTVdFZqE2hghkphFy1KuTuuL8HYTGNwPGCwtq46I4efHQ45krOKYKhEVo2U
         Nl6v0Qfa6QJYBrAe4J7yvW04ZwVsrizxNOWR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3O/mqypFsO3O218VUQ7AaVDZ9919y4ACFmjTnjCZTqU=;
        b=liWggmpdVloXROcYD6EEOrDfnCYuuEQ5W0HZL0a4ZLaKFhCrjeQUrct6DMQvj6NcGL
         gjWA6DVxsLCIrJ8i6oAI5C+rs4VNgP5oWx+M4qivPBJZhjebAhDLvsBgSIJ7PsommJL2
         me0S9MBTOx2Syb2oLj1r7KJ9wR38uzlkTK8D4Xfu+QmCinfp5DVauay1yFCHUJ2lE83p
         JhxEx19MqtV9yUuJ0+ylHz8NiFblfbv2D3yy5G4qyh13qdQ/m4LBCTG2yHbmEiP7H9ZD
         CLfpjHiZByi/RIPPO/jpyaP4M9mHNJBSqfOhCGTuVz4fObmbkp1AbPI7E4yzi1bfvqF8
         EuAg==
X-Gm-Message-State: AOAM531BKJpMbCWmgccMXVNSdRKKVAUFzVuWthTcPS9UIdn2cyvC06XA
        qzKO/J7EYnyDLw1PlptWC+WtNg==
X-Google-Smtp-Source: ABdhPJyfvEp5pATS1gcO5Hh3siii2AtaO2ih6dLkADvoH4jvuRkVkIv4v+Ll+vt/8Rk0YVkUBGGZfg==
X-Received: by 2002:a17:902:c284:b029:e1:8863:b3d6 with SMTP id i4-20020a170902c284b02900e18863b3d6mr22312104pld.64.1612897400252;
        Tue, 09 Feb 2021 11:03:20 -0800 (PST)
Received: from sd-kernel.dcol2.delphix.com (DELPHIX-COR.ear1.SanJose1.Level3.net. [4.15.123.66])
        by smtp.googlemail.com with ESMTPSA id 123sm23324903pfd.91.2021.02.09.11.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:03:19 -0800 (PST)
From:   Serapheim Dimitropoulos <serapheim.dimitro@delphix.com>
X-Google-Original-From: Serapheim Dimitropoulos <serapheim@delphix.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, osandov@osandov.com,
        urezki@gmail.com, serapheim@delphix.com
Subject: [PATCH v2] mm/vmalloc: use rb_tree instead of list for vread() lookups
Date:   Tue,  9 Feb 2021 19:02:53 +0000
Message-Id: <20210209190253.108763-1-serapheim@delphix.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vread() has been linearly searching vmap_area_list for looking up
vmalloc areas to read from. These same areas are also tracked by
a rb_tree (vmap_area_root) which offers logarithmic lookup.

This patch modifies vread() to use the rb_tree structure instead
of the list and the speedup for heavy /proc/kcore readers can
be pretty significant. Below are the wall clock measurements of
a Python application that leverages the drgn debugging library
to read and interpret data read from /proc/kcore.

Before the patch:
-----
$ time sudo sdb -e 'dbuf | head 3000 | wc'
(unsigned long)3000

real	0m22.446s
user	0m2.321s
sys	0m20.690s
-----

With the patch:
-----
$ time sudo sdb -e 'dbuf | head 3000 | wc'
(unsigned long)3000

real	0m2.104s
user	0m2.043s
sys	0m0.921s
-----

Signed-off-by: Serapheim Dimitropoulos <serapheim@delphix.com>
---
Changed in v2:

- Use __find_vmap_area() for initial lookup but keep iteration via
  va->list.

 mm/vmalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 49ab9b6c001d..eb133d000394 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2860,7 +2860,10 @@ long vread(char *buf, char *addr, unsigned long count)
 		count = -(unsigned long) addr;
 
 	spin_lock(&vmap_area_lock);
-	list_for_each_entry(va, &vmap_area_list, list) {
+	va = __find_vmap_area((unsigned long)addr);
+	if (!va)
+		goto finished;
+	list_for_each_entry_from(va, &vmap_area_list, list) {
 		if (!count)
 			break;
 
-- 
2.17.1

