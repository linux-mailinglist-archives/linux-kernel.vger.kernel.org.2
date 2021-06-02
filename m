Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FD2399667
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 01:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFBXhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 19:37:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:40062 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhFBXhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:37:02 -0400
IronPort-SDR: h01bxdGvwnoLZQYpZwaQI+30ZfgIYm+pcesEGExnLesCDWzwNnfxu8l5lM0SsuRpeQk8Cbggtw
 mek2cbBfQ8lw==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="267793181"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="267793181"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 16:35:13 -0700
IronPort-SDR: TY/3vp8j2UJAdB+5YHVpmtbplCRFpT9ECukUksTHe7HIVNb0KByfUn5AzkdN7szhcXLi6SLtGF
 AYD72W8cOiGw==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="550480767"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.87.193]) ([10.209.87.193])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 16:35:12 -0700
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, inglorion@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
References: <00000000000030293b05c39afd6f@google.com>
 <20210602230054.vyqama2q3koc4bpo@treble>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <527ad07e-eec2-a211-03e7-afafe5196100@linux.intel.com>
Date:   Wed, 2 Jun 2021 16:35:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602230054.vyqama2q3koc4bpo@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> profile_pc() assumes the return address is either directly at regs->sp,
> or one word adjacent to it due to saved flags, both of which are just
> completely wrong.  This code has probably never worked with ORC, and
> nobody noticed apparently.

I presume it used to work because the lock functions were really simple, 
but that's not true anymore.

>
> We could just use ORC to unwind to the next frame.  Though, isn't
> /proc/profile redundant, compared to all the more sophisticated options
> nowadays?  Is there still a distinct use case for it or can we just
> remove it?

It's still needed for some special cases. For example there is no other 
viable way to profile early boot without a VM

I would just drop the hack to unwind, at least for the early boot 
profile use case locking profiling is usually not needed.

-Andi

