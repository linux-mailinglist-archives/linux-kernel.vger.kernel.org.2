Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96640CEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhIOV3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhIOV3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:29:32 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED589C061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:28:12 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b6so4553420ilv.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/05t+cft47v+XjdfjmqtyGwgO/Y9iAdxp4y0oub3sQ=;
        b=EM5CoyJnEhE01BEs479VfIK4jImJFA22maAiLWfX5Z5H5XLK6PeVPVtKY+6RzJT87g
         H2wcT9fOX9GB0dUitCiGG5KaaQ1Quna3ubgUKRq++A8LoyLlgRCHzrLG4Kr6Uzpa0s7/
         a2HRzuRsOc5tj+nz+zso25WUH+s7WG+oOfKMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/05t+cft47v+XjdfjmqtyGwgO/Y9iAdxp4y0oub3sQ=;
        b=R9vLGSZy0WUeleBU4FJ4OM0jZCbJn2VzsXN917BMH9SaFUnns5nTcnbq8eQNoJDcjz
         0BMjsoF8NQ5hLkjgBRhvc8Z+nDzfWo4jN9J89KkgFMrK0aq9C8t41gy+bqhLQKp0z51e
         FX+XKD9fQNYEBmRX0jjJGa4yNFx7r4LSElFQ7zcFfzsrxEiQ/RidK5hZDS9/jiaCrHAY
         4dmpVczJNhQsasfZjTrMOqygACwNgRDIntskjKXkxOqhLb+/Lc+b4sgHLiB4Zf0XBNyA
         A71cKkH3HeRIrez+xlo5QeFmpdBPimSnjHhX2qxqh1MG18HhYa2LiLXLPwsOafb1bb4U
         tV3Q==
X-Gm-Message-State: AOAM531yawVpFJJaxEYQT5OZJixlQ79V2mC/Bu119csNTJq8dS6jtehJ
        ftPLIVCFdvQ0bo2RSmclU5IB1rnlbzTxIw==
X-Google-Smtp-Source: ABdhPJzxwqX7gRE030Q48r8VOe+p/R3TO1zws/jz/AaNUPiJtQPKoSMaf/CgIE2QH4dRMm+QAjA+MQ==
X-Received: by 2002:a92:bf0c:: with SMTP id z12mr1588379ilh.241.1631741292332;
        Wed, 15 Sep 2021 14:28:12 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f2sm622884ioz.14.2021.09.15.14.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:28:11 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] selftests:kvm: fix get_warnings_count() ignoring fscanf() return warn
Date:   Wed, 15 Sep 2021 15:28:06 -0600
Message-Id: <9dfad43fb500a77f7a08e5e7b80dcb07172d6e44.1631737524.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1631737524.git.skhan@linuxfoundation.org>
References: <cover.1631737524.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix get_warnings_count() to check fscanf() return value to get rid
of the following warning:

x86_64/mmio_warning_test.c: In function ‘get_warnings_count’:
x86_64/mmio_warning_test.c:85:2: warning: ignoring return value of ‘fscanf’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
   85 |  fscanf(f, "%d", &warnings);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kvm/x86_64/mmio_warning_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index e6480fd5c4bd..8039e1eff938 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -82,7 +82,8 @@ int get_warnings_count(void)
 	FILE *f;
 
 	f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
-	fscanf(f, "%d", &warnings);
+	if (fscanf(f, "%d", &warnings) < 1)
+		warnings = 0;
 	fclose(f);
 
 	return warnings;
-- 
2.30.2

