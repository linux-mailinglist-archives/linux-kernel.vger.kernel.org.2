Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3AC4253DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbhJGNQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:16:38 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241423AbhJGNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:16:33 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MAfQk-1mf2nO0dVA-00B6Ua for <linux-kernel@vger.kernel.org>; Thu, 07 Oct
 2021 15:14:38 +0200
Received: by mail-wr1-f54.google.com with SMTP id u18so19022744wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:14:38 -0700 (PDT)
X-Gm-Message-State: AOAM532yO0zrvnz4qFMbB4UE5V5OukIwkxFk6VbzgQqPCQ8cva9fNrwD
        A70TfvLMGyihWAw1yX7PuJEUNpbwjVQpWRfJMqs=
X-Google-Smtp-Source: ABdhPJxlorxaf1Zgj5Rs+eFsSNCfJHstb4n53ThIOsns1KYcxF/bXpbsGzOdHOqKwYnWgIneWV4ZKX7ki2fMu7OD7KY=
X-Received: by 2002:adf:b1c4:: with SMTP id r4mr5369225wra.428.1633612477750;
 Thu, 07 Oct 2021 06:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210821030519.127-1-yuzenghui@huawei.com> <39c2b2f9-4de2-8e7d-2135-96f1dab750e0@canonical.com>
 <5991e347-18f0-30cd-58b9-9e3276bd98bd@huawei.com> <YV7HGniKSKe7nXp/@arm.com> <1ebc899f-b7d7-fff4-9204-a0edd2be4387@huawei.com>
In-Reply-To: <1ebc899f-b7d7-fff4-9204-a0edd2be4387@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Oct 2021 15:14:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a30pdkERK2CREDmpVDtL9+mVBU3iok8DkNoayOTSE9yFQ@mail.gmail.com>
Message-ID: <CAK8P3a30pdkERK2CREDmpVDtL9+mVBU3iok8DkNoayOTSE9yFQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: drop obsolete ARCH_* configs
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        SoC Team <soc@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, wanghaibin.wang@huawei.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:owYkorfnfKwyyEY8o4vBxo58nirKiC3h5Qo28a4N/E2iWaf2GWk
 Sq+jpt9LXXuQBXjCP1OpIW8oAzMepApgkHBfaVOCBmZZxeWycuFaqepc8e3JAOEG1u7057M
 bSZA3w73qm/1I86JRpiHsTTvnxONv0FczKjMc2TTtfKXTApKZxxyV9/lA4GO8mj9vcET80c
 FvZ8k+qCgVf53K4Wrq4CQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nB2KQLBt0Tk=:UQYbVq+StdtuXQmng3+hy4
 kV08cl3Sfce5VSp+kC91tfvUWNtR687pTWDX3IZGN1UFdJaoHSLzxPPESZbkKf3zlwTT7sxm0
 k51X+b2Q0q9dJ4xn/m2YtOsD/o72lkg/gFZV/gjkuZbVad5XZc0UBZDzlUNY/SfbAXrG3uHLE
 oIEyhT7Aeh67Ka0skcMQm8fVB16dCfVsOecAU7QMTF8Ad4Vxv6OjpNdUy72ep9LUuSLNllqsP
 Gdr7nIN9jbrzZHxbMNbMo+ZGCt14kUsUzMuEtcNsgCO280kLXivTZYeVLe7izTgNAPnt69dHW
 K0rWYtOn+XNHGo5jKgUQDvQzQdtNUAR+kz0eP3cVON2hn2DTBeCjFPN8zHVrh4Bck3QDZrDfy
 62WGFfxgZhkKPseA18W0mgvGOv+owmxq3LNJI6muAc8j5HZV11YV05lURHcBnhIEbv8kK+klB
 JoQMnNhdyO8pXn2XuMVQjKXj9dMrTkgEoOxJOFh00UKqWITId5nThwL+yQ0QjZPoeLcxD11JV
 SdXca6oKAwm+HHeLX51Ovx/U5u5Mc/HQK1QQ20o47LMr7w2u1Ychh1myJbxAd2dWzpbovWXV5
 37UTA/VN6BvN6nNDhkxCe0tXAhCbBk457kbPnYr9ggVBL3O3iRqBytbHnFktQCm0UNF8xR1C1
 k8C4rdAEzox9V9l/MEk+wvl+cCK7LwvI03qAcpWyO8hMo/SJhx5OKebSEXJ2wwPH6685FB73m
 rGCgkl4PjIlHIFvsmK60ro3AIJ9ohChPf+zKi6x6qRkc0I7+BFqvnIB0s2Kr8gbrcmPHB/I64
 kdHIibpp2cpw3QiZmV5QOVt682jtzx49GraEpTkD4hZjEKpwmxfAqcTHUPBB53o6HoqCdVyVg
 OR1QsIQkFGeDd2v50AMQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 12:24 PM Zenghui Yu <yuzenghui@huawei.com> wrote:
>
> On 2021/10/7 18:08, Catalin Marinas wrote:
> > On Thu, Oct 07, 2021 at 05:42:46PM +0800, Zenghui Yu wrote:
> >> On 2021/8/23 21:01, Krzysztof Kozlowski wrote:
> >>> On 21/08/2021 05:05, Zenghui Yu wrote:
> >>>> Per commit 4a9a1a5602d8 ("arm64: socfpga: merge Agilex and N5X into
> >>>> ARCH_INTEL_SOCFPGA") and commit 89d4f98ae90d ("ARM: remove zte zx
> >>>> platform"), they can be dropped from defconfig now.
> >>>>
> >>>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >>>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> >>>> ---
> >>>>  arch/arm64/configs/defconfig | 3 ---
> >>>>  1 file changed, 3 deletions(-)
> >>>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >>
> >> I have no idea about which tree should this patch go via, so a gentle
> >> ping here. I've verified that this can still be applied cleanly on top
> >> of today's -next.
> >
> > Usually defconfig changes go in via the arm-soc tree rather than the
> > arm64 one.
>
> Thanks for the pointer!
>
> [+ soc@kernel.org]

Applied to the arm/defconfig branch for 5.16, thanks!

        Arnd
