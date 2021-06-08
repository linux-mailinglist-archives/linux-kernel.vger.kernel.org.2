Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B756139FA11
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhFHPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhFHPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:14:05 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728B2C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 08:11:59 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id c1so4621947vsh.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MSjX3nK0GtynqqM9iCd6zkIVV24QDnb4NX+dYBZ1IiE=;
        b=NZLM6u04LG7nwTw6PryrH38vcL6MJPJbpbyRCidi51cIdv94dnze5cgvX/h8Li8EUo
         SZtNHDQdv53sOUQIrSNi95dlL0BmjNBfkXDZfj6sFwYulYYqwnFr9kNy3yaM7UTsB5eA
         JjSN667e9IehHycBa4rQEw98ooWGeUrZA+JxBFa52bDrH8uNhPQ4nC2prvi5hQErPR1s
         31MdlAdpxfOFJ6KnUMPfsg8C3csLwWt0vi9M6HP2EtTkb0rwlsWXUmIuiWSqFIdr17Um
         WS+if7PN0r407S08u1Q4W3j6+7d+bhX623cYMeq2mDa2/qHdiVBEA/vWdEUXqXoXilBn
         TNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MSjX3nK0GtynqqM9iCd6zkIVV24QDnb4NX+dYBZ1IiE=;
        b=om6Wn3UQXt4XSpXIW/i4f9AJ58H0LNFK3Z/9rMG6oQYzBAX30E+61aVHcWCYtmuuBR
         1awd4WBd9brff0Cbu2ZWh1XboiGzHOdstAtyidx6Eu4fWi6LLJosYCtO6Tgj9y5QNisN
         ZAi1B0Wxw34QxpfTo2CXDlnLqXdzRq8Z0upEwxM2RyA1kH6t0RZY1RTSIChp2L7dPvr9
         aCo10YlFD+YIyfydb1ZufchhYsUJLdIGJjgn/4yNg8yJ1td2m+rl6zWhdLGLhK8Y5a+m
         Vs5JkQ7kNlxTSSdCZm9vVnqbKyUVoMh7wdHiIvqlfN4niGoIwaB2XVLISTpIJEDsG2UL
         d3vQ==
X-Gm-Message-State: AOAM531oBI8wnu7dau1MxcvFjq1m1BDQvKcNyeMNS8ktQaru30WYo5Xx
        09dCC66WNFzc6xVQOj6Q0iNfuF78Gnftq1aGD0U=
X-Google-Smtp-Source: ABdhPJxVExwpG2PuPqzwrJCiVhc2Ij6CRz8h+gU2c0qgiChMP52og2D5WbQzG29HrvxPuo43oT6jGStUz/wdM5QZZls=
X-Received: by 2002:a67:7cc7:: with SMTP id x190mr647069vsc.30.1623165118611;
 Tue, 08 Jun 2021 08:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
 <20210608083418.137226-12-wangkefeng.wang@huawei.com> <CAFqt6zZWanzsy=F4LVUkovQE-wqKd0CNG-n=Sx7SBddord6Gcg@mail.gmail.com>
 <215985fd-67d5-731f-743c-ea446b55bb8d@csgroup.eu>
In-Reply-To: <215985fd-67d5-731f-743c-ea446b55bb8d@csgroup.eu>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 8 Jun 2021 20:41:47 +0530
Message-ID: <CAFqt6zbk3rYPx9Qa+pZ3Q5XNLfQZ4w01CCGuq7LYhVYDwweYpw@mail.gmail.com>
Subject: Re: [PATCH v3 resend 11/15] powerpc: convert to setup_initial_init_mm()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 8:24 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 08/06/2021 =C3=A0 16:36, Souptick Joarder a =C3=A9crit :
> > On Tue, Jun 8, 2021 at 1:56 PM Kefeng Wang <wangkefeng.wang@huawei.com>=
 wrote:
> >>
> >> Use setup_initial_init_mm() helper to simplify code.
> >>
> >> Note klimit is (unsigned long) _end, with new helper,
> >> will use _end directly.
> >
> > With this change klimit left with no user in this file and can be
> > moved to some appropriate header.
> > But in a separate series.
>
> I have a patch to remove klimit, see
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/9fa9ba6807c17f93f=
35a582c199c646c4a8bfd9c.1622800638.git.christophe.leroy@csgroup.eu/

Got it. Thanks :)

>
> Christophe
>
>
> >
> >>
> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> Cc: linuxppc-dev@lists.ozlabs.org
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >> ---
> >>   arch/powerpc/kernel/setup-common.c | 5 +----
> >>   1 file changed, 1 insertion(+), 4 deletions(-)
> >>
> >> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/=
setup-common.c
> >> index 74a98fff2c2f..96697c6e1e16 100644
> >> --- a/arch/powerpc/kernel/setup-common.c
> >> +++ b/arch/powerpc/kernel/setup-common.c
> >> @@ -927,10 +927,7 @@ void __init setup_arch(char **cmdline_p)
> >>
> >>          klp_init_thread_info(&init_task);
> >>
> >> -       init_mm.start_code =3D (unsigned long)_stext;
> >> -       init_mm.end_code =3D (unsigned long) _etext;
> >> -       init_mm.end_data =3D (unsigned long) _edata;
> >> -       init_mm.brk =3D klimit;
> >> +       setup_initial_init_mm(_stext, _etext, _edata, _end);
> >>
> >>          mm_iommu_init(&init_mm);
> >>          irqstack_early_init();
> >> --
> >> 2.26.2
> >>
> >>
