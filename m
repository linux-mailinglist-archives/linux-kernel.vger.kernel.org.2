Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ECB39EF98
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFHHbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhFHHbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:31:42 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525DAC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 00:29:34 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id c10so7539934qvo.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mjJ37PmArsSDJUKmBe6EYoic7gWOGcLryXC0FyHwl6U=;
        b=n9p23/haum6EphyEVQ5DyGGD8//kQWp4SzqvdoDvzUhFGPlrT5NSasjGHw6U3Jl7fE
         3aJqwmCFY371QrorKhtxeyP9kKqewth5iSyXZ6ADi0ycDZQJZEJTa1SONQGqrhDVmqi6
         +bbfr957dW7r4axXOtm0XmDlLVDFFoNeU8cIUVjebPf4CM0j6N7JW2zazbPn9eIZ9Ojz
         oIM1SfrmHw+Wtzx2cJGbFs9vYvnydfyxvDGts6Lgdx6EKEX9qslQ6t4jxOfNHKW2ihwC
         rxVmKmqD084M1Q9DOySfpzUODh1emItF032y2TKOLdJRMUYzI+nP2Y27FAJKs4kC80Rt
         iKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mjJ37PmArsSDJUKmBe6EYoic7gWOGcLryXC0FyHwl6U=;
        b=MYAjGjOl9rUQE800+NSKG5pHAIrsC9LhQuSwaWZaqoHhSEfL1kprY8YbaEH8uE2eJ8
         /wUAVI53B4ZPLbgc8cuiEdOWp3JPTw2OA6xTD8+lTpJ6GiN5G/xTWsRGGmgaBaQRQRSa
         zuLgdUl3DroEg2yL8Dm02pIJpbVIXDeyQWHDr1uaXXLluZp++u3bAB8MwKqlr6HbvaO9
         5jCUX3bMnH7pr5IizspimO3+7rY/liBrHsljTASwq/snIi6DoX8JHwZWSzolgZmeDI5o
         gPVjLuuZLXd2XBvTE3omYcRzqPZklP972sQuHXb3kh5c9kartgH5tLQOMa9KUXARbDe3
         raSQ==
X-Gm-Message-State: AOAM5318lxqVm+O/EUbwcCXwSKgWSreW2QWEGFfGhEPCAwmxcpvPfa1t
        +kaTqtBsm0AorG4vLJxcu3lnTCX/FWht+GuiRUo=
X-Google-Smtp-Source: ABdhPJyo+0l3/CHTOa1jT5ydMhO2jKP1hSlIOWWAclutR0PCYMx6AjJEfPZRKrxVAjcmGJv9ggOUNLF1g5gUGV+YTcc=
X-Received: by 2002:a0c:d809:: with SMTP id h9mr14075712qvj.47.1623137373373;
 Tue, 08 Jun 2021 00:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210604092228.199588-1-heying24@huawei.com> <CAOSf1CELBh4F334LK6+zy+BPOXKcOm92QZw4g71hQ7oQNa68nw@mail.gmail.com>
 <9dc8b323-7846-0975-16f0-6e3e447383a4@huawei.com>
In-Reply-To: <9dc8b323-7846-0975-16f0-6e3e447383a4@huawei.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 8 Jun 2021 17:29:21 +1000
Message-ID: <CAOSf1CGXp=F2aqP6=c3vhd4e=L7+2_V5mMOpiseAQa7L1NsZ_w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix kernel-jump address for ppc64 wrapper boot
To:     He Ying <heying24@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 4:33 PM He Ying <heying24@huawei.com> wrote:
>
> Hello,
>
> =E5=9C=A8 2021/6/8 13:26, Oliver O'Halloran =E5=86=99=E9=81=93:
> > On Fri, Jun 4, 2021 at 7:39 PM He Ying <heying24@huawei.com> wrote:
> >>  From "64-bit PowerPC ELF Application Binary Interface Supplement 1.9"=
,
> >> we know that the value of a function pointer in a language like C is
> >> the address of the function descriptor and the first doubleword
> >> of the function descriptor contains the address of the entry point
> >> of the function.
> >>
> >> So, when we want to jump to an address (e.g. addr) to execute for
> >> PPC-elf64abi, we should assign the address of addr *NOT* addr itself
> >> to the function pointer or system will jump to the wrong address.
> > How have you tested this?
>
> I tested ppc64-elf big-endian. I changed the Kconfig so that ppc64
> big-endian
>
> selects PPC64_WRAPPER_BOOT. I used qemu to run the cuImage and found
>
> the problem. It made me confused. By applying this patch, I found it work=
s.
>
> I thought it works for ppc64le too. So I upstream this patch.
>
> >
> > IIRC the 64bit wrapper is only used for ppc64le builds. For that case
> > the current code is work because the LE ABI (ABIv2) doesn't use
> > function descriptors. I think even for a BE kernel we need the current
> > behaviour because the vmlinux's entry point is screwed up (i.e.
> > doesn't point a descriptor) and tools in the wild (probably kexec)
> > expect it to be screwed up.
>
> Yes, you're right. PPC64_WRAPPER_BOOT is only used for ppc64le builds
> currently.
>
> LE ABI (ABI v2) doesn't use function descriptors. Is that right? I don't
> test that. If so,
>
> this patch should be dropped. But why does ppc64 have different ABIs? So
> strange.

Yeah, it is strange. When LE support was added the toolchain team took
the opportunity to revamp the ABI since BE and LE binaries were never
going to be compatible. IIRC there is a slight performance advantage
to using v2 since function descriptors added an extra load when
performing a non-local function call. I think.

> If the wrapper is built to ppc64be, my patch is tested right. The entry
> point in the ELF
>
> header is always right so you can assign the header->e_entry to the
> function pointer
>
> and then jump to the entry by calling the function. But in the ppc
> wrapper, the address
>
> is intialized to 0 or malloced to be an address later. In this
> situation, I think my patch
>
> should be right for ppc64be.

Yeah maybe it's fine. I just have some memories of running into some
bizzare edge case at some point. It might have been the entrypoint of
the zImage rather than the vmlinux which had (has?) that problem.
