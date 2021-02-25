Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656C9325162
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhBYOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBYOPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:15:16 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF631C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 06:14:35 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b14so5741934qkk.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 06:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RjMGXZSNpl6MoX7cHLNDljQOvey0z0UfGIiH93TXoo=;
        b=dNvHe2jA2eFfzzQ+/FA2zet2QiRfRAO3T7+Pbv759Efj+/9RWU8hXRrfsLNTxnTZWT
         nRUtWqwW7+ojakxOdp7E+mdvydiURxEe5QjZmFhmu0i4JIr6XaCbXZCpLoSfSSwMMZxx
         /f6J79vivXlDcceT7/fXGBFtfG//ppxAIq9QxKC7euefTgJ7JogYuF2nsOmAiiSsSNZh
         48I5dvh5x8mksqhuqypiLcJ9y6y4YQZbWzY6bmhD+AFzyXtPqgwDCm23EN1zE1XXgBzd
         5G44Adz22c7DH7tTNbW7ZEGxhHErzV1n7SzxY5GVX/G48yq+EWTX7+CLwLJkr7rPg/zE
         VhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RjMGXZSNpl6MoX7cHLNDljQOvey0z0UfGIiH93TXoo=;
        b=rnjRwWTCbqMUrQOZkvZuHLXrdeMLTEt4p+Fjf9yUD9Op7wxc8BvqGqHXvUeIwPAUbA
         9y5T4StzNNhVw5TnSS4oILVd64dL2oytiyYtdq4mF+9tp8tEowzUpI+iVPqIC7coeMsA
         IPk7pLB7vzzYQRUkdMVaTD8ve4DQ/jfuAeuUnJDSGEZ+3QAZbjOayv5QBJsHspg4EJ+1
         rEwu6+G16DrE5ZpNC73CTJocraX6JJBn/dvggTLyIa8fdC+oIAzjbL7Z85TcN2eS8rfZ
         MUgDCyhDKilfy8Wr/+eyOtAwfAM14aeLuBxLj3bimZoHh4W1MZyqUeEranesfGpsucix
         PfbQ==
X-Gm-Message-State: AOAM530B2gvpahCPbb3X76vt7WtBnlYDUz3NAqrNDscAOV6YWGjafj7Q
        npaHESo1eT+lwO4JmPsyuNVTAlB2C1P5MqKWoTyoYw==
X-Google-Smtp-Source: ABdhPJyNOVk+IGqJAHDCUPVGKPdSNOqKuv8sqZ0EqKUEkvvQubQtKl5TlrdIj2A0KvdQgGjIpAFVDi7cYhOLFZz65o0=
X-Received: by 2002:a37:96c4:: with SMTP id y187mr2942832qkd.231.1614262474704;
 Thu, 25 Feb 2021 06:14:34 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007ff56205ba985b60@google.com> <00000000000004e7d105bc091e06@google.com>
 <20210224122710.GB20344@zn.tnic> <CACT4Y+ZaGOpJ1+dxfTVWhNuV5hFJmx=HgPqVf6bqWE==7PeFFQ@mail.gmail.com>
 <20210224174936.GG20344@zn.tnic>
In-Reply-To: <20210224174936.GG20344@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 25 Feb 2021 15:14:23 +0100
Message-ID: <CACT4Y+YGOgrYhwhRcX=C2WJ8x99LUZ3v6LppneStScWkQQMggQ@mail.gmail.com>
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
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, wanpengli@tencent.com,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 6:49 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi Dmitry,
>
> On Wed, Feb 24, 2021 at 06:12:57PM +0100, Dmitry Vyukov wrote:
> > Looking at the bisection log, the bisection was distracted by something else.
>
> Meaning the bisection result:
>
> 167dcfc08b0b ("x86/mm: Increase pgt_buf size for 5-level page tables")
>
> is bogus?
>
> > You can always find the original reported issue over the dashboard link:
> > https://syzkaller.appspot.com/bug?extid=42a71c84ef04577f1aef
> > or on lore:
> > https://lore.kernel.org/lkml/0000000000007ff56205ba985b60@google.com/
>
> Ok, so this looks like this is trying to run kvm ioctls *in* a guest,
> i.e., nested. Right?

Yes, testing happens in VM. But the kernel that crashes is the one
that receives the ioctls.
