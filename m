Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97F23AFDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhFVHOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFVHOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:14:42 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBDFC061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:12:26 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t9so16307273pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0AikK1isJc2wTUd2WzBNIrtSxJuRycoU0RO0M62jceM=;
        b=pQQwZrtca8YssPfwhiGtRY6bAXxPV7AW6CWDZSKKWn5EoZyUhSBI03fklUF2B2F6TS
         +8y+65jReh7xqkKnWzQOrw6SysVJLZm3NoKZ2JhmdwBx2Gs7Qhs7dVizvByQh93nAhjU
         0oycYOJI6rLpSl0MSdeAm6z9VkUWBvNXlcp2Pv1nPsUyPAQi0CT73Xn/HCojpcMLFPY8
         yWG+gM1zzLFWzbB6XMLBOM2HV57acc1mMWT2TQQHb+/2Wn5+SkIRxiH4aalOGciFtGBg
         1ou+xgVRZdDUX/zXsdvgQ7W0hOigoNygPmgeJeS3vHa9vNxXs4dg7qrMUhN/sGyYL2hW
         lVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0AikK1isJc2wTUd2WzBNIrtSxJuRycoU0RO0M62jceM=;
        b=QaUTz741Y6ceG1chhpTAdFTKoOY3izNqHN7JCvhPVmZD9N7RDvNB2EO15QeLggwDsW
         ZMuukA54/p8jy48S6aZziCke4K+eoOHkPwF2SWQLDNe9nV0PmzS8YEJkzysrihDOKR/g
         jPRkpcIZDLA2Iu77OqPWJ8Y/DxjuGKVDibKMfsIVrRoz76jaPYum7tnrdpMuq6SsvJH8
         mt+gsJh5OjrqhRPyVbgRk4OI6DM5JIjaSDokoPbg9im+bjI5PKouQXWXmmR00FV4R31i
         3sr1Mbks8G7R+8w5E9sG3eCIdiz7sBZTUGqJXgUkZHifyaFhIMow75m07ZatmrPOjLA5
         N5RQ==
X-Gm-Message-State: AOAM53204yX/Cxri8DlkjiBxgjPW0mPQk+8F3nqCTsziki1qhAcbUsef
        zzslxMTpgbCvxGqbYehIxQPM8pLfClXEGQ==
X-Google-Smtp-Source: ABdhPJyPFnbcrk9reOF64VKh5m0LyC9RY+OjbEn/c9N90xd1qGsjYKW0WGZEw0Cs+ncDCx+MAWGSPw==
X-Received: by 2002:a63:921e:: with SMTP id o30mr2445847pgd.346.1624345946044;
        Tue, 22 Jun 2021 00:12:26 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:62e3:ad14:6151:62fa])
        by smtp.gmail.com with ESMTPSA id j4sm16449129pfj.111.2021.06.22.00.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 00:12:25 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 1/3] perf tools: Add read_cgroup_id() function
Date:   Tue, 22 Jun 2021 00:12:19 -0700
Message-Id: <20210622071221.128271-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210622071221.128271-1-namhyung@kernel.org>
References: <20210622071221.128271-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read_cgroup_id() is to read a cgroup id from a file handle using
name_to_handle_at(2) for the given cgroup.  It'll be used by bperf
cgroup stat later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/cgroup.c | 25 +++++++++++++++++++++++++
 tools/perf/util/cgroup.h |  9 +++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index f24ab4585553..ef18c988c681 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -45,6 +45,31 @@ static int open_cgroup(const char *name)
 	return fd;
 }
 
+#ifdef HAVE_FILE_HANDLE
+int read_cgroup_id(struct cgroup *cgrp)
+{
+	char path[PATH_MAX + 1];
+	char mnt[PATH_MAX + 1];
+	struct {
+		struct file_handle fh;
+		uint64_t cgroup_id;
+	} handle;
+	int mount_id;
+
+	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, "perf_event"))
+		return -1;
+
+	scnprintf(path, PATH_MAX, "%s/%s", mnt, cgrp->name);
+
+	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
+	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0)
+		return -1;
+
+	cgrp->id = handle.cgroup_id;
+	return 0;
+}
+#endif  /* HAVE_FILE_HANDLE */
+
 static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str)
 {
 	struct evsel *counter;
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 162906f3412a..707adbe25123 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -38,4 +38,13 @@ struct cgroup *cgroup__find(struct perf_env *env, uint64_t id);
 
 void perf_env__purge_cgroups(struct perf_env *env);
 
+#ifdef HAVE_FILE_HANDLE
+int read_cgroup_id(struct cgroup *cgrp);
+#else
+int read_cgroup_id(struct cgroup *cgrp)
+{
+	return -1;
+}
+#endif  /* HAVE_FILE_HANDLE */
+
 #endif /* __CGROUP_H__ */
-- 
2.32.0.288.g62a8d224e6-goog

