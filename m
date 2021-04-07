Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6BC356E14
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352755AbhDGODb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:03:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:45262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343988AbhDGODa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:03:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617804199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RhbxS97pzXo6yg1ZJjSrAw7B2tiGA+xSGkssiHUPHsM=;
        b=LkNDFVwOrVK9L4CHZTJaXNqDgT8ZL+7TZZ+g/DAeDb6LzNZTqIz4YlB7ygm/gMAklCZt15
        jpoCzvM2F2z15pNKByB+A3y4Nj9p0pa5SEMVWnpMJFhPkiysLrBdm/qKlVhIujNeZB6UgP
        tw2Gv93TfVLADxQC7jpiAoA1IroV7pk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3FC5B159;
        Wed,  7 Apr 2021 14:03:19 +0000 (UTC)
Date:   Wed, 7 Apr 2021 16:03:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 03/12] dump_stack: Add vmlinux build ID to stack traces
Message-ID: <YG27p1AhiOKJOm+y@alley>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331030520.3816265-4-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-30 20:05:11, Stephen Boyd wrote:
> Add the running kernel's build ID[1] to the stacktrace information
> header.  This makes it simpler for developers to locate the vmlinux with
> full debuginfo for a particular kernel stacktrace. Combined with
> scripts/decode_stracktrace.sh, a developer can download the correct
> vmlinux from a debuginfod[2] server and find the exact file and line
> number for the functions plus offsets in a stacktrace.
> 
> This is especially useful for pstore crash debugging where the kernel
> crashes are recorded in the pstore logs and the recovery kernel is
> different or the debuginfo doesn't exist on the device due to space
> concerns (the data can be large and a security concern). The stacktrace
> can be analyzed after the crash by using the build ID to find the
> matching vmlinux and understand where in the function something went
> wrong.
> 
> Example stacktrace from lkdtm:
> 
>  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
>  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
>  CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1

I tried "echo l >/proc/sysrq-trigger" and get:

[   75.123014] CPU: 1 PID: 5079 Comm: bash Kdump: loaded Not tainted 5.12.0-rc6-default+ #169 00000080ffffffff0000000000000000
00000000

It does not look like an unique ID. I have already reported this for
v2. But you sent v3 just 8 hours later before I was able to provide
more details.

Anyway, here are the requested details:

