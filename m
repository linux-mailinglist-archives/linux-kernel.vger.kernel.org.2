Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5AE41058D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbhIRJm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:42:29 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:34963 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbhIRJm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:42:28 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MGyl3-1mexEi2OBv-00E894; Sat, 18 Sep 2021 11:41:03 +0200
Received: by mail-wr1-f45.google.com with SMTP id d21so19168349wra.12;
        Sat, 18 Sep 2021 02:41:03 -0700 (PDT)
X-Gm-Message-State: AOAM5333rzB5ir+X0d5Gt9bT5adFqMlnJEXGClhPEBDShKRZ5IQL2aTw
        RAHIas0baG949VVU7TvmG+fyqz/TYWp6cyEYzeg=
X-Google-Smtp-Source: ABdhPJx9yqI+1/9/BGcNvj+UPWnFAxrQw73U1HxZSwhNOnNNiyPOuaYL8RQiCFPVaYCRRHWPncR7qh7DTzY4XWN92IQ=
X-Received: by 2002:a05:6000:1561:: with SMTP id 1mr7487499wrz.369.1631958063252;
 Sat, 18 Sep 2021 02:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <c6f280927835c5677cc0367fccdc0ef54b307bd8.1631943364.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <c6f280927835c5677cc0367fccdc0ef54b307bd8.1631943364.git.christophe.jaillet@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 18 Sep 2021 11:40:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3=0kJamjC3Fd_xHx==AXs-_k77gpYkhZz6VEa31K6iOQ@mail.gmail.com>
Message-ID: <CAK8P3a3=0kJamjC3Fd_xHx==AXs-_k77gpYkhZz6VEa31K6iOQ@mail.gmail.com>
Subject: Re: [PATCH v2] mei: Remove usage of the deprecated "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:aRHOdbpH6fsglEmrF1NTwMM2llsFNWYF2GO1h2C24KAvivt0VFC
 lf7RvzIgimM7txwOXL29U62pUX2WnwDwA9KEoUq59AhYg6ohTvUUagBI5GV1/Cw4bHxoztp
 uA9lBCeeszkupgUhJ5Z9Pabeo0huk5IPKC5TVzbOGRhYKL5YlwDHqXzrSMAlURtVhGLHjdp
 A0q55Nk4mqkHu1ay7MbYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rzKSYP4C1fY=:48v6u8SUodSB8u4efnR1kg
 Z2tMe3uj/ENKOIUQ25M9haukuRBGDr/6jx+E+xe0FhYPB+80HyvTIQaJ+2lohhsarAZj892Y/
 B5c3mbSCyP4Rq9IxJxJ0oI+vd19zehA7o08B6vPpemqMSfLf/Nu6XMBV24RI5Kjf4oPZZSWez
 KgtEHTFkEatWT12NJQ2JGNKYLF41hWFWNjrFnwV5ftwxepNadVqrRrQbSlw5GY4g7zuWNEltA
 QxHgBcpOZkzgZL/4poheJ/I4Cvn8VAO4RONRhiPD6k8kdmujgU0St7FohxCo3LP9+pmordGV+
 sahQFdpHEOGMPNOMgByrt+a3d3dYUzEOBU0GSApOLiL8HsRK6U8E2QTw698UlBWY1TJrcp0TS
 9VbsNAyFIU4ZaTCfYyIn2WC1XP0cOYl8syPK1qeI8QoMFovr3uvVGfIztJrY7sGgt9tSl8B64
 A9jx1EngWpHTnfFI67bg9ymd46QMDapjxWIodKCFLUPBipwB479/lLku9c15XxHjymsbHQ1PT
 sfNRB8/sgPJ2s9K+vzxjfukRYj37thikAjXdpIRZztMxtI8hAv6Oxvswe1WZaeCXugh3YsYPm
 GSWIiXUP1+vnAUpF3Z6r61S4ECNKwVFuawh4nyHjmSRD3+rjEa7t17mAtGePQpovMNmSiRMw9
 QaTbsHXSaE52GEQhsaSjS1QuAjwkaPmrR8mvnQigab0PDY19z88gdt8ufCwPopJVchs+p3bBr
 yQhG2Rk0tS6MgxXqPzzHb6yI72MVMiXFHxUUM/zdq6oCEp53xorUCkhqH0pRBkWXHTaeQDbG2
 B5fNHn9/wkkj3zckpvb09qjAlmNA2jwyQTj8qu48wi8KTXTaUptzUVzq6w/WPfV4XCgapdEfJ
 Tm0tuqkcsV5Vdt0lH8mQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 7:36 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In [1], Christoph Hellwig has proposed to remove the wrappers in
> include/linux/pci-dma-compat.h.
>
> Some reasons why this API should be removed have been given by Julia
> Lawall in [2].
>
> Finally, Arnd Bergmann reminded that the documentation was updated 11 years
> ago to only describe the modern linux/dma-mapping.h interfaces and mark the
> old bus-specific ones as no longer recommended, see commit 216bf58f4092
> ("Documentation: convert PCI-DMA-mapping.txt to use the generic DMA API").
>
> A coccinelle script has been used to perform the needed transformation
> Only relevant parts are given below.
>
> @@
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
>
> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Change Subject to be more explicit
>     Keep only relevant part of the coccinelle script
>     Try to improve the commit message to give some reason of why this change is done

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
