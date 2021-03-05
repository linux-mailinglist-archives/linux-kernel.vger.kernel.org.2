Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7722532EB8E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 13:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCEMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 07:45:58 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:53116 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhCEMpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 07:45:42 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210305124540epoutp04f55da201194b0d0406053cfa5d04e345~pcvWismWm1310213102epoutp04l
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 12:45:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210305124540epoutp04f55da201194b0d0406053cfa5d04e345~pcvWismWm1310213102epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614948340;
        bh=JCMvGomjly37ON+Q63Pcg9XCIS3EcwzznHjh/pt+BsQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YkJVb/PhtCAyRBDgrltGeAWyAVPcQ2oY5cgcdztMPpSDxFZdAMoiZea7nvSScnozh
         gw8whdl6kL/OtBJB4dX+BcTVx5XgCi2LhxVBZjWfKfOUIoAG5VdZkscKlwGvmSxDbL
         +PmH+1BdjiFHK4V9AHXmV1PeoSZZqo6NQ6QAnyUU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210305124539epcas1p15f36c58ddde3ffe2a254ca762c42e5ab~pcvVelvtW1271012710epcas1p1h;
        Fri,  5 Mar 2021 12:45:39 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DsSBp4MMCz4x9Pp; Fri,  5 Mar
        2021 12:45:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.BD.63458.2F722406; Fri,  5 Mar 2021 21:45:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210305124537epcas1p1930302083680f1b1cf87e37630556460~pcvTVr2361271412714epcas1p1c;
        Fri,  5 Mar 2021 12:45:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210305124537epsmtrp1791347d4203962f57cda4fa70bbff354~pcvTTl5Sj2379623796epsmtrp1B;
        Fri,  5 Mar 2021 12:45:37 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-d1-604227f2c6c8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.8D.08745.0F722406; Fri,  5 Mar 2021 21:45:37 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210305124536epsmtip17ff60342b71593edc935f225adae6c14~pcvTA2Lfp1867218672epsmtip1g;
        Fri,  5 Mar 2021 12:45:36 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     jordan.lim@samsung.com, Sangmoon Kim <sangmoon.kim@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: traps: add tracepoints for unusal exception cases
Date:   Fri,  5 Mar 2021 21:36:30 +0900
Message-Id: <20210305123635.27492-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTQPeTulOCwdPZMhYTpr1gsZjyYQer
        xdSHT9gs3i/rYbRomruH0eLlrm1MFjeWhVlsenyN1eLyrjlsFkuvX2SyuHRgAZNF/53rbBb7
        Oh4wWdx60Mhi0XLH1IHfY828NYweO2fdZfdo2XeL3WPBplKPTas62Tw2L6n3eL/vKptH35ZV
        jB6fN8kFcEbl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYAna+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7Uy
        NDAwMgWqTMjJuLRkDWvBDJmKN3MfsTcwnhHvYuTkkBAwkZi6eSJzFyMXh5DADkaJv0e+sUE4
        nxglJp+fCOV8ZpSYdu8GM0zL7DVHwGwhgV2MEtuuekMUfWGU2DJ7BliCTUBX4su8y4wgtoiA
        j8TWv7fBbGaBW8wSa/fHdDFycAgLeEr8WhkIEmYRUJVoWPABrIRXwFZi78HL7BC75CVWbzgA
        dp6EQCuHxOVNH6ASLhJvj/+FsoUlXh3fAmVLSbzsb4Oy9zFK7FkpA9E8hVFi+ZQdUAljid6e
        C8wgRzALaEqs36UPEVaU2Pl7LtSdfBLvvvawgpRICPBKdLQJQZSoSTx+dZcRwpaR6L8znwXC
        9pCY+HkHGyRMYiVaHm1imsAoOwthwQJGxlWMYqkFxbnpqcWGBUbIkbSJEZwktcx2ME56+0Hv
        ECMTB+MhRgkOZiURXtt7jglCvCmJlVWpRfnxRaU5qcWHGE2BATaRWUo0OR+YpvNK4g1NjYyN
        jS1MzMzNTI2VxHkTDR7ECwmkJ5akZqemFqQWwfQxcXBKNTBpsXG9f6vz8cP5w8urwpmb2Oon
        F6yT285ruuzdwtlSdc/zf0z+p3DvAXPO1/LtW8+Vpz5dW5h6YOpGUYGdMVuKb0d8dTJLzXzK
        dGHx7sXB397dnpTQfubwrvmMi3pE4nJDPHK3XWetihLLVZCPOzlnogjf4+mfXvf8DePUlDu/
        13eCzesv4c+fxd7zTe273Lhyholceq5gyRR5fcWw2o25+bM9TneElH0LeBW64Yn1Yf3u9cYS
        Cs+L9ZLF7jydGdzx8drfbRLfw1Zu/VmktIND2WzG9MCoGJmiR9qqFfKNsUpxNu0fni1uzkm9
        pC+wtq3vRbTSa2X51cJxH98/2bTBdtMB5ddTzkqUzzHb+z5KiaU4I9FQi7moOBEAW6CQIBsE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnO5HdacEgzvnmC0mTHvBYjHlww5W
        i6kPn7BZvF/Ww2jRNHcPo8XLXduYLG4sC7PY9Pgaq8XlXXPYLJZev8hkcenAAiaL/jvX2Sz2
        dTxgsrj1oJHFouWOqQO/x5p5axg9ds66y+7Rsu8Wu8eCTaUem1Z1snlsXlLv8X7fVTaPvi2r
        GD0+b5IL4IzisklJzcksSy3St0vgyri0ZA1rwQyZijdzH7E3MJ4R72Lk5JAQMJGYveYIcxcj
        F4eQwA5GiRmfZrJCJGQkdl7czNTFyAFkC0scPlwMUfOJUWL2zStsIDVsAroSX+ZdZgSpERHw
        k3j2rA6khlngGbPEnF0LWEDiwgKeEr9WBoKUswioSjQs+MAIYvMK2ErsPXiZHWKVvMTqDQeY
        JzDyLGBkWMUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERyyWlo7GPes+qB3iJGJg/EQ
        owQHs5IIr+09xwQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4
        OKUamMTKdLuf73PI3B7CsmvC7fW8HKapEbsivYuOp1S0FWp0BbsVWm16np7IPH/e1Am/znCW
        MjUtOb/7u3aO1Gt1BwNm/Q1psRJMn9K+sRwSEuiWVEgQD7G5VWktbjnvmfvUikd1N48dn28Z
        rCBRsGjRyhnivPnO825dKhRxPpZ6/aXRk1e+C/vCHdIu3lu/fFvYznb5lVWSp2NcfhZJ119l
        aV30ZM+l17+fPjgc6JO20F99hosAy0bld3Gnyo6sK9Wesqs43fztDYVTHTzNk6Z+5dxUZHMm
        xGx9jsWy7Suir1uob/bf7NWXmK7wtOPdSwumKzKR8mazIsUYZ9kdKTqZGzStKLbPssEjUiuk
        YH6SEktxRqKhFnNRcSIA5vAiBcgCAAA=
