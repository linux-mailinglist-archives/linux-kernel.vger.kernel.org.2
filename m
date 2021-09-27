Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15C41A0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhI0VB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhI0VBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:01:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403B1C061575;
        Mon, 27 Sep 2021 14:00:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g7so15045572edv.1;
        Mon, 27 Sep 2021 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+02IDEYrPYq3F1M6y7pim37RPPbUvjKhUbqQrSE7xPE=;
        b=UL2Kc6yJm+n5Ftehbwc/ffXWaAzHQTACtoWpSBsw4Ccd4OQmWwbX8zk0UQruYz4P+Q
         A8OgAr1iMnsHVyv3Aadu1TBMuLa7Gj8CykXzsz8MVBfc1KI5yeUqVykqRBAxILSQsav/
         YHfh9zNnboDWOFlXLFHAhd2nqfCKTL1toTw2WIuuTswatPp+bqSbE9PyHyUinOEy69Nl
         v7KLZ5PP+ZPuPvjfiAqNf3MkF5QxfPTEUqW+O5K6PHNBRJ89zekBTAXhuWExyS6JTE38
         pXKE1vdlLDrO12Jsni2TIB4gduLmWBlgHUxFylR+BKLO//Qx4vsFccYGVEuusnLvSxGt
         e3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+02IDEYrPYq3F1M6y7pim37RPPbUvjKhUbqQrSE7xPE=;
        b=SHIDYmLvwBlUkTxYYKDpNdpE+It9TsRAnMdSFVg+TjIPe6HNzAOny5cBbaF733dwmB
         lVs1cRLzB1ogXxCC7NoWwQcVK4Yqxct/tJ7ollwvx7ORBedQWG5xrkW/BYhkmVU4DhnZ
         dYg8e+/1MeZfWHsQpDVRVtubPKXLfNW+CsYmzU60JFa+XQUtTc5lSMXRwRkC2r2eTxse
         +anMECOajidewT9o8pNlZHWRb8oLq8dn9sRHjaEThRn5XIYzlKd+4VCxmV0tufkgEpcg
         e+Nc6s0W7eM1JkBMTx8/RVb5zRlikdcgqPBO8gQLB1uVTCQ27E4y/WsLAqpUDCGvPF+t
         mERw==
X-Gm-Message-State: AOAM5327eX3ltobrrhRnqT0KZ3UiMF8yRk2bnv6E3r/GOAn0EtUWLhtQ
        WssgWDCUz65OrkvZctvDdw2KlUqw2UkA+YTHkE0=
X-Google-Smtp-Source: ABdhPJylfktO26n2FKL12pTxJEmFlZQOZIuN9A74w1/+w8gOqQT+FRA2G5lOUsCFJJSi1rEIveLt6WIegaY1AQ+eptc=
X-Received: by 2002:a50:dacf:: with SMTP id s15mr2757371edj.385.1632776414890;
 Mon, 27 Sep 2021 14:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632750608.git.mchehab+huawei@kernel.org> <9cdebbad008886b1d09f5f3ac5d88bee19f08d97.1632750608.git.mchehab+huawei@kernel.org>
In-Reply-To: <9cdebbad008886b1d09f5f3ac5d88bee19f08d97.1632750608.git.mchehab+huawei@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 28 Sep 2021 10:00:03 +1300
Message-ID: <CAGsJ_4xYJUCP_MSj5-bmjs6fUTbYqOM2eVVSvZcW_XJcf25w=Q@mail.gmail.com>
Subject: Re: [PATCH 17/17] ABI: sysfs-bus-platform: add modalias description
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 3:02 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Define the modalias parameter for platform devices, including
> the ones exposed via devicetree.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>
> See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/
>
>  Documentation/ABI/testing/sysfs-bus-platform | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-platform b/Documentation/ABI/testing/sysfs-bus-platform
> index ff30728595ef..c4dfe7355c2d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-platform
> +++ b/Documentation/ABI/testing/sysfs-bus-platform
> @@ -42,3 +42,15 @@ Date:                August 2021
>  Contact:       Barry Song <song.bao.hua@hisilicon.com>
>  Description:
>                 This attribute will show "msi" if <N> is a valid msi irq
> +
> +What:          /sys/bus/platform/devices/.../modalias
> +Description:
> +               Same as MODALIAS in the uevent at device creation.
> +
> +               A platform device that it is exposed via devicetree uses:
> +
> +                       - of:N`of node name`T`type`
> +
> +               Other platform devices use, instead:
> +
> +                       - platform:`driver name`
> --
> 2.31.1
>
