Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2086324307
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbhBXROQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhBXRNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:13:51 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77F8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:13:10 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id v206so2881633qkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtACNUPOTKFJMR28JTicXGvA4n2KurcOaH8kXxHNFz0=;
        b=eI6oM53GsMawJK3MX0YJNSdvTX2/qszUFCKStACoOBqn20F5iStdT+dsZMLCJuAB/n
         wip1Khr9NF3AtCXg0a6oIucpojk+uRWMLq5AdLKQywyo/WeOxgB6vzTBbFC/Gj8XdBo4
         cVJs9ZhZQmV69Hi+YDKxkUCL14U++5ffXxHE8OFK237hQwOCmA/7zmyJmIEMHkLCFUBX
         LPSxM/IDjghuIFELD5+KVBwKhhP7C0r4UAs+u7cwTxmrZrh9MSwTtUCzlcJhMf+5PhJ4
         hsu9WYwjWv2PQZmQndQHzticH0NfFPeY8Y8DMvrVraQNjMHgYVAeYSv7Uot/wY2Jzfrf
         mM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtACNUPOTKFJMR28JTicXGvA4n2KurcOaH8kXxHNFz0=;
        b=apjqq6O9nuDmvlvgUXStoo6eripeFjix3jdI38cSFDQ/m449vnF9fq2DqFjvdwMSOq
         soQ07fum4WLFnT7Fp4ME3URhJhf2FI+JW/TsRpnc7WWlbJf5z3Hxlt5YRqV1zFM2gnVW
         tnmKt2gNXPq0bEUW+rtYOJEsMJHKCuXIic0B4zAGIEDoVT/JpUahFhtFiFX+vRxDEnDx
         dOx1S+XyBFQ4GjKSQeQs9FHmmJo1Ys+18wC9gpGsLmCD3v3ySUKJTreZmt9FzfgTGfdM
         Y6o+cU9qI4FkJ4MYMv686kF/UgkG6Fm7ljKpKecCePxRD7K9UjTNxVNj8xAuhPBfy8CR
         RaKQ==
X-Gm-Message-State: AOAM532/yld8bX9PWIrWPLbFsgEaMnF9P9wpwruMIHwmPeldCvwqro3c
        SyY03ULd1CMNfnxFY4DkqKeRYqGV/iY1hUweOwpDbA==
X-Google-Smtp-Source: ABdhPJx0PiOREpVR7i9mJVHqO8PGscLL9eaNv3hBd8dNLOLqkCfG1mLQOV7o7VrvBi+IfrAMCb1o5hJFRJ10QHVIUoo=
X-Received: by 2002:a37:a757:: with SMTP id q84mr31057613qke.501.1614186789469;
 Wed, 24 Feb 2021 09:13:09 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007ff56205ba985b60@google.com> <00000000000004e7d105bc091e06@google.com>
 <20210224122710.GB20344@zn.tnic>
In-Reply-To: <20210224122710.GB20344@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 24 Feb 2021 18:12:57 +0100
Message-ID: <CACT4Y+ZaGOpJ1+dxfTVWhNuV5hFJmx=HgPqVf6bqWE==7PeFFQ@mail.gmail.com>
Subject: Re: general protection fault in vmx_vcpu_run (2)
To:     Borislav Petkov <bp@alien8.de>
Cc:     syzbot <syzbot+42a71c84ef04577f1aef@syzkaller.appspotmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, seanjc@google.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, wanpengli@tencent.com,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 1:27 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 23, 2021 at 03:17:07PM -0800, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 167dcfc08b0b1f964ea95d410aa496fd78adf475
> > Author: Lorenzo Stoakes <lstoakes@gmail.com>
> > Date:   Tue Dec 15 20:56:41 2020 +0000
> >
> >     x86/mm: Increase pgt_buf size for 5-level page tables
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13fe3ea8d00000
> > start commit:   a99163e9 Merge tag 'devicetree-for-5.12' of git://git.kern..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=10013ea8d00000
>
> No oops here.
>
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17fe3ea8d00000
>
> Nothing special here too.
>
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=49116074dd53b631
>
> Tried this on two boxes, the Intel one doesn't even boot with that
> config - and it is pretty standard one - and on the AMD one the
> reproducer doesn't trigger anything. It probably won't because the GP
> is in vmx_vcpu_run() but since the ioctls were doing something with
> IRQCHIP, I thought it is probably vendor-agnostic.
>
> So, all in all, I could use some more info on how you're reproducing and
> maybe you could show the oops too.

Hi Boris,

Looking at the bisection log, the bisection was distracted by something else.
You can always find the original reported issue over the dashboard link:
https://syzkaller.appspot.com/bug?extid=42a71c84ef04577f1aef
or on lore:
https://lore.kernel.org/lkml/0000000000007ff56205ba985b60@google.com/
