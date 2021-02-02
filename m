Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF630B8BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhBBHhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:37:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39202 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhBBHhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:37:04 -0500
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l6qEX-0007nV-TI
        for linux-kernel@vger.kernel.org; Tue, 02 Feb 2021 07:36:22 +0000
Received: by mail-lf1-f70.google.com with SMTP id t4so3542014lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 23:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSoMdUbpzG6cQwzLgZZTiGXvRVf2gEXyL2WC99OtW+s=;
        b=td1LDS/4JNxtVIU3HJEKr7r4iI6Ih5UxZnUc8I9HDycgqZKyp0fO1ubqB9yqCEYoFc
         WsmsdRxu4serPnMUOqJo8qzI8t51XJdcGgZVf+jW9+5/FbO69wmjhXwjfUQEDwvqTfRR
         UFN75+X5KY4KX8zMgVNBYeczQNBsDt3uQRVV6bMUJaGON9aARhsccv1QvE2cPAAyWKMQ
         n9XhwWYQS975cDbNeOc3X8rrVmfyasU1E1erDxCwJtjbJ20pHON8ss3V3j50flhVOth+
         dA8k6wsA+fSQVtMOxZcKRsMNBDfTZ4l0/2pPSEY0ExRFQIdwJwsByMZqGE9tlQLK1A7k
         oDPA==
X-Gm-Message-State: AOAM530bmJO7IlwKPogfwEgD01OSfowM2brZ2fl2eGct/af9G+P+HxDT
        dfajkxizCVyQ1oMy3R4xbrObfUrzJIwd5WvrzyRDw3K30tEgc9ZHtd0ITtmKDFuSphmbxCPLPnL
        5cWnstZ9iTzqd6GF+5EXgSCJ2vnKbroacggg7CGbFDFcvE8AWY1YuGariNg==
X-Received: by 2002:a05:6512:b1b:: with SMTP id w27mr10509604lfu.10.1612251381361;
        Mon, 01 Feb 2021 23:36:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5dv1Lrlfrr7Ynb6iQgLdZKKxLKhBfVWGXB8B6/fyiUueDPcltK2OaDOeatPA3x15vvGz/Vb5SF9Yn6KsvJL4=
X-Received: by 2002:a05:6512:b1b:: with SMTP id w27mr10509591lfu.10.1612251381100;
 Mon, 01 Feb 2021 23:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20200805084559.30092-1-kai.heng.feng@canonical.com>
 <c0c336d806584361992d4b52665fbb82@realtek.com> <9330BBA5-158B-49F1-8B7C-C2733F358AC1@canonical.com>
 <CAAd53p6SA5gG8V27eD1Kh1ik932Kt8KzmYjLy33pOkw=QPKgpA@mail.gmail.com>
 <871rdz7zjf.fsf@codeaurora.org> <e4f2fe2b-52a2-7b39-6758-decf22d82eb6@lwfinger.net>
In-Reply-To: <e4f2fe2b-52a2-7b39-6758-decf22d82eb6@lwfinger.net>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 2 Feb 2021 15:36:09 +0800
Message-ID: <CAAd53p5p=Bz-VKLxbajhZ2VeHs1Dczcqc1hgPZtNsMb-Fy6J3w@mail.gmail.com>
Subject: Re: [PATCH] rtw88: 8821c: Add RFE 2 support
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Tony Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 3:02 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 2/2/21 12:29 AM, Kalle Valo wrote:
> > Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
> >
> >> On Wed, Aug 5, 2020 at 7:24 PM Kai-Heng Feng
> >> <kai.heng.feng@canonical.com> wrote:
> >>>
> >>> Hi Tony,
> >>>
> >>>> On Aug 5, 2020, at 19:18, Tony Chuang <yhchuang@realtek.com> wrote:
> >>>>
> >>>>> 8821CE with RFE 2 isn't supported:
> >>>>> [   12.404834] rtw_8821ce 0000:02:00.0: rfe 2 isn't supported
> >>>>> [   12.404937] rtw_8821ce 0000:02:00.0: failed to setup chip efuse info
> >>>>> [   12.404939] rtw_8821ce 0000:02:00.0: failed to setup chip information
> >>>>>
> >>>>
> >>>> NACK
> >>>>
> >>>> The RFE type 2 should be working with some additional fixes.
> >>>> Did you tested connecting to AP with BT paired?
> >>>
> >>> No, I only tested WiFi.
> >>>
> >>>> The antenna configuration is different with RFE type 0.
> >>>> I will ask someone else to fix them.
> >>>> Then the RFE type 2 modules can be supported.
> >>>
> >>> Good to know that, I'll be patient and wait for a real fix.
> >>
> >> It's been quite some time, is support for RFE type 2 ready now?
> >
> > It looks like this patch should add it:
> >
> > https://patchwork.kernel.org/project/linux-wireless/patch/20210202055012.8296-4-pkshih@realtek.com/
> >
> New firmware (rtw8821c_fw.bin) is also needed. That is available at
> https://github.com/lwfinger/rtw88.git.

Thanks. RFE2 works with the new firmware.

Kai-Heng

>
> Larry
>
