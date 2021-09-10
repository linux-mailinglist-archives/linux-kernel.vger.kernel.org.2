Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAB5406513
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbhIJBXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhIJBXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:23:38 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926CFC061147
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 18:18:13 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id k124so79806vke.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 18:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbI2yiRU/jgiPI9Y0Qhq4XSNxGMyHQg/AsGVWpKiMPQ=;
        b=N/bV7DdzgzJX9tuD0gJ1oHWXMKjVIilDlTsd8CQdy9OcY+PYpLT/7StxhscRnc0n+X
         aHKf+SFbMiacCnfIm4gERFIDgquBJKQCAzX6eqvcwJObzw/lXlvYIzwbpd8nBNmjzE2f
         bBmO0P0lchrN8m8Zvi7E90n7aXB89xt1IPhFmL+Vza+M8LeKFpfNXbV1ZGdFCdyw+2EK
         sK1gkFyI3ofYwnp0dBfNxdkuFzesuyeGuSXXLAl+gxgK5M0EQYd9TMvh0N9dvtFgDcPy
         HiexPcqDYeAQiYrKzHOnxlvAp/LB2348/Mbc7USim1Kyfcsd45prwMumK1l3i8fOEPxv
         B8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbI2yiRU/jgiPI9Y0Qhq4XSNxGMyHQg/AsGVWpKiMPQ=;
        b=XbbcHarvKqSPT81bjUcd2mvE4QAZ3hrSPWT+ESpiNmDRj50JAfykaH8CWpNGWaDMM5
         Ytyq/7zVjv7zoZ1BPgstQlQmYRKiwe7ZhDH83XwsTyVriqKJbcxCwSIyffFWKKeObXiA
         CZxgPZbAucDkbkCXhTbwec+Lg7db56v8j1YX89XT9j3YOEFmDnDqlcQmXT+gBbxiNoXm
         bZ7m5489B5xPrnfOjJ1G24O2vMcWYLkEDK1VCXyKhzHqWRlbGmq/aegeAupkAu0bErF7
         s7dp30Q4bRIFckIlTqRsVUo/nyx/1CHC/jax0c2r8OdJiGCJxcGDasBeOPl2DiviBIpq
         NQQQ==
X-Gm-Message-State: AOAM532TQGAfsNneaxtogCnY7BiUc+d+UaqtX54SmapBLO/1MbYidBDq
        C5zMG5u5ygWhkxBIBBUMqipugFzwfotJO5XAdaSDPA==
X-Google-Smtp-Source: ABdhPJxVSmdutczIf+UKMJ5gDc9dI7OkFsH5fiUg1yZl4BNkB4w32KXzudQ2/8MTi7GZaj+yfhm0JyI1KEkD6NBtVz8=
X-Received: by 2002:a1f:43:: with SMTP id 64mr4038849vka.6.1631236692396; Thu,
 09 Sep 2021 18:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210818053908.1907051-1-mizhang@google.com> <20210818053908.1907051-4-mizhang@google.com>
 <YTJ5wjNShaHlDVAp@google.com> <fcb83a85-8150-9617-01e6-c6bcc249c485@amd.com>
 <YTf3udAv1TZzW+xA@google.com> <8421f104-34e8-cc68-1066-be95254af625@amd.com>
 <YTpOsUAqHjQ9DDLd@google.com> <CAL715W+u6mt5grwoT6DBhUtzN6xx=OjWPu6M0=p0sxLZ4JTvDg@mail.gmail.com>
 <48af420f-20e3-719a-cf5c-e651a176e7c2@amd.com>
In-Reply-To: <48af420f-20e3-719a-cf5c-e651a176e7c2@amd.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Thu, 9 Sep 2021 18:18:00 -0700
Message-ID: <CAL715WL6g3P6QKv1w-zSDvY3jjLVdbfxaqyr2XV_NicnuP2+EQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] KVM: SVM: move sev_bind_asid to psp
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alper Gun <alpergun@google.com>,
        Borislav Petkov <bp@alien8.de>,
        David Rienjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>, Peter Gonda <pgonda@google.com>,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe once we are done with it, will have 5 functions that will need
>  >=8 arguments. I don't know if its acceptable.
>
> > In addition, having to construct each sev_data_* structure in KVM code
> > is also a pain and  consumes a lot of irrelevant lines as well.
> >
>
> Maybe I am missing something, aren't those lines will be moved from KVM
> to PSP driver?
>
> I am in full support for restructuring, but lets look at full set of PSP
> APIs before making the final decision.
>
> thanks
>

Oh, sorry for the confusion. I think the current feedback I got is
that my restructuring patchset was blocked due to the fact that it is
a partial one. So, if this patchset got checked in, then the psp-sev.h
will have two types of APIs: ones that use sev_data_* structure and
ones that do not. So one of the worries is that this would make the
situation even worse.

So that's why I am thinking that maybe it is fine to just avoid using
sev_data_* for all PSP functions exposed to KVM? I use the number of
arguments as the justification. But that might not be a good one.

In anycase, I will not rush into any code change before we reach a consensus.

Thanks.
-Mingwei
