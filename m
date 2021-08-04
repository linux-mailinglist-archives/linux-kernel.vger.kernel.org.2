Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38D73E06EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbhHDRrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhHDRrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:47:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A866FC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 10:46:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f42so5814844lfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0fTnqSIwvP+B7/OhEc8RR4PahnQd+RFyLdkyhqe4Tc=;
        b=RRWCky2CXs3xzEfjAAPXPGGYAi8f16wCQRuYnmR0c854JYH46V1TU/iaBtBmpbnw6E
         Kfj9vaBkqxYESFYfSJY52AWmM1LbnilU7aC5Xu/KtvlFL3VbNADAAIfagU8CIGHXdDP2
         JgYquUWhMTOiGsXIXg82owPKoHCDn2hTIN4HBG6sixpXWP2eLeOunlVtNpCk+pcgu6Ns
         LvYGr6o1GdH1QFIjNHN5Bm1Rchoy1yt1ki7Vl9b3KaSaOTvDFzjQNT0NeTXA4J8/PKBm
         JIIjEmAR586EWxKNb42GY9/X/Gio6t1RQ1bfYDZspzJaKOr3HmKeMz0no9xzqC7o9AJr
         P6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0fTnqSIwvP+B7/OhEc8RR4PahnQd+RFyLdkyhqe4Tc=;
        b=KCWAuAofU1eYI/A9n0eZAz8jDlN19arLKZ177fCfXoktRxOccjyimxJWW9TjwwdkmH
         MUwXsdqf5rlku1Jrk28sKNY+qVNTHHdlXjY4uY/6gtWw4Ko0mLRjixTs8hcS+LkjbzlV
         CA7PSPIU4+sw6Vy4gopzgzkNb3Ja995wL0DC9lvKLwXGXdjJRxjlYtU930MqmpMVzhp3
         Fewzi+GYf0kS15mPT5MAej6ZtbA1gVX4MyX3H8y05lZVuvLJAkJZLp+c87mk/UsRYJ64
         82V36+jUOUfkqSDiE1z7iil/uH8pBwRJRq5bVvqDi1wxPv7xmPMQSLhFVInwC9Udfs0L
         o6fQ==
X-Gm-Message-State: AOAM530C510YPRGRXg+CAILVJO8FuzM0Gjm7zVkiJA+TDFG2Z2IIs45f
        GlIBJXQ9eK3PKFzh2NhPzc7rRbddZ5DtKxvKJmb5Sg==
X-Google-Smtp-Source: ABdhPJzJJxN9NhlxRp5no1JRr6vooQgAUqONBHOPfXRdIsLNXqjMeW7fZwg+VASNAi1sIXw3eOQOcoQYxTl9RDGai74=
X-Received: by 2002:a05:6512:71:: with SMTP id i17mr297370lfo.368.1628099215326;
 Wed, 04 Aug 2021 10:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210803223609.1627280-1-nathan@kernel.org> <20210803223609.1627280-3-nathan@kernel.org>
