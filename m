Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2C444F70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 08:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhKDHDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 03:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhKDHD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 03:03:29 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D33FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 00:00:52 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so3831745otv.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 00:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ztfoODKQtCoSAkQOF1PB4N0RYdp9UGtK0cgegZxVtWc=;
        b=aiEKgy45nYSlVQLX+o+nZ369l5vGBmMVwn+quE7M41iDwM2ohcnMwmTtAZcS41qsk0
         HNkDX25sPdDOVOKqYS1/Okb86mmxxxZg6SN3nwKQ8hiU37B+BafY61XX5ySkSCybHtGg
         wSG6jNch761CMwDeoRoij21PQgBcOGquCPNT4992qdxVnQAPjrIc85Po5qDcvqt1CpC7
         zZxapRhZYlCitbeWPSRE+ubrwe9k9+GoTl00+xsZd/3MLKa3A/rPTVJXhNapU6slQfBD
         SWUuesAzM18+gGT3HIPv7xd0V0uBaLSzN6HyYrVni18XwlQi62JKEQDbUvQLVoH0DXFI
         n3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ztfoODKQtCoSAkQOF1PB4N0RYdp9UGtK0cgegZxVtWc=;
        b=Dq4FF5LWATDVCNG+tH8jQ9bAzaJkWh9SAfUpD79/Y5sFMbJxO4EkIFr/zjg8qroUXx
         tQZystlKHSGNBzBkog1lsDno5uR/LXbKLvtAfcU4KMMmYEMg9fZCsNdktugxaOI1XQfn
         F1y/we9LFjVKC7ozGSRAjU0jJohgf44DTuZRbCi//ZmXuNonZbuW924uPEuX5YFrWxPD
         ocm3zj8m6kuejZLdcvq7N8VuPIzFteRYtWwUJSmvnm0MDU6KWyKBQXScl0fNGJ15G73j
         2WNEMZFSKZOGJ/DpIjNbouLw+QF8Spi/JUXndzP0iKPfuP+9Pa0cnn4ucw8njOj+m8JO
         BsmQ==
X-Gm-Message-State: AOAM532jcF0so0tcQnLh3TNchXgUdJW8akBUyhLRu+gTKNPnxfMK5Hml
        3XnVhT9mGV+ubkUFtm5BN2eLjXYd1ZL1HbtkFj8uHg==
X-Google-Smtp-Source: ABdhPJwfrJFdDNR2RNG5DijVHkTTLsCgoe8/2qKWKpvX+doxckURfZCzAj5GB6Jyqr1JvACQcB+cy3Io1PZT1LYnvm4=
X-Received: by 2002:a05:6830:1247:: with SMTP id s7mr26051994otp.329.1636009251085;
 Thu, 04 Nov 2021 00:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211103133845.78528-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20211103133845.78528-1-wangkefeng.wang@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 4 Nov 2021 08:00:00 +0100
Message-ID: <CANpmjNO6-=dLN=K6R7DrqZmZ5Q8NfORV9kQvwK9kcjCRQhuFaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: Support KFENCE feature
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2021 at 14:26, Kefeng Wang <wangkefeng.wang@huawei.com> wrote=
:
>
> This patchset supports Kfence feature, tested the kfence_test on ARM QEMU
> with or without ARM_LPAE and all passed.
>
> V2:
> - drop patch4 in v1, which is used a new way to skip kfence test
>   see commit c40c6e593bf9 ("kfence: test: fail fast if disabled at boot")
> - fix some issue about NO MMU
>   - drop useless set_memory_valid() under no mmu
>   - fix implicit declaration of function =E2=80=98is_write_fault=E2=80=99=
 if no mmu
> - make KFENCE depends on !XIP_KERNEL, no tested with xip
>
> v1:
> https://lore.kernel.org/linux-arm-kernel/20210825092116.149975-1-wangkefe=
ng.wang@huawei.com/
>
> Kefeng Wang (3):
>   ARM: mm: Provide set_memory_valid()
>   ARM: mm: Provide is_write_fault()
>   ARM: Support KFENCE for ARM

Looks good to me.

Acked-by: Marco Elver <elver@google.com>


>  arch/arm/Kconfig                  |  1 +
>  arch/arm/include/asm/kfence.h     | 53 +++++++++++++++++++++++++++++++
>  arch/arm/include/asm/set_memory.h |  1 +
>  arch/arm/mm/fault.c               | 16 ++++++++--
>  arch/arm/mm/pageattr.c            | 42 ++++++++++++++++++------
>  5 files changed, 100 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm/include/asm/kfence.h
>
> --
> 2.26.2
>
