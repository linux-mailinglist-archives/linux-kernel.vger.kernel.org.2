Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2255532CFFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhCDJqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237932AbhCDJqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:46:09 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F79AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:45:29 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n10so18540329pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MuNPzfsWJUyRk+KPgWKVHnHgzpGFaFQwGMRZkE6IW4A=;
        b=ptxStdrvnHB0B14UwfcoHGQ+2IjoBNcw9mNmsn7ZWL8WSZgiQPzbWXdAGWzipC4YkL
         dF6kGlS3o7qz7qFlewXUgOA8dPpdjpeWaHTv/RdgB9OoqNN9HQ6vBomIJEIabEdTdcOv
         AoFkyrVKGZ4uY0/gB5FgtnFZVnUEHMa21+yDT33f9T4sTWJ8hzhrYRztz+0O1lbZK1Bi
         MPp6cI5SZHrBfWpKGrCn9S0zvq13Or3ruYEBBff+iqNXlcVox8X57byd8cBojmAonFhq
         VtWIj1y/hHTwb6V7QQZBcDQDQrzYPd6CpH3bTPe+lNRUhqHdO3tcZZTg/5b6I+baqYjJ
         kDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MuNPzfsWJUyRk+KPgWKVHnHgzpGFaFQwGMRZkE6IW4A=;
        b=uSRQRZz5oR/8FS1XPpynIajIowSS8DXDRkiob6RSvVPvieuwQXm6dDF9JY7NKkWuzB
         Gycb/nrugVuvER+yT+iaX2P5TS8EMT5Tao4jgD+Ku5rZtIiW/wfMcjW2waUFnQue+sLB
         3va+zp8+YefBMpjtaTXGNdlTgXJzZtftpUL/f9XG9+dnm4lXO9xyoVAGsMGeMJaNCEqX
         4pocQyHWN7bMs9g9I1scwVTP7qQtVhbTFqEJ86mTDPrY+u6E4GY2J2NNn7Lfu/K45TYL
         DTwqejPJraMnm7l+Ls++ZqM70i+4ofrvJ0G4/EisXl4HxmL8vy75t3mHHiA2CLaFWfpv
         LZ5A==
X-Gm-Message-State: AOAM531eXCrc5VjFhCMCgcpTnCBgTszhg/7gOwc+TAmT/yZKv9kJKLvy
        U4NsLBw6xBoBeT42qcztJPx6AqIwDIQ=
X-Google-Smtp-Source: ABdhPJzfswaya9YgU4DlSmX0SeW5tvmE8VTdyMYk67yzz3KJcAm2JQKjrEz7gbB9z9oEn4wPBnMxDw==
X-Received: by 2002:a63:f808:: with SMTP id n8mr3010545pgh.115.1614851128570;
        Thu, 04 Mar 2021 01:45:28 -0800 (PST)
Received: from cosmos ([103.113.142.250])
        by smtp.gmail.com with ESMTPSA id i20sm6043111pgg.65.2021.03.04.01.45.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Mar 2021 01:45:28 -0800 (PST)
Date:   Thu, 4 Mar 2021 15:15:24 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: fix memory leaks in __create_synth_event()
Message-ID: <20210304094521.GA1826@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

In __create_synth_event(),while iterating field/type arguments, the
argv_split() will return array of atleast 2 elements even when zero
arguments(argc=0) are passed. for e.g. when there is double delimiter
or string ends with delimiter

To fix call argv_free() even when argc=0.

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
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
2.17.1

