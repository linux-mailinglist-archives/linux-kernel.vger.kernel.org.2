Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721E9419E18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhI0SZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhI0SZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:25:32 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B837C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:23:54 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z11so26800168oih.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9SFeoPXyI6hu/c5IGhRfKrUUOLxP3FUmK8Fq79Nf0I=;
        b=lVnzpjbnLvfxG1uAr8yJXhdJgK/8kFsYIRlffQCMufdJ2GmPXd20iA+VcJ8pS/7naK
         sC5TfspQXlla9R70TDDW0Ag528oS4gjIv5jQG7ZLCRHynlokbBrzkhpoUSFqZ0HbUrko
         B9uIka1vy4rGotTdb15OklE5JORtTI2XNeZnCvUAVNV6R8V2G5IdSKbVQtt/F1zlPt1+
         ZJXfhz4j0Cw9AWUBxsByTjum3x4j2IVRROUSY7ynWIErN0qvWsht/y6+xEQ1ZwNntZFH
         yuuMZdJJfF1bXIx9/UBrbPxlCpoEc2rWUlv+ArXSVzeIXQSvXXZ189OkE3tcDyQqlL8R
         Oigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9SFeoPXyI6hu/c5IGhRfKrUUOLxP3FUmK8Fq79Nf0I=;
        b=PMjlUzzFKjPgyskVf56QYsM0A/Qw4BGeP6aFEnJ3ClbQ0qAQ0gCww3z8Bs7mZa6whA
         PgE3qf3ftjCw4TpHMFWE0iDKibzk7qBUITd76Woe241lGw35/e1CZaLWGYcx55G0buRE
         dRJb0xpj1hPsol/CuF9h1Hqkf4h/79Si3cpMzRK9HpDA/A+1ozkQObQo37bW3HooHUfu
         8MQBvuCmw/BcktCz28gfBocsmNHP/tWVmprxPUsoKx3oiSgCvxHvXWPNwukUkVPNUtpE
         oKCsNUjRH5l6ZGq8g2rKUAvxgwPupNQwnXKAQgjCDRnVUu3Dpr6+QakUtimx2Ht+/TbA
         Y7kA==
X-Gm-Message-State: AOAM530KvRBZswU/4nPIl6zl0PtAatn7n0ylCUdlN8xdi/UHkclupR9T
        ZAPxsoYXEyIhW5g0IzLCTSOIAugCFYQs6z/HRV5QQw==
X-Google-Smtp-Source: ABdhPJwtMjMwt7qkJD9mPH63iqq/70C0wpKG5aSk7gT6vLSQhAg2tztMeCDZwJrx7Dfbxti7dlJs3TIPpx1ccEQrVDA=
X-Received: by 2002:aca:3d57:: with SMTP id k84mr365138oia.167.1632767033475;
 Mon, 27 Sep 2021 11:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210927170233.453060397@linuxfoundation.org>
In-Reply-To: <20210927170233.453060397@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 27 Sep 2021 23:53:41 +0530
Message-ID: <CA+G9fYvpn2OVw3-GrkDSPHA1piSD9L4v=thu+z5Z-uDXAx4FUQ@mail.gmail.com>
Subject: Re: [PATCH 5.14 000/162] 5.14.9-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 22:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.14.9 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Sep 2021 17:02:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following commit caused the build failures on s390 on 5.10 and 5.14 branches.


> Alexandra Winter <wintera@linux.ibm.com>
>     s390/qeth: fix deadlock during failing recovery

drivers/s390/net/qeth_core_main.c: In function 'qeth_close_dev_handler':
drivers/s390/net/qeth_core_main.c:83:9: error: too few arguments to
function 'ccwgroup_set_offline'
   83 |         ccwgroup_set_offline(card->gdev);
      |         ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/s390/net/qeth_core.h:44,
                 from drivers/s390/net/qeth_core_main.c:46:
arch/s390/include/asm/ccwgroup.h:61:5: note: declared here
   61 | int ccwgroup_set_offline(struct ccwgroup_device *gdev, bool call_gdrv);
      |     ^~~~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:280:
drivers/s390/net/qeth_core_main.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
