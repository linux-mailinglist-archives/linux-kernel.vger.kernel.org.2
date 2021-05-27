Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC023938AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 00:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhE0WZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 18:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhE0WZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 18:25:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE54EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 15:23:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m124so1012285pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7ujJ7Smgw3QSNlRofE7ahXwieqUQs0QzorIXzd3kSw=;
        b=k6oV4Rdz0LaxHXrHKUHjszJN7f9CJjuGlok6FZww/1bhzRARjx4wTlbVAtw3jvKiDS
         UOar18qVPiIg2PU7octp/3a42CMsq4fy9/UwK7P7lW00PNvClnW/irYh6IGeDCt9CL+D
         OuqgR3q6MZbTaYXrlL8Cv53odEILAvj40oJTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7ujJ7Smgw3QSNlRofE7ahXwieqUQs0QzorIXzd3kSw=;
        b=jSubcDe85+/VnuKla1NeVYQwmmOXmMON1YTe72oMLQCyLn+wWW2/iidnfeoqMTyAvp
         jdVCUB36FXOsnc8bMOpZ9kjwONIQ2U/JXqoquJGw0h38uNCdgh+ZyX2kyKZZf/RBQ4tQ
         BPf2JlQrgCA9uI8MgIC/zsWqTP/V10DOXYG/C1WL+UGJxnDjbUH6YLADAKy4bxfq/CE1
         Vm2sbF4mpxX2wgYbGz5f7wKpDjJ1PvyZN6sqZaxsYKygis3RdPq18n9yRSi5zI3VEdiH
         kmi6XJHIXjurpITmsEpFPbmj9yQGZdhtLTCmUeVA2Avc4rbUoZdXh7japVxfyUsYpla8
         ii6A==
X-Gm-Message-State: AOAM533MaZAthZ9VSWfm6RI+fckTqVv6RW5PrPYmVXBE9pZQ/S33J5GA
        1OgQBq1dNVb+usLcfZ7TlNgw2hLCSWwlIQ==
X-Google-Smtp-Source: ABdhPJzlsT6oL2D+fX8ecOTvqxXMMgVTx+KyePORx2SWzVOV4I4lTGtq7E8A3BYfrQELG7sS/U8Svw==
X-Received: by 2002:a62:7c46:0:b029:2dc:cb24:b5b1 with SMTP id x67-20020a627c460000b02902dccb24b5b1mr674546pfc.77.1622154233196;
        Thu, 27 May 2021 15:23:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j2sm2766390pji.34.2021.05.27.15.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 15:23:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2] selftests/seccomp: Flush benchmark output
Date:   Thu, 27 May 2021 15:23:49 -0700
Message-Id: <20210527222349.160313-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=50025d7c2f709b9526e76b6ce960f09690d87971; i=6243iECffBLBf0eyaYHwzDsTKC256/cNcbWhMnbB4WY=; m=vLz2ndLISh7t89L+RgrK0PLRIKThT5XRvLRgLgB9Qt8=; p=Z127bkhPB8jdCUW260X9wzE+8VCFTf74lJIc26Bcp3s=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCwG/QACgkQiXL039xtwCZY9Q/+LTK 8cQXKLBNkMElrLLAwCuXHNC62Gx6CeUkpWJ/iekfYE+JJi/qw4UUybYonKWSnVceMeCY6Ck3BSseJ 0KCw+1iBS/mVBHIZSFIvVih0SBLLDXGLprxu2rx+bjNtMXX3LATlFw/cOzPdrVzx5WOFyXdWlwzYb 2ULu49gfzQdmd8p2oJ/XLNMdo/hVU0fzv5aRGAJumeScpOynbreHT2U70KWbMH+9iJY7Op2dX/AmN VCjdGa0cezXioonYe2Kp7nxD2a0chs/0PBHkrKihVyjRtRxhu8YPMaA/0adPpyntSM5oywV+Rt74g GnQKvKROn3PpVKLn9SOoqEdpBtB17avKWDcp4ldHssXR1HXfaKiPBgU9MkLqdMJ/GZCWG7qfPDPmi 7JwQUwH85pqFeFiTZdW5LGacIvLoChx1EmidG4/cmk3S75crXFqeE3ZmjBs5x8Gj4NBiSp6iE+bwH 9tLvkijBvRyF+ru6jhyvGvGl2uWMGAEjwWV9DTBmW57D3rBqdhbPLkVkODhfIcW/YYUaNSSsdePYP yery9UZckgLx0FI+0XepgTFzmJHQJHQyGrgU6oWP9P6vltProhAx171R/3rjOBrCWQZwGW8T+mKqW Kco+zdajbUBx+hDtO6N4N9KPtWW0DZ6qbuKKUDTuG5xWck48YW04pTJlhoeuUVTI=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the seccomp benchmark under a test runner, it wouldn't
provide any feedback on progress. Set stdout unbuffered.

Suggested-by: Will Drewry <wad@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index fcc806585266..363cad755042 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -143,6 +143,8 @@ int main(int argc, char *argv[])
 	unsigned long long native, filter1, filter2, bitmap1, bitmap2;
 	unsigned long long entry, per_filter1, per_filter2;
 
+	setbuf(stdout, NULL);
+
 	printf("Current BPF sysctl settings:\n");
 	system("sysctl net.core.bpf_jit_enable");
 	system("sysctl net.core.bpf_jit_harden");
-- 
2.25.1

