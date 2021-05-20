Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD838A043
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhETIyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhETIyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:54:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6775DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 01:53:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621500802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=skGknAwoPCnWVG2vIbapxefIECkgS4asZL7CQlC2/vA=;
        b=GOJQJWMPrPgdhhjj5r3+3aNjLrqNK1mp48wbLJNIG+sytIkPv0AzRgtQNxCnoN1awN8u38
        cPiWH/ifiyt7TrXOCrkLS28SxETZsYB/mzV+T0QORXNIv3D3JAPFa1idddK0dRz3u6aE2Q
        dJOC8xp/2m0b72rCCVS0p1nlp2vWhtAzqqetAFZH4eNwjmthVaWGWFuKvqiIlQeDbwLiZz
        +qerfKMJRcoUrdxYNxsf2Vx9tjZoe/nf7+ZM5yP/ajSEA5LF/N2fKH8ULNq1kf875Camrz
        GOREoFrg27FVZGCdKEAlQaI349hnJE+2YDa7qoZDWMFt0WJBUNQCD/SXSFhk0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621500802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=skGknAwoPCnWVG2vIbapxefIECkgS4asZL7CQlC2/vA=;
        b=sSyLi6KeW5sAPJ6RpB9HYH1YmmIqj2RmYFSInSJqJhXlNivEXpNi2Qd5ULFDPsR9NjZSRS
        DO+Rho+qvqq+KJCA==
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] x86/syscall: use int everywhere for system call numbers
In-Reply-To: <20210518191303.4135296-7-hpa@zytor.com>
References: <20210518191303.4135296-1-hpa@zytor.com> <20210518191303.4135296-7-hpa@zytor.com>
Date:   Thu, 20 May 2021 10:53:21 +0200
Message-ID: <87zgwpbxby.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18 2021 at 12:13, H. Peter Anvin wrote:
> +static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
> +{
> +	/*
> +	 * Convert negative numbers to very high and thus out of range
> +	 * numbers for comparisons. Use unsigned long to slightly
> +	 * improve the array_index_nospec() generated code.

How is that actually improving the generated code?

unsigned long:

 104:	48 81 fa bf 01 00 00 	cmp    $0x1bf,%rdx
 10b:	48 19 c0             	sbb    %rax,%rax
 10e:	48 21 c2             	and    %rax,%rdx
 111:	48 89 df             	mov    %rbx,%rdi
 114:	48 8b 04 d5 00 00 00 	mov    0x0(,%rdx,8),%rax
 11b:	00 
 11c:	e8 00 00 00 00       	callq  121 <do_syscall_64+0x41>

unsigned int:

  f1:	48 81 fa bf 01 00 00 	cmp    $0x1bf,%rdx
  f8:	48 19 d2             	sbb    %rdx,%rdx
  fb:	21 d0                	and    %edx,%eax
  fd:	48 89 df             	mov    %rbx,%rdi
 100:	48 8b 04 c5 00 00 00 	mov    0x0(,%rax,8),%rax
 107:	00 
 108:	e8 00 00 00 00       	callq  10d <do_syscall_64+0x3d>

Text size increases with that unsigned long cast.

I must be missing something.

Thanks,

        tglx
