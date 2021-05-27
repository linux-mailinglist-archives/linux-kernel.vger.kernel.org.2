Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92EE392577
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhE0Dbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhE0Dby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:31:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:30:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v13-20020a17090abb8db029015f9f7d7290so4712666pjr.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NDFRD/MnroMzwShB8KPyuuiXqZ9lYk7B6Up7JR9HCSY=;
        b=nPR8Ubr37KjdsCNSlw4n5AeiMWqC6vs51qoHYMRW2MieC7JDbH/2ACj9jsZAWpXGIF
         9JGdZ3CD1yW+GODQYfOmB44oRlYOJaeZ5BG4F8iOaaFU0jVY8BkfhtyXxwKmHYHxVam0
         59IQso6CHNjKM0jDe1DT+gAVxl2FJiU15XFZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NDFRD/MnroMzwShB8KPyuuiXqZ9lYk7B6Up7JR9HCSY=;
        b=eCwRg8j/rxgB+ELNrcw2FkVINx8akzudOOY53UVWb0tSwsZsXdkhbfXp+eveRyrnH7
         tWYWC6sldDnNu4bV4+kEmIKHgwWsNgB4CbbCXAhTj3Mo8GSu1kOIzxdXmvKXdk+Ij1um
         eaPCDItRfG+0KwoyouaiZmCMsEfGb+0fClC5R5/IhQK/g4RiJ/cnoENk7EanU1R/ixgH
         Yb2jc9TrkWgpkBC/ET2jI3nIinpSj9rczJ7vk3pFXUTFWFB4KZFxVqRHdd9B5V2IKHnm
         C3h7MnrLbwQR+xpERyh0Ly+HIkDITpwBCa90JIg4f2Wmi+TMtFpyy8qjsvzwhZPUwHDI
         ieag==
X-Gm-Message-State: AOAM532RD5gT/caeRI9xwAaPmt2YLxCUOVUYd6PUb/o5zPSpX4PzTW+r
        HO1UUAwKdddIFz6beFO6XSdM9O7wwrQHZQ==
X-Google-Smtp-Source: ABdhPJwlW4I9Ur9Gzdlr+YKxu44krneyEH1+faFi2ojpnK9Jx6HOT3qi5Scc8Xj5JynZAB6zpynw1A==
X-Received: by 2002:a17:90b:2357:: with SMTP id ms23mr1486021pjb.96.1622086221577;
        Wed, 26 May 2021 20:30:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o134sm523280pfd.58.2021.05.26.20.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 20:30:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH] selftests/seccomp: Flush benchmark output regularly
Date:   Wed, 26 May 2021 20:30:18 -0700
Message-Id: <20210527033018.3731126-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=bd641d3971b51b9a068073ed18f974f18a380d43; i=7hLQTCF2EV2fIOUF6saf13OApWBFbccyMw31e/DaLUo=; m=fow9+w90zfO2bRGSX/3NCf1HjH+mLALgEf1U9iLJQ5U=; p=aiPY1gyVpT+EspIxQwCwrr3Ov+y9RTYRckxw+wJ/fn0=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCvEkkACgkQiXL039xtwCZB2hAAlYz n3mRIhI1FeYxCWcP5GRLJRF3ygd4dl88Z3cp01ttDk3jx7ajGG4YLoHypnqi+FC6D9Wi5rh75gKwG tGq9xUU2TLtF3oG9ecLr8CcNuQpLoSyG/WWjFGMwQULbW4rwjZMK53znZxeiEr+XQbbUfIsn85IBw ZT0K2SYz0KfdjtQOgtL5O6jUxKF8S5WHUuNZ+vUxUvQO7tdEJytT9ZCuPoUWEKY/Hsj6ADQeUYsY2 EIcOrEMsZeQiAhCicLoJ+ay6KuI69QeSEPt0HItiJCndXB6BMdw+Eg3yw1j2fqF9wtaMpNoPLVkdJ oUtD307DO3Psw77DYCjZH7XLdFQmXyPEOwXnyYN+8LRL4j97d2Ko9IUAti5Dr3FJk+FRgEtdoAOAb DEdkiUcRUEYhfelXruTIpD5D7/Sc17GKG+uNgVq5fPvl/kJ1ce0FclTdYCFRSwfgMfTjQtU09LxZN NtSjgDlq+/rrzWVkppooqdZYNNIVdpF6iTeZdeW6wdsM36pagK9gwJ4iotuBStv6yTjN24YYofg/m Psq/I0Ho+Y+z5TJJQ3iH3grD06E32DT1JR/b0FVY/R6HMWgnk9TtWGWKOQZ/8iWCQLJMKBCxg1rKj lodlIbD21XtTtv2zOQK3v610LyrN2uQLIdg782WYeAg5SklZw/wLflEIJqn0iCbc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the seccomp benchmark under a test runner, it wouldn't
provide any feedback on progress. Force IO flushes during the test.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index fcc806585266..7be1e2131f79 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -42,6 +42,7 @@ unsigned long long timing(clockid_t clk_id, unsigned long long samples)
 		finish.tv_sec, finish.tv_nsec,
 		start.tv_sec, start.tv_nsec,
 		i, (double)i / 1000000000.0);
+	fflush(NULL);
 
 	return i;
 }
@@ -54,6 +55,7 @@ unsigned long long calibrate(void)
 	int seconds = 15;
 
 	printf("Calibrating sample size for %d seconds worth of syscalls ...\n", seconds);
+	fflush(NULL);
 
 	samples = 0;
 	pid = getpid();
@@ -157,6 +159,7 @@ int main(int argc, char *argv[])
 	/* Native call */
 	native = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
 	printf("getpid native: %llu ns\n", native);
+	fflush(NULL);
 
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	assert(ret == 0);
@@ -167,6 +170,7 @@ int main(int argc, char *argv[])
 
 	bitmap1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
 	printf("getpid RET_ALLOW 1 filter (bitmap): %llu ns\n", bitmap1);
+	fflush(NULL);
 
 	/* Second filter resulting in a bitmap */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
@@ -174,6 +178,7 @@ int main(int argc, char *argv[])
 
 	bitmap2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
 	printf("getpid RET_ALLOW 2 filters (bitmap): %llu ns\n", bitmap2);
+	fflush(NULL);
 
 	/* Third filter, can no longer be converted to bitmap */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
@@ -181,6 +186,7 @@ int main(int argc, char *argv[])
 
 	filter1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
 	printf("getpid RET_ALLOW 3 filters (full): %llu ns\n", filter1);
+	fflush(NULL);
 
 	/* Fourth filter, can not be converted to bitmap because of filter 3 */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
@@ -188,6 +194,7 @@ int main(int argc, char *argv[])
 
 	filter2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
 	printf("getpid RET_ALLOW 4 filters (full): %llu ns\n", filter2);
+	fflush(NULL);
 
 	/* Estimations */
 #define ESTIMATE(fmt, var, what)	do {			\
-- 
2.25.1

