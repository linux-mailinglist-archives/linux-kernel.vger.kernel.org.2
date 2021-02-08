Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA5313290
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhBHMlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhBHMiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:38:25 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C55BC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 04:37:45 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id a12so10439885qvo.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 04:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=loEBbKa5Ndufz/0YdKNALswJPUUf0CuP6QsASXheX1o=;
        b=Sj/6u2t3k3ypU8C8kDoe7HnCdR55zJMrrmG1xeTBcCvNTJC5efYH56ucfavpLg2XOJ
         9AckL7Ceh0qr7NQMTAWaHA1ATX+njnAvTVHIh/OUeJ0/9dFZIpeaZs9xkxqyX00up7Is
         67fUA60LqD7cmdxfd2IxQc1Pcuz5jIlF6Gmbk998zQNhNprTyZOe0U+DUWq6fojZNbkh
         5jrq5vPDpWNfVJd4tktAcWTkyK72/gQOMI19uwl5kAG0UnKq5YWRt9G1OTmuDVqDUBqO
         4odIaUALMJbPInUFkz8EXEwtLHi/Un47HZZCMfPzR6uxV7lDXdv0EOlyOsXpY+frdjPS
         ap2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=loEBbKa5Ndufz/0YdKNALswJPUUf0CuP6QsASXheX1o=;
        b=jho91ladw1NqxX4Id7sXV1JfeLLLw5uk9FAPHf7GX6XDaO+BSklfCAlSXEE9sNtlwY
         L3LtovkF1B06Zn+6hFFPNTw7bmsKZ6VEqF/PHK21bXK0KSrva6ZLm96GCvVK/gaE41HL
         VwIy2u8gD1aLUg4pixe9z1UNL/MDxUXEoz79NLbDmGT3uUKKonyXSdgH0qrk8KYlB7hT
         AxYtwP4icu6awq91rLDL/K75X6FIXD8r1V4rFQFgf9GDztkXkVt/pe4/hvmUGNHKBGyB
         RkSQkMF38mDxDFR4y7nipThSoIgE884B2oFbnikGqxDMb4mQJGjfLOk+2ccUDcCYvFAS
         cEZA==
X-Gm-Message-State: AOAM5323pEXXlGFLnyET1S8WLbFAQBRy/btH2Qj16z7wcRsGTnGLGAt2
        2z4bzd68MGWpa5kiSuHmqrI0MU9CiXcVkA==
X-Google-Smtp-Source: ABdhPJyXLZ/NX2/0tyD5Vmr71iIcpYBLiXRQYku1uepql6hAHvWTX6HNsZbuPGpJ0dx7IfhwC6CYOs9g4J4E5Q==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:ad4:41c5:: with SMTP id
 a5mr15763127qvq.41.1612787864180; Mon, 08 Feb 2021 04:37:44 -0800 (PST)
Date:   Mon,  8 Feb 2021 12:37:37 +0000
Message-Id: <20210208123737.963172-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2 bpf-next] selftests/bpf: Add missing cleanup in
 atomic_bounds test
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

Differences from v1: this actually builds.

 tools/testing/selftests/bpf/prog_tests/atomic_bounds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
index addf127068e4..69bd7853e8f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
@@ -12,4 +12,6 @@ void test_atomic_bounds(void)
 	skel = atomic_bounds__open_and_load();
 	if (CHECK(!skel, "skel_load", "couldn't load program\n"))
 		return;
+
+	atomic_bounds__destroy(skel);
 }

base-commit: 23a2d70c7a2f28eb1a8f6bc19d68d23968cad0ce
--
2.30.0.478.g8a0d178c01-goog

