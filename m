Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02044291FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbhJKOhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbhJKOh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:37:29 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBDAC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:35:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so74457118lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KwV0j5l+6jp7oi03p9mWq74y0+pPufe5DR//TIJnJ0o=;
        b=tSlT/vaOIZ7/xP1SYtjDrUM6zeicsCDdfvQmPM0bhEaEe106g/25m1QWASj7TLzW/9
         DsOn6EGujLp17YIv7/Effv67U/zAr79cu3RUSBeiiip5hVaALHGajC6YeLmkQVGQ0C8S
         w7mEbguwEFrkl0xpyR9z7jGXRDQTRvsMWMlbrPvFO3naoD7VG+ujxFiZQRu+Ahy2Bzey
         Ow3Hw9kgiyzRRMY48ycOrOj1e0bHAnwCKdT1FEoOuHJWVQLc5aebEokPcv4C4Lp443Qs
         j3fCIezddi0EX9bSmjbA/1AApjzNwCrfNaOkoxTwADK3ImFvydV9qd75NUqYzbe5TX1i
         UY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KwV0j5l+6jp7oi03p9mWq74y0+pPufe5DR//TIJnJ0o=;
        b=lNFSdd/xWSWcLY2v/5CT+CIs9Eq25gUAw2HRz2owF+IUwfnWQ7xmJLRP89S1NmYowh
         6h8i6lUS10jtwfTD2edLsfQki6ALbYgO36gYD/bQ7pmInPFxHefAvskeuzDzPy1C8hjf
         QUvHa/ntHHLpnlo8rTmlmpMzb6IObTu/H+a3lFoS5NdC0xpi7jB1+10C41lVihlJXrtP
         Eiax87Iz9V75TUIR11ssKDkoOtZ9VQplgriI5wJQpH3vAdyzrzXYpvwLGudfyU5xxcZZ
         fCeiO7/PS+/KR7EcxGCqFwJEo4vPEcayK7RzdxjY86UoJxaTVrr4YSVc5vfANhJsg2mF
         dvaw==
X-Gm-Message-State: AOAM533Y55gjma86hit3UOFu7CxZyvNfTN5ckZwuJ/nuvHCWxXTstST5
        sPs6n13WPgi6ZA08qJkEBZ1zorpeqDKJPZMRMMtqoQ==
X-Google-Smtp-Source: ABdhPJyvJq+EGbz0XK0ctDpXW9jQaqubWu99B3p6kIGl1Sf0AYzfikJ14IoEewM995n2g++yyMaWr8hqRWbIxDKMXPo=
X-Received: by 2002:a2e:8ec3:: with SMTP id e3mr8346534ljl.337.1633962922631;
 Mon, 11 Oct 2021 07:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211007231647.3553604-1-seanjc@google.com>
In-Reply-To: <20211007231647.3553604-1-seanjc@google.com>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 11 Oct 2021 09:35:11 -0500
Message-ID: <CAOQ_Qsj9yiChnBZmotdYFYgsd=C0J5XXR8mthdiC+iXX22F7jw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Account for 32-bit kernels when handling
 address in TSC attrs
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 6:16 PM Sean Christopherson <seanjc@google.com> wrot=
e:
>
> When handling TSC attributes, cast the userspace provided virtual address
> to an unsigned long before casting it to a pointer to fix warnings on
> 32-bit kernels due to casting a 64-bit integer to a 32-bit pointer.
>
> Add a check that the truncated address matches the original address, e.g.
> to prevent userspace specifying garbage in bits 63:32.
>
>   arch/x86/kvm/x86.c: In function =E2=80=98kvm_arch_tsc_get_attr=E2=80=99=
:
>   arch/x86/kvm/x86.c:4947:22: error: cast to pointer from integer of diff=
erent size
>    4947 |  u64 __user *uaddr =3D (u64 __user *)attr->addr;
>         |                      ^
>   arch/x86/kvm/x86.c: In function =E2=80=98kvm_arch_tsc_set_attr=E2=80=99=
:
>   arch/x86/kvm/x86.c:4967:22: error: cast to pointer from integer of diff=
erent size
>    4967 |  u64 __user *uaddr =3D (u64 __user *)attr->addr;
>         |                      ^
>
> Cc: Oliver Upton <oupton@google.com>
> Fixes: 469fde25e680 ("KVM: x86: Expose TSC offset controls to userspace")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>

Reviewed-by: Oliver Upton <oupton@google.com>
