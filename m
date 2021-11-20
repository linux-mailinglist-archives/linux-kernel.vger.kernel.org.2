Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34777457B5E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhKTEyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbhKTEx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:53:29 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E813C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:25 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id p27-20020a637f5b000000b0030c116f1a68so3408945pgn.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Iq24JeebEl5J+lwUGxaMYnGaB9XaVCl6Xy4iwtIyjvA=;
        b=chHgb4puhIWCbXYE8Sfesk3NR0JUQxPlsgsGXteWK/zzn4p5veG4SJor/gZuL7JgX3
         rTpfhIB3TB148ACfiYmshuzDlk8La2eFK38A6waYF1P8TDVR9KDtqC5wgu6d4MhZGzn9
         AU/xppkCdNdEA6B7QqNnDCas+iwtGzetJMukBnFtJdRdTqKvTWX7FAcUwxCo6r8I32sf
         bBCWBPZBvHHjBAZX3j8SS2dTcb80lzU4+UCk6gX7wrhiM6xAKdh05qROmWp4Y+SiE12o
         V0NAZSvNAXayIFigemF54IXXzW9KOuEVLOEBm4hrqi2dGz99WYHyQdUR37wEDeW9fchV
         D+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Iq24JeebEl5J+lwUGxaMYnGaB9XaVCl6Xy4iwtIyjvA=;
        b=a4aNHL/DEh1QXO02n3REuVRjjq0HMPOhP3AC81OjJU/42Cmjc+D+eNhJ5GJARXp1l8
         XTHWfK1qSN50CXOTmh13L8jSmnvt/z9aR1ApIEN/phgLPnoqDvUNR6X3iloY0cgZSZVN
         6RjTAULz/WG7YY6h7Y++kdkmNY/EeUBLbLbcJTFI6V7JgN3D0LwL37oyBeI5sZyON2pN
         qkMMBEq8InxR9vRyXQwLscmXQ2TBNtaUJKqDAaZGAkZn/xaf4K6AnZINdL0AYEIDeFzP
         a6bpMZPERWX2vhf6v3koQlZKQxlU0wnNauOFCTPdzs/DtLZGkqTkT3LMWIoMx5mS4jtx
         +lgQ==
X-Gm-Message-State: AOAM531WPsrnkuB6A0y/TiyDsFBv3ZoQcNHyp+nLCOpHHkFYUF3o92tw
        BOnX3vStG3dsQ6Lr2g9pPTQZX+HX84annkd/kA==
X-Google-Smtp-Source: ABdhPJw2LtgTcmkkzLu7IfsO7oStiwjz2hQIMktMWyDyw5d5CngJQrpTot1D+094Y6eOR3p65b1F4UncxKHZugK7JQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:fa91:560a:d7b4:93])
 (user=almasrymina job=sendgmr) by 2002:a17:90b:4c8b:: with SMTP id
 my11mr6839565pjb.96.1637383825076; Fri, 19 Nov 2021 20:50:25 -0800 (PST)
Date:   Fri, 19 Nov 2021 20:50:09 -0800
In-Reply-To: <20211120045011.3074840-1-almasrymina@google.com>
Message-Id: <20211120045011.3074840-4-almasrymina@google.com>
Mime-Version: 1.0
References: <20211120045011.3074840-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v4 3/4] mm, shmem: add filesystem memcg= option documentation
From:   Mina Almasry <almasrymina@google.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mina Almasry <almasrymina@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the usage of the memcg= mount option, as well as permission
restrictions of its use and caveats with remote charging.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v4:
- Added more info about the permissions to mount with memcg=, and the
  importance of restricting write access to the mount point.
- Changed documentation to describe the ENOSPC/SIGBUS behavior rather
  than the ENOMEM behavior implemented in earlier patches.
- I did not find a good place to put this documentation after making the
  mount option generic. Please let me know if there is a good place to
  add this, and if not I can add a new file. Thanks!

---
 Documentation/filesystems/tmpfs.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 0408c245785e3..dc1f46e16eaf4 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -137,6 +137,34 @@ mount options.  It can be added later, when the tmpfs is already mounted
 on MountPoint, by 'mount -o remount,mpol=Policy:NodeList MountPoint'.


+If CONFIG_MEMCG is enabled, filesystems (including tmpfs) has a mount option to
+specify the memory cgroup to be charged for page allocations.
+
+memcg=/sys/fs/cgroup/unified/test/: data page allocations are charged to
+cgroup /sys/fs/cgroup/unified/test/.
+
+Only processes that have write access to
+/sys/fs/cgroup/unified/test/cgroup.procs can mount a tmpfs with
+memcg=/sys/fs/cgroup/unified/test. Thus, a process is able to charge memory to a
+cgroup only if it itself is able to enter that cgroup and allocate memory
+there. This is to prevent random processes from mounting filesystems in user
+namespaces and intentionally DoSing random cgroups running on the system.
+
+Once a mount point is created with memcg=, any process that has write access to
+this mount point is able to use this mount point and direct charges to the
+cgroup provided. Thus, it is important to limit write access to the mount point
+to the intended users if untrusted code is running on the machine. This is
+generally required regardless of whether the mount is done with memcg= or not.
+
+When charging memory to the remote memcg (memcg specified with memcg=) and
+hitting that memcg's limit, the oom-killer will be invoked (if enabled) and will
+attempt to kill a process in the remote memcg. If no killable processes are
+found, the remote charging process gets an ENOSPC error. If the remote charging
+process is in the pagefault path, it gets a SIGBUS signal. It's recommended
+that processes executing remote charges are able to handle a SIGBUS signal or
+ENOSPC error that may arise during executing the remote charges.
+
+
 To specify the initial root directory you can use the following mount
 options:

--
2.34.0.rc2.393.gf8c9666880-goog
