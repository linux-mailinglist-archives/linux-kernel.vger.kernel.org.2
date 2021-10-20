Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12277434C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJTNfu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Oct 2021 09:35:50 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51323 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTNft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:35:49 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MODeL-1mJhzw3XrN-00OUOY; Wed, 20 Oct 2021 15:33:33 +0200
Received: by mail-wm1-f46.google.com with SMTP id g79-20020a1c2052000000b00323023159e1so1790315wmg.2;
        Wed, 20 Oct 2021 06:33:33 -0700 (PDT)
X-Gm-Message-State: AOAM5301XPz0H3iXI2bGvd+m9ERXfiawu/rDO5yrf9dHivxD5xN+wjUf
        madVRj8iQ3ek+13uCHw7/5BzISHKEf9U/b33vAY=
X-Google-Smtp-Source: ABdhPJxY/Ua7ZwYe4Z5WF5LhCFLVLILKFKBq3mgQsPNvFmW5mHTQv/qL3luMioBXbYeLCvcOb7xVR7smc7gDFtx2g/E=
X-Received: by 2002:adf:b1c4:: with SMTP id r4mr51896376wra.428.1634736813387;
 Wed, 20 Oct 2021 06:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211019141228.1271617-1-pan@semihalf.com> <20211019141228.1271617-2-pan@semihalf.com>
In-Reply-To: <20211019141228.1271617-2-pan@semihalf.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Oct 2021 15:33:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0g82DoivaADueeOcKOjNVDiutZLAAWAROzgvuYt83Z3w@mail.gmail.com>
Message-ID: <CAK8P3a0g82DoivaADueeOcKOjNVDiutZLAAWAROzgvuYt83Z3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] socfpga: dts: move arria10 aliases to socfpga_arria10.dtsi
To:     =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        upstream@semihalf.com, Marcin Wojtas <mw@semihalf.com>,
        Jacek Majkowski <jam@semihalf.com>,
        Konrad Adamczyk <ka@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Alexandru Stan <amstan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:9TIBTlutona7zBFgeBOsTKFN5IW8STXY0jlFzDV4LvCQCZhpaFX
 0GsPasrHE+pnFjq9Uf2Ep6TOI5flGmlesLn5Yph37398bCnAfssBxHgR3dBa5Hh6lgceYfL
 mcDnHrMgkPV3eufRvafcfJjxv/oR3SEGqy7lgGBs/dPVBU7hGqjOJ0amr51P9Vs0h95FM6X
 rKWKpRR05lxVOUMDHIPvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YZdY5xPBj0c=:+SR+Wko6nNnxVLfq9AFIUH
 hUeS5jwnsiNlPPN6zSjcOUXz/Z3vog2mDdxzqHsvSZPZZnR8ecA7gpmwToh4gCQMRbcaYsQIQ
 8sqX8Gu3Xwi7TH4yDBCRcoUKZq00tU2JtqFdBpNt64CaZaJAQGOU44yi6g5RD++Yi2MhpJEpK
 J4x0svNo6SzVfFqI6vZpt2gSV0ZyIM9hmwWVRu6umPl6pHOESv8v6Wk8naTcJh+JsqA+x4/Te
 aEo/XkVIWCsBPzeUb2xG/CGx0c49RSAO/MT2Ikk9KZ1eWbFvWDnMO8AkasVMKgb5gMldWCha8
 nchFKDgvC7c4uhh9vOmdtsqa+BvJ0/9c2llMMkx9KtKwBGABvXEvXfbS+Jo2AI7shZQ0v6BLx
 +W5jDrsmOUMfp5tkjAU4mA5LmeOmMJHzZ0dzBn9g1Yhd7KvUbQx6JGfIlmP8139xtxS8AfpMR
 UZcH5vmDh6rpwW0Velre/g0bhdGs6DHUY8HqtWncyNeVoXPQR6h8KRZGQEQ6zbCsIHHSLoFsi
 Y75n+FTz9XKLH83yByUvdDnUuxZ5S3K3JIIzD3kkbBPWApUG/46mMe4BTXvHjZXaIeHvmESV5
 q5G7Z1GnXHDnwrg0aMuOW1l3uJJ8oDFiJrUzVaKmsdJ0Zv+DHIM6Rg+1cIjHaZswSYu11iOqM
 VgIzhQuJ2xMiLmK3YkfeJ586J/UEGJLpNshwymjU145ajFHPsebtGq7BaNK/+eWAU5hWqNeDN
 W3yS4U/fq6LD5xGRSFGg9/nZD6vcE503n1AaEAfrW3Zzo55sBHuQmUdpvK+2Misa3+sWzldoZ
 Schd+D/pgyLXiWUg3quK2qUpCPCh7f9u+/qoGu7Lxi+tZDiCE0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 4:12 PM Paweł Anikiel <pan@semihalf.com> wrote:
>
> socfpga_arria10_socdk.dtsi declares aliases which will most likely
> be used by other arria10 boards in the exact same way. move these
> aliases to the parent file.
>
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>

No, please move them into the .dts files instead for consistency.

Each board may use a different subset of them, or have them
numbered differently, so keep it out of the .dtsi file.

     Arnd
