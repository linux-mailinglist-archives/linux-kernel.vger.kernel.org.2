Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B9445B6CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbhKXIqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:46:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241440AbhKXIo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637743308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSbLxSzQQlSj2l2ivmebco5pJQPSDB4IoLoCnSyzCyI=;
        b=hLVoGQIB5w3VUlfaejALPn+wH/si+iB1nWfZ1GeHvt9WCGVjsHZUFgn/BGRORDh2lkmpeE
        7GBZcnz0379PYy3QoRPwsqy/FTQWZ7wnrO3L8dazcupwcz9jG2X0vIkKBiiDZ13RjtzuYy
        3yR5Rb4Jd9OFM4UY67JQe4N/qyG97aE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-ey_yxX_TOIW1YeHWZDncYQ-1; Wed, 24 Nov 2021 03:41:46 -0500
X-MC-Unique: ey_yxX_TOIW1YeHWZDncYQ-1
Received: by mail-wm1-f70.google.com with SMTP id y141-20020a1c7d93000000b0033c2ae3583fso957387wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSbLxSzQQlSj2l2ivmebco5pJQPSDB4IoLoCnSyzCyI=;
        b=ZYJHk/R6S2azsCOxZvu235ONHNpDec+j4XkDw2Bq0vzQQJxLbI51vr/RknNqX4SZy4
         mh+iS6NxgACy2cWZaT1dgWnSYgkTueOZ1+7oGM2zXshlVqxAuc6FCAFUFBNdKq7fNPEQ
         9rY4rtHDGApjg7K3CjKiVJghdunhgbTo4LqFIz9ZQp1hugM6E12PK9vl86OYYu1SiTV+
         HA3+TwwBNnLALZLOGFPJLIAny80l89fzhDWi/KAds8DsEyJBN1ypkuubBZGcRiZ6n60P
         DBP5xoOCZELVkpH1QrfWBfvjmy+DmkqNCyMVhEGpGc7qkPH1WnPG5mcn33Xh7P7HrogU
         3h3g==
X-Gm-Message-State: AOAM530jJrjTKU9zltLe85xwMcSzpW/2ebeWpDIGoYZmTFiQE45vSgwx
        7ujV3PW1VzkU++qRxXOfsmr8gbARZioi/K7Y9WqoLjNlVShpsGtiRb6EnIijnf5oC3w8VC0pw+e
        /alIoH7cQmWRIihyp70rSX9VM
X-Received: by 2002:a05:600c:a0b:: with SMTP id z11mr12965534wmp.147.1637743305726;
        Wed, 24 Nov 2021 00:41:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymrcuFByLsguSft6KExGLu1wEeNTSixB9Q5EfKs0oZ76e3br1ZPdJy/9cjaU2K/51mela6sg==
X-Received: by 2002:a05:600c:a0b:: with SMTP id z11mr12965499wmp.147.1637743305551;
        Wed, 24 Nov 2021 00:41:45 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d1sm13789041wrz.92.2021.11.24.00.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 00:41:45 -0800 (PST)
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
Subject: [PATCH 4/8] libbpf: Add struct perf_event_open_args
Date:   Wed, 24 Nov 2021 09:41:15 +0100
Message-Id: <20211124084119.260239-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124084119.260239-1-jolsa@kernel.org>
References: <20211124084119.260239-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding struct perf_event_open_args to hold arguments for
perf_event_open_probe, because there's already 6 arguments
and more will come in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b55c0fbfcc03..34219a0c39a7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9625,11 +9625,20 @@ static int determine_uprobe_retprobe_bit(void)
 #define PERF_UPROBE_REF_CTR_OFFSET_BITS 32
 #define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
 
-static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
-				 uint64_t offset, int pid, size_t ref_ctr_off)
+struct perf_event_open_args {
+	bool retprobe;
+	const char *name;
+	uint64_t offset;
+	int pid;
+	size_t ref_ctr_off;
+};
+
+static int perf_event_open_probe(bool uprobe, struct perf_event_open_args *args)
 {
+	size_t ref_ctr_off = args->ref_ctr_off;
 	struct perf_event_attr attr = {};
 	char errmsg[STRERR_BUFSIZE];
+	int pid = args->pid;
 	int type, pfd, err;
 
 	if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
@@ -9643,7 +9652,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 			libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
 		return type;
 	}
-	if (retprobe) {
+	if (args->retprobe) {
 		int bit = uprobe ? determine_uprobe_retprobe_bit()
 				 : determine_kprobe_retprobe_bit();
 
@@ -9658,8 +9667,8 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	attr.size = sizeof(attr);
 	attr.type = type;
 	attr.config |= (__u64)ref_ctr_off << PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
-	attr.config1 = ptr_to_u64(name); /* kprobe_func or uprobe_path */
-	attr.config2 = offset;		 /* kprobe_addr or probe_offset */
+	attr.config1 = ptr_to_u64(args->name); /* kprobe_func or uprobe_path */
+	attr.config2 = args->offset;		 /* kprobe_addr or probe_offset */
 
 	/* pid filter is meaningful only for uprobes */
 	pfd = syscall(__NR_perf_event_open, &attr,
@@ -9791,9 +9800,15 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 
 	legacy = determine_kprobe_perf_type() < 0;
 	if (!legacy) {
-		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
-					    func_name, offset,
-					    -1 /* pid */, 0 /* ref_ctr_off */);
+		struct perf_event_open_args args = {
+			.retprobe = retprobe,
+			.name = func_name,
+			.offset = offset,
+			.pid = -1,
+			.ref_ctr_off = 0,
+		};
+
+		pfd = perf_event_open_probe(false /* uprobe */, &args);
 	} else {
 		char probe_name[256];
 
@@ -9984,8 +9999,15 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 
 	legacy = determine_uprobe_perf_type() < 0;
 	if (!legacy) {
-		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
-					    func_offset, pid, ref_ctr_off);
+		struct perf_event_open_args args = {
+			.retprobe = retprobe,
+			.name = binary_path,
+			.offset = func_offset,
+			.pid = pid,
+			.ref_ctr_off = ref_ctr_off,
+		};
+
+		pfd = perf_event_open_probe(true /* uprobe */, &args);
 	} else {
 		char probe_name[512];
 
-- 
2.33.1

