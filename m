Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44E45B6C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbhKXIqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:46:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241543AbhKXIov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637743302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUpNCIf6I4xx/xoebeS2tiWidAHCtrV6dZkFUmxD4cc=;
        b=FgoVu18gtjma/DGnyax3NdOfNuUcsnEIs3pT65b9wgdTNw5I1QIW8uZesEQtCb8MFUEg3r
        xR+iWGT7iZEbcwqQuqXq8UsepfcVcSSTolbs5mRVNyGYpBLVJ+KZ40G0ELE2o1pFTJWfQJ
        foCezp3zf4yzFTe4PwF5KDNmicv7B9E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-oeEXM27uPxWegjnRuT3dgA-1; Wed, 24 Nov 2021 03:41:40 -0500
X-MC-Unique: oeEXM27uPxWegjnRuT3dgA-1
Received: by mail-wm1-f72.google.com with SMTP id m18-20020a05600c3b1200b0033283ea5facso1422447wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUpNCIf6I4xx/xoebeS2tiWidAHCtrV6dZkFUmxD4cc=;
        b=drKQkssfcbZWVmcGnaJ98z9xD8ofjdAHY+Jd5w/n0Q7z6WmRQOioce7EBWqNCAn5WH
         KLhDnsAtzLKbUjWJrTNWr5dVqAEF3tjeBtAR1x1L7BiIXMP+tSbQ04a2D+UJKohD2CGY
         qp8KkzJUZV69OyTRSNqvX64N5ihQqRcu+BEeHoABYGJFyqw7BSSI7nFotrCXYB88N6Hw
         gJwZub57xdBiuSAYZFSNsCe/ChDVw/+3BEpvEuvpiCO6gWuocFyLLYxj3E1OOGiEzrrL
         60nJVP0hfw+pZZ45CoKrPIoxF0s0MkfVgzQFbCT2yw0ZJD7nVEFIb21XS3qcU77Eq9mc
         dHKQ==
X-Gm-Message-State: AOAM531mbWhn5zQMm5zlsPjBo8QmYUln0BwC2WQ1OaDCR9PxMl6Qehyg
        ORCfnsNg2d60NE282sqpsvIR9Xoc7c2f2Y7299Y4AWwBFinzpI8TREtvBzFu2o+RN1jCZpQUHwY
        6DvxAOlNqRddgmV/wFVUxnPcm
X-Received: by 2002:a5d:548f:: with SMTP id h15mr16213861wrv.99.1637743299420;
        Wed, 24 Nov 2021 00:41:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyz1415SFxfiE43cMAnbGJQqe7kyuGSNL3YexfDBsTFRpB49fmucVAQmngtlVjsFf5uIYlC/A==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr16213828wrv.99.1637743299253;
        Wed, 24 Nov 2021 00:41:39 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id x4sm3649097wmi.3.2021.11.24.00.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 00:41:38 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 3/8] libbpf: Add libbpf__kallsyms_parse function
Date:   Wed, 24 Nov 2021 09:41:14 +0100
Message-Id: <20211124084119.260239-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124084119.260239-1-jolsa@kernel.org>
References: <20211124084119.260239-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the kallsyms parsing in internal libbpf__kallsyms_parse
function, so it can be used from other places.

It will be used in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 62 ++++++++++++++++++++-------------
 tools/lib/bpf/libbpf_internal.h |  5 +++
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index af405c38aadc..b55c0fbfcc03 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6950,12 +6950,10 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
 	return 0;
 }
 
-static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
+int libbpf__kallsyms_parse(void *arg, kallsyms_cb_t cb)
 {
 	char sym_type, sym_name[500];
 	unsigned long long sym_addr;
-	const struct btf_type *t;
-	struct extern_desc *ext;
 	int ret, err = 0;
 	FILE *f;
 
@@ -6974,35 +6972,51 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
 		if (ret != 3) {
 			pr_warn("failed to read kallsyms entry: %d\n", ret);
 			err = -EINVAL;
-			goto out;
+			break;
 		}
 
-		ext = find_extern_by_name(obj, sym_name);
-		if (!ext || ext->type != EXT_KSYM)
-			continue;
-
-		t = btf__type_by_id(obj->btf, ext->btf_id);
-		if (!btf_is_var(t))
-			continue;
-
-		if (ext->is_set && ext->ksym.addr != sym_addr) {
-			pr_warn("extern (ksym) '%s' resolution is ambiguous: 0x%llx or 0x%llx\n",
-				sym_name, ext->ksym.addr, sym_addr);
-			err = -EINVAL;
-			goto out;
-		}
-		if (!ext->is_set) {
-			ext->is_set = true;
-			ext->ksym.addr = sym_addr;
-			pr_debug("extern (ksym) %s=0x%llx\n", sym_name, sym_addr);
-		}
+		err = cb(arg, sym_addr, sym_type, sym_name);
+		if (err)
+			break;
 	}
 
-out:
 	fclose(f);
 	return err;
 }
 
+static int kallsyms_cb(void *arg, unsigned long long sym_addr,
+		       char sym_type, const char *sym_name)
+{
+	struct bpf_object *obj = arg;
+	const struct btf_type *t;
+	struct extern_desc *ext;
+
+	ext = find_extern_by_name(obj, sym_name);
+	if (!ext || ext->type != EXT_KSYM)
+		return 0;
+
+	t = btf__type_by_id(obj->btf, ext->btf_id);
+	if (!btf_is_var(t))
+		return 0;
+
+	if (ext->is_set && ext->ksym.addr != sym_addr) {
+		pr_warn("extern (ksym) '%s' resolution is ambiguous: 0x%llx or 0x%llx\n",
+			sym_name, ext->ksym.addr, sym_addr);
+		return -EINVAL;
+	}
+	if (!ext->is_set) {
+		ext->is_set = true;
+		ext->ksym.addr = sym_addr;
+		pr_debug("extern (ksym) %s=0x%llx\n", sym_name, sym_addr);
+	}
+	return 0;
+}
+
+static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
+{
+	return libbpf__kallsyms_parse(obj, kallsyms_cb);
+}
+
 static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
 			    __u16 kind, struct btf **res_btf,
 			    struct module_btf **res_mod_btf)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index f7ac349650a1..511cb09f593f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -406,6 +406,11 @@ __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
 
 extern enum libbpf_strict_mode libbpf_mode;
 
+typedef int (*kallsyms_cb_t)(void *arg, unsigned long long sym_addr,
+			     char sym_type, const char *sym_name);
+
+int libbpf__kallsyms_parse(void *arg, kallsyms_cb_t cb);
+
 /* handle direct returned errors */
 static inline int libbpf_err(int ret)
 {
-- 
2.33.1