# hex /sys/kernel/notes 
0000  04 00 00 00 06 00 00 00  06 00 00 00 58 65 6e 00  ........ ....Xen.
0010  6c 69 6e 75 78 00 00 00  04 00 00 00 04 00 00 00  linux... ........
0020  07 00 00 00 58 65 6e 00  32 2e 36 00 04 00 00 00  ....Xen. 2.6.....
0030  08 00 00 00 05 00 00 00  58 65 6e 00 78 65 6e 2d  ........ Xen.xen-
0040  33 2e 30 00 04 00 00 00  08 00 00 00 03 00 00 00  3.0..... ........
0050  58 65 6e 00 00 00 00 80  ff ff ff ff 04 00 00 00  Xen..... ........
0060  08 00 00 00 0f 00 00 00  58 65 6e 00 00 00 00 00  ........ Xen.....
0070  80 00 00 00 04 00 00 00  08 00 00 00 01 00 00 00  ........ ........
0080  58 65 6e 00 c0 11 34 93  ff ff ff ff 04 00 00 00  Xen...4. ........
0090  08 00 00 00 02 00 00 00  58 65 6e 00 00 20 00 91  ........ Xen.. ..
00a0  ff ff ff ff 04 00 00 00  29 00 00 00 0a 00 00 00  ........ ).......
00b0  58 65 6e 00 21 77 72 69  74 61 62 6c 65 5f 70 61  Xen.!wri table_pa
00c0  67 65 5f 74 61 62 6c 65  73 7c 70 61 65 5f 70 67  ge_table s|pae_pg
00d0  64 69 72 5f 61 62 6f 76  65 5f 34 67 62 00 00 00  dir_abov e_4gb...
00e0  04 00 00 00 04 00 00 00  11 00 00 00 58 65 6e 00  ........ ....Xen.
00f0  01 88 00 00 04 00 00 00  04 00 00 00 09 00 00 00  ........ ........
0100  58 65 6e 00 79 65 73 00  04 00 00 00 08 00 00 00  Xen.yes. ........
0110  08 00 00 00 58 65 6e 00  67 65 6e 65 72 69 63 00  ....Xen. generic.
0120  04 00 00 00 10 00 00 00  0d 00 00 00 58 65 6e 00  ........ ....Xen.
0130  01 00 00 00 00 00 00 00  01 00 00 00 00 00 00 00  ........ ........
0140  04 00 00 00 04 00 00 00  0e 00 00 00 58 65 6e 00  ........ ....Xen.
0150  01 00 00 00 04 00 00 00  04 00 00 00 10 00 00 00  ........ ........
0160  58 65 6e 00 01 00 00 00  04 00 00 00 08 00 00 00  Xen..... ........
0170  0c 00 00 00 58 65 6e 00  00 00 00 00 00 80 ff ff  ....Xen. ........
0180  04 00 00 00 08 00 00 00  04 00 00 00 58 65 6e 00  ........ ....Xen.
0190  00 00 00 00 00 00 00 00  04 00 00 00 14 00 00 00  ........ ........
01a0  03 00 00 00 47 4e 55 00  6c ed 77 1e 56 f7 47 d0  ....GNU. l.w.V.G.
01b0  1c 17 cd 28 25 8e 48 61  60 ee 3d e2 06 00 00 00  ...(%.Ha `.=.....
01c0  01 00 00 00 00 01 00 00  4c 69 6e 75 78 00 00 00  ........ Linux...
01d0  00 00 00 00 04 00 00 00  08 00 00 00 12 00 00 00  ........ ........
01e0  58 65 6e 00 a0 06 00 11  00 00 00 00              Xen..... ....

and

# file vmlinux-5.12.0-rc6-default+ 
vmlinux-5.12.0-rc6-default+: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=6ced771e56f747d01c17cd28258e486160ee3de2, not stripped

and also

# readelf -Wn vmlinux-5.12.0-rc6-default+ 

Displaying notes found in: .notes
  Owner                 Data size       Description
  Xen                  0x00000006       Unknown note type: (0x00000006)    description data: 6c 69 6e 75 78 00 
  Xen                  0x00000004       Unknown note type: (0x00000007)    description data: 32 2e 36 00 
  Xen                  0x00000008       Unknown note type: (0x00000005)    description data: 78 65 6e 2d 33 2e 30 00 
  Xen                  0x00000008       Unknown note type: (0x00000003)    description data: 00 00 00 ffffff80 ffffffff ffffffff ffffffff ffffffff 
  Xen                  0x00000008       Unknown note type: (0x0000000f)    description data: 00 00 00 00 ffffff80 00 00 00 
  Xen                  0x00000008       NT_VERSION (version)       description data: ffffffc0 11 34 ffffff83 ffffffff ffffffff ffffffff ffffffff 
  Xen                  0x00000008       NT_ARCH (architecture)     description data: 00 20 00 ffffff81 ffffffff ffffffff ffffffff ffffffff 
  Xen                  0x00000029       Unknown note type: (0x0000000a)    description data: 21 77 72 69 74 61 62 6c 65 5f 70 61 67 65 5f 74 61 62 6c 65 73 7c 70 61 65 5f 70 67 64 69 72 5f 61 62 6f 76 65 5f 34 67 62 
  Xen                  0x00000004       Unknown note type: (0x00000011)    description data: 01 ffffff88 00 00 
  Xen                  0x00000004       Unknown note type: (0x00000009)    description data: 79 65 73 00 
  Xen                  0x00000008       Unknown note type: (0x00000008)    description data: 67 65 6e 65 72 69 63 00 
  Xen                  0x00000010       Unknown note type: (0x0000000d)    description data: 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 
  Xen                  0x00000004       Unknown note type: (0x0000000e)    description data: 01 00 00 00 
  Xen                  0x00000004       Unknown note type: (0x00000010)    description data: 01 00 00 00 
  Xen                  0x00000008       Unknown note type: (0x0000000c)    description data: 00 00 00 00 00 ffffff80 ffffffff ffffffff 
  Xen                  0x00000008       Unknown note type: (0x00000004)    description data: 00 00 00 00 00 00 00 00 
  GNU                  0x00000014       NT_GNU_BUILD_ID (unique build ID bitstring)         Build ID: 6ced771e56f747d01c17cd28258e486160ee3de2
  Linux                0x00000001       OPEN       description data: 00 
  Xen                  0x00000008       Unknown note type: (0x00000012)    description data: ffffffa0 06 00 01 00 00 00 00 


Best Regards,
Petr
