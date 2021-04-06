Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA680355A18
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346816AbhDFRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhDFRP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:15:28 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C47C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 10:15:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x207so15892645oif.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OWq/IgI7Upin3PIz9SLauRAXaYnGnw0nwqkBOdEZIdU=;
        b=VrdU4cQKOw6gCfHXC48HHLFOsGZWh3UvxRiZbuO72C9tuIf3VsAnn2D6ER3pdOg676
         h5CBOxrBelXHzm9+eLhdur6xT6l+j5q9ThKnzKNCWnQ5T15SNsvX8KFjMi/3JvnXkbWL
         54hqzEcycqvuWC41ecB0+DH81XREAthT1/xbWBFqlNUWrm1sB/veHZCIYkX5xokeWKsB
         yPYRFK7YDjMVqQrYwrLis0b2Q8Y+2Tlcqd73AgDuPgyUz/IzvyBSEE04RnILUPyDKyaP
         qXFdUutua9n3EFRoVKYBL2vGzp3c58XM22GlO7SVbMtjxMyOmf302KH7mSwJsZ2PkWu9
         Zzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OWq/IgI7Upin3PIz9SLauRAXaYnGnw0nwqkBOdEZIdU=;
        b=fRYlFV4ztJV6dkzUROmjzAgTMZey/F3TqlZds3lsTouGK2F/b67wZ9QfLf34e6oyXp
         xulIWK8ZL7bxcV8NHyKSseOgNOUkTl0tUpFxkxT4se2yj1akIAFUyx2GrLzh4b6Ddl4B
         ITKc8bCbFsw1wFv49OC1UNiilGVrxQ0zjhUssLaMOAy7UnEVp4YUotheM+7AGoysCzzZ
         CNyx+MJB8vlEuS1qPGBpcHOeBFjAsnDAekNecM7VmiqSwRPe+tfgJPD8wejgpphEGrII
         UHtLe79TB3OR9+YBOfd+kJlACA/yVqsE0eDiISTMyOEic3G0hRwH75p3ncFzCLqVqCnq
         7ZEA==
X-Gm-Message-State: AOAM530sJSSw7LElJYh+THO8TxAyCC79V3E/ma7lxGY3g4P2u0uDD1vK
        iJuCn/Jm+ZWzpeqcQbzTbIz/Cfuq9ATiPm7FXmc=
X-Google-Smtp-Source: ABdhPJxCwiIC1wLKGkAw+KYDDe6Dq81A3MMDMwoGpqCYJuUhXD0PMWrUJ5nfmijf890eEF2CzC+z12PTKJB4FJ5fITM=
X-Received: by 2002:aca:4187:: with SMTP id o129mr4090587oia.10.1617729317460;
 Tue, 06 Apr 2021 10:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210406170011.20753-1-fmdefrancesco@gmail.com> <alpine.DEB.2.22.394.2104061903380.16498@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2104061903380.16498@hadrien>
From:   FMDF <fmdefrancesco@gmail.com>
Date:   Tue, 6 Apr 2021 19:15:01 +0200
Message-ID: <CAPj211uKYbTbP=5FoUWY8L_TSPgt8HZ4AYB7GBxniheKKQDHhQ@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Add spaces
 around operators in HalBtc8723b2Ant.c
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 7:05 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> On Tue, 6 Apr 2021, Fabio M. De Francesco wrote:
>
> > Added spaces around operators in file HalBtc8723b2Ant.c. Issue detected
> > by checkpatch.pl. Spaces are preferred to improve readibility.
>
> You don't usually need the file name in the subject line or the commit
> message.  One can easily see the file from the diffstat below.  The
> subject line should be concise, and the log message should focus on what
> you have done (briefly) and why.
>
> julia

Just in time to make me change the subject of another patch I'm about
to submit :)

Thanks,

Fabio

