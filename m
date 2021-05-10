Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C01379740
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhEJS5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhEJS5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:57:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55490C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 11:56:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a2so3932924lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otea4Q7cWX6hm03ky2Mnx+bXFJyYGiw/7obbMp2/aV8=;
        b=fwMgO4JNoez7QEIZwCp9nFD0cCGUMmWS1UpaxwDtsv9sTyllUTrcTRLDC/LGIn0pER
         PCh4/PIALMhH9IBE3PFklXV65Nh0naCAgHorTkZvIJDNAC2A9QvirrZLHD2sXlRtIDKN
         RQ6bQRrstKRHvsVUxHNygn0KOE8bTEjUeXia8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otea4Q7cWX6hm03ky2Mnx+bXFJyYGiw/7obbMp2/aV8=;
        b=samIfAlARzYiq275IgYxbKiaMXD9lfN5kiSvyhsLA8yIaGTkPblbXxkBg+y7xH5hqF
         WBRvulti37GzDiHB1+FYU/peJjiWW1a8qlVcPMh+fvO1/ENtMvHTlnfDBW2UACevRFXy
         7XVnOC//ZdCBaNXx9cwCVNGLYholYbljKL4vGwY76QqRm3jFjE0EKG76b9H9cVmn5Rfi
         dqbulA1ynZhbe+2giF5k3l45/PLWBrxdpU74joPpSMhY+xkKlBt9YmhA2DsONzm+Jjqa
         MnH9rFJFLC0rJyJYm4KyrczMrZHFXqFEqj/UtfREmfX/5JwdnqTpIOlCFdawSJrTeeX9
         p8xA==
X-Gm-Message-State: AOAM531bCEFEchIdmZFDxDfknj8hWTrXrk+L6pWiyIe8kgoWwMAEy9cj
        0Rd+wi/MR15XO2EE7RVJg3NDH9uBlZjanzhYS5I=
X-Google-Smtp-Source: ABdhPJxdQvPjXngTCtecaquEKX3qvP3WxbkCF+6EhrepOSn/uBnrnMKPH2ToYpX7aWCPakja5M2zdQ==
X-Received: by 2002:a05:6512:3a8:: with SMTP id v8mr18392608lfp.552.1620672962551;
        Mon, 10 May 2021 11:56:02 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id y20sm2345263lfe.162.2021.05.10.11.56.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 11:56:02 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id o16so22109998ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 11:56:02 -0700 (PDT)
X-Received: by 2002:a05:651c:33a:: with SMTP id b26mr21797493ljp.220.1620672961842;
 Mon, 10 May 2021 11:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiWTU+=wK9pv_YG01rXSqApCS_oY+78Ztz5-ORH5a-kvg@mail.gmail.com>
 <CA+G9fYvnM6rd2Sd7WdQmb-GFRF8y+QG1J3ocJOQKV0V0g=PofQ@mail.gmail.com>
In-Reply-To: <CA+G9fYvnM6rd2Sd7WdQmb-GFRF8y+QG1J3ocJOQKV0V0g=PofQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 May 2021 11:55:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj4TvmMRV4CYeXuVh15d+wDPw0LyY4Ov4Og4XP6EH7nw@mail.gmail.com>
Message-ID: <CAHk-=wgj4TvmMRV4CYeXuVh15d+wDPw0LyY4Ov4Og4XP6EH7nw@mail.gmail.com>
Subject: Re: Linux 5.13-rc1
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:54 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Regressions (compared to build v5.12)
> ------------------------------------
>
> Regression on TI BeagleBoard-X15 arm32 bit platform as the device was not able
> to detect SATA drive.
>
> Which is fixed by Tony Lindgren but this is yet to get into the mainline tree.
>
> "
> Naresh Kamboju <naresh.kamboju@linaro.org> reported that Beaglebone-X15
> does not detect sata drives any longer after dra7 was flipped to boot with
> device tree data only. Turns out we are now missing the sata related quirk
> flags in ti-sysc that we used to have earlier.
>
> Fixes: 98feab31ac49 ("ARM: OMAP2+: Drop legacy platform data for dra7 sata")
> Fixes: 21206c8f2cb5 ("ARM: OMAP2+: Drop legacy platform data for omap5 sata")
> Link: https://lore.kernel.org/regressions/CA+G9fYtTN6ug3eBAW3wMcDeESUo+ebj7L5HBe5_fj4uqDExFQg@mail.gmail.com/
> "
> ref:
> https://lore.kernel.org/linux-arm-kernel/20210507112857.12753-1-tony@atomide.com/

Ok, thanks, looks good.

I'm assuming I'll be getting that fix through the usual ARM SoC trees,
so it will hopefully be all good by rc2.

Thanks,

              Linus
