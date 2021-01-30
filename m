Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541F230919F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 04:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhA3DIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 22:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbhA3DBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 22:01:36 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F6FC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 18:53:21 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p72so11442940iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 18:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/5VbabLQqVUsALiL3z7L4ylR60t/J7u9FpiG3x5sEs=;
        b=DccSi3gVI1PsJyBx3xhXAmmZISZ02rnEexw6zeIvzeXbGqGSEeJX7A+sacvsvkdE3z
         kwpDFrv177cL8wIJtKe33PsJWCYz+fRysOX8dqNOdVf8Rzd8rPdkk1qhC7RPWMl72rrj
         N8RYqkVidiSx5tJpeuxIGr0s41WBC92dn9DWNJO3KSLbVuTzebMJT5/OauxPgZPLSISU
         AhyZDL8txaSOGVRhuV8kAEHgkpcLnxI9sdgxbHvcfb6LkUR8huJ2KOBymOJvTpff9jiY
         04VItQ54g9/VefVasJ3UYwmDLlK7JksTPXgtZaJxU5lN25LfX/ibTqr3o1FJuN1oTC8w
         lOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/5VbabLQqVUsALiL3z7L4ylR60t/J7u9FpiG3x5sEs=;
        b=Mvl+xPsD/O5MpfHgQhIHm1An8ZZhj42S+VcQC2d9KuQLrcVKwLKDuc2xWG4eqvXTFE
         XT1WAG7tAnoXsmRSKLxra+54RYppNCHLBuXWMoDR/5YXFXl4SJ+vrVxa75oOEiqRPdgn
         NmD/ZHrcbFTIfNX1SCY/QvnGB/7KklcO0cxXQGEEBYfR+DxTV8QaDJVYt8F1G9lBT8lh
         u8XoxHlWnlQ4Uz11x3Vpqc5/kPbygprEEKO3YfuzdnkO8RswqI2o5w8ihz5UKPZXqu33
         WBAY1O7Fc56W8PoKW1E94D/ODa812RYbuin7zqthGGKi1NKjlTvPy8GrMzImPng80QMm
         /Xfw==
X-Gm-Message-State: AOAM531jH03ENHD+hGhEl24kdIqF1qDconD57Fb0SIsldYhjIi4SuUvB
        5gJIozB+qp3necaYXAXp3AV4OWRnbLk0UvCQefw0E7QK
X-Google-Smtp-Source: ABdhPJy1HC9/B3BC0TVsz8lRs+1bzE77k9ciEvNqoCEcwShfeGh0IBGDUBsEe8O+eL6nPc19xVtunJBfHSUvZL4cTyQ=
X-Received: by 2002:a05:6602:4b:: with SMTP id z11mr6001872ioz.47.1611975201394;
 Fri, 29 Jan 2021 18:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20210127163231.12709-1-jiangshanlai@gmail.com>
 <CAJhGHyA1U9M2Lv_=Wa2NPzBNevZKOrLaG1FDwbmySMOR_x_GRQ@mail.gmail.com> <20210129164320.GE27841@zn.tnic>
In-Reply-To: <20210129164320.GE27841@zn.tnic>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sat, 30 Jan 2021 10:53:10 +0800
Message-ID: <CAJhGHyDKc-5-0MCX0zYdASTweWcN8pP8OU0DuVBM42-nvUEgSg@mail.gmail.com>
Subject: Re: [PATCH V3 0/6] x86: don't abuse tss.sp1
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 12:43 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jan 29, 2021 at 11:35:46PM +0800, Lai Jiangshan wrote:
> > Any feedback?
>
> Yes: be patient please.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

Thank you for your reply and this gentle hint.

I did "reply to all", but I have no clue why the mail failed
to be delivered to LKML, and maybe it also failed to be delivered
to other guys in the cc-list.

Hopefully this won't happen again to this reply.

Thanks
Lai
