Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6CF331F90
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 07:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCIGz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 01:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCIGzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:55:06 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4B5C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 22:55:06 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b130so12006055qkc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 22:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2bPry4S6r4S3ID+ZCMhgKWwpmYkYjT1/OMlDvwgN7I=;
        b=i59nqI12fvQaDTn9BFQQmaloLPN4PCiy/BAI006cnsmPI2df7d2SjT3Rm95TzeZzPY
         UWhkkkl+xF5WydVZkYvip5iN5pgr6kL5VSDt39TRsyTYbdHEpnyOhHabdv2XJ1fhD1Jf
         x26AjtAU18EHDhcc1W+9GJwTAEqxbQGklGhJNvB/jfm/ZUgBQMjBYBbpvLvEOoZ6HgTu
         n9fMkTLQkc9wDWUqF7CQoMT3A4Nv0NYKEt/K+qK4mDoIPKTI9yPZUn7mmdEugOrYwa/h
         hLxmNnplX3/FuIf+hYHgkBBj7thj3h85hb81o3NHlRFUqrkkwzZ59fLuAH591OO+LOfw
         heEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2bPry4S6r4S3ID+ZCMhgKWwpmYkYjT1/OMlDvwgN7I=;
        b=Go4xn/J8Zg51EhIHcrfQ568yC94dysKJqIcjhaNmZvwfs5IZEpswORFLolHr/aun0c
         lFmLEdg3GndgVLkDHNpHHqVR934ky9s+KzE0KGglXRlmSXo5iJc3D26+CYNwB4Ef+RvS
         td4C5/7cewFGYqZPtJB07/gAS9qe5ODz+JZt/rPVSZW+Y9XIJdbu1x6wPfo3eKrGziCm
         VMv4Ifjp05Pb+EU91yJwUwIftuztDHmrsyQ0WgkyqUf7RVKvZaVCxQPz2rkAyG/ss90E
         dm0BfPV0k0vx4IA1Iu2qMF4kNa1Ia7XB/k+67QrlhMUMAUDKA9sj0PTkekiotEsb8kcs
         MI0g==
X-Gm-Message-State: AOAM53069TPCMYw4ACJRrjpAYILZYqBgV8ZKLZ+f2HJEF2fD+6cBe+eb
        HFnKGs9QqI++BK27foWuVHRYV3mfM7ZchR9FYZoO7g==
X-Google-Smtp-Source: ABdhPJw8nsZO+P6qauJC8mSb2Mq7A/sNOQMzN2CkBC6GJXldRqq2hpGDo7HTgf6evQ0UdM1jyaigT7bLmxnw+CVPIP4=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr24557038qko.424.1615272905098;
 Mon, 08 Mar 2021 22:55:05 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003912cf05bd0cdd75@google.com> <YEazSAsa2l6KQZwL@google.com>
In-Reply-To: <YEazSAsa2l6KQZwL@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 9 Mar 2021 07:54:54 +0100
Message-ID: <CACT4Y+bwjEv_EQgk8KDNYO0W7iOkeeUBUarzzd-NOZ0FZcPSRw@mail.gmail.com>
Subject: Re: [syzbot] WARNING in kvm_wait
To:     Sean Christopherson <seanjc@google.com>
Cc:     syzbot <syzbot+3c2bc6358072ede0f11b@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, wanpengli@tencent.com,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 12:29 AM 'Sean Christopherson' via
syzkaller-bugs <syzkaller-bugs@googlegroups.com> wrote:
>
> On Mon, Mar 08, 2021, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a38fd874 Linux 5.12-rc2
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14158fdad00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c6adb4986f2f2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3c2bc6358072ede0f11b
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1096d35cd00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bf1e52d00000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3c2bc6358072ede0f11b@syzkaller.appspotmail.com
>
> Wanpeng has a patch posted to fix this[*], is there a way to retroactively point
> syzbot at that fix?
>
> [*] https://lkml.kernel.org/r/1614057902-23774-1-git-send-email-wanpengli@tencent.com

Great! Yes, it can be communicated to syzbot with:

#syz fix: x86/kvm: Fix broken irq restoration in kvm_wait

For details see: http://bit.do/syzbot#communication-with-syzbot
