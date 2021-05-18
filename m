Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5115838805A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbhERTPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:15:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38295 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240805AbhERTPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:15:04 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14IJDDRo4008171
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 18 May 2021 12:13:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14IJDDRo4008171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621365214;
        bh=KCIa/Uo4jzG+ExN9vc+ow3svYGd1O74NW9f3zQXMBIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8xDzSB35CxxBZbPghKZETrb12cRJ7QVBdXWIx/sR98N7n7JEOf8kXqPLRkYJUAUL
         ZBD2pyKUgRrf0AocvYv2UvcaFXcbrJaAuu1WGTL/QB/xdS2Buov4gHSkom1m2NjTZX
         rpukeMrXqqN7iy8uoI3egb/67HRLAmVo+52Z5kb5M7guaWhLf6QfZb8WinjTVuoabG
         3gCpvep81mNZ9LXqe3c+ow663AWaLE+241xjiBPOtEEuNwlJqStTsvwM7A8QAoF8Mx
         8tiXYS1Jsnj/bPniPVdh8k69DM96Jvz5VsUbXqaBM3EA7R5Abw+KQoktnuL+vTV/CS
         0jnpJgbDuLFoA==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/6] x86/syscall: simplify message reporting in syscall_numbering.c
Date:   Tue, 18 May 2021 12:12:59 -0700
Message-Id: <20210518191303.4135296-3-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518191303.4135296-1-hpa@zytor.com>
References: <20210518191303.4135296-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Reduce some boiler plate in printing and indenting messages in
syscall_numbering.c. This makes it easier to produce clean status
output.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 .../testing/selftests/x86/syscall_numbering.c | 102 ++++++++++++------
 1 file changed, 71 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
index 7dd86bcbee25..03915cd48cfc 100644
--- a/tools/testing/selftests/x86/syscall_numbering.c
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -34,6 +34,33 @@
 
 static unsigned int nerr = 0;	/* Cumulative error count */
 static int nullfd = -1;		/* File descriptor for /dev/null */
