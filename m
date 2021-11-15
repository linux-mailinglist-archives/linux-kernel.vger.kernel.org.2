Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975DD45057A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhKONdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhKONcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:32:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F28CC061207
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:28:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m14so72187621edd.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cRmbCo9kjvNgwv7vSSBuH8WEW+eAn1HMf/bmF9PTrM=;
        b=PpOLKmMO141AHO2LthNVc1GBHjkYGTgnoRIEHSH991PbEODCwwVho43tYn9STIYdCM
         SzFVpgjKAKyp0QWdWRpumxa/i6dzKGgKMA75DkSw/Ff15lTmzWdndttSr4mPOA4jZfZw
         T4xBtFBEdq0tWBVTd4Pm8VDXU0e62EOzaNldX5iY6BC/9FHK857mQsLlo2V6Qs5qjVOq
         tyqU6xpCiyKiGqn8LbV5dZXSvV482KSEskO6rnn0hnu1SquRBIII2SrgRk2F661xdJGY
         zSW2vrYEei1afzEVdQF/F6LF/Uo5wA7ig7UqZgDxmjlqVqncSPzctuAXPCepXYtgH1D+
         EZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cRmbCo9kjvNgwv7vSSBuH8WEW+eAn1HMf/bmF9PTrM=;
        b=zcadzGjNtOld1zRnw6f1UEZ3/rXFRiP1xDJlAMSfqsYultYuPAZj3H5LHlcqvXODtE
         Rhi9visnU2lrdEvwj8/n9MnBEEqVAtvEyh75DA7tZIxVwoUfN7Bf4NpbAjo5k4AIVrTH
         1yBAvxFGmmqKYOeLTsX/o5fseT7KWca+9DIurNHsdaFLoyj8/lAhoo13W//y5g6hEri5
         ipxe3NyEwRSeW1etdEieI8iFLuz/8fw/Y9Op5wYW5Zg+4JmxZvU6vcdUtbMKaSoNDxfU
         TansjrqeQ9EpuTIJw6DVVuqprykoN4UVdPi5PP8T3tMRtXB69EDScd+8IZBsLUJg5h4Y
         zlUA==
X-Gm-Message-State: AOAM530y6dGjPXJBmrlB62SgVoJxoEDk2AKrkphaXH2/T6GVuT3gn/OS
        ChM06EBgplk8INrviUzI6bldC8ed0q7pJwFTDzckog==
X-Google-Smtp-Source: ABdhPJz6Udv1Bqde1kFPfmZFvq2RGosFkkXKXqcczQ2H+gQ1/7ffgsAHUCSai1s9AAuvn4ddinbkNxcrnF4nwBOQ3mQ=
X-Received: by 2002:a17:907:1deb:: with SMTP id og43mr48646216ejc.189.1636982920718;
 Mon, 15 Nov 2021 05:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20211108012851.7772-1-warthog618@gmail.com>
In-Reply-To: <20211108012851.7772-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 15 Nov 2021 14:28:30 +0100
Message-ID: <CAMRc=Mco28U7D15BJjvPrOqORQQ2MKUrwPkKWKVFQg9ks0--fw@mail.gmail.com>
Subject: Re: [PATCH 0/3] selftests: gpio: fix minor build issues
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        lizhijian@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 2:29 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> This is a series of fixes for minor problems in the building of the GPIO
> selftests introduced by my rework of those tests.
>
> The first patch is from Li Zhijian and fixes a compiler error when
> building the selftests in environments with stale system includes.
> I have reworded the commit comment to make it more to the point in
> describing the root cause of the problem and the fix, as suggested by
> Shuah in his initial review of that patch.
>
> The second patch fixes a warning when the tests are compiled with -Wall,
> and the final patch restores the CFLAGS that should not have been removed
> in the rework, including the -Wall.
>
> Kent Gibson (2):
>   selftests: gpio: fix uninitialised variable warning
>   selftests: gpio: restore CFLAGS options
>
> Li Zhijian (1):
>   selftests: gpio: fix gpio compiling error
>
>  tools/testing/selftests/gpio/Makefile           | 1 +
>  tools/testing/selftests/gpio/gpio-mockup-cdev.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> --
> 2.33.1
>

Queued for fixes, thanks!

Bart