X-CMS-MailID: 20210305124537epcas1p1930302083680f1b1cf87e37630556460
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210305124537epcas1p1930302083680f1b1cf87e37630556460
References: <CGME20210305124537epcas1p1930302083680f1b1cf87e37630556460@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel panic occurs, a kernel module can use either the
panic_notifier or die_notifier to obtain the debugging information.

However, in case of these exceptions like do_undefinstr(), regs and
esr data are not passed on. Although a module might be able to find
those data in the console messages, parsing text messages is very
expensive behavior for a module especially on mobile devices.

These bare tracepoints allow a module to probe regs and esr information
for debugging purpose. _tp suffix comes from bare tracepoints of
sched/core.c

Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
---
 arch/arm64/kernel/traps.c    | 15 +++++++++++++
 include/trace/events/traps.h | 41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 include/trace/events/traps.h

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index a05d34f0e82a..e58797743442 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -45,6 +45,17 @@
 #include <asm/system_misc.h>
 #include <asm/sysreg.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/traps.h>
+
+/*
+ * Export tracepoints that act as a bare tracehook (ie: have no trace event
+ * associated with them) to allow external modules to probe them.
+ */
+EXPORT_TRACEPOINT_SYMBOL_GPL(traps_undefinstr_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(traps_bad_mode_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(traps_serror_panic_tp);
+
 static const char *handler[] = {
 	"Synchronous Abort",
 	"IRQ",
@@ -403,6 +414,8 @@ void do_undefinstr(struct pt_regs *regs)
 	if (call_undef_hook(regs) == 0)
 		return;
 
+	if (!user_mode(regs))
+		trace_traps_undefinstr_tp(regs, 0);
 	BUG_ON(!user_mode(regs));
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
@@ -766,6 +779,7 @@ asmlinkage void notrace bad_mode(struct pt_regs *regs, int reason, unsigned int
 
 	__show_regs(regs);
 	local_daif_mask();
+	trace_traps_bad_mode_tp(regs, esr);
 	panic("bad mode");
 }
 
@@ -832,6 +846,7 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, u32 esr)
 	if (regs)
 		__show_regs(regs);
 
+	trace_traps_serror_panic_tp(regs, esr);
 	nmi_panic(regs, "Asynchronous SError Interrupt");
 
 	cpu_park_loop();
diff --git a/include/trace/events/traps.h b/include/trace/events/traps.h
new file mode 100644
index 000000000000..b4f53db90ce7
--- /dev/null
+++ b/include/trace/events/traps.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM traps
+
+#if !defined(_TRACE_TRAPS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TRAPS_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * Following tracepoints are not exported in tracefs and provide hooking
+ * mechanisms only for testing and debugging purposes.
+ *
+ * Postfixed with _tp to make them easily identifiable in the code.
+ */
+
+/*
+ * Tracepoint for unhandled undefined exception at EL1.
+ */
+DECLARE_TRACE(traps_undefinstr_tp,
+	TP_PROTO(struct pt_regs *regs, unsigned int esr),
+	TP_ARGS(regs, esr));
+
+/*
+ * Tracepoint for bad_mode for the impossible case in the exception vector.
+ */
+DECLARE_TRACE(traps_bad_mode_tp,
+	TP_PROTO(struct pt_regs *regs, unsigned int esr),
+	TP_ARGS(regs, esr));
+
+/*
+ * Tracepoint for unhandled SError exception.
+ */
+DECLARE_TRACE(traps_serror_panic_tp,
+	TP_PROTO(struct pt_regs *regs, unsigned int esr),
+	TP_ARGS(regs, esr));
+
+#endif /* _TRACE_TRAPS_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

