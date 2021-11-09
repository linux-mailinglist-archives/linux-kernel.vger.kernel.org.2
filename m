Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4C44AF29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 15:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhKIOKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 09:10:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233870AbhKIOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 09:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636466838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2VSOyXzYRYMOEABj++/yoqePCQtL86lxwiOVvIUF4mo=;
        b=GUCiLCHaMEGrtTXA15S0i7t2TnUT4XU72OvobMuOfvRT0JUqQOwvrJTVS+fWk4UE1ABlg3
        xvk6rcKODXLRz6WzmTSgBvAKCGUzkjCPD1Kj2hdKlMs3OYTcD0RqfJHRJOKqIX6Dy7P+84
        Uu0+mr6ijqANgDNSm7jh/MGzGydS6SU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-KnJAlm3DN7KWAqnveVhAow-1; Tue, 09 Nov 2021 09:07:17 -0500
X-MC-Unique: KnJAlm3DN7KWAqnveVhAow-1
Received: by mail-wm1-f72.google.com with SMTP id m14-20020a05600c3b0e00b0033308dcc933so1161861wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 06:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VSOyXzYRYMOEABj++/yoqePCQtL86lxwiOVvIUF4mo=;
        b=Mdhvi9jGRLDL9XnaMURoUknePqzHYwCc7Ub3OCoPg7XHeZOKld+BcoIWTD7A/BW8EN
         bb73/oYwkYLG2heZc9pZlHWx5wTjBmJsFS2swzr0QE0bSiOFQUPMsTylvgSElBIPa3F2
         EJs5IJf//p1fwo/5CXPcNzB7lppo6jAPeo6CJf1304nDvZG4AFUgW/h802KLA2ME2L04
         BOtSDV+DV41TfKnHl/CMv88i88fB3sCYDdDg01QTcbMgir1QkuYK6HeG/3lJkoJJYEvj
         sTe8do7YrPGcCrvpa45g6yqFpMzg8mrAclu6ObqNoKz3Rv0r4W3mk7vgL4IiBctnKQHQ
         Rbpg==
X-Gm-Message-State: AOAM5302Pw4nGR36npsPajpaRtwOHLIGJi0+Q+kLzivx84Cp195D0jbY
        mclhoNBAp/UMwiPBZ2ACKTDI13hBz1m6JdhLbVtbkh2e/4vs0mTWoY4zGD1PjMmH0Z2VahSmyzy
        B3/NPaz3BAlqJl26eNeW6k+Ij
X-Received: by 2002:adf:c70b:: with SMTP id k11mr9364295wrg.154.1636466835740;
        Tue, 09 Nov 2021 06:07:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNm1pd04AbIgF9WPOiwVj+EGz/K0L4fW1W7w/m7IXHp1YHSkWqek+LItUcB0zz4psr/S+BLw==
X-Received: by 2002:adf:c70b:: with SMTP id k11mr9364265wrg.154.1636466835539;
        Tue, 09 Nov 2021 06:07:15 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id m22sm2910495wmq.38.2021.11.09.06.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 06:07:14 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 1/2] perf tools: Add more weak libbpf functions
Date:   Tue,  9 Nov 2021 15:07:06 +0100
Message-Id: <20211109140707.1689940-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211109140707.1689940-1-jolsa@kernel.org>
References: <20211109140707.1689940-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We hit the window where perf uses libbpf functions, that did not
make it to the official libbpf release yet and it's breaking perf
build with dynamicly linked libbpf.

Fixing this by providing the new interface as weak functions which
calls the original libbpf functions. Fortunatelly the changes were
just renames.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf-event.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 4d3b4cdce176..ceb96360fd12 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -33,6 +33,33 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
        return err ? ERR_PTR(err) : btf;
 }
 
+struct bpf_program * __weak
+bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
+{
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+	return bpf_program__next(prev, obj);
+#pragma GCC diagnostic pop
+}
+
+struct bpf_map * __weak
+bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
+{
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+	return bpf_map__next(prev, obj);
+#pragma GCC diagnostic pop
+}
+
+const void * __weak
+btf__raw_data(const struct btf *btf_ro, __u32 *size)
+{
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+	return btf__get_raw_data(btf_ro, size);
+#pragma GCC diagnostic pop
+}
+
 static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
 {
 	int ret = 0;
-- 
2.31.1

