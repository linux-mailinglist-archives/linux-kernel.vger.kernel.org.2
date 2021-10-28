Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E633A43E679
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhJ1QrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhJ1QrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:47:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B9DC061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:44:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m22so11390715wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s5sA21svvdbNRWWkv4wMUduPzISF+IZMbMm8sVfICi8=;
        b=EMwKjOqLDz5qZUjDGCmvTlH8VtASiWSWR4Zy5Dc9G4g9ye/Y/9OWW8ksuTLNrdUvyK
         A/zF3mcxz6ouMGoWV3zlgOFheF1aWW1O79vJNTT2Ohtgsx0rtBdnnhyUBNwPSUO5D/CV
         dvy4ROeIBoAqvWxtUpIaBruVetdvQBGtS6MiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s5sA21svvdbNRWWkv4wMUduPzISF+IZMbMm8sVfICi8=;
        b=sbhIwAlUILnbGtwARzoc8hqc/xzQdkNq0A8GOFhCyPC/FaEJ51iphPE8mMQM6M9gjV
         a/7aPss4ejQbK18aXek/0x0OLkDBgf1P5FJ4P3dR0ix7pIQ8FDgZpAmYHk4xZKbFXzhA
         y+0mTFnIdbTFFQUQjwnhL48Wthffhp+g+gbiJEoZRQ96iexnJskzVyJyfFFMP6qYz9pF
         +1wp/zxOO7Px4Y8iYGOtPf+ZjdAHiEil0Wu2/DHzhin56FUWEmiBM9sQFW0LOc5QXUVq
         vOB0D0HykAc91G7yJb8GTLi8Yu1OASst/0roWm1Jw6/tTmjc4Ug6IcznbIiDeBh8PldD
         wsuw==
X-Gm-Message-State: AOAM533wS37YRZShc3gt4ITLXCf23DIz9D+/wU5i4KWfSY7NQjl4EhWa
        Ugi+hkN/H0PnJUAPCk5iO55eHQ==
X-Google-Smtp-Source: ABdhPJyQ3fo1TyiyK8Sl04sewX0JkJkHS9zN663Ikmzp4vjjIXaF/KHmJ6tIBPLuO+pQMKyCjZkUdw==
X-Received: by 2002:a5d:64aa:: with SMTP id m10mr7306377wrp.196.1635439484187;
        Thu, 28 Oct 2021 09:44:44 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:60fa:f15c:2dfe:b1df])
        by smtp.gmail.com with ESMTPSA id s13sm6873286wmc.47.2021.10.28.09.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:44:43 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
Date:   Thu, 28 Oct 2021 18:43:57 +0200
Message-Id: <20211028164357.1439102-1-revest@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the helper to be called from the perf_event_mmap hook. This is
convenient to lookup vma->vm_file and implement a similar logic as
perf_event_mmap_event in BPF.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/trace/bpf_trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cbcd0d6fca7c..f6e301c775a5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -922,6 +922,9 @@ BTF_ID(func, vfs_fallocate)
 BTF_ID(func, dentry_open)
 BTF_ID(func, vfs_getattr)
 BTF_ID(func, filp_close)
+#ifdef CONFIG_PERF_EVENTS
+BTF_ID(func, perf_event_mmap)
+#endif
 BTF_SET_END(btf_allowlist_d_path)
 
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
-- 
2.33.0.1079.g6e70778dc9-goog

