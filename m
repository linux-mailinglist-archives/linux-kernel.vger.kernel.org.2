Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37A1392A83
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhE0JTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbhE0JSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7992BC0613CE;
        Thu, 27 May 2021 02:17:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g24so76237pji.4;
        Thu, 27 May 2021 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xI8m5cR8Tn9ErPsZTpFSxloNjd24JBeFi6flTU3KaOg=;
        b=uKmDX1SFaZHNkFQOzi8R9h3E2ulxUtzjpt3Fw3zAmH3lEWX0OsIsfv3PUa5SR9IOPG
         Dy5yBa6XCIHPHdZB8kltYyzryE4KRyG4bhfvyp+/F90DUyW4w+YnWiTeHslGnvoJngFD
         E1bP0Ju+P+eWMd3yhmtYzrQI+H8npp0NheTA7EAUG5QphrcWY34zVrkjExr6ccYSCPYV
         XUL4tXbEbVHhQyPLS5fsNj0tvR2/XvrQjjnSFUVzolGszTpaK75oS8EYEHh7xRL45u6U
         2mGdA6Qw26R0qpm46zPRLnjVEZT5u/Iso4viEQSSBWPhRTHPg4hUm4mLCkvuiyc8rKId
         AZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xI8m5cR8Tn9ErPsZTpFSxloNjd24JBeFi6flTU3KaOg=;
        b=UX+99z0YGQupp/QWuaA6cZFdttmgJYp2djOraoZmgJn+1Py3/vht3Ykc8/fP4LXV2L
         9Iztn3YPd4b6oL3tCv//ql/EiUBeiO2t3+nB08jMONClK1TgLH7yFZIB/vXW0wwf9WKE
         7Z0GK2q5sYcrETJQHIAR6N2nq4rTXSLjqjGZ3GJnutT4Sse6K3hZz6rCFqB1f3tOtftR
         PlOh3upv0di/PqUDlX1TIrVsAwPm+HKAe4zbzUC96p2uxyDMHcz5ov2O77h49ZkZCqSr
         ZzeNf/4uIKH3CAArJmuRdqtFsvr5UPPRmei256p8YF4u9lDIhRpCnSN39ieQ6bP/Ljq+
         4ncw==
X-Gm-Message-State: AOAM532WyAoP29wrQRGGRN2e9kTMHpl8oPfk6pRj+znbbCvfPdtJhcpU
        eMaCUCvvlFSei1VhIzwJJO4=
X-Google-Smtp-Source: ABdhPJxkkHMeaRu6lQLhzGp/87zYGCaUNy9qsfZ9xbdOCw6twy7WKd0xfwOA9JlJV2kqbXLFpsAnfw==
X-Received: by 2002:a17:90a:4493:: with SMTP id t19mr2674423pjg.217.1622107020003;
        Thu, 27 May 2021 02:17:00 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:16:59 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 05/13] docs: path-lookup: remove filename_mountpoint
Date:   Thu, 27 May 2021 17:16:10 +0800
Message-Id: <20210527091618.287093-6-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
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
index 2b0b33168067..3cbaf30b0f83 100644
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
2.31.1

