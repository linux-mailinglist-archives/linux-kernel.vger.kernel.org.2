Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF673F6AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 23:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhHXVT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 17:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhHXVTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 17:19:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47AA161247;
        Tue, 24 Aug 2021 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629839949;
        bh=YfWmgyuD68bN8upiO0KXXatKOqqx5eEEKTXFIn2lrms=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ChXXmcCaJdPDbxO/bgCMAiDWs1dseVoXupLGua0zD9oVMZrXR0BU/f+gHIsqQoa2i
         5XRa4L1lw6H9KdnvZ+ZrXP/q9OBKIwiuacMvT393RtEbiCTWqfMsWsibPrka9kdC+i
         GXgSVOnVnBUfkKhfFshhSe11FRlWKT9CpCKM6EWCvk2Nun85U9pvtpHzV17TlQk84H
         p8kaBMOFNqe0mfDQsPITtmCrg3i+mPg6OatJ2yV9IuwbDvVbILvtOB07sb7nsJ5CxX
         MB/QLqcdg6t+QTYP27RjJIdpP9BJ2jrXgkRzfTQAVOGVfvHpHpu1odh/ZHcw4dMVSL
         sSX4qvu/rQP6Q==
Subject: Re: objtool warning in cfg80211_edmg_chandef_valid() with ThinLTO
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <5913cdf4-9c8e-38f8-8914-d3b8a3565d73@kernel.org>
 <20210824210507.GC17784@worktop.programming.kicks-ass.net>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <dedde693-bf1d-a35b-e858-dab1f8f65246@kernel.org>
Date:   Tue, 24 Aug 2021 14:19:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824210507.GC17784@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/2021 2:05 PM, Peter Zijlstra wrote:
> On Tue, Aug 24, 2021 at 01:08:58PM -0700, Nathan Chancellor wrote:
> 
>> The LLVM developers are under the impression that this is an issue with
>> objtool; specifically quoting Eli Friedman:
>>
>> "The backend can, in general, create basic blocks that don't contain any
>> instructions, and don't fall through to another block. A jump table entry
>> can refer to such a block. I guess certain tools could be confused by this.
>>
>> If that's the issue, it should be possible to work around it using '-mllvm
>> -trap-unreachable'."
> 
> So jump-tables are a weak point; ARM64 was having worse problems than
> x86 there, they can't even locate them.
> 
> As to having a jump-table entry to an empty block and not falling
> through; how are we supposed to know?

Fair enough. It does make me wonder why LLVM does that.

> Emitting them is a waste of space, so I'd say it's a compiler bug :-))

Isn't it always? :)

Turns out Nick brought up an issue very similar to this (unreachable 
conditions with switches) on LLVM's issue tracker 
(https://bugs.llvm.org/show_bug.cgi?id=50080) with the same workaround 
suggestion ('-mllvm -trap-unreachable') and there was no follow up after 
that so maybe that is one thing to look into once Nick is back online.

> It's been brought up before; but perhaps we should look at an 'informal'
> ABI for jump-tables ?
Not a bad idea, especially if this has come up before.

Cheers,
Nathan
