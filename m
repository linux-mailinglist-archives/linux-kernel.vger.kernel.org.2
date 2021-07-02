Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF543BA071
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhGBMfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:35:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:3459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232227AbhGBMfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:35:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="230397081"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="230397081"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 05:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="642660144"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2021 05:32:39 -0700
From:   Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH v9 02/24] tools lib: Introduce fdarray clone function
Date:   Fri,  2 Jul 2021 15:32:10 +0300
Message-Id: <e400806e403d2d607c89c251f72b4ba631b52f14.1625227739.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1625227739.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1625227739.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a function to create a copy of an existing file descriptor in
the fdarray structure. The function returns the position of the copied fd.

Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/lib/api/fd/array.c | 17 +++++++++++++++++
 tools/lib/api/fd/array.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 5e6cb9debe37..de8bcbaea3f1 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -88,6 +88,23 @@ int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags
 	return pos;
 }
 
+int fdarray__clone(struct fdarray *fda, int pos, struct fdarray *base)
+{
+	struct pollfd *entry;
+	int npos;
+
+	if (pos >= base->nr)
+		return -EINVAL;
+
+	entry = &base->entries[pos];
+
+	npos = fdarray__add(fda, entry->fd, entry->events, base->priv[pos].flags);
+	if (npos >= 0)
+		fda->priv[npos] = base->priv[pos];
+
+	return npos;
+}
+
 int fdarray__filter(struct fdarray *fda, short revents,
 		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
 		    void *arg)
diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
index 7fcf21a33c0c..4a03da7f1fc1 100644
--- a/tools/lib/api/fd/array.h
+++ b/tools/lib/api/fd/array.h
@@ -42,6 +42,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
 void fdarray__delete(struct fdarray *fda);
 
 int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags flags);
+int fdarray__clone(struct fdarray *fda, int pos, struct fdarray *base);
 int fdarray__poll(struct fdarray *fda, int timeout);
 int fdarray__filter(struct fdarray *fda, short revents,
 		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
-- 
2.19.0

