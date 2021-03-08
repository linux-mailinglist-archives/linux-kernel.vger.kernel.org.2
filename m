Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71415331340
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCHQUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhCHQUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:20:21 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58236C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 08:20:21 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id e7so21956289lft.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 08:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mq5t5EXYTkjP+ybGzyx3+G3Vm4kxVCqgAzqjpUIRzNM=;
        b=b+h+112y3ebiz95oGha/nSHDUyV4qWqLbh7s6HWXqpchc/KQ6l9+lY9uMVVoe2jacZ
         +6AGyh3Tyx9X9sN/HgSye3HXdYOxEbRa6fBqDY5mD6QEGq0gwpEhSMUW8wsgzIJiboO2
         Nfc5c+q6gYUTSNdqZGlFablRt4ma1wiCHwiruWqcpj1Ie9eKyrwiRa6TE4GSQlUYOSC4
         BFZ8auSPNqAHtgknYX4ZaZHhpWe0Vk/tv5G6uWoEBGqb5UF8aQ2svCv7zlrXkNowHpKV
         rirSDxOMW8QXt1hefFpX98AxtMOTDHy9WDfbNiCkBUpZ/GCke2KlcoBO8Bice77rNA+j
         z5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mq5t5EXYTkjP+ybGzyx3+G3Vm4kxVCqgAzqjpUIRzNM=;
        b=G81XU/AU1EHsTfHFa8jbIRKq7IHrPz3fOkkd6lt77vHrGP7IjSgxFU4QgpS2K6gOtd
         b3ASVBi5h6/m7Jphqma7OmdDXPaGtvuVtOjgb7mWIw2082QQy02jNcS5ZIsmeZDV7SsU
         ImDJDrQRsiDAvRHIei1irXEzZw3eERINfeBI4yJyTeX5ybtQeb8OzYcoAu3aGHjXhw8L
         CthBJyEpXHnh6o2Wmz/S6bSaAQheKNi5CbmoK7MRKg4Fj5NN5rb9egh2gCNly13QS2r1
         ty82kkTOg+7naMUAz/XyFFgJRfAy+nsA82Ju9DvxXZoILcdtPBqSjwla2Z6cCQ1CbkQQ
         0xcA==
X-Gm-Message-State: AOAM5318GE2qPikbF4LyNN3Ij+2eA2RZx0huVsCa76pCucdU6+XqGAX8
        5UEDKHV8G7MdK3JifsLvfPDMNPs4gGeY4pes0cFVNg==
X-Google-Smtp-Source: ABdhPJxefbXkGdCY3QxQH6a1mIYMLsvpRgHrK9W4yH+Qa5hC2ifqLSzeiXPxO7L3VQVm2HDLKnQkMK0MqMetWU92tJk=
X-Received: by 2002:a05:6512:10d1:: with SMTP id k17mr14325798lfg.649.1615220419656;
 Mon, 08 Mar 2021 08:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20210303135500.24673-1-alex.bennee@linaro.org>
 <20210303135500.24673-2-alex.bennee@linaro.org> <CAK8P3a0W5X8Mvq0tDrz7d67SfQA=PqthpnGDhn8w1Xhwa030-A@mail.gmail.com>
 <20210305075131.GA15940@goby> <CAK8P3a0qtByN4Fnutr1yetdVZkPJn87yK+w+_DAUXOMif-13aA@mail.gmail.com>
In-Reply-To: <CAK8P3a0qtByN4Fnutr1yetdVZkPJn87yK+w+_DAUXOMif-13aA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Mar 2021 17:20:08 +0100
Message-ID: <CACRpkdb4RkQvDBgTMW_+7yYBsHNRyJZiT5bn04uQJgk7tKGDOA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To:     Arnd Bergmann <arnd@linaro.org>, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Joakim Bech <joakim.bech@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        ruchika.gupta@linaro.org,
        "Winkler, Tomas" <tomas.winkler@intel.com>, yang.huang@intel.com,
        bing.zhu@intel.com, Matti.Moell@opensynergy.com,
        hmo@opensynergy.com, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 9:44 AM Arnd Bergmann <arnd@linaro.org> wrote:

> I think the scenario for the 'nvme-rpmb' tool that does the signing in user
> space does not involve any TEE at the moment, because PCs usually
> don't have one.

Isn't that because (Windows-)PC:s prefer to use TPMs which
include their own key storage?

Apple has their "secure enclave" (separate security chip) and as illustrated
by Marcan it did not make use of RPMB as of 2016:
https://marcan.st/2016/03/untangling-ios-pin-code-security/
Maybe they have since started to use it? (They should.)

AFAICT the use case for RPMB is:
1. Used by Android with some TEE, and if you're not running
    Android and some TEE then
2. Use it for whatever you like

As it seems neither Microsoft nor Apple is paying it much attention
(+/- new facts) it will be up to the community to define use cases
for RPMB. I don't know what would make most sense, but the
kernel keyring seems to make a bit of sense as it is a well maintained
keyring project.

So the proposal is to (as some goal) bridge the keyring subsystem
to the proposed RPMB subsystem with an kernel-internal API.

What do the keyring people think of this? Added David & Jarkko to the
thread to get some input.

I suppose it would be a bit brutal if the kernel would just go in and
appropriate any empty RPMB it finds, but I suspect it is the right way
to make use of this facility given that so many of them are just sitting
there unused. Noone will run $CUSTOM_UTILITY any more than they
run the current RPMB tools in mmc-tools.

Agreeing with OP-TEE on the format and management of
any one RPMB partition seems like a good idea, if for nothing else
then for sharing documentation.

> I agree that sharing the RPMB is not a great idea, so if you have a TEE
> in the system that requires an RPMB for storage, it won't be usable by
> anything else. However, you can have multiple RPMB partitions with separate
> keys on an NVMe drive, and you can easily have multiple emulated
> virtio-rpmb devices  in a guest and use them for purposes other than the
> TEE.

The eMMC RPMB code even handles multiple RPMB partitions on an
eMMC. But I don't think I have ever seen a device with more than
one RPMB.

Yours,
Linus Walleij
