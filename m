Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A232D3C410B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 03:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhGLBnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 21:43:20 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54574 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhGLBnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 21:43:19 -0400
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16C1eRvc024402;
        Mon, 12 Jul 2021 10:40:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 12 Jul 2021 10:40:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16C1eRgP024399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Jul 2021 10:40:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [5.14-rc1] kbuild: stdout from cmd should not be discarded
Message-ID: <c4d2f929-9a1f-d816-5a24-e2bf8a64fa8f@i-love.sakura.ne.jp>
Date:   Mon, 12 Jul 2021 10:40:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 174a1dcc96429efc ("kbuild: sink stdout from cmd for silent build")
confuses users by sending prompt messages from

  scripts/kconfig/conf -s --syncconfig

to /dev/null before start waiting for response to prompt messages
when building with "make -s". Reverting that commit fixes this problem.

----------
$ make
  SYNC    include/config/auto.conf.cmd
*
* Restart config...
*
*
* General setup
*
Compile also drivers which will not load (COMPILE_TEST) [N/y/?] n
Local version - append to kernel release (LOCALVERSION) []
Automatically append version information to the version string (LOCALVERSION_AUTO) [N/y/?] n
Build ID Salt (BUILD_SALT) []
Kernel compression mode
> 1. Gzip (KERNEL_GZIP)
  2. Bzip2 (KERNEL_BZIP2)
  3. LZMA (KERNEL_LZMA)
  4. XZ (KERNEL_XZ)
  5. LZO (KERNEL_LZO)
  6. LZ4 (KERNEL_LZ4)
  7. ZSTD (KERNEL_ZSTD)
choice[1-7?]: 1
Default init path (DEFAULT_INIT) []
Default hostname (DEFAULT_HOSTNAME) [(none)] (none)
Support for paging of anonymous memory (swap) (SWAP) [Y/n/?] y
System V IPC (SYSVIPC) [Y/n/?] y
POSIX Message Queues (POSIX_MQUEUE) [Y/n/?] y
General notification queue (WATCH_QUEUE) [Y/n/?] y
Enable process_vm_readv/writev syscalls (CROSS_MEMORY_ATTACH) [Y/n/?] y
uselib syscall (USELIB) [Y/n/?] y
Auditing support (AUDIT) [Y/n/?] y
Preemption Model
  1. No Forced Preemption (Server) (PREEMPT_NONE)
  2. Voluntary Kernel Preemption (Desktop) (PREEMPT_VOLUNTARY)
> 3. Preemptible Kernel (Low-Latency Desktop) (PREEMPT)
choice[1-3?]: 3
Core Scheduling for SMT (SCHED_CORE) [N/y/?] (NEW) ^Cmake[2]: *** [scripts/kconfig/Makefile:77: syncconfig] Interrupt
make[1]: *** [Makefile:626: syncconfig] Interrupt
make: *** [Makefile:735: include/config/auto.conf.cmd] Interrupt
