Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4634D481
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhC2QHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:07:22 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:42838 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhC2QGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:06:51 -0400
Received: by mail-ej1-f49.google.com with SMTP id hq27so20286060ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3DGCLzA96F2hSo9UAJwDmXVtZ3GtX89wEcmJ815Uf0=;
        b=MqRZ32Mfxq44MorPAEWHgKnYEUSvWPxh9jdHI5CkuZuy+yIGwZGeJlnm6gJHzrVCCi
         tjNT5njq2BSDXDZqNkJ5TdkDiTwx27XETWJfx8l9xyyFS/0NJsQ7BAoM9TpDUo/HWbki
         KE8VPOUzRIFhsjjNu6FZUhOze0t5tkkdHCngBa4BhxAKgD3t18U/+GgevIvPhr2gTwkq
         93wEr8Nyxknovdf1rhHHUovtCpCx/Og2djgO0pf9Sk98yNs/pcTEKYGp2E1TZgOx3kjx
         vkucA7I3/rJuIQv9EpmrLWK0XqaqlRdHf1ugT2ly6BN3G8K4K+wHIXsHox1+iBBKswtO
         1M+g==
X-Gm-Message-State: AOAM532LsT4plBeH7tlOifNCRpIdGPxoDkQA/HnP+oLMbAReXad8TOLn
        ciCJ70ycenR40U+IeNYUVF03GJF7fZmBfpYBenq/O3wZ
X-Google-Smtp-Source: ABdhPJy9FbUSdbgeqSAmCGmxd7wiApuZjzIrGifd5hwMK6y1xRcxdBfidKu2HnCvuSRneCcidfuvSnsF+9jt/+Wcjsg=
X-Received: by 2002:a17:906:6d01:: with SMTP id m1mr19449942ejr.501.1617034010211;
 Mon, 29 Mar 2021 09:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com> <87o8fda2ye.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkZEWTsqhXLC+qiQ49c2xn7GDF95PfTBi0rw1FnE--JKQ@mail.gmail.com>
 <87r1jyaxum.ffs@nanos.tec.linutronix.de> <CAJvTdKnBRmogm6zF0KyDtx1VC_bpRa8_H1P9mxtMP06fy8a57g@mail.gmail.com>
In-Reply-To: <CAJvTdKnBRmogm6zF0KyDtx1VC_bpRa8_H1P9mxtMP06fy8a57g@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 29 Mar 2021 12:06:38 -0400
Message-ID: <CAJvTdKm4qKw8D8b+NokBsdiE5yBj=LTiH50VuxJY2aAL8qQq6g@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:43 AM Len Brown <lenb@kernel.org> wrote:
>
> On Mon, Mar 29, 2021 at 9:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> > > I found the author of this passage, and he agreed to revise it to say this
> > > was targeted primarily at VMMs.
> >
> > Why would this only a problem for VMMs?
>
> VMMs may have to emulate different hardware for different guest OS's,
> and they would likely "context switch" XCR0 to achieve that.
>
> As switching XCR0 at run-time would confuse the heck out of user-space,
> it was not imagined that a bare-metal OS would do that.

to clarify...
*switching* XCR0 on context switch is slow, but perfectly legal.

*changing* XCR0 during the lifetime of a process, in any of its tasks,
on any of its CPUs, will confuse any software that uses xgetbv/XCR0
to calculate the size of XSAVE buffers for userspace threading.


-- 
Len Brown, Intel Open Source Technology Center
