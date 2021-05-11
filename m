Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1188837B08B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhEKVJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhEKVIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:08:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E09C061761
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:07:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h4so21460927wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbKIRmrOmcl+u/rxAwo2Al1Qol8WlT1/5GsgyCqqF4g=;
        b=DTHfQaLiLMsK8++hKEIE611yGiUCJ05dtoLlcI8nww8VVwfze2472TOBCzFcf8iH9G
         CtHM7h+oXdIIOaUKuhHz2EvGehc+qMAGastvZFg2NjszdtD+r+Ae7y6aES8DKiZ56/7M
         3pRY5IAprWdFQwhrWGkAqY+608315exDVucRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbKIRmrOmcl+u/rxAwo2Al1Qol8WlT1/5GsgyCqqF4g=;
        b=ZfcNxKgPuV1GS6ioy072jTs7jv0xvlEXnOJ8A7s6u/qzgqrGVxDcHC7FqMo3B/9w5T
         08vu+GJ7JUbn044VsqdpbOFmW7m0G+GbA6ggWWg3Z4NRH9oSAfhsA1npZe7ZYFrv61VC
         ho9Vup9/64LdLRrDVfBCgo/IG32BTeG/2mHhA1K2AQjDNZc/YmxFURLbp3Ylq6SpuNOK
         jvUpsFF8DUPmS2L0m2kMx6maUyVfPwW6ApsmVGE50FfO33rjbXsOeMQoxNl7SmDhOwcg
         vf6DofC63bMAFFM4GSYKchBHre/8H/k7+BxLIC/L43pct18b+NefzHHXTVUich4FJrMO
         xV3Q==
X-Gm-Message-State: AOAM531GdIyiwd9JCe0M79p6IAg9zVrPPXU9z9hVvfZ5g5xanuo8yjOA
        w+Oet2FyDeMGob4WBLW6dZfcDelnLtHbu5mJb9i9Ew==
X-Google-Smtp-Source: ABdhPJzC2Q9UxpNmIchezZOh2txOxVPSjPGlPyH9VS2cIgY/MjDauz10NsHnwacwHfAfabMSNde/gVfXxSgzrd1ELzM=
X-Received: by 2002:a5d:6752:: with SMTP id l18mr39437393wrw.422.1620767262631;
 Tue, 11 May 2021 14:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210510102014.849075526@linuxfoundation.org>
In-Reply-To: <20210510102014.849075526@linuxfoundation.org>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 11 May 2021 16:07:31 -0500
Message-ID: <CAFxkdApQS6WhHhci0jvDyxakXBNL7vhn2LtpV7QYEqkpMMxskA@mail.gmail.com>
Subject: Re: [PATCH 5.12 000/384] 5.12.3-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 6:17 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.12.3 release.
> There are 384 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 May 2021 10:19:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Tested rc2 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
