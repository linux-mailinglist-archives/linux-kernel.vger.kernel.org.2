Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFE4541F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhKQHlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 02:41:15 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:40833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhKQHlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:41:13 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MJW5G-1n77p020xE-00JpgD for <linux-kernel@vger.kernel.org>; Wed, 17 Nov
 2021 08:38:14 +0100
Received: by mail-wr1-f45.google.com with SMTP id u1so2700875wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:38:14 -0800 (PST)
X-Gm-Message-State: AOAM532k44KuPi7pKmvPjDXa3h1sUdWfTMGfNytYRFxhJ1IcbqBZbDC8
        87z1Sx+KQ5vgUY5XUDw0FbFZ2d/5mhGUtavve8g=
X-Google-Smtp-Source: ABdhPJyDzFzUZ26UQ9WxGi2mM9RgY/r6prCrnT92LA3jbLR4805/P5X5Rjrcv3jyDIe0oztp/vyy6t17ke0ttd8f6lw=
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr17637588wrd.369.1637134694103;
 Tue, 16 Nov 2021 23:38:14 -0800 (PST)
MIME-Version: 1.0
References: <1637104560-37432-1-git-send-email-quic_c_gdjako@quicinc.com> <1637104560-37432-2-git-send-email-quic_c_gdjako@quicinc.com>
In-Reply-To: <1637104560-37432-2-git-send-email-quic_c_gdjako@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Nov 2021 08:37:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3W13wb5B_FMSCEp0JTUFrPk=Fp8N59oa58wxn+WeTroA@mail.gmail.com>
Message-ID: <CAK8P3a3W13wb5B_FMSCEp0JTUFrPk=Fp8N59oa58wxn+WeTroA@mail.gmail.com>
Subject: Re: [RFC 2/2] drm/msm/gem: Make use of the system cache
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ziVZN41oBhBj++miuebYLVne5FL6WXUo4Y7o+r0/eUt1s6M4oUM
 TItpLDQCb7FcaqzJa+YLWxtwNvZb216g1wQ7bJJ6Aa+EEmdJ/LTjO7BTQ7jy0gL0sTs2Tw5
 DJ829eh6pqbWFb8pU4jhZC5qkl6nbMr+BhrHEdwFlJnm4wokhVOtxG5jU8KuVaqtf9xslie
 z54JKYY27bPOx+4ivGFgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6LnhbJqQ9fE=:tBnWqB6S1i+Mc+87JJKCLe
 IzyY2+/WLcx65v6ZKKe/EQPtKFslmxW33hkwhQMpFzG/Dx38SJBJlH3gIWyMMFqDxrKMe2KA4
 zNnQSamfZP/N9IRdhqv+AD1u2LP2fdtSdi8uPUVlA/XoxHQdDP+onmJZOh7sVWAGhii92JV2h
 1WlKLTJEBSGQZXDHi+NuxV8/BTNEYWUd4puKrl533+FY/LOPyAHG7dX4GIg6dA5P9b5PG77XU
 TTru9sSX7+q9EifwP7/NYmaY95ZfnacHuDJwP/cBXzHOEQIBHEgvnyYBWDNGEouTeI3ztZzsT
 C1sIrsrg7GE2PNLxsIoEENlY22kR/7ueSQ/MckOMcDIWqyzwfYCR0rxb3Mrn+I82HFXcdcPQV
 VSJAkeqczCXdwbNkpJXmybwi63xUeLtrdyWmQya1K+dqrUToM/0UwY2v1FBdzw5iOB03UhgNZ
 zCL6gPGWvVQWwEjksabMjGyRx2kjL0LQyvwo+bQRsE6m5ADUNGIZ+/9QUTT1druF+N7KigzzT
 jsdFVkEDDbn9sk+t0RbXHKawOdZwBBsmU9sLZ+4Kx6WLRR3HFT/rhgHl7Z5trAVYE3blp/h2c
 qt0Q1p+CuxpDTX7Jqrpl1j2Sqq21Kfv8SY8bntd99pLz2y8LecPRpHHIeixR/uw7T7M3tmmF9
 ERhGYxvMnUODb/vIhPGT6FstHvWK6TYjKWYQly/bS/UPU4G3fxauQuw0ubS42325zbjU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 12:16 AM Georgi Djakov
<quic_c_gdjako@quicinc.com> wrote:
>
> Instead of writing to WC cmdstream buffers that go all the way to the main
> memory, let's use the system cache to improve the performance.
>
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 104fdfc14027..921a1c24721e 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -214,7 +214,7 @@ void msm_gem_put_pages(struct drm_gem_object *obj)
>  static pgprot_t msm_gem_pgprot(struct msm_gem_object *msm_obj, pgprot_t prot)
>  {
>         if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
> -               return pgprot_writecombine(prot);
> +               return pgprot_syscached(prot);
>         return prot;
>  }

Based on the definition in patch 1, doesn't this mean that 32-bit
kernels degrade
from writecombined to uncached, making them a lot slower?

My feeling about this series is that there should be a clearer
definition of what
exactly happens on systems with and without system cache.

         Arnd
