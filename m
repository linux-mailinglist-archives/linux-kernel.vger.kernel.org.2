Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8543E38B12E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbhETOLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243623AbhETOKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:10:44 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A46FC06138F
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:09:12 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so4404205oty.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHxuga1ErFF65E853qwFcrjYHY1gP/v6uMoWxWHzxU8=;
        b=vWMScIMAuBJSC33GVqps5NmQj50vpWdmMBY1L0iMYHDEqsTut6eiVNJUfOelmth+oX
         aBMDIVfW/CWyQLvJkXd7c6ykKnkNiwsvau3aBArOH9aDBUPyXLoEfNuRY6vti3iV4U1T
         L1RSmZ5l9CCu5tD3wggsEGfo9VU6JiwI2SwHHsy14bz43YsfYK+YBm+fd1oDZV81wBAU
         NSOZTtnPQxq4iWX7enfyLVT+PbGX1i+JmcDusj9EBO3z/uJ0jFEsWskOKj5PcFU1pYpF
         zCmXKCijqAb53tis5ZrTrtf6DBbJed4THgh8ZrzPyKFHVsxQPFeWM/04McykVXa7Uzs0
         fDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHxuga1ErFF65E853qwFcrjYHY1gP/v6uMoWxWHzxU8=;
        b=M+6+EX5Dk2QVgrojrWgRMVYiAI9bTE1kx7SW/rW064UKypuSZIjj+gAHSAOax0fjSl
         eGIeHVouaZp3VEn2kYRaipj4w87QHiVk3T9xvA+FuL9SFm7OKIQPA1snrK4aGJGHvUVY
         G5HO5ecr9w1jLrsgDYE226RTo5Z88k6wXURkXyeE1tsMhtNMq9BEuve0v2xKO9o2e++n
         tcZ8fVxbINttogyys8oMtQfzqWPsn6OtomAstk0tSOf0BISmiRkbrvZVPt7egk/ATsm9
         EFGveNT96bq3fMqp29GMNC24nCI6j48tuPi0BWYtOQ2Blurbln6IbtVIQzPfqR9MbIKE
         wgyw==
X-Gm-Message-State: AOAM531htlhn+DrCWY07QoS3farpM/5JEe2/KlgZPcdZRAeSubSphcOm
        ZRQmT1pu4GFe84H5XTM+M7m1iEClDkvTNbeevEhhNQ==
X-Google-Smtp-Source: ABdhPJzN2xX0aRggvFLd3dE0g94qJKPAYD+X6kMd9VeHQ4jcRCc7+JXcF08RI5Aa7paJeeRt509mTwqMU2u1E5AuKCE=
X-Received: by 2002:a05:6830:4a6:: with SMTP id l6mr4077023otd.72.1621519751301;
 Thu, 20 May 2021 07:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210520092102.149300807@linuxfoundation.org> <cf63f39b-6323-4c11-8e53-d04532ed0b6a@roeck-us.net>
In-Reply-To: <cf63f39b-6323-4c11-8e53-d04532ed0b6a@roeck-us.net>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 May 2021 19:38:59 +0530
Message-ID: <CA+G9fYuVKoKnL5FHeHT_r-zwCrNLkgp2O8DJyso0mgOXXTXmAg@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/190] 4.4.269-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 at 17:12, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 5/20/21 2:21 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.269 release.
> > There are 190 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 22 May 2021 09:20:38 +0000.
> > Anything received after that time might be too late.
> >
>
> All mips builds still fail.
>
> Building mips:defconfig ... failed
> --------------
> Error log:
> In file included from include/linux/kernel.h:136,
>                   from include/asm-generic/bug.h:13,
>                   from arch/mips/include/asm/bug.h:41,
>                   from include/linux/bug.h:4,
>                   from include/linux/page-flags.h:9,
>                   from kernel/bounds.c:9:
> arch/mips/include/asm/div64.h:59:30: error: expected identifier or '(' before '{' token
>     59 | #define __div64_32(n, base) ({      \
>        |                              ^
> include/asm-generic/div64.h:35:17: note: in expansion of macro '__div64_32'
>     35 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
>        |                 ^~~~~~~~~~
>
> It looks like the changes conflict with the code in include/asm-generic/div64.h.
> That code is completely different in later kernel versions.

LKFT build system also found these MIPS builds failed.

- Naresh
