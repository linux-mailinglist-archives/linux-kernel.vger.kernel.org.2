Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DA839D229
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhFFXNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:13:00 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:41708 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhFFXM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:12:59 -0400
Received: by mail-pl1-f173.google.com with SMTP id o12so4238860plk.8;
        Sun, 06 Jun 2021 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhZN7KKaKCv7HNFS5txFLEUB6UgBFOh/XOVxD+WngTc=;
        b=p0ja2QyILLQE3xZheBYcONtVgT93DwiUzK0izJcYbc2E2euF/aDA7285cwe6Lb2jqC
         bFw85jWWFrzSLuFIzJjiarn1Rz2O346t7E+aHbscntiXQybfkXHYHVHA5CREYniQl8G+
         KxCQOLrhQy4dfoqmEz7QIPLQqVU7Q122UOO59/NzPLmCU5KAVzCQ98jXoSvrpPZudYz3
         j3HSGY+Otfpyji0hy7TBNOkB4SuiC7xsmdK5uFvzJ4g1ZTnFJt43OHlEdFlkdU0pQy4t
         hgwWzxFm6RvbLIxcn15X1RYeNT2EJ2BrbWo48BFzQe2TeLeDKP9rIwBPyvNoqv5PyiSx
         3ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhZN7KKaKCv7HNFS5txFLEUB6UgBFOh/XOVxD+WngTc=;
        b=MD+GPNyEz7FowqlHePwygNfm9tYsPoA8j4sUdadxo4eSOznyO+9JQa+f2ZTZONyx7p
         sHTCQLjeis6N8CjJSYXcyAYWO+BwF1bTEDKg/wTS/wD+5LzfnX0WZsklIb2WXzsWmG3q
         FrcBwUSWYLsXxmoU1HptOwd+rVNMJ2nEJwu6g+V2YZ+kYJHQxPGIYTwARQc3QPOhkGo+
         qwmXH3SuR4o2WnDwVJ2kw+q9u6Eev4uj3eN0QuEB1YoQHJkOKzJwE9CL9Szdsr5OhswY
         LUSSeYtIwg3UqE0eqLbvdLTlZKmDKMMT+DfNwNP+JXVCE2469Bro38U8HetxS3mFP1jt
         jwFw==
X-Gm-Message-State: AOAM5327hU6ZOjx4tB8m4o8nHh4OSCIxIkNrCxfibwxNeA0I8vQlBZtT
        Cy0HonVepvAAPj3lmTI86fo=
X-Google-Smtp-Source: ABdhPJxCVNTIVuq9x/8ALU1cNA0s8JhSoIMxiODWzqG2b2WSiMx+EchW7kGt8WTBuxTN8YREAkfjSQ==
X-Received: by 2002:a17:90a:9bc4:: with SMTP id b4mr28848399pjw.42.1623020994934;
        Sun, 06 Jun 2021 16:09:54 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id f15sm6775672pgg.23.2021.06.06.16.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 16:09:54 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 2/3] 9p: doc: move to a new dedicated folder
Date:   Mon,  7 Jun 2021 07:09:21 +0800
Message-Id: <20210606230922.77268-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210606230922.77268-1-changbin.du@gmail.com>
References: <20210606230922.77268-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later we will add another documentation for v9fs.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/filesystems/index.rst         |  2 +-
 Documentation/filesystems/{ => v9fs}/9p.rst |  0
 Documentation/filesystems/v9fs/index.rst    | 11 +++++++++++
 MAINTAINERS                                 |  2 +-
 4 files changed, 13 insertions(+), 2 deletions(-)
 rename Documentation/filesystems/{ => v9fs}/9p.rst (100%)
 create mode 100644 Documentation/filesystems/v9fs/index.rst

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index d4853cb919d2..e53992636a49 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -63,7 +63,7 @@ Documentation for filesystem implementations.
 .. toctree::
    :maxdepth: 2
 
-   9p
+   v9fs/index
    adfs
    affs
    afs
diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/v9fs/9p.rst
similarity index 100%
rename from Documentation/filesystems/9p.rst
rename to Documentation/filesystems/v9fs/9p.rst
diff --git a/Documentation/filesystems/v9fs/index.rst b/Documentation/filesystems/v9fs/index.rst
new file mode 100644
index 000000000000..a1e45b89e2a2
--- /dev/null
+++ b/Documentation/filesystems/v9fs/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====
+v9fs
+====
+
+.. toctree::
+   :maxdepth: 6
+   :numbered:
+
+   9p
diff --git a/MAINTAINERS b/MAINTAINERS
index 35b2c8f614d0..3da44eef1471 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -232,7 +232,7 @@ W:	http://swik.net/v9fs
 Q:	http://patchwork.kernel.org/project/v9fs-devel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
 T:	git git://github.com/martinetd/linux.git
-F:	Documentation/filesystems/9p.rst
+F:	Documentation/filesystems/v9fs/
 F:	fs/9p/
 F:	include/net/9p/
 F:	include/trace/events/9p.h
-- 
2.30.2

