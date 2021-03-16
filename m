Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5DF33CD93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhCPFsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbhCPFry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:47:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE052C06174A;
        Mon, 15 Mar 2021 22:47:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so829796pjg.5;
        Mon, 15 Mar 2021 22:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrX0uA71OowVyTTnDGqfDijFuUtJZKHnFh7xg6V5Bok=;
        b=i8VnZicj1pSZQzZEwopyvE3RECtFTK4njnSLZbA0Zm1qdsSvu/U9K6T8q3agAaM3f7
         8c6aIa3mrHyLsECmtwAA9CCUjT8ZuvVf1MHHf1ydKRO8WGIhlZVO+A3wiYzpSKodSJNf
         4t22cGLmF6TRKpvLi5r5m4SmVMgjwgZ22/Cw9TpJxbH4jhHx30m1/qJ7xGVjTJ+EKjCK
         fg3NvJYPU8bKqijkvwP+qc0e5CnYL4b5KZKZ/BLlYttX/iXp2Q0WPedKIFDUaEmtDjvb
         CYVXLCMcGceHG9TZsOMY+c//37pGByGuMnLXnGkVURiCtcYBdpdjSfTgEkKIDUBAPLq0
         xHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrX0uA71OowVyTTnDGqfDijFuUtJZKHnFh7xg6V5Bok=;
        b=qHTBB/ZKm7w0UGisyhITowV2/pqNfgrDWsYlgAZCDalJxRk87yLFldmsbYcQh01kG3
         FS+DZHMlFyJS+o/EU8GcJ360BXJirRxiNZav3kgnyv1QvFezxNr6WeeGZL8mfN45mKRs
         DwV2MIl5WB5ZfmMVyCrOJIYDdKyiZwZOANiz00px/XzI4DKa8UE5MsmpYSBPaXRRext6
         px6AzlPdUMsWgd5ibjVLQRocXDPFXdDEjZlZBjMaVvGBGvFg0jINhWZ7JwMiaDipkj4P
         DnjMxqf31vK6Cck0lLlOc+xlPA+iFTMdsGggvYYzTjHrHWN4eVQM5ok++Zj9w1ACdyor
         gUTA==
X-Gm-Message-State: AOAM533O+YwUZuhyMOaU1hTA9aqXjGJ95CP8Vh0bZZP9k7okSSYG6a7n
        buvRhRH3SYOGzVf3OSCiYe4=
X-Google-Smtp-Source: ABdhPJxX5LBIeretrB4Fk8jvMzMoJmkNNwDxybbEW4HxFHOyDyyqRHUHLy/fe6PK8saXD9i8NReOiQ==
X-Received: by 2002:a17:902:a617:b029:e5:b41e:4d7b with SMTP id u23-20020a170902a617b02900e5b41e4d7bmr15782600plq.33.1615873673485;
        Mon, 15 Mar 2021 22:47:53 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l22sm15096513pfd.145.2021.03.15.22.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:47:53 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 05/12] docs: path-lookup: remove filename_mountpoint
Date:   Tue, 16 Mar 2021 13:47:20 +0800
Message-Id: <20210316054727.25655-6-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No filename_mountpoint any more
see commit: commit 161aff1d93ab ("LOOKUP_MOUNTPOINT:
fold path_mountpointat() into path_lookupat()")

Without filename_mountpoint and path_mountpoint(), the
numbers should be four & three:

"These four correspond roughly to the three path_*() functions"

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index a65cb477d524..66697db74955 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -652,9 +652,9 @@ restarts from the top with REF-walk.
 
 This pattern of "try RCU-walk, if that fails try REF-walk" can be
 clearly seen in functions like ``filename_lookup()``,
-``filename_parentat()``, ``filename_mountpoint()``,
-``do_filp_open()``, and ``do_file_open_root()``.  These five
-correspond roughly to the four ``path_*()`` functions we met earlier,
+``filename_parentat()``,
+``do_filp_open()``, and ``do_file_open_root()``.  These four
+correspond roughly to the three ``path_*()`` functions we met earlier,
 each of which calls ``link_path_walk()``.  The ``path_*()`` functions are
 called using different mode flags until a mode is found which works.
 They are first called with ``LOOKUP_RCU`` set to request "RCU-walk".  If
-- 
2.30.2

