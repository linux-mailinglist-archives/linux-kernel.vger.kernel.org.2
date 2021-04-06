Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7833355782
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbhDFPPd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Apr 2021 11:15:33 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhDFPP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:15:28 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MSKly-1l15R91IHA-00Shhp; Tue, 06 Apr 2021 17:15:19 +0200
Received: by mail-oi1-f179.google.com with SMTP id a8so15432339oic.11;
        Tue, 06 Apr 2021 08:15:18 -0700 (PDT)
X-Gm-Message-State: AOAM530fUSLnprMb+MnFMSs6qnHnFIpNUBAge6I3v//n2kk1Onz4tJSF
        X2YJ1ylCKRAglxWS+iaOXAzU9yS3TeBT5WBh0tU=
X-Google-Smtp-Source: ABdhPJz4slBAtMkWReqWmn9qjq3arsJPPMq5eMKJmxc8Fy+6BZN/lNC6TLdMMNWBQOCPC67UyuJWAc0FKYC/hZSiCXo=
X-Received: by 2002:aca:5945:: with SMTP id n66mr3568287oib.11.1617722117908;
 Tue, 06 Apr 2021 08:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
In-Reply-To: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Apr 2021 17:15:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0VfnUucvZNkA9PdxrWiYUOkisV00v-375PmgQYp4aXoQ@mail.gmail.com>
Message-ID: <CAK8P3a0VfnUucvZNkA9PdxrWiYUOkisV00v-375PmgQYp4aXoQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Initial support for Nuvoton WPCM450 BMC SoC
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:x9m9Q7ff8yYoUKMapPbk0VCXGxTFqarRF1FuovFTBO71aSCgZjH
 Po6rw+plCFrh0OdO2FGF9ybkZAmTqovns5fzlYeSqGq0GOJ9KprPzn/qnM9i5Mz9JlY3mnG
 aq6vPyoA9QfhEEV7yO4KZ6vE/C6vcR+yP8kysZcwaYhNP0vqUudlJki+cnULlp/6lGT47U7
 NrKMVk5s5XoanE4/sEKrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FIxxS8Y/tss=:pyW7CUrCROU5LIDU3UsC3e
 4aPbEcReqp+R3vzJziGSjQhrSit3f29yqc2HMr4JzC3QkyoUBh7svZkah0tLVc5ZCaud/A9se
 /hmJrNsnv5aHGdph1FmTE+jQDn7cr3sFswFLSgd+3olzX5DaVIY0+yZ9uf0ANqU7+Xn4TNE4B
 LoLtbPsTqsy7OvhNmws9Fo3n8rVtWshIny7ZjHtFrdan/Ec7NhKQP3S4S3mSQ/mOy+DTKGNUy
 3+ic4uYfDYB4xMgON0C3SFBiQkG4bYHU9QT8xfKHj4hMSInwriXIs0tYbo+Gbl2IH+XdulKk5
 Fz3Yfpz/tnY7MYJTFmNNcawNWljRavlavdd4CdXH9GjQwrZW09B3DyJfvvgy5AeuYRX7OcITE
 I3q7Gi3xddSott0ickVG71yhJPS3nEKiNl5dHxpIMcKy6aNuvtuYHh8ZNR4siAOF85D6ftmpk
 bSbmD+WOq4YuAXjZhihN5UxBYlvZuvDd65Wd3cDmdi3izAYVRp2FdkjO0cCzsMsfSsiStxMLt
 e+zgpouykTuLSXDyeHmCDERi8VKQFxc9cZ9DRiC1SF3QRJQHUr2EONft7WGFe914muKAMKhTl
 lnyvNUWLmSFHM/kToXJuFvJsXsX0P2nyEL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 2:09 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
>
> This series adds basic support for the Nuvoton WPCM450 BMC SoC. It's an older
> SoC but still commonly found on eBay, mostly in Supermicro X9 server boards.
>
> Third-party documentation is available at: https://github.com/neuschaefer/wpcm450/wiki
>
> Patches 1-4 add devicetree bindings for the WPCM450 SoC and its various parts.
> Patches 5-7 add arch and driver support. Patches 8 and 9 add a devicetree for
> the SoC and a board based on it. Patch 10 finally updates the MAINTAINERS file.
>
> Patch 2 requires "dt-bindings: arm: Convert nuvoton,npcm750 binding to YAML"
> (https://lore.kernel.org/lkml/20210320164023.614059-1-j.neuschaefer@gmx.net/)

Hi Jonathan,

It appears these patches are doing roughly the right thing, and we may still
be able to get them into v5.13, but I'm not sure what your plan for maintaining
them is. The two options are that you either send your patches to be picked up
by Joel, or you send everything directly to soc@kernel.org once it's fully
reviewed.

I only noticed your series when patch 9/10 made it into the soc@kernel.org
patchwork because of the Cc, but none of the other ones did.

If you end up with the second option, we can go through what this involves
off-list.

Regarding the Cc:soc@kernel.org, please add that only for patches that
are already reviewed and ready to be picked up, ideally with a cover letter
that describes what the plan is for merging. If you need me to review the
platform code, use my arnd@arndb.de or arnd@kernel.org addresses.

          Arnd
