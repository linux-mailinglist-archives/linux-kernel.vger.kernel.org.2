Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7AA42D565
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJNIvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 04:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNIu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:50:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76461C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 01:48:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so6390005pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P89F2whoCgyWJPvW66dsXGR/mvbEh8Ef1fvEf+e15VI=;
        b=P8cfbUFlqNUDYJTqKsFInuNumBL1dE2gKrtCdrwFbipDT0YANJt0l+lFyFj+uCwdSy
         ZZF47Y3R49jZeYisDSLoBIVPfSLr6uk4T+suF3waM2pEr3wKTr5r4mTOfB4fBoXKGLrh
         uxWhj8eIQZiuQTk5d4aS28AjBvE15ZYTlcJSeeoVWtpVW8KI3CgfCPV+8CH4sBe7A4U1
         mjCZ43cvn+5fxv8gx8G7ztoCpkIGfxPJOVoFglFs98Km/bb8OpWpsofvo+Y5TQmRFHj5
         MF04UergV7r8W9YbEINxVMaOD6wsBzol7BOjyaFoimMpIuHwmVBMoWxGxaHipZJh5PmI
         8y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P89F2whoCgyWJPvW66dsXGR/mvbEh8Ef1fvEf+e15VI=;
        b=w8s58sp+MX0u8GltGWNIKhhChgHrzzIsCwnw68vNAYwOJxI+uOsezdXxG+e9J0IE7i
         xK8HIPe4dvqbVhVxe7lN0zkBC7Mrds4WBlfZT+KPta5Oe/TdYqrd8gqpKXXV+PHPe5/x
         +RDi/CiqlclVkiLrDIj389uCMDqmAGOhAWCSVjp+4l6i+miAofODvM+4MI/7Xa0mfShg
         QRI2bV4UR8e/NEijxLwpAg5eYNoz6fZDLRgYQjlU7AqiDtiZqMEvBd+A01+M8aJ5x+SS
         9aV55T89o2JLaKwuQponihevDrKJSu1hAx6b8nqFJ4eebw2LR4WfVrDKgpC/Fhij06yf
         yvXg==
X-Gm-Message-State: AOAM533BThZWboxXpeLlxGFLNXLCIrydxd8GoD0Mpr+jaco5FdU30h1Z
        RyfHGIvVstVHSVLzj4U8aKBg+w==
X-Google-Smtp-Source: ABdhPJx7WkDroP3+cbyg+DQTFy0h+xKVDdLVPQW5Vtih/X4LG1fjg8GbshFZJ4MioQ7SP0ENG+GAyw==
X-Received: by 2002:a17:902:c713:b0:13f:295d:8064 with SMTP id p19-20020a170902c71300b0013f295d8064mr3960651plp.74.1634201331914;
        Thu, 14 Oct 2021 01:48:51 -0700 (PDT)
Received: from localhost.localdomain ([182.2.74.1])
        by smtp.gmail.com with ESMTPSA id h1sm1883975pfh.183.2021.10.14.01.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 01:48:51 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Michael Matz <matz@suse.de>, Willy Tarreau <w@1wt.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber list
Date:   Thu, 14 Oct 2021 15:44:43 +0700
Message-Id: <HvtY0TQ1cVfJf5WD1XTAig@gnuweeb.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YWcOvmXkSiecGkER@zn.tnic>
References: <YWcOvmXkSiecGkER@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:52 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 13, 2021 at 06:30:23PM +0200, Willy Tarreau wrote:
> > Hello Michael,
> >
> > On Wed, Oct 13, 2021 at 04:24:28PM +0000, Michael Matz wrote:
> > (...)
> > > In short:  Ammars initial claim:
> > >
> > > > Linux x86-64 syscall only clobbers rax, rcx and r11 (and "memory").
> > > >
> > > >   - rax for the return value.
> > > >   - rcx to save the return address.
> > > >   - r11 to save the rflags.
> > > >
> > > > Other registers are preserved.
> > >
> > > is accurate and I will clarify the psABI to make that explicit.
> >
> > Many thanks for this very detailed explanation! Ammar, I'll take your
> > patch.

Thanks all.

>
> Great, why are we dealing with some funky document when the law is in
> glibc sources?!
>
> :-)))
>
> Ammar, if you wanna fixup the comment in entry_64.S too - make sure you
> explain that glibc expects argument registers to be restored - I'll take
> that patch too.
>
> :-)

Yay! I will send a patch for it, on this or next week.

>
> Thx, that was fun.
>

-- 
Ammar Faizi
