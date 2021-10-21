Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941D043604C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhJULda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:33:30 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhJULdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:33:17 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MMGZM-1mNUlq0RSI-00JHDl for <linux-kernel@vger.kernel.org>; Thu, 21 Oct
 2021 13:30:56 +0200
Received: by mail-wr1-f47.google.com with SMTP id u18so68706wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:30:56 -0700 (PDT)
X-Gm-Message-State: AOAM531JZEa8A6xnC7BZWW107IhO4iFwWfuA6z+JNMkLZYhDH85k7CMu
        7l5DEKG5TXSOP+JvSBdHGVZrO2DDpKo4uIm6YI0=
X-Google-Smtp-Source: ABdhPJzcazkfKoonw6SZah3e238itbP12J74p79Qz07ksYN7hvsrDFAzWhgeXXpFqRr6x5tkdlMCty5l3RadM5Cj6F0=
X-Received: by 2002:adf:d0c6:: with SMTP id z6mr5050441wrh.336.1634815855802;
 Thu, 21 Oct 2021 04:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211018121324.GA2943530@jade>
In-Reply-To: <20211018121324.GA2943530@jade>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Oct 2021 13:30:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Z-Hh9xav1peg8LqGoPaHnrt9eo453QmwKrWcWwWAEXw@mail.gmail.com>
Message-ID: <CAK8P3a0Z-Hh9xav1peg8LqGoPaHnrt9eo453QmwKrWcWwWAEXw@mail.gmail.com>
Subject: Re: [GIT PULL] OP-TEE FF-A for V5.16
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3lB6jItQFKoow/pJKTEHCoL3phQgjPuKixB+e5hP7Y3FWxOfgRB
 a2u9XNWEz5tAytc0YUpgPSMgea1YEw0JO22LBEnnGpbIIm+VMbtu3THgfZ2PJZNgoewwK4d
 dJuC8K8EBwtVky/F5x3O5hCeC2GkTtC+I+hDRDatDpBy97j1vVKOCIw+9EDCg+Xulphs604
 DVSAB+w1kqFCrsDxQUpxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kT5AKmdWuU0=:YQvk2HjRHh9FPvRgzFbCJi
 RsYYHEGgS7pzfOycMazERdW+w5AErHk7SYrO4+VC/ttYzSxyw5MaB3DhIMfeoMZBPCk5p/46i
 pR9qy7MxOc0TEt7xBE07tNTIe0Moy9yiyYQ0AsPLC5tN/XyZ1PqZJje+xNVc8YHJVqhgQfpb0
 Z9h4Yt8y7Lingb41sOY77ZZBz3pI9prZdBQ3DzayOXpPFCGfu2p+Ojq8ve2tBEdBjif5g+BrT
 unpW9Co4wA++e//MTpDtQvp6cEUaGrl7cR/HScKI16ixw4lY8A/JgZdXRsnx94z/tE9Q4yWde
 xKpIaCaeKjFmpvkz1KUE8F1Wr/DLk4c+rNowL+G0ThpUCmoJq+hxkSV9BB2ldgFFYd1htYTnc
 Bfkj8qbYRVdCTFEd4385I4FnDZ3bLvt7McxYureaWewAMYD9Dj8c7qstu1WOK5xuQuoRFIkj6
 UY9/5NNruIyhiOomHf+jWBQ3lnD4hg6I2S8wrAL6lwh7K7Q9At20HucJkRYa+Rt0UbgwtfQa3
 LbiasIlALzi7QBrYqkz06W/vLNGQGpgimh0QQDtIqltpC1dCuAjgunurmFneL9zDYAgQp1PvH
 p546RlrKjBwgPCoI3xwm2IoantSgtfeb+k3MS9+FuC1jNEIb0Z6frvRrc20pwoWj43qB7ffT5
 trHcKugLqHRX2DubJ7bSuKN2C8xWYhQ4JBrWPc8Dw5xlJeDPvIMrEZxBUQCg/iT5JNCk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 2:13 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>       optee: isolate smc abi

This one caused a randconfig build regression on 32-bit arm:

/git/arm-soc/drivers/tee/optee/smc_abi.c:405:15: error: implicit
declaration of function 'page_to_section'
[-Werror,-Wimplicit-function-declaration]
        optee_page = page_to_phys(*pages) +
                     ^
/git/arm-soc/arch/arm/include/asm/memory.h:148:43: note: expanded from
macro 'page_to_phys'
#define page_to_phys(page)      (__pfn_to_phys(page_to_pfn(page)))
                                               ^
/git/arm-soc/include/asm-generic/memory_model.h:52:21: note: expanded
from macro 'page_to_pfn'
#define page_to_pfn __page_to_pfn
                    ^
/git/arm-soc/include/asm-generic/memory_model.h:35:14: note: expanded
from macro '__page_to_pfn'
        int __sec = page_to_section(__pg);                      \
                    ^
/git/arm-soc/drivers/tee/optee/smc_abi.c:405:15: note: did you mean
'__nr_to_section'?
/git/arm-soc/arch/arm/include/asm/memory.h:148:43: note: expanded from
macro 'page_to_phys'
#define page_to_phys(page)      (__pfn_to_phys(page_to_pfn(page)))
                                               ^
/git/arm-soc/include/asm-generic/memory_model.h:52:21: note: expanded
from macro 'page_to_pfn'
#define page_to_pfn __page_to_pfn
                    ^
/git/arm-soc/include/asm-generic/memory_model.h:35:14: note: expanded
from macro '__page_to_pfn'
        int __sec = page_to_section(__pg);                      \
                    ^
/git/arm-soc/include/linux/mmzone.h:1365:35: note: '__nr_to_section'
declared here
static inline struct mem_section *__nr_to_section(unsigned long nr)

I have not investigated it, but it's probably trivial. Can have a look
and send a fix to
soc@kernel.org?

      Arnd
