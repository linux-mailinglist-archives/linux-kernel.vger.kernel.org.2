Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCDB452EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhKPKOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbhKPKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:14:08 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7439C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:11:11 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z5so25446259edd.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2DocWUqnOkza5PB8A2UAOk6CnIFmfolzOV4erGlKec=;
        b=BCIB7GbiKqq4mlsohn++40FcSkgp5LSHImpM8N+cBUn1UDI5f3bngQIIL76vME/MuC
         pEiC28nKDzgdJY3QxNUbN1k2Hsv4pOOWS+QHaJH6Q2ZSz7huiOhfjFiyFVX6RdXBHUI2
         ajIeOVrvFW94eGcexYTRrbhrbinyWRCtgGg9sqK/t1NhC5U6jxdWulv0psnsPYoIWevE
         5ff0zHHZp0k3eTKEEhrVYLdFC2FFcpmPvNxqtp9agEdwJzQjxs/u9AsaaOdiy8ptcVTg
         op/BUQkfvrJFKAer/bNnJO6fpqqpc+sQgb5CfKyOii/Z+hSIe5vX+2a3k8MK0qxWR5Eq
         fc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2DocWUqnOkza5PB8A2UAOk6CnIFmfolzOV4erGlKec=;
        b=4MkiHnOPAG3CI+L1efatZ8Oh9N5sDgfw0P//7apuzykqVQK29qItvyWQNBCi+xP+y9
         Gqrg4OqFYeFQ6X8EHU8PtHiZcXgMjkSJKljCmW5W8n7grKi1JYSH3vYxe1QoQWQNNQRS
         JX0+6ggYlMOxxly43Y3ulrQ+2Apnj9gjJfOs9oeyvJbywlPKAeHOAsN+W97XBE19k5RU
         pqwo701ZEUWRPOYtVYjkRHxE+3XBiipSz7axAUKIl7eh+Q7c53S4kaE4jJNwqhcrr8Ye
         cbS2wQLavMTUmQh3fLkFJg9zFihwf+m//9ueyfb8qIhhuoJX/mXGBMESSQBWw1qGdf7b
         Qd6w==
X-Gm-Message-State: AOAM530DY7/FYFnmTIeucW+LdHmHUyrfCtOm9Eni/SmAzaUPnsWJjj3o
        qpm8hYd4ps1vkn6kGzuqluLGXClZmx4w68Ebq7fbLg==
X-Google-Smtp-Source: ABdhPJygztPZs1CJIzTjpgIzeasqEEohsLAMVzSmTNwPh8i8YG0aqdJJ0WccLNojT5eGYgJc78tHft2e+cclE0w+ASs=
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr8280582ejc.493.1637057470332;
 Tue, 16 Nov 2021 02:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20211115165428.722074685@linuxfoundation.org> <CA+G9fYtFOnKQ4=3-4rUTfVM-fPno1KyTga1ZAFA2OoqNvcnAUg@mail.gmail.com>
 <CA+G9fYuF1F-9TAwgR9ik_qjFqQvp324FJwFJbYForA_iRexZjg@mail.gmail.com> <YZNwcylQcKVlZDlO@kroah.com>
In-Reply-To: <YZNwcylQcKVlZDlO@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 Nov 2021 15:40:58 +0530
Message-ID: <CA+G9fYu_KCoQSr=Fbf0XqMFWQNq454KAESscn2jYDqTfg4dA_Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/917] 5.15.3-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net,
        Anders Roxell <anders.roxell@linaro.org>,
        Vladis Dronov <vdronov@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 at 14:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 16, 2021 at 02:09:44PM +0530, Naresh Kamboju wrote:
> > On Tue, 16 Nov 2021 at 12:06, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Tue, 16 Nov 2021 at 00:03, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 5.15.3 release.
> > > > There are 917 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Wed, 17 Nov 2021 16:52:23 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.3-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > >
> >
> > Regression found on arm64 juno-r2 / qemu.
> > Following kernel crash reported on stable-rc 5.15.
> >
> > Anders bisected this kernel crash and found the first bad commit,
> >
> > Herbert Xu <herbert@gondor.apana.org.au>
> >    crypto: api - Fix built-in testing dependency failures
>
> Is this also an issue on 5.16-rc1?

Not an issue on 5.16-rc1.
5.16-rc1 boot successful on arm64 juno-r2 / qemu-arm64.

- Naresh
