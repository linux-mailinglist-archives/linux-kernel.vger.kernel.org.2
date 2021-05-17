Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D00F382849
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbhEQJaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbhEQJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:30:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160E9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:28:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k5-20020a05600c4785b0290174b7945d7eso2745094wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UekJLfYsQQ9U7jHP9ExccSivPWVMtsjWSFlJO7W1AFc=;
        b=KJKsXdQjOO0+jmpc8hEvK/54LqAG2bMlKXcGcaSpRnRl9aPY3ViNRijH2EPhT1uwDJ
         nixOf6hXly9CfjbDPcjFKfydJMCNHxeXeiY51cbM1hs4PGVvxUOHQuE5cwcqNMuJqaZX
         m6SvFk+nqadDBxYbp73QHhrzUCngFiWyRwhRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UekJLfYsQQ9U7jHP9ExccSivPWVMtsjWSFlJO7W1AFc=;
        b=iYN1IQAIh9gpKGFqMaM5D/hpIe6Ji8onjGoWHyQ6+XAxgntUrcMe2AKtglUXF1hfFm
         dM1xGZiRJfG7UQrJ/9P1TQ4wGrGuhXJJ6/yEspL+7vsupumcvWvixzLENfktZY5qG2Rt
         KxLfCz0Sa5yWvbxFFHS05dUmBDd5oMlpxsdtdDLWNxrMy0wzez/ZO7BLgmd03Z/Z4t9o
         vzETmPyMH0eX7v07rmxTtH5zgb8bc9zN7Z5f2DDKDitm+9znTqhd+kf35QBiLh/Ou822
         8FtOmqPhvew5W21bYdfIymNhc5nAuS0Xa/AlDs/KNBZxYcpVhn+rrRIyjIWO4iB9nWqq
         /7XA==
X-Gm-Message-State: AOAM532UrYne+XilT38+sXJwxAsiP+BAccDc3TCfTD3kza93efrWr1Zw
        rXMNK3N04lMcrua+1ni9Ebg6bQ==
X-Google-Smtp-Source: ABdhPJxa+9Z5sLcMkeGMTF4+AK2meXbrrogNh6WPRkBmSXgeC4y9gYxgwoIBeP/8WproL9fM81bSVg==
X-Received: by 2002:a05:600c:3545:: with SMTP id i5mr21813454wmq.43.1621243730802;
        Mon, 17 May 2021 02:28:50 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:6c6d:556b:3e10:9fd0])
        by smtp.gmail.com with ESMTPSA id e8sm16316616wrt.30.2021.05.17.02.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:28:50 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf 1/2] bpf: Clarify a bpf_bprintf_prepare macro
Date:   Mon, 17 May 2021 11:28:29 +0200
Message-Id: <20210517092830.1026418-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-cpu buffers contain bprintf data rather than printf arguments.
The macro name and comment were a bit confusing, this rewords them in a
clearer way.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/bpf/helpers.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ef658a9ea5c9..3a5ab614cbb0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -692,13 +692,14 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 	return -EINVAL;
 }
 
-/* Per-cpu temp buffers which can be used by printf-like helpers for %s or %p
+/* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
+ * arguments representation.
  */
-#define MAX_PRINTF_BUF_LEN	512
+#define MAX_BPRINTF_BUF_LEN	512
 
 /* Support executing three nested bprintf helper calls on a given CPU */
 struct bpf_bprintf_buffers {
-	char tmp_bufs[3][MAX_PRINTF_BUF_LEN];
+	char tmp_bufs[3][MAX_BPRINTF_BUF_LEN];
 };
 static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
 static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
@@ -761,7 +762,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		if (num_args && try_get_fmt_tmp_buf(&tmp_buf))
 			return -EBUSY;
 
-		tmp_buf_end = tmp_buf + MAX_PRINTF_BUF_LEN;
+		tmp_buf_end = tmp_buf + MAX_BPRINTF_BUF_LEN;
 		*bin_args = (u32 *)tmp_buf;
 	}
 
-- 
2.31.1.751.gd2f1c929bd-goog