In-Reply-To: <20210803223609.1627280-3-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Aug 2021 10:46:44 -0700
Message-ID: <CAKwvOdmMH6V1yK42Y9xBQX2+2UoCF38q5g=6NXVtk3EWNGz2oQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] staging: r8188eu: Remove unnecessary parentheses
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 3:36 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns several times across the driver along the lines of:
>
> drivers/staging/r8188eu/core/rtw_pwrctrl.c:222:21: warning: equality
> comparison with extraneous parentheses [-Wparentheses-equality]
>         if ((pwrpriv->rpwm == pslv)) {
>              ~~~~~~~~~~~~~~^~~~~~~
> drivers/staging/r8188eu/core/rtw_pwrctrl.c:222:21: note: remove
> extraneous parentheses around the comparison to silence this warning
>         if ((pwrpriv->rpwm == pslv)) {
>             ~              ^      ~
> drivers/staging/r8188eu/core/rtw_pwrctrl.c:222:21: note: use '=' to turn
> this equality comparison into an assignment
>         if ((pwrpriv->rpwm == pslv)) {
>                            ^~
>                            =
> 1 warning generated.
>
> The compilers have agreed that single parentheses are used for equality
> and double parentheses are used for assignment within control flow
> statements such as if and while so remove them in these places to fix
> the warning.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 2 +-
>  drivers/staging/r8188eu/core/rtw_security.c  | 4 ++--
>  drivers/staging/r8188eu/core/rtw_wlan_util.c | 2 +-
>  drivers/staging/r8188eu/hal/odm.c            | 2 +-
>  drivers/staging/r8188eu/hal/usb_halinit.c    | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> index d67eeb045002..598c32d7eaa5 100644
> --- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> +++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> @@ -219,7 +219,7 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
>                         pslv = PS_STATE_S3;
>         }
>
> -       if ((pwrpriv->rpwm == pslv)) {
> +       if (pwrpriv->rpwm == pslv) {
>                 RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
>                          ("%s: Already set rpwm[0x%02X], new=0x%02X!\n", __func__, pwrpriv->rpwm, pslv));
>                 return;
> diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
> index 2c1b9a6dcdf2..45fd8b1aeb59 100644
> --- a/drivers/staging/r8188eu/core/rtw_security.c
> +++ b/drivers/staging/r8188eu/core/rtw_security.c
> @@ -1211,7 +1211,7 @@ u32       rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
>         pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + hw_hdr_offset;
>
>         /* 4 start to encrypt each fragment */
> -       if ((pattrib->encrypt == _AES_)) {
> +       if (pattrib->encrypt == _AES_) {
>                 if (pattrib->psta)
>                         stainfo = pattrib->psta;
>                 else
> @@ -1454,7 +1454,7 @@ u32       rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
>
>         pframe = (unsigned char *)((struct recv_frame *)precvframe)->rx_data;
>         /* 4 start to encrypt each fragment */
> -       if ((prxattrib->encrypt == _AES_)) {
> +       if (prxattrib->encrypt == _AES_) {
>                 stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
>                 if (stainfo != NULL) {
>                         RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_decrypt: stainfo!= NULL!!!\n"));
> diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> index 15edccef9f1d..4a8e52484cfd 100644
> --- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
> +++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> @@ -1306,7 +1306,7 @@ int support_short_GI(struct adapter *padapter, struct HT_caps_element *pHT_caps)
>         if (!(pmlmeinfo->HT_enable))
>                 return _FAIL;
>
> -       if ((pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_RALINK))
> +       if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_RALINK)
>                 return _FAIL;
>
>         bit_offset = (pmlmeext->cur_bwmode & HT_CHANNEL_WIDTH_40) ? 6 : 5;
> diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
> index 0bc836311036..65a117408d50 100644
> --- a/drivers/staging/r8188eu/hal/odm.c
> +++ b/drivers/staging/r8188eu/hal/odm.c
> @@ -1631,7 +1631,7 @@ void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm)
>         struct mlme_ext_priv    *pmlmeext = &(Adapter->mlmeextpriv);
>         struct mlme_ext_info    *pmlmeinfo = &(pmlmeext->mlmext_info);
>
> -       if ((pregpriv->wifi_spec == 1))/*  (pmlmeinfo->HT_enable == 0)) */
> +       if (pregpriv->wifi_spec == 1)

^ was the comment you removed important?

If not:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                 goto dm_CheckEdcaTurbo_EXIT;
>
>         if (pmlmeinfo->assoc_AP_vendor >=  HT_IOT_PEER_MAX)
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index d985894c0f30..ec7badfd72aa 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -1300,7 +1300,7 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
>                 StopTxBeacon(Adapter);
>
>                 rtw_write8(Adapter, REG_BCN_CTRL, 0x19);/* disable atim wnd */
> -       } else if ((mode == _HW_STATE_ADHOC_)) {
> +       } else if (mode == _HW_STATE_ADHOC_) {
>                 ResumeTxBeacon(Adapter);
>                 rtw_write8(Adapter, REG_BCN_CTRL, 0x1a);
>         } else if (mode == _HW_STATE_AP_) {
> --
> 2.33.0.rc0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210803223609.1627280-3-nathan%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
