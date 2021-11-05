Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A463446716
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhKEQgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhKEQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:36:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE054C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:34:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id br12so17978526lfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzrUiRlOTDSyR0yIE9XOqUFOZskRKEswBH4H0O7JYfs=;
        b=r2PBYD0o/7yKVv84EqGaFVVcJIV9W1GBljo7y9hvbw5+a18HKBJwR6qJQMfh+/F3+w
         yslWA8z+hy+4/pUFfMYI0EvKEWT9S2n+abnTLYaNrqqY5oa7AjOoKXUpkRmIroPZmtVO
         iOjeb93++S5lV5Dd/e2PLnXsYFr40WK7q0hoJY26w381ckDpjYEiQodqdxUAMU6tK3mv
         EAOsxuiYQfAYEE21otp2/ll5sAesersuUKg0z4OEgqAphHu3IuoOK80p8f74ZTYx2q/B
         QS0/Nmpu48SImGqaf7D0FfyO4sA5XVOfMWJTKWnsTTtUoz0gzGtquweT6E27AA8JX7iN
         +9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzrUiRlOTDSyR0yIE9XOqUFOZskRKEswBH4H0O7JYfs=;
        b=ZydL5AsBRQGgeMPpg4GIkyovoSUlot3bDqkahDG1QmfAumgFajHO7krlQKnWX5j80P
         tmDIRQA6qA00ZOdnbiJc/RkTIitIaH+mXmWMjz0r6Q0ZPKMvMYIWF71YkiPfpUsZSdis
         tRWhWwLa7GW245VJWjJeC23E4eW35wEewYoEieXdIKUvLaSM+ZfZWCZN1nWumgYH8mTV
         E8W2V5Wjy6JEG58qSrXQ/rV2Di/PmQwjkpeMZWZ3GFG26MioRFP01WPyqOAvqIgM9/wO
         vchBgSikBV9etCcUnFSbJ3GObjG2ZObUQo23a8mooSFVxUPAWzmOxIeORyyp37wEcFcE
         fssg==
X-Gm-Message-State: AOAM532ckbTka24VPwxP1WacMNnY84q0cZdjIoIbdJirh3Rha0pY1j4g
        c/QFL9xMkbYhXys6Um7OdIk4hw==
X-Google-Smtp-Source: ABdhPJxRsIIRzYyKsBNMYNxRJ1ENdoWMYWMReqQjdDKf3Yx8utY6fyEAwzjPyisJ268xjPYHjvc0gQ==
X-Received: by 2002:a05:6512:3caa:: with SMTP id h42mr3684376lfv.544.1636130048161;
        Fri, 05 Nov 2021 09:34:08 -0700 (PDT)
Received: from localhost ([85.229.40.155])
        by smtp.gmail.com with ESMTPSA id bu5sm973559lfb.50.2021.11.05.09.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:34:07 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, tglx@linutronix.de, john.stultz@linaro.org
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: timers: use 'llabs()' over 'abs()'
Date:   Fri,  5 Nov 2021 17:34:03 +0100
Message-Id: <20211105163403.3330950-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building selftests/timers with clang, the compiler warn about the
function abs() see below:

posix_timers.c:69:6: warning: absolute value function 'abs' given an argument of type 'long long' but has parameter of type 'int' which may cause truncation of value [-Wabsolute-value]
        if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
            ^
posix_timers.c:69:6: note: use function 'llabs' instead
        if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
            ^~~
            llabs

The note indicates what to do, Rework to use the function 'llabs()'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/timers/posix_timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 337424c5c987..73fb27901a1d 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -66,7 +66,7 @@ static int check_diff(struct timeval start, struct timeval end)
 	diff = end.tv_usec - start.tv_usec;
 	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
 
-	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
+	if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
 		printf("Diff too high: %lld..", diff);
 		return -1;
 	}
-- 
2.33.0

