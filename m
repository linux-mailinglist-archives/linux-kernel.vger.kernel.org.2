Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09BC4074C4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 04:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhIKC56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 22:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKC55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 22:57:57 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FEFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 19:56:45 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bk29so4261500qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89y7dtYjpW2V9bTWN6kb0LJfhttVbVV+nnJbuimMLgY=;
        b=CA/aZXFeGkPuzg/ckeBhtNY8HYbXRlOYOhmLKCI2KF0rZ/NZcqyTRuwEd1PgrerdSC
         iGWWHM3lXyXIi0IWv0+n9JbNCwV+tCPZWA1HIZvPRSaJ3BI0+uTCum3FolNyCMFrOuKR
         4VWhE5avruEnXE9qopY1Q0NlrT81Pze+kDVNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89y7dtYjpW2V9bTWN6kb0LJfhttVbVV+nnJbuimMLgY=;
        b=AfLTwUa8qQTBH+ebiwOH8DJJoEPOVe5QP3xO/R9ks7o5U5GBexAgWM6aDg7YH+YLOK
         OHyLAeIZ9jS8IIJHUJc4Zo32u86zZjJGR7qaeXtS67P7+CVJFGdwopQt1wjFfJ2CqF3R
         3dGFoN8C5XC2U1ro4T+KSjLj5JN8ZeBhQL/PCcEuc+7y86dJIyM/cvC+u+5CvEmjLdqI
         A3fmXW3Xn/0wUdtO1aHwFOmG4JDtQnbCkC4jWnZPFxb1XBjhZLqIWWO2cZgG6wStpIuN
         db5As+bB94ycshtYhYLxogg24w6ri60rGw1ifDIzYrufv79CfAVyg/CcfQSJW5jNDVOQ
         pJmw==
X-Gm-Message-State: AOAM532LYCPRSfv9iGPUZumNXWmo8qlRm/iYtXmlZVDoTulUq988/dZS
        3wejGsjT+KoPb/aftrYUh5p9Yr3OUwJi2eS12g9wVQ==
X-Google-Smtp-Source: ABdhPJxyPNstiWLJG53wPOjDbgm6Dv1LCOTIxLjonS9hoQA3Pq9DmrgpkpAr3oJe8ZeISaPvJyLJTY5o5JC47ysONNM=
X-Received: by 2002:a05:620a:4495:: with SMTP id x21mr498697qkp.378.1631329004367;
 Fri, 10 Sep 2021 19:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210910190322.27058-1-romain.perier@gmail.com> <20210910190322.27058-5-romain.perier@gmail.com>
In-Reply-To: <20210910190322.27058-5-romain.perier@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 11 Sep 2021 11:56:33 +0900
Message-ID: <CAFr9PXnLZC1zfs4e1GqZU4UU3knU-BwREe0-abrWNq7akrTntw@mail.gmail.com>
Subject: Re: [PATCH 4/4] MAINTAINERS: Add myself as MStar/Sigmastar Armv7 SoC maintainers
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Sat, 11 Sept 2021 at 04:03, Romain Perier <romain.perier@gmail.com> wrote:
>
> As proposed by Daniel, I am going to help him to maintain the platform,
> so add myself as co-maintainer.
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a9a7cbf9456..ad1a0e5a5425 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2231,6 +2231,7 @@ F:        arch/arm/mach-pxa/mioa701.c
>
>  ARM/MStar/Sigmastar Armv7 SoC support
>  M:     Daniel Palmer <daniel@thingy.jp>
> +M:     Romain Perier <romain.perier@gmail.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
>  W:     http://linux-chenxing.org/
> --
> 2.33.0
>

Acked-by: Daniel Palmer <daniel@thingy.jp>

For everyone else: For MStar/SigmaStar I have a ~350 commit backlog
that makes almost everything work on these machines.
It's impossible for me to finish up working out the hardware and clean
up and push patches without the whole process taking years.
Romain stepped up to help out and has been pulling out patches,
cleaning them up and pushing them. He deserves to be listed as a
maintainer.

Cheers,

Daniel
