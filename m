Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34BF441A76
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhKALMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhKALMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:12:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A64EC061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 04:10:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w1so9169246edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 04:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnqQRd6hBaYfWki68lQPDIO80Hq57QzHkXr+8T/A1cg=;
        b=tGWmTFjDJz7ZHICrb2qpN56/6awLBIMQFdVKur6rqwzwJPCjyI9B+AzA9vu5adS5ju
         nYMkE6QElGtiy4pzpA7mXc5FKPQJmyfa8KyNRONybbWp1L4yR2tG95RQKZa6pQbXCh1d
         uc4EFFZv0ab3yZ0VRRYaXj3Z61IhU0HJDjrz+DQkE6hKB6SplYm7AguXedVSsQ/tXDr5
         Rmu8FSARakgsuXgdHZ2/lO4WrLgcBFjvP0A80Kvnq/VnrUDHpeiFF/In7/3ijMRo9MaR
         6CBRgDgNq7JBplCJlhhhHwv4gUUw0zW8xGC7QiU9PFp2STulnUeZlKymyC0raoAF3EMa
         AIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnqQRd6hBaYfWki68lQPDIO80Hq57QzHkXr+8T/A1cg=;
        b=hkvYOHmiQ3FTG8eJDlBXp8ABOBPrSI0/uzRLL1eEHWwUf5KsZnY/bSrjGUnuh6QD+u
         R43Daw1zYLQqHxOEn2slOcAn1ocdb5rw8Liq3WWihpzEawGRJFOeYwDeuwM43CPws7W5
         3Mk6Us4V4IQPpXyboBHQ51rHzQ16e1DrNDpN+FkPxggFH0SiYse5peUJkdPyWf+v1wj+
         xOSB9vNPTljsc0qElfoppwIONNyptS2xlIAVGAbkn9OIeeBCjpZML20M9Ntejbitq90r
         Mlbd0rBvvvJJkuwOioxFHeq4YiaF9Ybjpm/k4gqbVC1SSk1anXq/p2aNICjYq+gCH3rj
         7C1Q==
X-Gm-Message-State: AOAM532j1dJChigs2TV8Jip9ftKwD31Tji3xpVuSjHK2fAMGKzK7tBpR
        KtZhKKHt4/gFI4Qdn5P9jj6YTUV4eHV9O8Exf8vpwSdhBpKgyw==
X-Google-Smtp-Source: ABdhPJy7NCj6xQhFYdNxrNVAiKtFdkmV7VaRSAZZf6HeIgPM8n2Xemo4OZDTfhbHBNsu0GMGMFSIzDR835UkqQZqgmE=
X-Received: by 2002:a17:907:76b0:: with SMTP id jw16mr12118337ejc.169.1635764998419;
 Mon, 01 Nov 2021 04:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211101082500.203657870@linuxfoundation.org>
In-Reply-To: <20211101082500.203657870@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 1 Nov 2021 16:39:46 +0530
Message-ID: <CA+G9fYs6FbiP=o=4ACyQ6Lp9YgUpOr9Xtn+ZhHdZm2Z+rhBJZw@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/51] 5.4.157-rc1 review
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

On Mon, 1 Nov 2021 at 14:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.157 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Nov 2021 08:24:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.157-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regression found on arm and arm64 builds
Following build warnings / errors reported on stable-rc 5.4.

> Haibo Chen <haibo.chen@nxp.com>
>     mmc: sdhci-esdhc-imx: clear the buffer_read_ready to reset standard tuning circuit


build error :
--------------
drivers/mmc/host/sdhci-esdhc-imx.c: In function 'esdhc_reset_tuning':
drivers/mmc/host/sdhci-esdhc-imx.c:1041:10: error: implicit
declaration of function 'readl_poll_timeout'; did you mean
'key_set_timeout'? [-Werror=implicit-function-declaration]
     ret = readl_poll_timeout(host->ioaddr + SDHCI_AUTO_CMD_STATUS,
           ^~~~~~~~~~~~~~~~~~
           key_set_timeoutcc1: some warnings being treated as errors


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
