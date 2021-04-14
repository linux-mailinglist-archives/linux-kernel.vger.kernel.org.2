Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3919135F88A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhDNP5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhDNP5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:57:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC02C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:56:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so2814547wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hakvSth19CwFZlwh3YMNFY/spXWwZoBmln8dVIngfeE=;
        b=kqd1G5z0GmuSbfpQML2emAiJnZ8ErF4Ml3gO7hMACxJU7U4LODHnQGoipPcWW8wQvc
         t/bSuv3k42mx0hV7BXldowWUR2grG4rkTgSr0GMFBbvo3j+omXvQz0lYr80og2Amrev8
         ZavAVJ3n8d4ioH+Sjf1NK6IKpVeYKG7vTXwQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hakvSth19CwFZlwh3YMNFY/spXWwZoBmln8dVIngfeE=;
        b=qkB2W3r5qYqzvDQpZD9Tdkmdp5bKqvzEzjRnYPnQPlO/ted+pmJm9trXCR101PE/cI
         P3suLHxIsO8DLhHvJG+WA14LvCZwmFdetQjdOIwDCEL/kFVGwaIOrX4jiOiJ+Pza5XoW
         +2EdD+zU6rezP/qj3+U/6Hm0KVwrTg/niN3EbCVTewj6alCa4zX5M2A0coikpRl1beZX
         2k7wMB3b0+cz34KvOD9GqBVjGYouq0LXITqeKeNuC8KgQoUknJZ1mNbbXZADhrGzMcfn
         NA0TdtFtPiyhjcA2DwbWvyp9y14V/UePtnfrPknOQpoN1mYfxkwgWjSkS+udsdIUPv7F
         OHYQ==
X-Gm-Message-State: AOAM533eUE0rE5cK+FALRX7JHZBwnsUunllq2koOxbABsRsh8VEBeHUu
        BckFhqttEyTW2rC9k7YQ7fIAB2wrcLJtuw==
X-Google-Smtp-Source: ABdhPJxDm4ArJeDTutVnC8hE1110UxbwPKrqMSxmdnsugIhkHTlRMAJAsLUSvTL933ggj4XLnddwGg==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr3670803wmj.54.1618415799574;
        Wed, 14 Apr 2021 08:56:39 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:8b2a:41bd:9d62:10d5])
        by smtp.gmail.com with ESMTPSA id s14sm20545578wrm.51.2021.04.14.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:56:39 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH] selftests/bpf: Fix the ASSERT_ERR_PTR macro
Date:   Wed, 14 Apr 2021 17:56:32 +0200
Message-Id: <20210414155632.737866-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is just missing a ';'. This macro is not used by any test yet.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/bpf/test_progs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index e87c8546230e..ee7e3b45182a 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -210,7 +210,7 @@ extern int test__join_cgroup(const char *path);
 #define ASSERT_ERR_PTR(ptr, name) ({					\
 	static int duration = 0;					\
 	const void *___res = (ptr);					\
-	bool ___ok = IS_ERR(___res)					\
+	bool ___ok = IS_ERR(___res);					\
 	CHECK(!___ok, (name), "unexpected pointer: %p\n", ___res);	\
 	___ok;								\
 })
-- 
2.31.1.295.g9ea45b61b8-goog

