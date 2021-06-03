Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E650C39A287
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFCNyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:54:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:51811 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhFCNyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:54:05 -0400
IronPort-SDR: LMDMo8rqObo8LLD3STpRDtoooU/w3CZBAYiAs+4vKUQIg5fYGEJ1zfQxivWtcS+N1uXPfvXMos
 glFybxiObfSg==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="202188128"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="202188128"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 06:52:21 -0700
IronPort-SDR: fv56pyERrrhKBW/gDO/7lXeQpqsHLUUKL+t9kRcRwUJuqj95ljzowb3MrW9/EFobTBJqLPu0d5
 PPU2EdRVXORQ==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="550697803"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.7.237]) ([10.209.7.237])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 06:52:20 -0700
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, inglorion@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <00000000000030293b05c39afd6f@google.com>
 <20210602230054.vyqama2q3koc4bpo@treble>
 <527ad07e-eec2-a211-03e7-afafe5196100@linux.intel.com>
 <YLjZYvXnuPnbXzOm@hirez.programming.kicks-ass.net>
 <20210603133914.j2aeadmvhncnlk5q@treble>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <0b71d4f9-f707-3d39-c358-7c06c5689a9d@linux.intel.com>
Date:   Thu, 3 Jun 2021 06:52:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603133914.j2aeadmvhncnlk5q@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> True, ftrace does have function profiling (function_profile_enabled).
>
> Steve, is there a way to enable that on the kernel cmdline?

That's not really comparable. function profiling has a lot more 
overhead. Also there is various code which has ftrace instrumentation 
disabled.

I don't think why you want to kill the old profiler. It's rarely used, 
but when you need it usually works. It's always good to have simple fall 
backs. And it's not that it's a lot of difficult code.

-Andi

