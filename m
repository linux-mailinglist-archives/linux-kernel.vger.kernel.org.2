Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1953C222A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhGIK05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhGIK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:26:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFD4C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:24:12 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id h9so11670196oih.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrFysvGtZpqXVqpBVFoh0317yBisoNGnai+6UrvUk7k=;
        b=TH32T0AvvOADtM+gmhIZoLk/+/VEDgzB5+2M0dUWVpSlBWUGlcOaz0BiLzu9BEvsI+
         Wl3Ao7p2GuOroM7UgOJtOTW/Nrwu0d12j/xKbLQrT9HNu0oCj2PsRAH6kg9nA/4D1yRq
         jxtGLz58Ov6MihaI1QaS8RgtshCmSicenMxWvy4G6ArIxwlL2fRM2NYNfluSsDBfFU35
         hV5Lqt9gMApLQccW3XUIEmRS7e9METSeTqQ33tUz5Mh7JVlvDODuEU0z0aa+Mu28EfSQ
         IsilitjiyfVYBBHAn8g/Pv19QG/EupZX7p9md9W2Ot7f9uJz4JgIWCi1uonZ0ZALvKHw
         yaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrFysvGtZpqXVqpBVFoh0317yBisoNGnai+6UrvUk7k=;
        b=QwLOJ/ctlow9OIryftzumdi4P5D0Gc3mLFdfrmm9Oa9o3SGxowpf9cdJol2kPOQyD4
         mD5zkhWmG6krmaL8tZdL/tCE2BfYYP5GBNkKPV7hA1Xu8Q2VSSHoqRZ+br323uru0VV7
         4ilPAjVsImBiiKAmeUJZfLCDb9q8wJ/DPhHAHhUK9FDIu+3w4L0Kx8hjej0ae8eRJK1E
         fKC/EszO0gpVC8KItkRq0TS+x9TRgeuJVbPHmZJDo805mxjJ06hjLncxCJL27A79hcyI
         QVWSSna/tBweP0gz5fnD1c5SGk0aN/Tb1heiFfEQJJle+oT2SzVImaKnfSBrhjBMO3Be
         VbbQ==
X-Gm-Message-State: AOAM531dv7BEPVP+pfS6N2AS8B4WQBMQibw92W7aqbUsEigtgcfRpY28
        ULf5e7DlbyGHiVJxuvDjyypdRTYcnR5j+pdbPVw=
X-Google-Smtp-Source: ABdhPJxayM4pdC8nMdAa1QJHD34ol8ekXE74iF0w0jDTquH5U6cu1w+75WuKowH+FhvxWQKWfZclSxqZJROIrKg+E2E=
X-Received: by 2002:aca:cf82:: with SMTP id f124mr20633162oig.47.1625826251840;
 Fri, 09 Jul 2021 03:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-cc8f5927-9aaf-43ae-a107-6a6229f1b481-1625565279264@3c-app-gmx-bs60>
 <25d61873-38ae-5648-faab-03431b74f777@collabora.com> <trinity-e6443313-a436-4e9d-a93c-1bef1cce135d-1625736911475@3c-app-gmx-bap19>
 <trinity-3f4f4b55-7e39-4d80-8fc3-7d0e2b3026de-1625758259993@3c-app-gmx-bap19> <trinity-fd86a04e-81b6-45f0-8ab4-5c21655bdf53-1625824929532@3c-app-gmx-bap43>
In-Reply-To: <trinity-fd86a04e-81b6-45f0-8ab4-5c21655bdf53-1625824929532@3c-app-gmx-bap43>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 9 Jul 2021 12:24:00 +0200
Message-ID: <CAFqH_52OdB+H+yLh-b8ndbS_w3uwFyQEkZ-y2RQ2RnKnMEt6vQ@mail.gmail.com>
Subject: Re: Re: BUG: MTK DRM/HDMI broken on 5.13 (mt7623/bpi-r2)
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        chunkuang Hu <chunkuang.hu@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Missatge de Frank Wunderlich <frank-w@public-files.de> del dia dv., 9
de jul. 2021 a les 12:02:
>
> Hi,
>
> i've found it :)
>
> hdmi-problem is caused by
>
> commit 440147639ac79f699a4eb9811d0bc39d3cc815f4
> Author: CK Hu <ck.hu@mediatek.com>
> Date:   Wed Mar 17 19:17:10 2021 +0100
>
>     soc: mediatek: mmsys: Use an array for setting the routing registers
>
> but i cannot revert it alone, but after reverting all mmsys-patches hdmi works (ovl irq-handler called)
>

If this is the offending commit, could you try if the following patch
fixes the issue for you?

https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.13-next/fixes&id=db39994e0bd852c6612a9709e63c09b98b161e00

If not, and that patch is the offending commit, it probably means that
the default routing table doesn't work for mt7623. Needs a specific
soc table.

Thanks,
  Enric.

> $ git logone v5.12..v5.13-rc1 -- drivers/ | grep 'mtk\|mediatek' | grep mmsys
> 060f7875bd23 2021-04-05 soc: mediatek: mmsys: Add support for MT8167 SoC
> 1ff1270fca33 2021-03-30 soc: mediatek: mmsys: Add mt8183 mmsys routing table
> 440147639ac7 2021-03-17 soc: mediatek: mmsys: Use an array for setting the routing registers
> ce15e7faa2fc 2021-03-17 soc: mediatek: mmsys: Create struct mtk_mmsys to store context data
>
> git revert 060f7875bd23 1ff1270fca33 440147639ac7 ce15e7faa2fc
>
> and after reapplying them one-by-one it stops working on commit above (440147639ac7)
>
> @Dafna can you confirm it solves your issue too?
>
> btw. watchdog issue is caused by
>
> commit bbece05c0d3a96817483e0b249ad1e302ba95117
> watchdog: mtk_wdt: Remove mtk_wdt_stop() in probe() to prevent the system freeze and it doesn't reboot by watchdog problem
>
> have already contacted author
>
> regards Frank
