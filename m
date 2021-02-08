Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98961313278
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhBHMgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhBHMcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:32:19 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D105C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 04:31:39 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id y9so8477103wmi.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 04:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Tz3EEiGtqhAZQlBh+d9mhoi0ASY5WVHpqxEBNOrbNmA=;
        b=hn5osd+w4b+f6msnUJ7+kJz24A0jojRgXS2mYqMSj5xpjKVBeGXCXLzCKt8Ftf+lbY
         qpX4gJ0J1dO4lVRVA79nS9baDTjvoIAoXY//eu52wzA7QQodvWNW6r0xlkSfQq7cA0xZ
         Wgb8z3+33aVi1AS0syr/5HGj2aXCwlz6yzfbR6yumylmsQVWaySmoDY0pArCp0T5H0/3
         kNsZG8j22tkEsScalnGkV5qHqthq03zkM+nqh+/KjJRiIlmCQy4QKtmh/ZYPSp5JuBNs
         SjKDcFhB+25GY/A2MuGmRjCBA5TplWJHyEowV6ZUaHvwP9707N0YcvoFVS7sfJrxGCLi
         HjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Tz3EEiGtqhAZQlBh+d9mhoi0ASY5WVHpqxEBNOrbNmA=;
        b=J0tgD0+bqBjsQ8pvWcxtLDRkD4VuRDVULkFbxJcO1RmxH5GNcpgZX3WTdz11JDhuld
         zrvkfrTXZE6qyCQSeQLQ+gmJyWtdHCV0uHXHwZcNfqtJOrQ9y8xp5koKaWrrYJQvdvUx
         KLOqxvdwr8zrGv2uooCuvWJwznn4beniz3w1FCHdluu4pBgGGMbjkgROAtv7sikGaDi3
         O9tzpKBEQUCn5DbVCiaJgk+h7LOQuHio9cE0Jj2GL70ID4IYRrx8ew6VaxHY/Z4Z6jPA
         5Zg1gmkYqsCDP5I3bfzCKR8inV01A1FJI69mRIofzXSRQdGeDaEcY5wDsKSZfosGZKDq
         w0Lg==
X-Gm-Message-State: AOAM531WPdgWbuG6B7dt6OKmsWsiEq44UfLYXT5QsVxArYj5KdjnSVVX
        cUFEssD2jWk4egVRmFS273RFxYsG8qLp4g==
X-Google-Smtp-Source: ABdhPJw3Kbgr6vQqx5hgrlT75XJqxVXpDt3t2CfAv4kQvno+YIfbJIKofJ/HAfi1W8RZlOeCSMfNWpAB9Pomcg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:8523:: with SMTP id
 32mr6576804wrh.275.1612787497636; Mon, 08 Feb 2021 04:31:37 -0800 (PST)
Date:   Mon,  8 Feb 2021 12:31:22 +0000
Message-Id: <20210208123122.956545-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH bpf-next] selftests/bpf: Add missing cleanup in atomic_bounds test
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing skeleton destroy call.

Reported-by: Yonghong Song <yhs@fb.com>
Fixes: 37086bfdc737 ("bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/bpf/prog_tests/atomic_bounds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
index addf127068e4..290506fa1c38 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
@@ -12,4 +12,6 @@ void test_atomic_bounds(void)
 	skel = atomic_bounds__open_and_load();
 	if (CHECK(!skel, "skel_load", "couldn't load program\n"))
 		return;
+
+	atomic_bounds__destroy()
 }

base-commit: 23a2d70c7a2f28eb1a8f6bc19d68d23968cad0ce
-- 
2.30.0.478.g8a0d178c01-goog

