Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120C2348E80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCYLGg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Mar 2021 07:06:36 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:10591 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229801AbhCYLGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:06:32 -0400
Subject: Re: [PATCH v2 00/12] Add build ID to stacktraces
To:     Christoph Hellwig <hch@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
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
 <20210324085543.GA2660708@infradead.org>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <dbb430e1-2223-9df0-2563-4b017d6b409d@sony.com>
Date:   Thu, 25 Mar 2021 12:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210324085543.GA2660708@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=crzlbGwi c=1 sm=1 tr=0 a=fZcToFWbXLKijqHhjJ02CA==:117 a=IkcTkHD0fZMA:10 a=dESyimp9J3IA:10 a=9PaoSj5ytQdNhtA7W4EA:9 a=QEXdDO2ut3YA:10 a=fCgQI5UlmZDRPDxm0A3o:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 9:55 AM, Christoph Hellwig wrote:
> On Tue, Mar 23, 2021 at 07:04:31PM -0700, Stephen Boyd wrote:
>>  x5 : 0000000000000000 x4 : 0000000000000001
>>  x3 : 0000000000000008 x2 : ffffff93fef25a70
>>  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
>>  Call trace:
>>   lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
>>   direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
> Yikes.  No, please do not make the backtraces a complete mess for
> something that serves absolutely no need.

Would a "verbose" flag be acceptable solution?    Something like write 1 to /sys/kernel/debug/verbose_stack to get the extra info.

I think I see a need for it.

