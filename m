Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B30392A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbhE0JTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhE0JSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:39 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85223C06138D;
        Thu, 27 May 2021 02:17:03 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 27so3244098pgy.3;
        Thu, 27 May 2021 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lrZH3w+e6dzF4yCydRff6CFmaZr+68hvRraxAf7kb/g=;
        b=gEsL8cN/EnTL59MulqPM/BA5mieoGvdasGlL0EBToM8jOhrDzLNmVJernSyGttuIWC
         /PPSjftJ4qchUotxXuXRx3i6HKZOUNKJwIUNZJnBVaEfuhDILP2/kOBYGjMG+CpTnXg+
         Gt41zqh48rWspihRenyBC0b4ko5K4MJGtnstpO9jCXAN6rB5efS5qbISFGpq5OqYyryg
         hhhWFNWdmunJxy/yiYvcAlgQ5vaJeJ4B+BnjCHDyrWDQqEH882w5cBzCCuPqvP7qEwhn
         3XmNTBzM/FGsKQpXZo15kKTY+7l/FpO0FQ317ITnKBxaCbUBWAmU/hZllcy4AnNPV7I5
         v6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lrZH3w+e6dzF4yCydRff6CFmaZr+68hvRraxAf7kb/g=;
        b=uG0TYZQ/MtpONQrFML55EciZLCitLgLZinyNL+h/fBZOfwxhQevR9W4qibBr8Pyp1m
         qhgiQ21SXe/veACpVfwt/eAqMJU5oE7oO/R9xXAOk81joLN0+zXAT6y38pi0QKU2fF5E
         gUhc3wZORTCviOZ7p/9xzWwdHchZZVcxpIayqnDV6KAdL+na6QfU9/EZnLdCCY57DEvR
         VKOBWwtQewIVQk3/umOidizekO3398ZfpgNWC4O50864xTMNxuy2VpisiTJ53YGstqCw
         29VlZq4sNtoKnYVpOTqHE8Sm8t4dK0neUkXgsqAxv5uCnyWPWKS4HwFgnW/yYkiwM5xZ
         V9ig==
X-Gm-Message-State: AOAM532N8ZgR/BeATYCf6J8ocyjImcOWCOvUGruxPRSDH8kJy6kbtIi1
        hBrNIDETdV+/EMalmh7TGnI=
X-Google-Smtp-Source: ABdhPJwlbjRfrP0XzUSRlrnU2RpDdMQvIcFvRGwPCiQOIik0MiV8+T0noUNX2GL9LBGedxElEozoeQ==
X-Received: by 2002:a62:e21a:0:b029:2de:4440:3a with SMTP id a26-20020a62e21a0000b02902de4440003amr2781175pfi.23.1622107023065;
        Thu, 27 May 2021 02:17:03 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:17:02 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 07/13] docs: path-lookup: i_op->follow_link replaced with i_op->get_link
Date:   Thu, 27 May 2021 17:16:12 +0800
Message-Id: <20210527091618.287093-8-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow_link has been replaced by get_link() which can be
called in RCU mode.

see commit: commit 6b2553918d8b ("replace ->follow_link() with
new method that could stay in RCU mode")

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 40b9afec4d60..4650c6427963 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1060,13 +1060,11 @@ filesystem cannot successfully get a reference in RCU-walk mode, it
 must return ``-ECHILD`` and ``unlazy_walk()`` will be called to return to
 REF-walk mode in which the filesystem is allowed to sleep.
 
-The place for all this to happen is the ``i_op->follow_link()`` inode
-method.  In the present mainline code this is never actually called in
-RCU-walk mode as the rewrite is not quite complete.  It is likely that
-in a future release this method will be passed an ``inode`` pointer when
-called in RCU-walk mode so it both (1) knows to be careful, and (2) has the
-validated pointer.  Much like the ``i_op->permission()`` method we
-looked at previously, ``->follow_link()`` would need to be careful that
+The place for all this to happen is the ``i_op->get_link()`` inode
+method. This is called both in RCU-walk and REF-walk. In RCU-walk the
+``dentry*`` argument is NULL, ``->get_link()`` can return -ECHILD to drop out of
+RCU-walk.  Much like the ``i_op->permission()`` method we
+looked at previously, ``->get_link()`` would need to be careful that
 all the data structures it references are safe to be accessed while
 holding no counted reference, only the RCU lock.  Though getting a
 reference with ``->follow_link()`` is not yet done in RCU-walk mode, the
-- 
2.31.1

