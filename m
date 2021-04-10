Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0374635AC66
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhDJJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbhDJJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:22:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D42C061763
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:22:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g5so5615388ejx.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCY/uzytg+00OXSbJzdDQusGwDBz4DC76EcTISMF7o8=;
        b=rF+iqDy+u3OsS+gqlWrT+SzPPTe+x9l0yKPkSge5sBdNZiFyC8uKNhmu0gzLMZleHD
         BMefEaOVkLEXx7m/XLekwgm5FHoucz/BOxUIP9B7bDum8oCY6wkWxbj9GR5Ajr1YrgU6
         SweYM43KBJ8NimK6e/QaUrbjxTfdjRs9HPSpKdUgy+LgGTh13u/GsZ5L52W9hibEfH1O
         3etx048wlcDvaEqHVLt0j8HvsbCHPmOhgQWxSb/rbppdxjcxOcIMrd1Jex7RzOM+5yAH
         PFqAd4K6qEE/ohRso44Esn0GGMHRNbmZ25v0lb+QBwGbbzZBgvjPyCcg7EEx9eEQaPkf
         IKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCY/uzytg+00OXSbJzdDQusGwDBz4DC76EcTISMF7o8=;
        b=niJFP6dq56AoV1anyNG3IYDPanolERlymVoBVJpsSScl84yDWl+j7twT4nZnKMIhIn
         vvUWpWoC8yddjM2wKFgcdwWLfycN+n3dHbBNqRyN9w5w/ZXIeNqAElZ/4r9SF8Nxy2zW
         Or7kvuwlWYDhbpKJs/Qwd0B7BYA5yRkZCpZq4GXZZMvNweyOqS39SyJ6fP2QwttsD+jV
         sSfGepr4ZV4gBdlPRw3lDBZuSuafbBFhDfXzfK5ofCmROEvr8xcjfErvyfZeR8FZF4D6
         ztlO7c8zxp0u8ot6ArLAi3siUh/4vBdS3sTbMxciwvdwPRoXAsl6VFmRqVMofaA79WHO
         h7nA==
X-Gm-Message-State: AOAM531wknkVK92ykq0myDjqiYaz+JTwsDknq5EJBSta/fiUbkjJoCIM
        yIGj3gNTZO0kqCfkyTknYNfRdrM6DIkJFuJb0gqceg==
X-Google-Smtp-Source: ABdhPJyegHJygyq6dKJ28f+uttoZFBjfstvv6nfTx5DPHKiolUbo7ydSTuMplCjCxqiQLKRIn1BecPmDbaJcUIn45ow=
X-Received: by 2002:a17:906:2a16:: with SMTP id j22mr19620436eje.247.1618046521190;
 Sat, 10 Apr 2021 02:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210409095300.391558233@linuxfoundation.org> <20210409201306.GC227412@roeck-us.net>
In-Reply-To: <20210409201306.GC227412@roeck-us.net>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 10 Apr 2021 14:51:49 +0530
Message-ID: <CA+G9fYuB5wgnoa4Q7Ag5XW+HSKeXKRFOtScQ3m6OZGLEnBs0dQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/14] 4.14.230-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Apr 2021 at 01:43, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Apr 09, 2021 at 11:53:25AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.230 release.
> > There are 14 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun, 11 Apr 2021 09:52:52 +0000.
> > Anything received after that time might be too late.
> >
>
> Build results:
>         total: 168 pass: 168 fail: 0
> Qemu test results:
>         total: 408 pass: 408 fail: 0
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
>
> Having said this, I did see a spurious crash, and I see an unusual warning.
> I have seen the crash only once, but the warning happens with every boot.
> These are likely not new but exposed because I added network interface
> tests. This is all v4.14.y specific; I did not see it in other branches.
> See below for the tracebacks. Maybe someone has seen it before.

I do not notice these warnings.
Please share the testing environment / device / setup / network interfaces
and Kernel configs and steps to reproduce.

 - Naresh
