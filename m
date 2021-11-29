Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EDD460D65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 04:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350484AbhK2Dpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 22:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348163AbhK2Dno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 22:43:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EEAC06175E
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:40:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s13so33647123wrb.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MWox7pMHyR0qcRdGS+0RZRCWvfw/dHAAH8xPTK+l3bg=;
        b=Xk+d+xhG4+Z7lzMNFQPU/ZRqqE2Q8Vku4rPID+rdJv5DwOS8XvIvjgfz0tJKLwGm+z
         b/URVPG9yvCfoXpJxi7nBFCEITlxA3qpPxsVoilHt0IeSzbPeVBXP60Caex28GxHOb8k
         gMT0lDAKzhCl+UL6QB8Fl4vqiR9vFAjNgvTPRM30cFs30fnxtn9EYkG3ony7zFw0w/qW
         bFHGact0uqCGI999gHsRBLtleAlwr/xPaaa525Gizp72gEpPEfLPVbOlcb1AqpJP5etE
         05toy7BXQGGXMuuD/8o9onenREXFlOVqEm9oxqLNcgKouOIMYTOY84mhRH8VgUe4NHVB
         YaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MWox7pMHyR0qcRdGS+0RZRCWvfw/dHAAH8xPTK+l3bg=;
        b=AbuJ+fnIfpXkVho6CLFKL/3mWTe8UuF6M+WEwPtUD0mV3gXYRqqRCNDJaop49uIAES
         qVm/VKdJdjL50g4/U19gYo4xRp4p1WP8XLwWv4Ed4VdP2a6dkh1Qd9UJ2ATaRld9go8f
         UFq8WWKCeOhcibpMWJicMs83l3yNRT3oBrLZ6hPaZE8sgipjnzsRRBSx3IoJIel12wxG
         NfSdshG0wqnK9upxzTwY5vxvRXK+n+NQuMzxQALQura4l15SX6rq+iZglXra9Bx/tENG
         cwawgAAVFhQ4FzYZybEzMeVsdxeBOmmB5x6CG3DHUCOHcoGG2GASlFBHy/zI94T/wEuU
         LwoQ==
X-Gm-Message-State: AOAM533H9OO+LC7XEtq7CFjm8TAiSEIIqlUSNI34foFVS6UCx6jYYYX/
        HF7RiCSCF2HfAfvS81cSqH2E/rbP9f/17V4ba9jjCQ==
X-Google-Smtp-Source: ABdhPJwxTF4itSodvdNADBx2t3eVLv2fdXR7JyED2RU5O76/w+2bvnAc9HWZucJxJtZvwzvqgEAh8s66khCIOZboUzQ=
X-Received: by 2002:a5d:4f8d:: with SMTP id d13mr29221931wru.89.1638157208592;
 Sun, 28 Nov 2021 19:40:08 -0800 (PST)
MIME-Version: 1.0
References: <20211126154020.342924-1-anup.patel@wdc.com> <20211126154020.342924-2-anup.patel@wdc.com>
 <558e7e30-2d87-a19c-c85c-a2993a354074@redhat.com>
In-Reply-To: <558e7e30-2d87-a19c-c85c-a2993a354074@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Nov 2021 09:09:57 +0530
Message-ID: <CAAhSdy2mAHyA04nTOh_XM==moKv1UARpmqt2QhkQwFZo98kwtA@mail.gmail.com>
Subject: Re: [PATCH 1/4] RISC-V: KVM: Forward SBI experimental and vendor extensions
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <anup.patel@wdc.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 9:42 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/26/21 16:40, Anup Patel wrote:
> > +static int kvm_sbi_ext_expevend_handler(struct kvm_vcpu *vcpu,
> > +                                     struct kvm_run *run,
> > +                                     unsigned long *out_val,
> > +                                     struct kvm_cpu_trap *utrap,
> > +                                     bool *exit)
>
> Doesn't really matter what this is used for, it's a handler that
> forwards.  So you can name it kvm_sbi_ext_forward_handler.

Sure, I will rename this to kvm_sbi_ext_forward_handler()

Regards,
Anup

>
> Paolo
>
> > +{
> > +     /*
> > +      * Both SBI experimental and vendor extensions are
> > +      * unconditionally forwarded to userspace.
> > +      */
> > +     kvm_riscv_vcpu_sbi_forward(vcpu, run);
> > +     *exit = true;
> > +     return 0;
> > +}
> > +
>
