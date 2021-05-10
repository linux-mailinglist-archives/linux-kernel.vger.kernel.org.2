Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAC83791CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhEJPBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbhEJPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:00:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B41C028002
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:19:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s6so18878330edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpImL+tB/XUHzVGb+AbyDX33FOfais3F/VyVXseZvh4=;
        b=TAbBZ/1E9I2puIfEbEVMUzwVU96rJ1cldIEPCQXjF5fml6hiiUyxR91nM9xrZrkFTY
         yU9kuUkmjGV6ncE9HgSPCJHiRWAV7dZ9K0UbPZ+aTBIwffWIGKUU6gLnWRwKdjk44tgI
         pr0+8mrx+sYWU4pRo1su1qkjB8HeZSP+/Adk0V4NoEuLY0IqOU4MHS3Sx2djC6w//dQu
         ON7eMzobUTw+S+dpcxiiLt/zE0dCtnBPshgh7M6zAdcdWfHowlgY3HL7V/SrPH8WB+27
         qwNBA30INUjl7OTDURsi+GcmMF514SIUvd5CEdjy4+NyeGiA6vFwWwms4FyQnBoa28wd
         yl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpImL+tB/XUHzVGb+AbyDX33FOfais3F/VyVXseZvh4=;
        b=Rizva2BK/VF0YOMR9vNShSVAAIg9ub5zrj4smxh48BsRBdjfdPyMqyZkSjnY44Sui/
         VVtum5j5BV3yPI0VeuqofwhyAMq9IhGXbs1fT8k5FLhgzDh1nJH1dguEwrs8buME/bPG
         ujV0DbYXLmPuYBCVvcQMJUhNdnPKBbyYRo0NR/Ucjm8adN6uVHJxiW8XUdel78o0SQqQ
         BLSbGnPuwIP/fRS9jKtkV1gMxn9stCd/HdSEZMlFkeznSeZ98/eYpFDsZ9OSZRx/uBUX
         +KPVwrrHEGlB5BW32nA6S8f/ptxiSJlgqgsmsdR6RGRqlSvn/PdcnGL/Iw8HQ8V8AAfI
         RpOg==
X-Gm-Message-State: AOAM530cQ1XMZMXg3S2SMQxsoJsRK93ZEbvEBNRpw+3ew14FbjbdYkVg
        RqPc4Amf2qTnNmf3QPopd4ZpRLLEEH9eaKj73i0=
X-Google-Smtp-Source: ABdhPJzEArh67NTPV25SncAHGMqHWUv8XpPTtSPs/tn8phQSrAYuNIat6mUWQFzKS6xpiHbxbF1nCDQvjx9MVUAeRYY=
X-Received: by 2002:a05:6402:644:: with SMTP id u4mr29767812edx.386.1620656387056;
 Mon, 10 May 2021 07:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210510093753.40683-1-mark.rutland@arm.com> <20210510093753.40683-32-mark.rutland@arm.com>
In-Reply-To: <20210510093753.40683-32-mark.rutland@arm.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 10 May 2021 07:19:35 -0700
Message-ID: <CAMo8BfLg8G7_Tn4R7oZkO7+wwMDC5Bz_7E7v_EGxJLX7F_M+5Q@mail.gmail.com>
Subject: Re: [PATCH 31/33] locking/atomic: xtensa: move to ARCH_ATOMIC
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
        boqun.feng@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        bcain@codeaurora.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>, deanbo422@gmail.com,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jonas Bonn <jonas@southpole.se>, ley.foon.tan@intel.com,
        Russell King <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, nickhu@andestech.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <rth@twiddle.net>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 2:44 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> We'd like all architectures to convert to ARCH_ATOMIC, as once all
> architectures are converted it will be possible to make significant
> cleanups to the atomics headers, and this will make it much easier to
> generically enable atomic functionality (e.g. debug logic in the
> instrumented wrappers).
>
> As a step towards that, this patch migrates xtensa to ARCH_ATOMIC. The
> arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
> code wraps these with optional instrumentation to provide the regular
> functions.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/xtensa/Kconfig               |  1 +
>  arch/xtensa/include/asm/atomic.h  | 26 +++++++++++++-------------
>  arch/xtensa/include/asm/cmpxchg.h | 10 +++++-----
>  3 files changed, 19 insertions(+), 18 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
