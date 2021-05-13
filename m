Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2254A37FD19
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhEMSOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhEMSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:14:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0DFC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 11:12:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so27724621wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XuA6sUlFZXXpiuHNA+05tj6J5nZ4D+eMz9vUvR1ZNfU=;
        b=b7+Ytv3bCixoOHYmhYLrbXOWJcMNTbsngfpuFAJE551igzQxbjqGPhoJMQZSsA47p9
         suqT8b+iGo6or/CcuRS+N1S1IrS4DI7O8OaeK/fvNClcIz7SaAzk3061YhZSBTA8u0+r
         0cauoGaZeKhRhMdn5R5Ux14FHa1OZ1PTqEjkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XuA6sUlFZXXpiuHNA+05tj6J5nZ4D+eMz9vUvR1ZNfU=;
        b=nOh30JEOa40kuMr/kYmuQAjOTDvazz001shd/VCYsUpxTx1cS3TWGiKdOeDq0tmMX9
         ZNeocTLWYCD7E4JXO7PXTsl5mFOEY+XMbj8JJbDE6o8dEfHfo5BBS1pWVkxVm5dULmRQ
         UsdKPIHgk3XskUSTPg9d84Jv0kyc1Jib07E1+Sj40PjP29Ebj6w8cH7vkIoabrw1jVZZ
         QfG3FiqVvXStFwxVunghGkKE1QV0MaCF9+PNg3hmG4BkxIyxPc8GnR7YDN43GyDiyImf
         TX11/CYutqvfIZrcjQQkBrL4ndSJwjM7S8VE12e8uFvoJMAsxS5grVfgyRPx4ni8Q852
         B8pQ==
X-Gm-Message-State: AOAM531Nf3gpnaMaJ79/QIqRKHB9vu7vkZ2R7HfpnrTq86h6RablK4sB
        Wr06zmnVGRiU1+5XJpzZedd5obR/5VabKnwo8BOKjZJ7aB1ZcfoN
X-Google-Smtp-Source: ABdhPJyYRSKEmrUYlUo9JVbQIZzt5osyTHtjV3yeaLGKmhj7GgdK1Z0AoMUtt+0aDWH9xDVuWKZESwblGEbvMsj+waw=
X-Received: by 2002:a05:6000:1012:: with SMTP id a18mr53796075wrx.68.1620929574137;
 Thu, 13 May 2021 11:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210512144837.204217980@linuxfoundation.org>
In-Reply-To: <20210512144837.204217980@linuxfoundation.org>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 13 May 2021 13:12:43 -0500
Message-ID: <CAFxkdAp8L=Okq79GVfmYs=MjEF4buQh9qv_gXUZ9cVK9wi-Ybw@mail.gmail.com>
Subject: Re: [PATCH 5.12 000/677] 5.12.4-rc1 review
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

On Wed, May 12, 2021 at 11:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.12.4 release.
> There are 677 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 14 May 2021 14:47:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
