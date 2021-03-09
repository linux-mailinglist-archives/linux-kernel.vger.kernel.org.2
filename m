Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9889B332A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhCIPUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:20:32 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:53711 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhCIPUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:20:00 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MjjGV-1m2vKe0G5r-00lDYJ; Tue, 09 Mar 2021 16:19:59 +0100
Received: by mail-oi1-f177.google.com with SMTP id y131so12422022oia.8;
        Tue, 09 Mar 2021 07:19:58 -0800 (PST)
X-Gm-Message-State: AOAM5339a4r5qZ9D2qwrSyyYr1vzMdRsvGqQE1zUvvpmnJ7rDdDDXoVg
        d6q+vICPyAYuHMkJ6kdB7Tq+pev6MBeRNXXOsKo=
X-Google-Smtp-Source: ABdhPJzLaYkFBQxeenML1CtvrMiCXYHwEhB7UewHLGYWzvuz3PZ33xGUA54iow9OSLWqVDbvpKTVkJjaZNVQIbBYtnE=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr3319660oie.4.1615303197754;
 Tue, 09 Mar 2021 07:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20210308174824.278372-1-krzysztof.kozlowski@canonical.com>
 <776e0c26-4f05-2a3c-1536-f730b9109b1b@kernel.org> <7462eeec-5c4e-b4d5-cf94-9945042fc1d1@canonical.com>
 <73dafebf-5c47-5d90-e29e-e1811f370a54@kernel.org>
In-Reply-To: <73dafebf-5c47-5d90-e29e-e1811f370a54@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Mar 2021 16:19:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a36-6yjVLSdJiUWPEz0_i_DWbPasQ8RZWHyxth-4D62+w@mail.gmail.com>
Message-ID: <CAK8P3a36-6yjVLSdJiUWPEz0_i_DWbPasQ8RZWHyxth-4D62+w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: enable Intel's eASIC N5X SoCFPGA and
 Keem Bay SoC
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0VNQWv4CJMORYfYt384S4Cwbt/RyMCjriXy/gnf+9pzZTRQjku1
 sczWe+TvzeqhfJIKWv/mRywefscDgEutjIEKcxSMq52vWYDDFg0OELBcYu0HIuCQdrUju23
 NX/nRAiiatSNB/Cmn6kmwxx4C7aaQDlZrs0V3/hYdmcez5rgi/9vPYTicKkEyB++00avYkQ
 sb32KMH3TfEjFdU15Lq1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x44rUkFs4VI=:YhiqcnipD+ehvEIQeO2MU8
 AkumpthI3Lcz4Jk0tKamLpgHHjAmyKlU87gSD8UoH/7Ag4oedLtbUbF1M7uhxXcgL+rd3wi5W
 qLrbq5/0/Zqtr7/sVPxbBX8PixyEQnWNBX/Xzv+UOpb6pSOBTI09PzAQa5tuz2kyogEZMtk8m
 kuHKafjx4/fkaKR08aOHZ2gpKYzMwQoUTWGbGrTFtjH58IViEzXkLPyGgd2UzxNwlZQxK5SxJ
 Wu2LkUOpOi1xY5Ly1t8Sbk3enqxFf6Jegnz2gPwZi0ucPeTnzlpIuFhSI+RNw5NTqCuWSeY7R
 sGJ8B4PJVkKReQo2Nx+cMXc7mHv54MNY/meua/t6w//fgsuul1JfyVdSskQQ5ZYNXEEBD8Yiw
 s5OXbPUx8OGMhnm27uu1yc53B/7PlPedEZ5fGg/dB6SYvzz/r+vTkZpKkRX40tpIf1vRKfA6d
 K4N84QVt9lS4Fqq/upzHh2VZ573EhvzZdJii8wItKxrDzi4emj9TJD5jlraLLsg5aIFR2lTdC
 RHA4GknC6XLynf17Di6tDY8Wj4WFFGbPhDWMKFJdS8QoBLlsa0YIa9DOssA6mx4GA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 2:26 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
> On 3/9/21 3:29 AM, Krzysztof Kozlowski wrote:
> > On 08/03/2021 20:07, Dinh Nguyen wrote:
> >>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> >>> index d612f633b771..9f9adcb8b0e9 100644
> >>> --- a/arch/arm64/configs/defconfig
> >>> +++ b/arch/arm64/configs/defconfig
> >>> @@ -29,6 +29,7 @@ CONFIG_KALLSYMS_ALL=y
> >>>    CONFIG_PROFILING=y
> >>>    CONFIG_ARCH_ACTIONS=y
> >>>    CONFIG_ARCH_AGILEX=y
> >>> +CONFIG_ARCH_N5X=y
> >>
> >> I just submitted a patch for this as well. From the looks of the
> >> defconfig file, it looks like the platforms are in alphabetical order,
> >> but then I see that ARCH_SUNXI is not in it's correct spot if there is a
> >> rule for keeping things in alphabetical order.
> >>
> >
> > The rule is that order comes from savedefconfig, not alphabetical. This
> > way you avoid reshuffling of symbols on any future savedefconfig.
> >
>
> Got it. But I've done savedefconfig in the past and Arnd adviced against
> that because what if multiple patches come in with savedefconfig,
> wouldn't that cause a messy merge?

To clarify: you should not send the result of 'make savedefconfig'
if it changes the contents of the file in another way, but Krzysztof's
recommendation of adding new lines where savedefconfig would
put them is best.

        Arnd
