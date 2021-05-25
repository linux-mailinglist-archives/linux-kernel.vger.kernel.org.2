Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80BD38FF90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhEYKzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhEYKzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:55:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC53AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:54:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621940046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G/RGtg85sxQU7HugL/NB5xiG2Ekdrx8Z1JtQYBNfkUE=;
        b=rP9s4nJ0IM/3ETu7fxGBKwMyTii0zhMC0fSJtk4LCQm0le1i65LTjo9/kuagVgyKbwW2qB
        Os88+bcKpi4r8DDNsgYGI1FfJNzt2I0+11M/bQl1YY11aGuvqQUyJYInVNU8VopTD4Vao+
        CrNorGI7fYyRx9Mr2WzUgiRoZbp9gAYqwOU/l520ALK5iuph3lUUSfaZ4QX5LLujWj9eRC
        77o+vJQfpRHgKnHvReKyxdU8rqdGrMfaC4SSnWl2KjEwAo41rU15OeD39pGEW/qMrmkL6K
        tHtgt+AzUamKvCPVjj83MboHBZrujgPkEuPXkdPwDDzGjOWM2rVqzdAMnacSXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621940046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G/RGtg85sxQU7HugL/NB5xiG2Ekdrx8Z1JtQYBNfkUE=;
        b=v0vbvLPEYF1pAoLZ4/3UvEhh7hntlT7RlbmL/EOf5MrYYko9ADnm/oD6MwItD0y8PwwFi+
        mHD5nhAGtxB2kSCw==
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        X86 ML <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: x86: unistd_64.h: warning: missing whitespace after the macro name
In-Reply-To: <CA+G9fYvFXTHPKwasdVidF7qEHdqwRht8Xg6qm6CCLL0HGaU1ew@mail.gmail.com>
References: <CA+G9fYvFXTHPKwasdVidF7qEHdqwRht8Xg6qm6CCLL0HGaU1ew@mail.gmail.com>
Date:   Tue, 25 May 2021 12:54:05 +0200
Message-ID: <874ker9j8y.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24 2021 at 17:16, Naresh Kamboju wrote:

> While building Linux next-20210524 tag with gcc 7.x the following warnings and
> errors were noticed.
>
> build log:
> ------------
>   HOSTLD  scripts/mod/modpost
>   CC      kernel/bounds.s
>   CALL    /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/scripts/atomic/check-atomics.sh
>   UPD     include/generated/bounds.h
>   UPD     include/generated/timeconst.h
>   CC      arch/x86/kernel/asm-offsets.s
> In file included from
> /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/arch/x86/include/asm/unistd.h:20:0,
>                  from
> /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/arch/x86/include/asm/seccomp.h:5,
>                  from
> /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/include/linux/seccomp.h:21,
>                  from
> /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/include/linux/sched.h:21,
>                  from
> /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/arch/x86/kernel/asm-offsets.c:10:
> ./arch/x86/include/generated/uapi/asm/unistd_64.h:4:14: warning:
> missing whitespace after the macro name
>  #define __NR_/usrread 0
>               ^

Where is that "/usr" coming from? 

Looking at the generator script this looks like a stale $prefix
parameter...
