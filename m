Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534B3343CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCVJ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:29:22 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45237 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCVJ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:29:14 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M2fDl-1lO0QB2UNL-004CII for <linux-kernel@vger.kernel.org>; Mon, 22 Mar
 2021 10:29:12 +0100
Received: by mail-ot1-f43.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso15246404ott.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:29:12 -0700 (PDT)
X-Gm-Message-State: AOAM533LnC6qn2uUqUIRD28WRsY8C7fo1/IRwTtW7ahyMgbmeFBgc/WM
        xI6J5y0yyn0fP2MxEP7Vs06I24PT2FqjqWQq/B0=
X-Google-Smtp-Source: ABdhPJxeH7jVCKboaCJ5rtKasmB68rqepDL9o94uPYjbqXj/fkPZ6gfV4nIFWazqlXT8yg/fbrL88WwEXBSzhrP13UY=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr10996745otq.305.1616405349381;
 Mon, 22 Mar 2021 02:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210321184650.10926-1-krzysztof.kozlowski@canonical.com>
 <CAK8P3a2mN0stqiGSMqyY7neODfqFv700KkVecaYS0Ck3D7LRnQ@mail.gmail.com> <2ae8379f-c79f-3257-e54c-fa17c576e929@canonical.com>
In-Reply-To: <2ae8379f-c79f-3257-e54c-fa17c576e929@canonical.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Mar 2021 10:28:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3UVqJ+pfFxtKOiTtWUYW+9FBBONz+OwJUamc=N33G8QQ@mail.gmail.com>
Message-ID: <CAK8P3a3UVqJ+pfFxtKOiTtWUYW+9FBBONz+OwJUamc=N33G8QQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:oORdNvn5yFGmwEagKXXLUBMPpZ17dLQjqbvXyAaqX2U+y5zhDj2
 GLJ1rugNuF+2JOczhW1FLA7yPVGpasoosEPFgFSHRieEQHiZvp9AcobQFTL0s3NBibHLmUU
 kr/vy81aeolRCn5msXwnm93p6HiOoe5Phtksu3J+rBXQWplhkifivOfxCRryPrz5kQKHQW0
 95kO1ncuyRhlzQL2OHtUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:91cfye8siyI=:J53Tr7EkIEoKXIF/ODdMQo
 MjYaPPKJxIJRkpjKxE4M9P1B+5WDfGItUUaftEiVQpphue+HfDygFf3zW2jexwo1nnkBvZYCO
 gykhoUfCykoUQYnUhJWpdzjjUfy7wHNAdFLTYVDov/lEgp9DQzsOJshYMwyNWVv/TPeNybYJ5
 LllsZJekR8kGB8rBkp0ZpnC5K9lXd1D4nUEUky4hFwNge4lKaGjFhtt0n+p1mGENyYtIklIkY
 SdiK0C0leWHfclwr+gzQoW3FhhC18uFukwfOVk4xUUPZMbEPt/6zLAZ0cXtRhCG636L4LVlmY
 SlMMBRTbeQjI2Jf384yYpS0K/+ctv0hxqYPtyXdH5hehPj55sdYkdcbQu0mnm10MrjyIb7cu+
 lgHyxKRagViXpLdplp+Nmx22q/knQZlS04/1909VMPzqOdCgW1iTHP1/Zsc1Yqz6MaTgaVNdh
 ziS5bRuZCHdJqFSle7W+FZjgYLq7HwirL8CLUxhkTpxv5RjmpJi+IQwb111b6n8ZJZCeZXuMN
 5Tjtq4JNGh+RcUnmPHJIiJt9Q6FLQV8/fNOq62B9YLxnp7BQa5TjbvUwGmQXtJaIg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 9:26 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> On 21/03/2021 22:09, Arnd Bergmann wrote:
>
> The SMC has two calling conventions - SMC32/HVC32 and SMC64/HVC64. The
> Stratix 10 driver uses the 64-bit calling convention (see
> INTEL_SIP_SMC_FAST_CALL_VAL in
> include/linux/firmware/intel/stratix10-smc.h), so it should not run in
> aarch32 (regardless of type of hardware).
>
> I think that my patch limiting the support to 64-bit makes sense.

I see that this is the only driver in the kernel that doesn't support the
32-bit calling conventions though, everything else either uses the the 32-bit
calling conventions unconditionally, or picks the ones matching the
kernel execution state.

If the firmware supports both, it would seem best to change the driver
to work like the other ones and pick the appropriate interface based
on what kernel it's running on.

If the firmware is fundamentally limited to the 64-bit interface, your
patch does seem correct, but I'd suggest explaining that in the
changelog.

         Arnd
