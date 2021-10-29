Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEEF43FAC0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhJ2Keo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:34:44 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhJ2Kel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:34:41 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MAxLT-1mV9hA0AKf-00BMA5 for <linux-kernel@vger.kernel.org>; Fri, 29 Oct
 2021 12:32:09 +0200
Received: by mail-wm1-f44.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso12151583wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 03:32:08 -0700 (PDT)
X-Gm-Message-State: AOAM5322OZxLqeIkIsydkTSHodRxJoNAu3ZFHpysBzYfkJ3mO6KBer0c
        TMX1JpCCIyAy9F3fx/fPH6B45lrS/VbZuza38OI=
X-Google-Smtp-Source: ABdhPJzpoC1uwEdXwA/EYltB+hnqLIUcaruW7ppyYN9xJI0v2mHJF54n11A3f8YTR3iswMMa6VHQJhWVnLlIHtsfsYI=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr10549583wmg.35.1635503528589;
 Fri, 29 Oct 2021 03:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211014223125.2605031-1-suzuki.poulose@arm.com> <20211014223125.2605031-10-suzuki.poulose@arm.com>
In-Reply-To: <20211014223125.2605031-10-suzuki.poulose@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Oct 2021 12:31:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0=GC26FBuyoj2Q02VXdfkOd4k0DiDfp+0KF3C6tNO3XQ@mail.gmail.com>
Message-ID: <CAK8P3a0=GC26FBuyoj2Q02VXdfkOd4k0DiDfp+0KF3C6tNO3XQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] coresight: trbe: Add infrastructure for Errata handling
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Marc Zyngier <maz@kernel.org>,
        coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6i88G4sbACJ770UBiQK1XQAJ4KXiS0woymk+JFF+FcHzLNnNE/0
 vTFrWI0Ex26ISXEQI9WJfvHwg4njzKETN+ybeQLMxM/fqrqZ8kLqctsMss/RDVFct9ZZr15
 HCKk/8gtpUgjxppFMmaFVFQoxBU8MUq8BxjhZb1W/GRRs81Dh2lWdB66x9p8qIIht3yTOuP
 hcG/OCSL9kEmAOh2HE/Ag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2eB31LQVoZc=:LGp8iSPAGuM8IzgdcAQspn
 RZi3wfOKxHQ6D2RuyCLWxfNc4d6kXRJV+HaED6E4ukAl4hjGGIqLwDviW0lbsOsDaQNyHXJQr
 ZAlZ0AFpOfOH5zbqvFxmVunjGaxtb4YQ9m/nmSKD+GwS3fPq4VSM42XMoANzfeLVHGPrVzCHK
 NkYLm20Eji0b4Fe9O+BaR6h83RF0p+CiXQ0q9q3E74dUlUZLk2fwZlDU7sDHk7xY2yL5X8RJA
 Qwr3wEoK8Ekq1HsEEmfDE9NL7nkxeNK2hHEPoHN1cuNd+ZR407qkVJbvmOJxvYKvJTP6VBMUv
 EklVh4ZwG2lKDHybiPZbOv6v5gwrD3KgBpiQ0IqBD5Wst/E5pXRY8lkC02XC4061lbnWT2pLV
 lSQq2S8wNgKO1gCC5hkX8rY3THNGVM/xXs3JsNbkM3o+g3JxCJnZ+HasBk+fe8Awgdzhrmd7B
 ElccbDU3BdjeqIbV0uixJQ+7Rg/tCXjhqJWp1ojY+tSiuBguLJ2c6J1QJSnxNwt2r9BaO9+dk
 0dnw13GT3BrS7zEvZr4EL1rcgFrVk9FaWIhDprSHu3rf+eyS2h3sLlIPk9Bn81AMp01O00aOL
 YNhI1IRhKuHXLTEnDPhL9tpplg3CkIZIDWxazfFRKgumYrV3Fbd7efKhV1dXriC2MTbC6z5rq
 okw2jiDKHLcWbz0KOJ5fmMJsixpH5OuDO6H7cFGQS7tLEcEHIs0SFm8sDtJlZ6hTT5Ivwmcdx
 oXTubB9dKzRzdQ2fAY0neR7aSuvwndzYNkN7aupRwdCh8A2svzRjLUFw5z/UEufBfXRCOMyjX
 An1lexhQH1TdLs0ZKBnxt0DMX5EQVKSf+T/tKHHnJByeQSwYvM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:31 AM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> +static void trbe_check_errata(struct trbe_cpudata *cpudata)
> +{
> +       int i;
> +
> +       for (i = 0; i < TRBE_ERRATA_MAX; i++) {
> +               int cap = trbe_errata_cpucaps[i];
> +
> +               if (WARN_ON_ONCE(cap < 0))
> +                       return;
> +               if (this_cpu_has_cap(cap))
> +                       set_bit(i, cpudata->errata);
> +       }
> +}

this_cpu_has_cap() is private to arch/arm64 and not exported, so this causes
a build failure when used from a loadable module:

ERROR: modpost: "this_cpu_has_cap"
[drivers/hwtracing/coresight/coresight-trbe.ko] undefined!

Should this symbol be exported or do we need a different workaround?

       Arnd
