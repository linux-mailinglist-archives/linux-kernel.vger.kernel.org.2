Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5966355688
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345126AbhDFOWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhDFOWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:22:51 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93380C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 07:22:43 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so14760731otb.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2C58heWhjWSXVwd82d75mh+4ssAK4ihVn1YcjIF/AAg=;
        b=soHVhgYDQK5DhGL2cYR8dtJ3mFb+IY7oWhlKrSZCmDH1eu4FvpnLjil8XXxZp8VfI1
         KMfyYHBaG4bbiJGwZVZclylKZoUl+Vbq+NrD7aEkhlRvckUYo4j3I8AQNFzsAoioZEv+
         W9aI91zfZzVrrfEOpCA52VvHoMwsr5hJFfWbc/19Myy/9rp8ysbtrUXfpdv+MXN2CHbG
         S1BHi1AorKcTyhjRmhqoS5OEJ8UwUK2MwlIeRcVuYLUBg76CREejoZyN9phYCF311Dk2
         sSYUHg4A3W2eGOXnYDhPc7MzEG32PaakcTBpLeeTgyYyZZyKL78UGPxJFO1EaHYLtzxr
         p7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2C58heWhjWSXVwd82d75mh+4ssAK4ihVn1YcjIF/AAg=;
        b=QZiC1CLNRGZi/doPsiKBV8ygHsqsKy2AqoaJc26rmry5TLFTCPRunkgI5/T2kR45SY
         0fJY/yyEry8ggt1piaeUB4HnzoTCzsj0XrJXZMjEl5/3Z/rZZTjcnWWuiPzyEChEfIF/
         ehTe9qgE71YOdll9CFwfxBs6TgvHpllUSmfv9SecrRosYpmGJMtjKC6JxgVZOTZMMYir
         ict8Wo6gVlhhWjvz1HymghiHQZS65tDnEFvqWEfztvScqxpGTjgUiyyPDxRf7HQHa/b9
         cBFo+/HtjLpChuxXo+BCoBMOBPAGKTzS8Y7k7s+24GWNuVbsdRXO3hitFDAFYtG3tt5m
         /pcw==
X-Gm-Message-State: AOAM530H4PSS8ygqH5S2uVlrpmYzXifSnqYIlwj0FCMkK9pangBCeIjP
        gsAY4RIYaTSWfp13qggPeLfC0jvPDCmCd1snDQfycGmZ7xipMw==
X-Google-Smtp-Source: ABdhPJy+Cwg2iYwtFcgBus7i09ayPPWSytIc4YUURuFQzet7jXBYENspMVnnC2fb4zFlxp0jCH/i5bdsoHdsVulcIas=
X-Received: by 2002:a9d:7f8a:: with SMTP id t10mr26150737otp.239.1617718962943;
 Tue, 06 Apr 2021 07:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210406130138.30744-1-fmdefrancesco@gmail.com> <YGxsNVs+sexiPMJS@kroah.com>
In-Reply-To: <YGxsNVs+sexiPMJS@kroah.com>
From:   FMDF <fmdefrancesco@gmail.com>
Date:   Tue, 6 Apr 2021 16:22:27 +0200
Message-ID: <CAPj211s_MCJ6R+DgETqzj8pbzToZv=aYsDjT-c-HvLst+4nNOQ@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Add spaces
 around operators
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 4:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 06, 2021 at 03:01:38PM +0200, Fabio M. De Francesco wrote:
> > Added spaces around operators in file HalBtc8723b1Ant.c. Issue detected
> > by checkpatch.pl. Spaces are preferred to improve readibility.
> >
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 98 +++++++++----------
> >  1 file changed, 49 insertions(+), 49 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> > index 3e794093092b..b2b872016e45 100644
> > --- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> > +++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> > @@ -38,7 +38,7 @@ static u8 halbtc8723b1ant_BtRssiState(
> >                       (pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
> >                       (pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
> >               ) {
> > -                     if (btRssi >= (rssiThresh+BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
> > +                     if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
> >
> >                               btRssiState = BTC_RSSI_STATE_HIGH;
> >                               BTC_PRINT(
> > @@ -85,7 +85,7 @@ static u8 halbtc8723b1ant_BtRssiState(
> >                       (pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
> >                       (pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
> >               ) {
> > -                     if (btRssi >= (rssiThresh+BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
> > +                     if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
> >                               btRssiState = BTC_RSSI_STATE_MEDIUM;
> >                               BTC_PRINT(
> >                                       BTC_MSG_ALGORITHM,
> > @@ -104,7 +104,7 @@ static u8 halbtc8723b1ant_BtRssiState(
> >                       (pCoexSta->preBtRssiState == BTC_RSSI_STATE_MEDIUM) ||
> >                       (pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_MEDIUM)
> >               ) {
> > -                     if (btRssi >= (rssiThresh1+BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
> > +                     if (btRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
> >                               btRssiState = BTC_RSSI_STATE_HIGH;
> >                               BTC_PRINT(
> >                                       BTC_MSG_ALGORITHM,
> > @@ -353,11 +353,11 @@ static void halbtc8723b1ant_MonitorBtCtr(struct btc_coexist *pBtCoexist)
> >
> >       u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, regHPTxRx);
> >       regHPTx = u4Tmp & bMaskLWord;
> > -     regHPRx = (u4Tmp & bMaskHWord)>>16;
> > +     regHPRx = (u4Tmp & bMaskHWord) >> 16;
> >
> >       u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, regLPTxRx);
> >       regLPTx = u4Tmp & bMaskLWord;
> > -     regLPRx = (u4Tmp & bMaskHWord)>>16;
> > +     regLPRx = (u4Tmp & bMaskHWord) >> 16;
> >
> >       pCoexSta->highPriorityTx = regHPTx;
> >       pCoexSta->highPriorityRx = regHPRx;
> > @@ -1317,7 +1317,7 @@ static void halbtc8723b1ant_SetFwPstdma(
> >       pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_AP_MODE_ENABLE, &bApEnable);
> >
> >       if (bApEnable) {
> > -             if (byte1&BIT4 && !(byte1&BIT5)) {
> > +             if (byte1 & BIT4 && !(byte1 & BIT5)) {
> >                       BTC_PRINT(
> >                               BTC_MSG_INTERFACE,
> >                               INTF_NOTIFY,
> > @@ -1349,9 +1349,9 @@ static void halbtc8723b1ant_SetFwPstdma(
> >               (
> >                       "[BTCoex], PS-TDMA H2C cmd = 0x%x%08x\n",
> >                       H2C_Parameter[0],
> > -                     H2C_Parameter[1]<<24|
> > -                     H2C_Parameter[2]<<16|
> > -                     H2C_Parameter[3]<<8|
> > +                     H2C_Parameter[1] << 24 |
> > +                     H2C_Parameter[2] << 16 |
> > +                     H2C_Parameter[3]<< 8 |
>
> Why did you miss the space that is needed here too?

I really don't know why I overlooked these.

>
> Did you run this patch through checkpatch.pl?

Yes, I did it as I always do.

>
> Please do so.
>
> thanks,
>
> greg k-h

I am going to send a v2 as soon as possible.

Thanks for your review,

Fabio