+static int indent = 0;
+
+static inline unsigned int offset(void)
+{
+	return 8+indent*4;
+}
+
+#define msg(lvl, fmt, ...) printf("%-*s" fmt, offset(), "[" #lvl "]", \
+                                 ## __VA_ARGS__)
+
+#define run(fmt, ...)  msg(RUN,  fmt, ## __VA_ARGS__)
+#define info(fmt, ...) msg(INFO, fmt, ## __VA_ARGS__)
+#define ok(fmt, ...)   msg(OK,   fmt, ## __VA_ARGS__)
+
+#define fail(fmt, ...)					\
+	do {						\
+		msg(FAIL, fmt, ## __VA_ARGS__);		\
+		nerr++;					\
+	} while (0)
+
+#define crit(fmt, ...)					\
+	do {						\
+		indent = 0;				\
+		msg(FAIL, fmt, ## __VA_ARGS__);		\
+		msg(SKIP, "Unable to run test\n");	\
+		exit(71); /* EX_OSERR */		\
+	} while (0)
 
 /*
  * Directly invokes the given syscall with nullfd as the first argument
@@ -91,28 +118,37 @@ static unsigned int _check_for(int msb, int start, int end, long long expect,
 {
 	unsigned int err = 0;
 
+	indent++;
+	if (start != end)
+		indent++;
+
 	for (int nr = start; nr <= end; nr++) {
 		long long ret = probe_syscall(msb, nr);
 
 		if (ret != expect) {
-			printf("[FAIL]\t      %s returned %lld, but it should have returned %s\n",
+			fail("%s returned %lld, but it should have returned %s\n",
 			       syscall_str(msb, nr, nr),
 			       ret, expect_str);
 			err++;
 		}
 	}
 
+	if (start != end)
+		indent--;
+
 	if (err) {
 		nerr += err;
 		if (start != end)
-			printf("[FAIL]\t      %s had %u failure%s\n",
+			fail("%s had %u failure%s\n",
 			       syscall_str(msb, start, end),
-			       err, (err == 1) ? "s" : "");
+			       err, err == 1 ? "s" : "");
 	} else {
-		printf("[OK]\t      %s returned %s as expected\n",
-		       syscall_str(msb, start, end), expect_str);
+		ok("%s returned %s as expected\n",
+		   syscall_str(msb, start, end), expect_str);
 	}
 
+	indent--;
+
 	return err;
 }
 
@@ -137,35 +173,38 @@ static bool check_enosys(int msb, int nr)
 static bool test_x32(void)
 {
 	long long ret;
-	long long mypid = getpid();
+	pid_t mypid = getpid();
+	bool with_x32;
 
-	printf("[RUN]\tChecking for x32 by calling x32 getpid()\n");
+	run("Checking for x32 by calling x32 getpid()\n");
 	ret = probe_syscall(0, SYS_GETPID | X32_BIT);
 
+	indent++;
 	if (ret == mypid) {
-		printf("[INFO]\t   x32 is supported\n");
-		return true;
+		info("x32 is supported\n");
+		with_x32 = true;
 	} else if (ret == -ENOSYS) {
-		printf("[INFO]\t   x32 is not supported\n");
-		return false;
+		info("x32 is not supported\n");
+		with_x32 = false;
 	} else {
-		printf("[FAIL]\t   x32 getpid() returned %lld, but it should have returned either %lld or -ENOSYS\n", ret, mypid);
-		nerr++;
-		return true;	/* Proceed as if... */
+		fail("x32 getpid() returned %lld, but it should have returned either %lld or -ENOSYS\n", ret, mypid);
+		with_x32 = false;
 	}
+	indent--;
+	return with_x32;
 }
 
 static void test_syscalls_common(int msb)
 {
-	printf("[RUN]\t   Checking some common syscalls as 64 bit\n");
+	run("Checking some common syscalls as 64 bit\n");
 	check_zero(msb, SYS_READ);
 	check_zero(msb, SYS_WRITE);
 
-	printf("[RUN]\t   Checking some 64-bit only syscalls as 64 bit\n");
+	run("Checking some 64-bit only syscalls as 64 bit\n");
 	check_zero(msb, X64_READV);
 	check_zero(msb, X64_WRITEV);
 
-	printf("[RUN]\t   Checking out of range system calls\n");
+	run("Checking out of range system calls\n");
 	check_for(msb, -64, -1, -ENOSYS);
 	check_for(msb, X32_BIT-64, X32_BIT-1, -ENOSYS);
 	check_for(msb, -64-X32_BIT, -1-X32_BIT, -ENOSYS);
@@ -180,18 +219,18 @@ static void test_syscalls_with_x32(int msb)
 	 * set.  Calling them without the x32 bit set is
 	 * nonsense and should not work.
 	 */
-	printf("[RUN]\t   Checking x32 syscalls as 64 bit\n");
+	run("Checking x32 syscalls as 64 bit\n");
 	check_for(msb, 512, 547, -ENOSYS);
 
-	printf("[RUN]\t   Checking some common syscalls as x32\n");
+	run("Checking some common syscalls as x32\n");
 	check_zero(msb, SYS_READ   | X32_BIT);
 	check_zero(msb, SYS_WRITE  | X32_BIT);
 
-	printf("[RUN]\t   Checking some x32 syscalls as x32\n");
+	run("Checking some x32 syscalls as x32\n");
 	check_zero(msb, X32_READV  | X32_BIT);
 	check_zero(msb, X32_WRITEV | X32_BIT);
 
-	printf("[RUN]\t   Checking some 64-bit syscalls as x32\n");
+	run("Checking some 64-bit syscalls as x32\n");
 	check_enosys(msb, X64_IOCTL  | X32_BIT);
 	check_enosys(msb, X64_READV  | X32_BIT);
 	check_enosys(msb, X64_WRITEV | X32_BIT);
@@ -199,7 +238,7 @@ static void test_syscalls_with_x32(int msb)
 
 static void test_syscalls_without_x32(int msb)
 {
-	printf("[RUN]\t  Checking for absence of x32 system calls\n");
+	run("Checking for absence of x32 system calls\n");
 	check_for(msb, 0 | X32_BIT, 999 | X32_BIT, -ENOSYS);
 }
 
@@ -217,14 +256,18 @@ static void test_syscall_numbering(void)
 	 */
 	for (size_t i = 0; i < sizeof(msbs)/sizeof(msbs[0]); i++) {
 		int msb = msbs[i];
-		printf("[RUN]\tChecking system calls with msb = %d (0x%x)\n",
-		       msb, msb);
+		run("Checking system calls with msb = %d (0x%x)\n",
+		    msb, msb);
+
+		indent++;
 
 		test_syscalls_common(msb);
 		if (with_x32)
 			test_syscalls_with_x32(msb);
 		else
 			test_syscalls_without_x32(msb);
+
+		indent--;
 	}
 }
 
@@ -241,19 +284,16 @@ int main(void)
 	 */
 	nullfd = open("/dev/null", O_RDWR);
 	if (nullfd < 0) {
-		printf("[FAIL]\tUnable to open /dev/null: %s\n",
-		       strerror(errno));
-		printf("[SKIP]\tCannot execute test\n");
-		return 71;	/* EX_OSERR */
+		crit("Unable to open /dev/null: %s\n", strerror(errno));
 	}
 
 	test_syscall_numbering();
 	if (!nerr) {
-		printf("[OK]\tAll system calls succeeded or failed as expected\n");
+		ok("All system calls succeeded or failed as expected\n");
 		return 0;
 	} else {
-		printf("[FAIL]\tA total of %u system call%s had incorrect behavior\n",
-		       nerr, nerr != 1 ? "s" : "");
+		fail("A total of %u system call%s had incorrect behavior\n",
+		     nerr, nerr != 1 ? "s" : "");
 		return 1;
 	}
 }
-- 
2.31.1

