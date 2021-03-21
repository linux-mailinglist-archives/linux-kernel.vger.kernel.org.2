Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC363434FB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 22:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCUVKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 17:10:40 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56243 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhCUVKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 17:10:17 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MVMNF-1lDOEp0jNX-00SLUM for <linux-kernel@vger.kernel.org>; Sun, 21 Mar
 2021 22:10:16 +0100
Received: by mail-oi1-f181.google.com with SMTP id a8so11048021oic.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 14:10:15 -0700 (PDT)
X-Gm-Message-State: AOAM533tB5To74EC3z3DVtDUSQB6mDFMFFuWGuDUWR+1jDBNVgmEZqnW
        tHcdbMFUi8QVTSiJPAE702K00OtAHYWp+DM49oI=
X-Google-Smtp-Source: ABdhPJxrSpOmi5k9VJ4RxKS2BYT/nGiBVe0BEIMQz0Es7QIQB/1R+USoY88qu16qN93xA5ZAN7pYnpjnDPeKADv8oJA=
X-Received: by 2002:aca:5945:: with SMTP id n66mr7657182oib.11.1616361014951;
 Sun, 21 Mar 2021 14:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210321184650.10926-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210321184650.10926-1-krzysztof.kozlowski@canonical.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Mar 2021 22:09:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2mN0stqiGSMqyY7neODfqFv700KkVecaYS0Ck3D7LRnQ@mail.gmail.com>
Message-ID: <CAK8P3a2mN0stqiGSMqyY7neODfqFv700KkVecaYS0Ck3D7LRnQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: stratix10-svc: build only on 64-bit ARM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Richard Gong <richard.gong@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, kbuild-all@lists.01.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel test robot <lkp@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:k5+ivsvCZ+8b37T4P8AwxFHJ6+6ysWJwzYOG/E1Gzb2onLWnrBX
 X17qQk0M/GdUXk1/gx5QugF7d/qMKvYPDUgmHROWuX38LYNvG+n8Eom9fEK+NBEa8Uo31YM
 +41g0tHbWGxHlJLvoDc/VNEna7d5MmGTbq7TO8hs4W7UkLQl8JNZeiCg7b+XmTjlLhWX9VC
 DeDLcIlfLBLyq+ykul7bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YSWe2k7uMec=:dS90OFaESI/BUuSo7/htr/
 92CnDk9yFySkjEewEYXklnbm7G4QLW7Ilt5F1wl7dk3JH2U+M59yZR39hDw6HnLYyENY6BtyO
 FST7WrdfERUvzjRqJyb4F2GCaKzflZHbrvVXCYDje5Jh6nn8j4rOWtgo0fcn3y/xAylLwe2A3
 +MBndXoIqrIHO5fVd+Bm7S0n5+W/W03djruqWGa8ZZxDH2BPV6MmXIeN+7aDSxn+HpnyZWE4d
 x4Qn1frXslJdWyJsbSCDr7DqSbQ6RMR0xeZWDEwX5LI5juSDVkEt60w1xl8Y49Utvwe4UA4Mc
 fJj2IzLEdxzIk5bche4Cyza+HPLJ7UQTKgH30pqmsT1QdMlV2gReZjieyQnmx4TiTvKGcczh+
 8CPp5P/9urb1Xi509UULDKCx8bNq+332NM7HNJAZtdEZ510XNwPW9kMCyM4CCzZXR/rTH5h3B
 NHg6ntsIFzDRwubbMb6tbfV0VAcUCa00JkrSOH7tgPNJ4dyGeAXk4lrMfnBMf15YbNuFuUvAK
 OA4yThTmhimeI2/QuuCBHI6AfDGTORlTsTyZDENc6AALZZJs+XkjB/N+VDzaFf17Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 7:46 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The Stratix10 service layer and RCU drivers are useful only on
> Stratix10, so on ARMv8.  Compile testing the RCU driver on 32-bit ARM
> fails:
>
>   drivers/firmware/stratix10-rsu.c: In function 'rsu_status_callback':
>   include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_179'
>     declared with attribute error: FIELD_GET: type of reg too small for mask
>     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ...
>   drivers/firmware/stratix10-rsu.c:96:26: note: in expansion of macro 'FIELD_GET'
>     priv->status.version = FIELD_GET(RSU_VERSION_MASK,
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reported-by: kernel test robot <lkp@intel.com>

While I agree that one shouldn't run 32-bit kernels on this, we should also try
to write drivers portably, and in theory any SoC that can run a 64-bit
Arm kernel
should also be able to run a 32-bit kernel if you include the same drivers.

It seems that the problem here is in the smccc definition

struct arm_smccc_res {
        unsigned long a0;
        unsigned long a1;
        unsigned long a2;
        unsigned long a3;
};

so the result of

#define RSU_VERSION_MASK                GENMASK_ULL(63, 32)
          priv->status.version = FIELD_GET(RSU_VERSION_MASK, res->a2);

tries to access bits that are just not returned by the firmware here,
which indicates that it probably won't work in this case.

What I'm not entirely sure about is whether this is a problem in
the Intel firmware implementation requiring the smccc caller to
run in a 64-bit context, or if it's a mistake in the way the driver
extracts the information if the firmware can actually pass it down
correctly.

        Arnd
