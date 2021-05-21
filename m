Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A92538CCFD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhEUSN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhEUSN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:13:27 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B80C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:12:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t193so14873806pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b/dZqtmx+QzSxGZqs+ZxxfhErrzL6Mbxy7NhY5biBNQ=;
        b=JB10/KaVuL70nrPHJYRsqyp+H95R3LO9/lA59b479E5sIqi953RI5rNBQP4JA/8qVd
         mWm5Mt/XMjg6SDMQcGBrTCPWaHlFT0YNnihkKO0AJNeSAMh0dd9xmYnlbtxVm1Fxh2nZ
         TASMsMy+svEfKTyeG4cUihe0fZ1Ls6O62JeZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b/dZqtmx+QzSxGZqs+ZxxfhErrzL6Mbxy7NhY5biBNQ=;
        b=MuOOyJEzEcoXnNQzDPc1ngl6wBl89FY/pbHvqfDBK4qjgcaRByY6yv5gkT7/t6gS2g
         h3FHWO6z1kINB/9DJucc3D3NibyDyn5vTSwDyB+G/O7Q6lfosgrWNi8JwT9/w4fsfd/A
         D/1tWa+D6w8ZD5psDUWhcR64CNv/iVJ/5ylSfwbtAOVS/S+ZxsxppS6WHSokdGyKB1AI
         tOiSXT9zZQzl5YiMqpF8LxZLpK1qBPwSzubEp9zW7y7i/PQwEOxB88ywO1aIYQJRMNpV
         w9DFidWN8Yfq2GelLBMpSdZXbWHzC8E7vv7pPHwp8CFJUDRqI2L89h7iZHFDWhFZapIZ
         pFAg==
X-Gm-Message-State: AOAM533T0SWIpbg2RSaWVy2BBendGc087ZdIWlJLONeXPuI9n0AHlOqQ
        amgjj336zaApRAgtYmP29VHztg==
X-Google-Smtp-Source: ABdhPJyQ6ViMNs89ZpVqSmjEbM0qp5SFTUlUHh6cBdK7H9z2r1i2y2mpmyI8EiYRJQjBGhJWCrXNHA==
X-Received: by 2002:a05:6a00:bc2:b029:2df:93cc:371a with SMTP id x2-20020a056a000bc2b02902df93cc371amr11331142pfu.12.1621620722226;
        Fri, 21 May 2021 11:12:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k7sm9254707pjj.46.2021.05.21.11.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:12:01 -0700 (PDT)
Date:   Fri, 21 May 2021 11:12:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [GIT PULL] Stack randomization fix
Message-ID: <202105211105.2E1A1B4D6@keescook>
References: <20210515073453.GA78379@gmail.com>
 <CAHk-=whpKm_bCDui-VcRwJWVPDPCFKY_oqRACpTff5zXNr8MjQ@mail.gmail.com>
 <YKDJ40DUdY1Oy+FJ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKDJ40DUdY1Oy+FJ@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 09:29:39AM +0200, Ingo Molnar wrote:
> Without stackprotector we get:
> 
> ffffffff81080330 <dummy_dummy>:
> ffffffff81080330:       55                      push   %rbp
> ffffffff81080331:       65 8b 05 88 12 f9 7e    mov    %gs:0x7ef91288(%rip),%eax        # 115c0 <kstack_offset>
> ffffffff81080338:       25 ff 03 00 00          and    $0x3ff,%eax
> ffffffff8108033d:       48 83 c0 0f             add    $0xf,%rax
> ffffffff81080341:       48 89 e5                mov    %rsp,%rbp
> ffffffff81080344:       25 f8 07 00 00          and    $0x7f8,%eax
> ffffffff81080349:       48 29 c4                sub    %rax,%rsp
> ffffffff8108034c:       48 8d 44 24 0f          lea    0xf(%rsp),%rax
> ffffffff81080351:       48 83 e0 f0             and    $0xfffffffffffffff0,%rax
> ffffffff81080355:       c9                      leave  
> ffffffff81080356:       c3                      ret    
> 
> Which is still quite a bit longer than it probably should be, IMO. Since we 
> are relying on assembly anyway, we don't we force frame pointers explicitly 
> and do this in assembly? The key sequence should only be something like:
> 
>        65 8b 05 88 12 f9 7e    mov    %gs:0x7ef91288(%rip),%eax        # 115c0 <kstack_offset>
>        48 29 c4                sub    %rax,%rsp
> 
> There's no fundamental reason for all the masking games IMO.

Mainly the mask is for enforcing stack alignment (and the compiler
does it). The top-level mask is to limit the resulting entropy while
keeping the rest of the entropy for mixing the per-cpu variable.

However, the compile almost entirely fails to optimize the masking:

>        25 ff 03 00 00          and    $0x3ff,%eax
>        48 83 c0 0f             add    $0xf,%rax
>        25 f8 07 00 00          and    $0x7f8,%eax

This should just be and $0x3f0, I suspect (I need to double-check the
rounding up it wants to do with the "add"...)

Luckily, while long, it is very fast.

-- 
Kees Cook
