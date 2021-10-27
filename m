Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4E543C7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbhJ0Kkt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Oct 2021 06:40:49 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37073 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhJ0Kks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:40:48 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MlO5j-1n4nTM3YLd-00ljfu; Wed, 27 Oct 2021 12:38:21 +0200
Received: by mail-wm1-f43.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso5842776wmd.3;
        Wed, 27 Oct 2021 03:38:21 -0700 (PDT)
X-Gm-Message-State: AOAM533T6KMXll3ZrO5qtGVi3o7TSGnCsK0AmTex4VqFCYeAZC+TUFOf
        NHD0TvWo8t/A/e7HbxVmHTE1vmkn6CQUUulAqzA=
X-Google-Smtp-Source: ABdhPJzWVmMJRu6Nz/rjaD9BGMlTJTXmWs4kciJksMzsWQT3KiOawx9iTDk2eBtfMChr7uV7l5Br7Iq8uFXkQjkfCiM=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr4852836wmg.35.1635331101366;
 Wed, 27 Oct 2021 03:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211027080849.3276289-1-geert@linux-m68k.org>
In-Reply-To: <20211027080849.3276289-1-geert@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Oct 2021 12:38:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2uxL3qGtDOuCg2Np4k_MtYML2VgOj4HVvOZXEFAEEuvg@mail.gmail.com>
Message-ID: <CAK8P3a2uxL3qGtDOuCg2Np4k_MtYML2VgOj4HVvOZXEFAEEuvg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: Mark USB_FSL_QE broken on 64-bit
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        USB list <linux-usb@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:977zZkHhQJaxSarzoX+MR9G0xluBYVdMBh6F4U5fjgpQ+lABTwh
 lapMD1fGalsvx2dDFu9HgqG5VwfQdL87TVGSq+CEcW8cnYIbmh4d6EyZAEVTq7yNpJPbAwt
 Dcm2qI/3BqaT1+E1wyygVaBs4dfdbEsL8Tc55Uc35T2q0xret+9ph3iQHJ8SvW/r/cK34dh
 2q+sGi9W69BRrdREfoYqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oQA6l8nLBSY=:qGuxqGpsLsMXWhN9LuMm1y
 7em73T326vPryxf/5CSF0l79nbH5sAmPZ92COu6mt4sh3376Z88DcN/ZgyvXjMM5p2nLvQq3I
 4dlOUfwHuOzKkCkAnqbwgoK1Oy9u1xKby262k3eSCOrVlwAVAvza5+1C3NLw28Bh/rK/uMXsv
 FR7nAw82NwOmZRkvV6pR0AYEmIN1jB/GeE2e6pc1gygoj0o+l1/b93HNM/cD5c/OkLAOVMhH+
 abfkUry8riB7+anqZ2QhOztyLvRjWYM5VliOYOSxYh2Il4SI1dqt4T+868JjHJKoejpZ7bGqh
 9R5zVTPbW6fJdvBeY3rjjhn06ju7K97L3/AXsdmzvqBAdWv3jldQmLkZHCwzTBITHK2BwNXNS
 z56s+THLBFDizpwMJBI8c6tuTFhemGIhPfnu9XXVH3nTMQnb/77Q9MNjsl1hAV5WFLCmr0/LF
 EKIqVI9M/8PqfinIr0aFzwNei8BFsbx5vRrcMXnUlKuFWQJ8iqZbkcQ8hQKJz/AYpNpH2iOC1
 O6PZnlaMUsC50rteThhQhQFp7F1xyVg3mhZTCR3uKFmaKiflO8BWY9hRAc7bzkphZAl32Ps44
 sXv0DjzelL+1iteEeUhJiNOW1IoXBINkSzj2g3tORgSRSmdx31ZgqAiI0ykJ4/2KhJZwHmvME
 0j+Ge/mg9aJVbU4lnv/iBjM6pi9vXc2jaxspV5QnUBIOpIrkS4K62fgpbeIz48pf1Rho=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 10:08 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On 64-bit:
>
>     drivers/usb/gadget/udc/fsl_qe_udc.c: In function ‘qe_ep0_rx’:
>     drivers/usb/gadget/udc/fsl_qe_udc.c:842:13: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>       842 |     vaddr = (u32)phys_to_virt(in_be32(&bd->buf));
>           |             ^
>     In file included from drivers/usb/gadget/udc/fsl_qe_udc.c:41:
>     drivers/usb/gadget/udc/fsl_qe_udc.c:843:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>       843 |     frame_set_data(pframe, (u8 *)vaddr);
>           |                            ^
>
> The driver assumes physical and virtual addresses are 32-bit, hence it
> cannot work on 64-bit platforms.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Interesting, I have not seen this one in randconfig builds.

It looks like the driver also assumes that physical addresses are the same as
bus addresses, so maybe it should also be marked broken when CONFIG_IOMMU
is enabled? Maybe that takes it too far, as this driver could still be used
on a machine without IOMMU in a kernel that supports IOMMUs on
other machines.

        Arnd
