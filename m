Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1833EF85
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhCQL0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhCQL02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:26:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C35C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 04:26:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id mj10so1990409ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 04:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRfa0qhtPwnNjC51WNRqDlm41I744u3Ur+Q2yVB8lng=;
        b=eykAXuwg/pIFTzVJgUZJsXGlckBN0PyAGQO60S6pZ+wkvoxafhOOpwyK8EFPHM6pQ5
         5UvvGiontMQBnJRvtWCInETfC0zu2QtyJP5ajsg7/aMpYkgwIudiHxXb3Oe4O0bpcOc3
         utXTcCssm85mzU+nf/2W/2rg0dloRiKaE0K9PooRQscPoyxHR2d55b8xBIkcwfTojzEE
         by4LLm0Vwv9X9viyAoDKO0Jd+sDvKpQx5Xv2YzwLeZvxc707MIvVUMkHDSMlwrbyXwob
         rRxadGRbGvb9wP/n2JgaGfsqAEA+kc9uxlMtXFmaNvi6Jqlk/WqFlji/oBszIqUjGDQS
         q6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRfa0qhtPwnNjC51WNRqDlm41I744u3Ur+Q2yVB8lng=;
        b=jMJIXxFTehZqtB6Yx/BLtEcOrsLF156DiAEauJc9V8ukVBvsUhkzA6loXseydalHUY
         yPCpJTijGa3T6IWDqmmHo0htucs98IXDniEGScON9i8OnkQ9pNd6f9sRJagj9QyCsxG7
         afWfc4a0iueZR7Z8flVcKzC9yUfS5g3liJe7cdbbDGhDncgeeEQlk200Qhqy+v2qIab0
         b7hli66syqSMlw17zpBEPjB/Z7KiXFmzzN2hdY6r0Q8RUqpdaZb1cO+hJnDpgpLT8Z2h
         0qoheNvZh8XU+R2Onn8+8TYj8CY6mFf7QZsWtosMZjYBaPEOmrTnEF8Kazz1WYgzUbjv
         14GA==
X-Gm-Message-State: AOAM531LKFpA/QFE8KkDLpFetGKP3afRwBn5h7bfiAVXzUvapexrCQ/q
        PtQGZ92O3Q2lwOfRskFNHb9yQwKGFuoy6i6PW6RkyUBFRYT6No36
X-Google-Smtp-Source: ABdhPJxXrgSknrQkk5WRAaovq/1zvErlUglMYXas+ZkL1BeLc3iD1CMfyfGylSw5fOMxKzngezS/4CbqJ+HW3nnDBp4=
X-Received: by 2002:a17:906:2a16:: with SMTP id j22mr23791884eje.247.1615980386827;
 Wed, 17 Mar 2021 04:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsKBLOvvxOfB6AAzjarsABQiEUhGd4JB3FDq3q1OrFmOw@mail.gmail.com>
 <YFHUGG6AWGt/C8C+@kroah.com>
In-Reply-To: <YFHUGG6AWGt/C8C+@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Mar 2021 16:56:15 +0530
Message-ID: <CA+G9fYv9kwQDYzzA1e=c8kg1wWQ1MwKtintBvyqMiKG5S+ggqA@mail.gmail.com>
Subject: Re: BUG: KFENCE: memory corruption in usb_get_device_descriptor
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, lkft-triage@lists.linaro.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Yan <yanaijie@huawei.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 at 15:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 17, 2021 at 02:28:40PM +0530, Naresh Kamboju wrote:
> > While booting Linux mainline master 5.12.0-rc2 and 5.12.0-rc3 on arm64
> > Hikey device the following KFENCE bug was found.
> >
> > Recently, we have enabled CONFIG_KFENCE=y and started seeing this crash.
> > kernel BUG log:
>
> What USB traffic are you having here?

This is  getting triggered while booting the device.
We are not running any traffic.

>
> And has this ever not triggered?

No.
It was not triggered before.
Since CONFIG_KFENCE=y is added to our builds recently we are able to
reproduce always on recent builds.

Steps to reproduce:
1) Build arm64 kernel Image with this given config.
      - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-9
--kconfig defconfig --kconfig-add
https://builds.tuxbuild.com/1pfztfszUNcDwOAyMrw2wPMKNfc/config
2) Boot arm64 hikey hi6220 device
3) While booting the device you will get to see this kernel BUG:

[   18.243075] BUG: KFENCE: memory corruption in
usb_get_device_descriptor+0x80/0xb0
[   18.813861] BUG: KFENCE: memory corruption in
__usbnet_read_cmd.isra.0+0xd0/0x1a0

link:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.12-rc2-487-gf296bfd5cd04/testrun/4155170/suite/linux-log-parser/test/check-kernel-bug-2388200/log

- Naresh
