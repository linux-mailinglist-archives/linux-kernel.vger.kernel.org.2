Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09D145D3AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 04:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbhKYDlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 22:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbhKYDjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 22:39:36 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893F5C061748
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 19:36:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y12so19325366eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 19:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnOkcoI9SASsIRcxAmu8kvSAocTBqeXw7yfU0ln5Dag=;
        b=pE4ZDr5XsVDe/wRmaYkvYF2PHuYkGihQ7WujowPLpE50LVn1znSWAh6wiNXe8O5U7x
         pQGQtz1gtDdyY63zA16hw1VoYXpDs6yh+dnfjQ6ypTmMmNqFdBzzx3uic3iEEcKsmj1h
         UZYdtcY/qMxURHYUth89gcU76IooZpFnRFzsct93+3na4bbSjGCETbSGMjP0tYaPWYyo
         fCdoGj7tJGAwhHtAItSYBVy6FQ0SsYaeFMou6tjbxU3dlhAMlHl1hLWCuGelQxFb6+qh
         VzKNnBzSozv+aF8CxQ214LgF+nuwBpkoqQEQSERyXfWTGGJFypwh8pUiFh/ytgaWblym
         ijrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnOkcoI9SASsIRcxAmu8kvSAocTBqeXw7yfU0ln5Dag=;
        b=oO2MeM6px4eG68PSePIrgR6hzM4aq37X7KA07vQfAic/O/wJHdTHZ4Z9nwfkHR8HU9
         3RFf1AwtUACwzYKbwUGbY4YOmfElUAkzCfo+x+ZJAI30zwr6VLqXOMpJ0EMZyHri+gR1
         9eZNWauNe9+qUqbvTazNUW5EMS82giiidqKK1TkpH/ZtWxLTdZlyplFYxC4iuTJNvej1
         11DNuvOqkIqTdIFaAW37OBNjrg52ysOMDz8c5DxzCfDFeHKpQfdrHFgcFLhkLQ2BMTUY
         1CN/QFJ6yvGrZSp5CGmEgYvknXl1/rrRjsAYrkQohnD5wN0wMi3gPgYzWJqw/5JoHf8w
         u49A==
X-Gm-Message-State: AOAM532sYPOpIGGrgQXVv/5POZz/XLgSUc5fPzWbwrj9dTh+/YUQtN1x
        2l8yTnAQbIMG0COJ86egmJsU3zZcKGKMsiL+c3W9wfoZR+ERxw==
X-Google-Smtp-Source: ABdhPJxvZvm3aknt9+QNEFiD3Dr+MfgmR6WPN/JlpN6dou7DEezeJiIMRyw+g7p4VcfXOieHwCi7D8R00S4+swzTm4Q=
X-Received: by 2002:a05:6402:90c:: with SMTP id g12mr33643592edz.217.1637811382895;
 Wed, 24 Nov 2021 19:36:22 -0800 (PST)
MIME-Version: 1.0
References: <20211124115703.941380739@linuxfoundation.org>
In-Reply-To: <20211124115703.941380739@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Nov 2021 09:06:11 +0530
Message-ID: <CA+G9fYvXKXWMQY_X6NCBT41kGKszi3oRBw1HCfg+BN6GOWoRhg@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/207] 4.9.291-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 17:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.291 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 26 Nov 2021 11:56:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.291-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

FYI,
New warnings noticed,

Linux 4.9.291-rc1 on arm (defconfig) with gcc-11

drivers/soc/tegra/pmc.c: In function 'tegra_powergate_power_up':
drivers/soc/tegra/pmc.c:412:1: warning: label 'powergate_off' defined
but not used [-Wunused-label]
  412 | powergate_off:
      | ^~~~~~~~~~~~~

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
