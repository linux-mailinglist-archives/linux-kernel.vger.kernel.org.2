Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69EC30EDDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhBDH5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhBDH5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:57:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A9C061573;
        Wed,  3 Feb 2021 23:56:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o10so5364728wmc.1;
        Wed, 03 Feb 2021 23:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b+smnUyuE7wK61OgxqWN7JVnQDJSBJSmIoedEWNjQv4=;
        b=s5Hf5E+rBCWZ6lRhqA35/hsHYMsvRS1rLqs+8SxZdi52f3gQJ8KmS0z2Gz6LIUsgrb
         qRMhVECrHyifJ7sTr91bEZ+8ZpmGsx2Zrx1qwPiVjxwFHhCr22xfguXx3M2Y7MuG+AuC
         GQvsG/535ao/vjz0sTbkXd+Nq1Yn8vfWZB+b5PZiAkxJBrp0kIDHrRc6MeRVoIKaC0Qt
         /RHPQ/JfqLQhAMjpyWKKmW58lzbDXyrjgBmHrxbEs349gkTxOnvVEy0zjC9CoXVVHTiB
         uQcfN3OUyXAgtYv7bd2UamUqKKRK/mF7f0YuiMGyEU+iXAFvw4QY7XQndoMpSC2Ky5lj
         SKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b+smnUyuE7wK61OgxqWN7JVnQDJSBJSmIoedEWNjQv4=;
        b=NX4aXkJDyHvqdcjl3Yn8cpsY6FjD48SHgrQrJdJaPb7FWr7+6NsKBgusSeH8eBKvsi
         gFmhE7l3q03ohDqjlRjnBNo+n3dXhgFjkdDKzUmocyxZ2LZTNCVRkX3KcLXPFKgIyS6n
         iEFqYS6FjW7SuktKFrikk6wRdnoyDpRD69WNjziufqmDlbaMBO2gh1+YPoQl4puKYS22
         q5F/sATfI4VW6RBtGz9p0q6Yc+rAXmCQdgpP4fd0ROAVT7BdSCRC8njdaFaUOfQi6lsJ
         Hjr9hgKbC0re7HKCFHfY5wfzgTycXgNuHMVxceGRkamjCc1je3KxMyVstaqbjXu173BA
         FZMA==
X-Gm-Message-State: AOAM5308nlfWSzZbXYMceKWDJiTqBtCceU2s0j591ZUJTY+PdzDM7qI6
        BZFS+DSo+tiv2XPqLYJ5ldI=
X-Google-Smtp-Source: ABdhPJznv8dlGhVT1RXWZc2O8Gbutrctv0DjJ0d2As5aR/nFBLQC467b/jdjfyj7wKr51SBKpu1FgA==
X-Received: by 2002:a1c:7704:: with SMTP id t4mr6089144wmi.55.1612425395879;
        Wed, 03 Feb 2021 23:56:35 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de7:9900:a89a:b345:dd05:c439])
        by smtp.gmail.com with ESMTPSA id v1sm5307806wmj.31.2021.02.03.23.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 23:56:35 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] fscache: rectify minor kernel-doc issues
Date:   Thu,  4 Feb 2021 08:56:24 +0100
Message-Id: <20210204075624.27915-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command './scripts/kernel-doc -none include/linux/fscache.h' reports
some minor mismatches of the kernel-doc and function signature, which are
easily resolved.

Rectify the kernel-doc, such that no issues remain for fscache.h.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20210202

David, please pick the quick kernel-doc fix.

 include/linux/fscache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 3f177faa0ac2..7e1f12e52baf 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -418,7 +418,7 @@ int fscache_pin_cookie(struct fscache_cookie *cookie)
 }
 
 /**
- * fscache_pin_cookie - Unpin a data-storage cache object in its cache
+ * fscache_unpin_cookie - Unpin a data-storage cache object in its cache
  * @cookie: The cookie representing the cache object
  *
  * Permit data-storage cache objects to be unpinned from the cache.
@@ -490,7 +490,7 @@ void fscache_wait_on_invalidate(struct fscache_cookie *cookie)
 /**
  * fscache_reserve_space - Reserve data space for a cached object
  * @cookie: The cookie representing the cache object
- * @i_size: The amount of space to be reserved
+ * @size: The amount of space to be reserved
  *
  * Reserve an amount of space in the cache for the cache object attached to a
  * cookie so that a write to that object within the space can always be
-- 
2.17.1

