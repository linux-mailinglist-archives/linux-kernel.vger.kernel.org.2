Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B073C32DE9F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 01:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhCEAwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 19:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhCEAw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 19:52:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53C16500E;
        Fri,  5 Mar 2021 00:52:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lHyhe-001sUH-F9; Thu, 04 Mar 2021 19:52:26 -0500
Message-ID: <20210305005226.350410136@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Mar 2021 19:52:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Subject: [for-linus][PATCH 1/3] tracing: Fix memory leak in __create_synth_event()
References: <20210305005201.588505771@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>

kmemleak report:
unreferenced object 0xc5a6f708 (size 8):
  comm "ftracetest", pid 1209, jiffies 4294911500 (age 6.816s)
  hex dump (first 8 bytes):
    00 c1 3d 60 14 83 1f 8a                          ..=`....
  backtrace:
    [<f0aa4ac4>] __kmalloc_track_caller+0x2a6/0x460
    [<7d3d60a6>] kstrndup+0x37/0x70
    [<45a0e739>] argv_split+0x1c/0x120
    [<c17982f8>] __create_synth_event+0x192/0xb00
    [<0708b8a3>] create_synth_event+0xbb/0x150
    [<3d1941e1>] create_dyn_event+0x5c/0xb0
    [<5cf8b9e3>] trace_parse_run_command+0xa7/0x140
    [<04deb2ef>] dyn_event_write+0x10/0x20
    [<8779ac95>] vfs_write+0xa9/0x3c0
    [<ed93722a>] ksys_write+0x89/0xc0
    [<b9ca0507>] __ia32_sys_write+0x15/0x20
    [<7ce02d85>] __do_fast_syscall_32+0x45/0x80
    [<cb0ecb35>] do_fast_syscall_32+0x29/0x60
    [<2467454a>] do_SYSENTER_32+0x15/0x20
    [<9beaa61d>] entry_SYSENTER_32+0xa9/0xfc
unreferenced object 0xc5a6f078 (size 8):
  comm "ftracetest", pid 1209, jiffies 4294911500 (age 6.816s)
  hex dump (first 8 bytes):
    08 f7 a6 c5 00 00 00 00                          ........
  backtrace:
    [<bbac096a>] __kmalloc+0x2b6/0x470
    [<aa2624b4>] argv_split+0x82/0x120
    [<c17982f8>] __create_synth_event+0x192/0xb00
    [<0708b8a3>] create_synth_event+0xbb/0x150
    [<3d1941e1>] create_dyn_event+0x5c/0xb0
    [<5cf8b9e3>] trace_parse_run_command+0xa7/0x140
    [<04deb2ef>] dyn_event_write+0x10/0x20
    [<8779ac95>] vfs_write+0xa9/0x3c0
    [<ed93722a>] ksys_write+0x89/0xc0
    [<b9ca0507>] __ia32_sys_write+0x15/0x20
    [<7ce02d85>] __do_fast_syscall_32+0x45/0x80
    [<cb0ecb35>] do_fast_syscall_32+0x29/0x60
    [<2467454a>] do_SYSENTER_32+0x15/0x20
    [<9beaa61d>] entry_SYSENTER_32+0xa9/0xfc

In __create_synth_event(), while iterating field/type arguments, the
argv_split() will return array of atleast 2 elements even when zero
arguments(argc=0) are passed. for e.g. when there is double delimiter
or string ends with delimiter

To fix call argv_free() even when argc=0.

Link: https://lkml.kernel.org/r/20210304094521.GA1826@cosmos

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2979a96595b4..8d71e6c83f10 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1225,8 +1225,10 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 			goto err;
 		}
 
-		if (!argc)
+		if (!argc) {
+			argv_free(argv);
 			continue;
+		}
 
 		n_fields_this_loop = 0;
 		consumed = 0;
-- 
2.30.0


