Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8085133CD98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhCPFse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbhCPFr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:47:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E76FC06174A;
        Mon, 15 Mar 2021 22:47:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a13so1321856pln.8;
        Mon, 15 Mar 2021 22:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtuJokPeDEKHjFBjlX+6+q1iW8IGangHbU2n+5YDhZI=;
        b=PMaEfExGqqyGpSnS0JR8+dFwV2Zzq968tVye4274BeLfSxVDbaYuHm59T+WlJAnDaI
         jCPgtHT1Ariw2bVRpT7YNfT3osdBbAVbc3vBdtCLP43htuxjC0cP1tbUsnTp+LnavF6q
         uYz9WCQ0Wa9rGbiUfDTrDOQ2sDPD0qZMPlWVals4cP2YxcrdCE9hBx0Kgr9LeninvFd2
         z1K0OK6TEglS4500RMvc9RZgFhiQ2ftYBSnXcDg0gj7nwrdkrzsiyW9JIUhDlSVoIAzm
         MyYHQSOFcDB4PbgDOzZnZ0kEIRoWXqr4WKyiqDfDuA7oYf699sGvU3LLpiVbc3vBPcuk
         4XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtuJokPeDEKHjFBjlX+6+q1iW8IGangHbU2n+5YDhZI=;
        b=qPL034CmH6ztSaI4skToscvnIPqSzt/b7d4Z3Sot02eIiyLCL+NXLmstM2LQ25/1Nj
         rUar5GXLojy7DZleoBl8qc+HXQSwZwWazYgZb2+aMc+peNcpoN3E0QfbKua9W7X++m07
         EtiSB997L4gM4WRH2mcclJaLNwS2pnBZTSwr0WIXHJgDZ17v7eXSThZ1X3Bpygu1Str/
         +mHhHllwz9MqUG7Bsc086rro8HvJJSJZJ+bnQqdG6RvST2IRaAvb1jOBkQdcW+xevQVS
         6D9RM3N5pJCIFc9J/kEN1EOZhW8MMFx5AnjB5MUCJcHSeBuKqjeQQxP8ZggSwDgskIuw
         C89Q==
X-Gm-Message-State: AOAM530Gr/+tGRPNqwW8JkQ5w+FdSCN3QW40n54w+oQrkZBEijFwBpjh
        tGSXgcQoXzNkUuFDiGt4g44=
X-Google-Smtp-Source: ABdhPJxHanfPhlgpkOFq8AX51zh413IC8nL0E0J6fjDS1eQuZd9h95zIe2RLLj53pllPfw+qtJB/Iw==
X-Received: by 2002:a17:90a:5587:: with SMTP id c7mr2959955pji.5.1615873676071;
        Mon, 15 Mar 2021 22:47:56 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l22sm15096513pfd.145.2021.03.15.22.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:47:55 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 07/12] docs: path-lookup: i_op->follow_link replaced with i_op->get_link
Date:   Tue, 16 Mar 2021 13:47:22 +0800
Message-Id: <20210316054727.25655-8-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
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
index af5c20fecfef..e6b6c43ff0f6 100644
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
2.30.2

