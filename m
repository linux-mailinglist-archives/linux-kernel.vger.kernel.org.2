Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F0E348EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCYLPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:15:09 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:11461 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229988AbhCYLOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:14:42 -0400
Subject: Re: [PATCH v2 00/12] Add build ID to stacktraces
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, <kexec@lists.infradead.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>,
        <x86@kernel.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <a7a5e6b4-109b-fdf6-5d72-1d8675a2b1ae@sony.com>
Date:   Thu, 25 Mar 2021 12:14:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=crzlbGwi c=1 sm=1 tr=0 a=9drRLWArJOlETflmpfiyCA==:117 a=IkcTkHD0fZMA:10 a=dESyimp9J3IA:10 a=g0dnI_grFRafmFuLWKwA:9 a=QEXdDO2ut3YA:10 a=fCgQI5UlmZDRPDxm0A3o:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 3:04 AM, Stephen Boyd wrote:
> This series adds the kernel's build ID[1] to the stacktrace header printed
> in oops messages, warnings, etc. and the build ID for any module that
> appears in the stacktrace after the module name. The goal is to make the
> stacktrace more self-contained and descriptive by including the relevant
> build IDs in the kernel logs when something goes wrong. This can be used
> by post processing tools like script/decode_stacktrace.sh and kernel
> developers to easily locate the debug info associated with a kernel
> crash and line up what line and file things started falling apart at.
>
> To show how this can be used I've included a patch to
> decode_stacktrace.sh that downloads the debuginfo from a debuginfod
> server.
>
> This also includes some patches to make the buildid.c file use more
> const arguments and consolidate logic into buildid.c from kdump. These
> are left to the end as they were mostly cleanup patches. I don't know
> who exactly maintains this so I guess Andrew is the best option to merge
> all this code.
>
> Here's an example lkdtm stacktrace on arm64.
>
>  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
>  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
>  CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
>  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
>  pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
>  pc : lkdtm_WARNING+0x28/0x30 [lkdtm]
>  lr : lkdtm_do_action+0x24/0x40 [lkdtm]
>  sp : ffffffc0134fbca0
>  x29: ffffffc0134fbca0 x28: ffffff92d53ba240
>  x27: 0000000000000000 x26: 0000000000000000
>  x25: 0000000000000000 x24: ffffffe3622352c0
>  x23: 0000000000000020 x22: ffffffe362233366
>  x21: ffffffe3622352e0 x20: ffffffc0134fbde0
>  x19: 0000000000000008 x18: 0000000000000000
>  x17: ffffff929b6536fc x16: 0000000000000000
>  x15: 0000000000000000 x14: 0000000000000012
>  x13: ffffffe380ed892c x12: ffffffe381d05068
>  x11: 0000000000000000 x10: 0000000000000000
>  x9 : 0000000000000001 x8 : ffffffe362237000
>  x7 : aaaaaaaaaaaaaaaa x6 : 0000000000000000
>  x5 : 0000000000000000 x4 : 0000000000000001
>  x3 : 0000000000000008 x2 : ffffff93fef25a70
>  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
>  Call trace:
>   lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
>   direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
>   full_proxy_write+0x74/0xa4
>   vfs_write+0xec/0x2e8
>   ksys_write+0x84/0xf0
>   __arm64_sys_write+0x24/0x30
>   el0_svc_common+0xf4/0x1c0
>   do_el0_svc_compat+0x28/0x3c
>   el0_svc_compat+0x10/0x1c
>   el0_sync_compat_handler+0xa8/0xcc
>   el0_sync_compat+0x178/0x180
>  ---[ end trace 3d95032303e59e68 ]---

How will this work with the ftrace?

