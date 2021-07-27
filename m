Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC143D71BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhG0JMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbhG0JMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:12:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ECFC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 02:12:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t21so14915726plr.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 02:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rluK+pOhIb8FILDrgZN4MclSo9wi1R9TyuuYegFS3c=;
        b=O8RNZOylgIfFd5MJB6bCTVdF9M+YC3fNptlBHMCtVio314rf3eWtCfGWIGhQV5q4tw
         wPuKCyTFlHtgAoX9G/xJlIjgDaq8SyuKQ/OfClRzWJZe6FYm0drviLCKPGBOx7WD5jHM
         IcblQ3zfH9PfEUKyzdnpf3wSqpKS7M8dKN+zWYhOujSLbKwjB4zjuShC3cEOF+l24NUf
         bUm4S8vnqIZ4FNtZOs569hu77icxuZRMfa8kL6SGsPa6joINB9gDvv0tIkJLKpDwfX1t
         kQrJ8XwDr627CliLCTFbVa+4wozAmCt9kyCApFh+aV/3XgedL7tlQjJ3KlqQbuzbxFOP
         f62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rluK+pOhIb8FILDrgZN4MclSo9wi1R9TyuuYegFS3c=;
        b=SzodwisyLqtf9Se5dH+zRl0fz48w78KrMs3JqQvXygd97o6AN5/Fp9Zwi2/s45ZJGq
         5AvAzKVlQQiVno36LGuE3OFn6sVhx6jFpvDCMjY104iaMwBj7h6MZjrsLv4Yqt119WWa
         zXTcKTsP2YSQqXZ7Z8dXceK08hMsuWtzuBhECN9QCHXzwjhZDFF2+iW8cNp1EkiNWySp
         It3eAroS+fWBIbWGCHGFGjR27RV1Cz5esSdgoYUt1ITE/P5kOThM6KKzkKxIzf32G/ke
         WWbWruCPKRTXMZczidArZA7DAghMzex40fkPZ0lW9vSW9Elj2bJSScEcxBeSiLAGnzx3
         ZYyQ==
X-Gm-Message-State: AOAM530Prt2qTm7papRZwBf8lMqhzzR3CBzOAdiOLc0jwMB5UQcwKpAc
        R86/4u3/DxDLgM9Mqtb8/qHy+KolSGNseyrF1c+mDg==
X-Google-Smtp-Source: ABdhPJw2EKqlRylpPbp9OkXdj7y3BeX7ygqlaMweZ8bIg/J3FA1oS1bRlPVBYElNVJbV8Iv4ya+imTT0SW6KULLALUQ=
X-Received: by 2002:a62:d447:0:b029:291:19f7:ddcd with SMTP id
 u7-20020a62d4470000b029029119f7ddcdmr22329027pfl.54.1627377125991; Tue, 27
 Jul 2021 02:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210714211805.22350-1-richard.laing@alliedtelesis.co.nz>
 <CAMZdPi-1E5pieVwt_XFF-+PML-cX05nM=PdD0pApD_ym5k_uMQ@mail.gmail.com> <5165a859-1b00-e50e-985e-25044cf0e9ec@alliedtelesis.co.nz>
In-Reply-To: <5165a859-1b00-e50e-985e-25044cf0e9ec@alliedtelesis.co.nz>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 27 Jul 2021 11:21:52 +0200
Message-ID: <CAMZdPi8MZp5Vx_ZnjjQWptms9vj6bEMoV83pcv4wmgxbZz0wjQ@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: pci-generic: configurable network interface MRU
To:     Richard Laing <Richard.Laing@alliedtelesis.co.nz>
Cc:     David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 at 23:44, Richard Laing
<Richard.Laing@alliedtelesis.co.nz> wrote:
>
> Hi Loic,
>
> On 7/19/21 10:11 PM, Loic Poulain wrote:
> > For my interest do you have some numbers here highlighting improvement?
> These are some of the numbers we found from initial testing using an
> external packet generator:
>
> packet size    packets sent  throughput (%pps)
> 64             1000000        6.21%
> 128            1000000        7.42%
> 256            1000000        10.79%
> 512            1000000        16.40%
> 1024           1000000        34.34%
> 1262           1000000        43.82%
> 1263           1000000        22.45%    <--
> 1280           1000000        23.15%
> 1500           1000000        46.32%
> 1518           1000000        46.84%
>
> You can see the sudden drop of almost 50% between 1262 and 1263 byte
> packets. This is what caused us to investigate further. Following the
> change to 32KB buffers the drop in throughput is no longer seen.
>
> packet size    packets sent  throughput (%pps)
> 64             1000000       4.41%
> 128            1000000       7.70%
> 256            1000000       14.26%
> 512            1000000       27.06%
> 1024           1000000       49.39%
> 1280           1000000       58.82%
> 1428           1000000       62.63%
>
> In all cases we were testing with the modem itself in internal loopback
> mode.
>
> We have noted that our modem defaults to 32KB buffers (and a maximum of
> 32 packets per buffer) and also that these values can be changed. We are
> considering adding the ability to tune the buffer size, perhaps adding a
> sysfs entry or netlink message to change the buffer size instead of the
> hard coded value. Any comments would be appreciated.

Thanks for the info, that's interesting.

Note that the default MRU you define is not MHI controller specific
but MHI channel specific (IP/MBIM channel), so it should not be a
property of the MHI controller. AFAIK, The MHI specification already
defines MRU for the transfered buffers which is 65535. I would
recommend to move this prop to the channel config.

Regards,
Loic

>
> Regards,
> Richard
>
>
>
