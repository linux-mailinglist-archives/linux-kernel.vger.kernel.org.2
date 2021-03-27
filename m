Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE7D34B35D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 01:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhC0Ahu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 20:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhC0Aht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 20:37:49 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A742C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 17:37:49 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so6870482otk.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BI+iabPhrvYtDPz3qHAsKBtGQ2YVcLK/4lCP31o5TUE=;
        b=Fow2FqH+CBY1R2373Haa2XixmsXYU30WR4Xkavgn5oA+01i5YYiMB0K5FcaP/x01CX
         W1gzSNdvRJQtrcUY1/g0+AxVFzPSS+fw7yhe7i/MQpnJVSdh8Q9krd9w/YwlWQFmyl+m
         88mNxE4MjkqkhdtziGSJ29G3sWjPPy5ra5Mpn5FcSJYmsWTdC6nM2VcO/OZWc57Ks4lI
         FLibRiOGKARmyFNpKNbrKr/SkjxmOzGEKhamJSqQQtFDqN5ws7frrLJ2jYDZ1m+8Sb2v
         lfFC8HOdC9tAIR5Xs356hbjXFO40w2AnrLxPQQS57AUCI90AKfKWXxmwY9SRRAaN/KAT
         nbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BI+iabPhrvYtDPz3qHAsKBtGQ2YVcLK/4lCP31o5TUE=;
        b=BWydLraCQctEgx3XRI3mcfgeWub5R75bO+DocvXc7Kml5+d4LJTgSQEx2UoLky391q
         VeqaK0Wjt5dPU2EVES/7k1geg9DMk4YJrlaY/D+0hMtInUPb/TNkVPJ4Iloeq/ocZ8d6
         5JgwClPBFgmOp4h60LtN/8bL2GZkDnREr2ntg1tEapFmkiVK3Su3UVxkoVKPJ6F6bpws
         W563fGWxN6QQgYkj2g9WYTUKTHffQklmeh5llp4HSxmghWgavFszo3DR+wf/CZ2RfOxl
         lu4B4g5dpOlksiRYR6H0Hi+KCrO61d67xEld+Y2wmIX69fHQdJ6y95Pcg3qMLq6oSRZm
         B+XQ==
X-Gm-Message-State: AOAM532nhXQPsjBefKdlXoQN9FJBxE0WnH/9YgcsO4CW7wUpNAEJIyNK
        X08q9G1oFhSPKDOScZ78yVZDkAjoVO4TVakC290=
X-Google-Smtp-Source: ABdhPJycnq4cn23xX+kgLjQoby8h0XdATQJ85Z39SlztjCXr+bui55nWR1KSF860JDUv9vE391Ix3Bw4ofDbVcV240g=
X-Received: by 2002:a05:6830:1542:: with SMTP id l2mr12808241otp.95.1616805468507;
 Fri, 26 Mar 2021 17:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210322225053.428615-1-avagin@gmail.com> <20210322225053.428615-2-avagin@gmail.com>
 <20210326182839.GE5126@arm.com>
In-Reply-To: <20210326182839.GE5126@arm.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 26 Mar 2021 17:35:19 -0700
Message-ID: <CANaxB-xTrMkJ2D19wwjSbCfizdRDnNO52fibpaRXP5g3hOcQwQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: expose orig_x0 in the user_pt_regs structure
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:28 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Mon, Mar 22, 2021 at 03:50:50PM -0700, Andrei Vagin wrote:
> > diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> > index 758ae984ff97..3c118c5b0893 100644
> > --- a/arch/arm64/include/uapi/asm/ptrace.h
> > +++ b/arch/arm64/include/uapi/asm/ptrace.h
> > @@ -90,6 +90,7 @@ struct user_pt_regs {
> >       __u64           sp;
> >       __u64           pc;
> >       __u64           pstate;
> > +     __u64           orig_x0;
> >  };
>
> That's a UAPI change, likely to go wrong. For example, a
> ptrace(PTRACE_GETREGSET, pid, REGSET_GPR, data) would write past the end
> of an old struct user_pt_regs in the debugger.

ptrace(PTRACE_GETREGSET, ...) receives iovec:
ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov)

iov contains a pointer to a buffer and its size and the kernel fills
only the part that fits the buffer.
I think this interface was invented to allow extending structures
without breaking backward compatibility.

>
> --
> Catalin