>
> >
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  .../staging/rtl8723bs/hal/HalBtc8723b2Ant.c   | 78 +++++++++----------
> >  1 file changed, 39 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/=
staging/rtl8723bs/hal/HalBtc8723b2Ant.c
> > index 6edaefa47af1..4b570ec75e67 100644
> > --- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
> > +++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
> > @@ -44,7 +44,7 @@ static u8 halbtc8723b2ant_BtRssiState(
> >                       (pCoexSta->preBtRssiState =3D=3D BTC_RSSI_STATE_L=
OW) ||
> >                       (pCoexSta->preBtRssiState =3D=3D BTC_RSSI_STATE_S=
TAY_LOW)
> >               ) {
> > -                     if (btRssi >=3D (rssiThresh+BTC_RSSI_COEX_THRESH_=
TOL_8723B_2ANT)) {
> > +                     if (btRssi >=3D (rssiThresh + BTC_RSSI_COEX_THRES=
H_TOL_8723B_2ANT)) {
> >                               btRssiState =3D BTC_RSSI_STATE_HIGH;
> >                               BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI=
_STATE, ("[BTCoex], BT Rssi state switch to High\n"));
> >                       } else {
> > @@ -70,7 +70,7 @@ static u8 halbtc8723b2ant_BtRssiState(
> >                       (pCoexSta->preBtRssiState =3D=3D BTC_RSSI_STATE_L=
OW) ||
> >                       (pCoexSta->preBtRssiState =3D=3D BTC_RSSI_STATE_S=
TAY_LOW)
> >               ) {
> > -                     if (btRssi >=3D (rssiThresh+BTC_RSSI_COEX_THRESH_=
TOL_8723B_2ANT)) {
> > +                     if (btRssi >=3D (rssiThresh + BTC_RSSI_COEX_THRES=
H_TOL_8723B_2ANT)) {
> >                               btRssiState =3D BTC_RSSI_STATE_MEDIUM;
> >                               BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI=
_STATE, ("[BTCoex], BT Rssi state switch to Medium\n"));
> >                       } else {
> > @@ -81,7 +81,7 @@ static u8 halbtc8723b2ant_BtRssiState(
> >                       (pCoexSta->preBtRssiState =3D=3D BTC_RSSI_STATE_M=
EDIUM) ||
> >                       (pCoexSta->preBtRssiState =3D=3D BTC_RSSI_STATE_S=
TAY_MEDIUM)
> >               ) {
> > -                     if (btRssi >=3D (rssiThresh1+BTC_RSSI_COEX_THRESH=
_TOL_8723B_2ANT)) {
> > +                     if (btRssi >=3D (rssiThresh1 + BTC_RSSI_COEX_THRE=
SH_TOL_8723B_2ANT)) {
> >                               btRssiState =3D BTC_RSSI_STATE_HIGH;
> >                               BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_BT_RSSI=
_STATE, ("[BTCoex], BT Rssi state switch to High\n"));
> >                       } else if (btRssi < rssiThresh) {
> > @@ -125,7 +125,7 @@ static u8 halbtc8723b2ant_WifiRssiState(
> >                       (pCoexSta->preWifiRssiState[index] =3D=3D BTC_RSS=
I_STATE_LOW) ||
> >                       (pCoexSta->preWifiRssiState[index] =3D=3D BTC_RSS=
I_STATE_STAY_LOW)
> >               ) {
> > -                     if (wifiRssi >=3D (rssiThresh+BTC_RSSI_COEX_THRES=
H_TOL_8723B_2ANT)) {
> > +                     if (wifiRssi >=3D (rssiThresh + BTC_RSSI_COEX_THR=
ESH_TOL_8723B_2ANT)) {
> >                               wifiRssiState =3D BTC_RSSI_STATE_HIGH;
> >                               BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RS=
SI_STATE, ("[BTCoex], wifi RSSI state switch to High\n"));
> >                       } else {
> > @@ -151,7 +151,7 @@ static u8 halbtc8723b2ant_WifiRssiState(
> >                       (pCoexSta->preWifiRssiState[index] =3D=3D BTC_RSS=
I_STATE_LOW) ||
> >                       (pCoexSta->preWifiRssiState[index] =3D=3D BTC_RSS=
I_STATE_STAY_LOW)
> >               ) {
> > -                     if (wifiRssi >=3D (rssiThresh+BTC_RSSI_COEX_THRES=
H_TOL_8723B_2ANT)) {
> > +                     if (wifiRssi >=3D (rssiThresh + BTC_RSSI_COEX_THR=
ESH_TOL_8723B_2ANT)) {
> >                               wifiRssiState =3D BTC_RSSI_STATE_MEDIUM;
> >                               BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RS=
SI_STATE, ("[BTCoex], wifi RSSI state switch to Medium\n"));
> >                       } else {
> > @@ -162,7 +162,7 @@ static u8 halbtc8723b2ant_WifiRssiState(
> >                       (pCoexSta->preWifiRssiState[index] =3D=3D BTC_RSS=
I_STATE_MEDIUM) ||
> >                       (pCoexSta->preWifiRssiState[index] =3D=3D BTC_RSS=
I_STATE_STAY_MEDIUM)
> >               ) {
> > -                     if (wifiRssi >=3D (rssiThresh1+BTC_RSSI_COEX_THRE=
SH_TOL_8723B_2ANT)) {
> > +                     if (wifiRssi >=3D (rssiThresh1 + BTC_RSSI_COEX_TH=
RESH_TOL_8723B_2ANT)) {
> >                               wifiRssiState =3D BTC_RSSI_STATE_HIGH;
> >                               BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_WIFI_RS=
SI_STATE, ("[BTCoex], wifi RSSI state switch to High\n"));
> >                       } else if (wifiRssi < rssiThresh) {
> > @@ -222,11 +222,11 @@ static void halbtc8723b2ant_MonitorBtCtr(struct b=
tc_coexist *pBtCoexist)
> >
> >       u4Tmp =3D pBtCoexist->fBtcRead4Byte(pBtCoexist, regHPTxRx);
> >       regHPTx =3D u4Tmp & bMaskLWord;
> > -     regHPRx =3D (u4Tmp & bMaskHWord)>>16;
> > +     regHPRx =3D (u4Tmp & bMaskHWord) >> 16;
> >
> >       u4Tmp =3D pBtCoexist->fBtcRead4Byte(pBtCoexist, regLPTxRx);
> >       regLPTx =3D u4Tmp & bMaskLWord;
> > -     regLPRx =3D (u4Tmp & bMaskHWord)>>16;
> > +     regLPRx =3D (u4Tmp & bMaskHWord) >> 16;
> >
> >       pCoexSta->highPriorityTx =3D regHPTx;
> >       pCoexSta->highPriorityRx =3D regHPRx;
> > @@ -1173,9 +1173,9 @@ static void halbtc8723b2ant_SetFwPstdma(
> >               (
> >                       "[BTCoex], FW write 0x60(5bytes) =3D 0x%x%08x\n",
> >                       H2C_Parameter[0],
> > -                     H2C_Parameter[1]<<24|
> > -                     H2C_Parameter[2]<<16|
> > -                     H2C_Parameter[3]<<8|
> > +                     H2C_Parameter[1] << 24 |
> > +                     H2C_Parameter[2] << 16 |
> > +                     H2C_Parameter[3] << 8 |
> >                       H2C_Parameter[4]
> >               )
> >       );
> > @@ -1691,7 +1691,7 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
> >                               if (m >=3D 20) /* m =E6=9C=80=E5=A4=A7=E5=
=80=BC =3D 20 ' =E6=9C=80=E5=A4=A7120=E7=A7=92 recheck=E6=98=AF=E5=90=A6=E8=
=AA=BF=E6=95=B4 WiFi duration. */
> >                                       m =3D 20;
> >
> > -                             n =3D 3*m;
> > +                             n =3D 3 * m;
> >                               up =3D 0;
> >                               dn =3D 0;
> >                               WaitCount =3D 0;
> > @@ -1707,7 +1707,7 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
> >                       if (m >=3D 20) /* m =E6=9C=80=E5=A4=A7=E5=80=BC =
=3D 20 ' =E6=9C=80=E5=A4=A7120=E7=A7=92 recheck=E6=98=AF=E5=90=A6=E8=AA=BF=
=E6=95=B4 WiFi duration. */
> >                               m =3D 20;
> >
> > -                     n =3D 3*m;
> > +                     n =3D 3 * m;
> >                       up =3D 0;
> >                       dn =3D 0;
> >                       WaitCount =3D 0;
> > @@ -2824,7 +2824,7 @@ void EXhalbtc8723b2ant_PowerOnSetting(struct btc_=
coexist *pBtCoexist)
> >
> >       /*  enable BB, REG_SYS_FUNC_EN such that we can write 0x948 corre=
ctly. */
> >       u2Tmp =3D pBtCoexist->fBtcRead2Byte(pBtCoexist, 0x2);
> > -     pBtCoexist->fBtcWrite2Byte(pBtCoexist, 0x2, u2Tmp|BIT0|BIT1);
> > +     pBtCoexist->fBtcWrite2Byte(pBtCoexist, 0x2, u2Tmp | BIT0 | BIT1);
> >
> >       /*  set GRAN_BT =3D 1 */
> >       pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x765, 0x18);
> > @@ -3019,7 +3019,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc=
_coexist *pBtCoexist)
> >               cliBuf,
> >               BT_TMP_BUF_SIZE,
> >               "\r\n %-35s =3D %s", "BT Info A2DP rate", \
> > -             (btInfoExt&BIT0) ? "Basic rate" : "EDR rate"
> > +             (btInfoExt & BIT0) ? "Basic rate" : "EDR rate"
> >       );
> >       CL_PRINTF(cliBuf);
> >
> > @@ -3126,7 +3126,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc=
_coexist *pBtCoexist)
> >               BT_TMP_BUF_SIZE,
> >               "\r\n %-35s =3D 0x%x/ 0x%x", "0x778/0x880[29:25]", \
> >               u1Tmp[0],
> > -             (u4Tmp[0]&0x3e000000) >> 25
> > +             (u4Tmp[0] & 0x3e000000) >> 25
> >       );
> >       CL_PRINTF(cliBuf);
> >
> > @@ -3139,7 +3139,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc=
_coexist *pBtCoexist)
> >               BT_TMP_BUF_SIZE,
> >               "\r\n %-35s =3D 0x%x/ 0x%x/ 0x%x", "0x948/ 0x67[5] / 0x76=
5", \
> >               u4Tmp[0],
> > -             ((u1Tmp[0]&0x20)>>5),
> > +             ((u1Tmp[0] & 0x20) >> 5),
> >               u1Tmp[1]
> >       );
> >       CL_PRINTF(cliBuf);
> > @@ -3151,9 +3151,9 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc=
_coexist *pBtCoexist)
> >               cliBuf,
> >               BT_TMP_BUF_SIZE,
> >               "\r\n %-35s =3D 0x%x/ 0x%x/ 0x%x", "0x92c[1:0]/ 0x930[7:0=
]/0x944[1:0]", \
> > -             u4Tmp[0]&0x3,
> > -             u4Tmp[1]&0xff,
> > -             u4Tmp[2]&0x3
> > +             u4Tmp[0] & 0x3,
> > +             u4Tmp[1] & 0xff,
> > +             u4Tmp[2] & 0x3
> >       );
> >       CL_PRINTF(cliBuf);
> >
> > @@ -3166,10 +3166,10 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct b=
tc_coexist *pBtCoexist)
> >               cliBuf,
> >               BT_TMP_BUF_SIZE,
> >               "\r\n %-35s =3D 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x38[11]/0x40/0=
x4c[24:23]/0x64[0]", \
> > -             ((u1Tmp[0] & 0x8)>>3),
> > +             ((u1Tmp[0] & 0x8) >> 3),
> >               u1Tmp[1],
> > -             ((u4Tmp[0]&0x01800000)>>23),
> > -             u1Tmp[2]&0x1
> > +             ((u4Tmp[0] & 0x01800000) >> 23),
> > +             u1Tmp[2] & 0x1
> >       );
> >       CL_PRINTF(cliBuf);
> >
> > @@ -3190,7 +3190,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc=
_coexist *pBtCoexist)
> >               cliBuf,
> >               BT_TMP_BUF_SIZE,
> >               "\r\n %-35s =3D 0x%x/ 0x%x", "0xc50(dig)/0x49c(null-drop)=
", \
> > -             u4Tmp[0]&0xff,
> > +             u4Tmp[0] & 0xff,
> >               u1Tmp[0]
> >       );
> >       CL_PRINTF(cliBuf);
> > @@ -3204,10 +3204,10 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct b=
tc_coexist *pBtCoexist)
> >       u1Tmp[1] =3D pBtCoexist->fBtcRead1Byte(pBtCoexist, 0xa5c);
> >
> >       faOfdm =3D
> > -             ((u4Tmp[0]&0xffff0000) >> 16) +
> > -             ((u4Tmp[1]&0xffff0000) >> 16) +
> > +             ((u4Tmp[0] & 0xffff0000) >> 16) +
> > +             ((u4Tmp[1] & 0xffff0000) >> 16) +
> >               (u4Tmp[1] & 0xffff) +  (u4Tmp[2] & 0xffff) + \
> > -             ((u4Tmp[3]&0xffff0000) >> 16) +
> > +             ((u4Tmp[3] & 0xffff0000) >> 16) +
> >               (u4Tmp[3] & 0xffff);
> >
> >       faCck =3D (u1Tmp[0] << 8) + u1Tmp[1];
> > @@ -3216,7 +3216,7 @@ void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc=
_coexist *pBtCoexist)
> >               cliBuf,
> >               BT_TMP_BUF_SIZE,
> >               "\r\n %-35s =3D 0x%x/ 0x%x/ 0x%x", "OFDM-CCA/OFDM-FA/CCK-=
FA", \
> > -             u4Tmp[0]&0xffff,
> > +             u4Tmp[0] & 0xffff,
> >               faOfdm,
> >               faCck
> >       );
> > @@ -3344,7 +3344,7 @@ void EXhalbtc8723b2ant_MediaStatusNotify(struct b=
tc_coexist *pBtCoexist, u8 type
> >               ALGO_TRACE_FW_EXEC,
> >               (
> >                       "[BTCoex], FW write 0x66 =3D 0x%x\n",
> > -                     H2C_Parameter[0]<<16|H2C_Parameter[1]<<8|H2C_Para=
meter[2]
> > +                     H2C_Parameter[0] << 16 | H2C_Parameter[1] << 8 | =
H2C_Parameter[2]
> >               )
> >       );
> >
> > @@ -3369,7 +3369,7 @@ void EXhalbtc8723b2ant_BtInfoNotify(
> >
> >       pCoexSta->bC2hBtInfoReqSent =3D false;
> >
> > -     rspSource =3D tmpBuf[0]&0xf;
> > +     rspSource =3D tmpBuf[0] & 0xf;
> >       if (rspSource >=3D BT_INFO_SRC_8723B_2ANT_MAX)
> >               rspSource =3D BT_INFO_SRC_8723B_2ANT_WIFI_FW;
> >
> > @@ -3381,7 +3381,7 @@ void EXhalbtc8723b2ant_BtInfoNotify(
> >               if (i =3D=3D 1)
> >                       btInfo =3D tmpBuf[i];
> >
> > -             if (i =3D=3D length-1) {
> > +             if (i =3D=3D length - 1) {
> >                       BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("0x%02=
x]\n", tmpBuf[i]));
> >               } else {
> >                       BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("0x%02=
x, ", tmpBuf[i]));
> > @@ -3394,13 +3394,13 @@ void EXhalbtc8723b2ant_BtInfoNotify(
> >       }
> >
> >       if (BT_INFO_SRC_8723B_2ANT_WIFI_FW !=3D rspSource) {
> > -             pCoexSta->btRetryCnt =3D pCoexSta->btInfoC2h[rspSource][2=
]&0xf; /* [3:0] */
> > +             pCoexSta->btRetryCnt =3D pCoexSta->btInfoC2h[rspSource][2=
] & 0xf; /* [3:0] */
> >
> > -             pCoexSta->btRssi =3D pCoexSta->btInfoC2h[rspSource][3]*2+=
10;
> > +             pCoexSta->btRssi =3D pCoexSta->btInfoC2h[rspSource][3] * =
2 + 10;
> >
> >               pCoexSta->btInfoExt =3D pCoexSta->btInfoC2h[rspSource][4]=
;
> >
> > -             pCoexSta->bBtTxRxMask =3D (pCoexSta->btInfoC2h[rspSource]=
[2]&0x40);
> > +             pCoexSta->bBtTxRxMask =3D (pCoexSta->btInfoC2h[rspSource]=
[2] & 0x40);
> >               pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_BL_BT_TX_RX_MASK,=
 &pCoexSta->bBtTxRxMask);
> >               if (pCoexSta->bBtTxRxMask) {
> >                       /* BT into is responded by BT FW and BT RF REG 0x=
3C !=3D 0x01 =3D> Need to switch BT TRx Mask */
> > @@ -3435,7 +3435,7 @@ void EXhalbtc8723b2ant_BtInfoNotify(
> >               pCoexSta->bC2hBtInquiryPage =3D false;
> >
> >       /*  set link exist status */
> > -     if (!(btInfo&BT_INFO_8723B_2ANT_B_CONNECTION)) {
> > +     if (!(btInfo & BT_INFO_8723B_2ANT_B_CONNECTION)) {
> >               pCoexSta->bBtLinkExist =3D false;
> >               pCoexSta->bPanExist =3D false;
> >               pCoexSta->bA2dpExist =3D false;
> > @@ -3463,19 +3463,19 @@ void EXhalbtc8723b2ant_BtInfoNotify(
> >
> >       halbtc8723b2ant_UpdateBtLinkInfo(pBtCoexist);
> >
> > -     if (!(btInfo&BT_INFO_8723B_2ANT_B_CONNECTION)) {
> > +     if (!(btInfo & BT_INFO_8723B_2ANT_B_CONNECTION)) {
> >               pCoexDm->btStatus =3D BT_8723B_2ANT_BT_STATUS_NON_CONNECT=
ED_IDLE;
> >               BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtIn=
foNotify(), BT Non-Connected idle!!!\n"));
> >       } else if (btInfo =3D=3D BT_INFO_8723B_2ANT_B_CONNECTION)   { /* =
 connection exists but no busy */
> >               pCoexDm->btStatus =3D BT_8723B_2ANT_BT_STATUS_CONNECTED_I=
DLE;
> >               BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtIn=
foNotify(), BT Connected-idle!!!\n"));
> >       } else if (
> > -             (btInfo&BT_INFO_8723B_2ANT_B_SCO_ESCO) ||
> > -             (btInfo&BT_INFO_8723B_2ANT_B_SCO_BUSY)
> > +             (btInfo & BT_INFO_8723B_2ANT_B_SCO_ESCO) ||
> > +             (btInfo & BT_INFO_8723B_2ANT_B_SCO_BUSY)
> >       ) {
> >               pCoexDm->btStatus =3D BT_8723B_2ANT_BT_STATUS_SCO_BUSY;
> >               BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtIn=
foNotify(), BT SCO busy!!!\n"));
> > -     } else if (btInfo&BT_INFO_8723B_2ANT_B_ACL_BUSY) {
> > +     } else if (btInfo & BT_INFO_8723B_2ANT_B_ACL_BUSY) {
> >               pCoexDm->btStatus =3D BT_8723B_2ANT_BT_STATUS_ACL_BUSY;
> >               BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtIn=
foNotify(), BT ACL busy!!!\n"));
> >       } else {
> > --
> > 2.30.2
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/outreachy-kernel/20210406170011.20753-1-fmdefrancesco%40gmail.com.
> >
>
> --
> You received this message because you are subscribed to the Google Groups=
 "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/outreachy-kernel/alpine.DEB.2.22.394.2104061903380.16498%40hadrien.
