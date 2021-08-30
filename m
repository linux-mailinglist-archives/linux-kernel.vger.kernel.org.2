Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B9C3FAF38
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 02:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhH3AWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 20:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhH3AWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 20:22:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE8EC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:21:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oa17so8324305pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ke0tls+7+LPLJsimfwRuyYvi3NKswNkWCJ4p4i2engI=;
        b=HghffSYgTGHoFgrjY4yWMmNA9fDowsajh8hWyAGMVlZJ9w0HEcN8XwuLOLV7ENkvHF
         UAcj62DlXLOWWCGM4Dtb1hpKm8CdaCIiYDZT+FsH2PSI6RCM3jwpvD6L/EHQzDP6MPPU
         A2qzMS4hIm5sfqj2+dcBv6oVAfmcdLzCRg78YyxEacySFReT0yS6jBMQ/7A4879x/dM6
         YCDzTvwy2ZNPZW62UvRmAQ6Kswc/Q/iWZD0nWeEiJuqSbWK81pMtUi8Mh82WnFk74EUx
         OdAbYpwmRlKmR4BkorEebap0+5eNc9hLPxD39bs5wqCRVAK6YGKtp2Gfz7mn6+/d4gh3
         SYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ke0tls+7+LPLJsimfwRuyYvi3NKswNkWCJ4p4i2engI=;
        b=QEIx0Em8jVU0ZFRaYAwl1CEbd0yPRyh/+moFu8+VAjPioZpCFZKKrkiTtASOO8bkKP
         qrhZuBgHOP0rnpjT2HLHhEJ+6uQy06K0Bt03OU6E8t/DAoAwMD6bYcKSM206RntC91e5
         vha50fzrC6GdY19k3QEPs4MqRXEYCmLn2JF0vJU1h+ltB40ELYgqc6jrOPQw/oaidQR7
         WESy7Bdq8hv/5gottiPfdpL+QmToDAL2dS2Jnp8OW8NDB7vbNcEbCnPtMTR2dvI2VDGM
         tJhPIpdbI3gjvJ8ceQx2TakrXUYO5O2a1Ye5u4w/lqtq7RC7hRyLELbV0ONNay1W3xDd
         kO2w==
X-Gm-Message-State: AOAM530rGGxVjjahV28anWwfCCfFzY6ECRjQdjH92ewflsMjumLavWUj
        jWgPtlJMVb3PvXRrqk9EZnw8tCNtcrxwF7QmM3x73A==
X-Google-Smtp-Source: ABdhPJzQ9pUbyzNzCIuIzs40Pa1q8XCu1tinyUikd4Jssccim1V4FNauBFjBPNqQIDqkByVuXb81Lt9jzTymBFrjdgk=
X-Received: by 2002:a17:90b:691:: with SMTP id m17mr4125982pjz.217.1630282898122;
 Sun, 29 Aug 2021 17:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210829180717.15393-1-straube.linux@gmail.com> <20210829180717.15393-2-straube.linux@gmail.com>
In-Reply-To: <20210829180717.15393-2-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 30 Aug 2021 01:21:27 +0100
Message-ID: <CAA=Fs0mnaBKbw0ZWg-fgRZ0a6vZCHO-U9cL+D5_a2WpROtWKYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: r8188eu: remove commented constants from wifi.h
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021 at 19:07, Michael Straube <straube.linux@gmail.com> wrote:
>
> Remove commented constants from wifi.h.
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/include/wifi.h | 50 --------------------------
>  1 file changed, 50 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
> index eb07ac9b8943..193a557f0f47 100644
> --- a/drivers/staging/r8188eu/include/wifi.h
> +++ b/drivers/staging/r8188eu/include/wifi.h
> @@ -114,33 +114,6 @@ enum WIFI_REASON_CODE      {
>         _RSON_TDLS_TEAR_UN_RSN_         = 26,
>  };
>
> -/* Reason codes (IEEE 802.11-2007, 7.3.1.7, Table 7-22)
> -
> -#define WLAN_REASON_UNSPECIFIED 1
> -#define WLAN_REASON_PREV_AUTH_NOT_VALID 2
> -#define WLAN_REASON_DEAUTH_LEAVING 3
> -#define WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY 4
> -#define WLAN_REASON_DISASSOC_AP_BUSY 5
> -#define WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA 6
> -#define WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA 7
> -#define WLAN_REASON_DISASSOC_STA_HAS_LEFT 8
> -#define WLAN_REASON_STA_REQ_ASSOC_WITHOUT_AUTH 9 */
> -/* IEEE 802.11h */
> -
> -/* IEEE 802.11i
> -#define WLAN_REASON_INVALID_IE 13
> -#define WLAN_REASON_MICHAEL_MIC_FAILURE 14
> -#define WLAN_REASON_4WAY_HANDSHAKE_TIMEOUT 15
> -#define WLAN_REASON_GROUP_KEY_UPDATE_TIMEOUT 16
> -#define WLAN_REASON_IE_IN_4WAY_DIFFERS 17
> -#define WLAN_REASON_GROUP_CIPHER_NOT_VALID 18
> -#define WLAN_REASON_PAIRWISE_CIPHER_NOT_VALID 19
> -#define WLAN_REASON_AKMP_NOT_VALID 20
> -#define WLAN_REASON_UNSUPPORTED_RSN_IE_VERSION 21
> -#define WLAN_REASON_INVALID_RSN_IE_CAPAB 22
> -#define WLAN_REASON_IEEE_802_1X_AUTH_FAILED 23
> -#define WLAN_REASON_CIPHER_SUITE_REJECTED 24 */
> -
>  enum WIFI_STATUS_CODE {
>         _STATS_SUCCESSFUL_              = 0,
>         _STATS_FAILURE_                 = 1,
> @@ -155,19 +128,6 @@ enum WIFI_STATUS_CODE {
>         _STATS_RATE_FAIL_               = 18,
>  };
>
> -/* Status codes (IEEE 802.11-2007, 7.3.1.9, Table 7-23)
> -#define WLAN_STATUS_SUCCESS 0
> -#define WLAN_STATUS_UNSPECIFIED_FAILURE 1
> -#define WLAN_STATUS_CAPS_UNSUPPORTED 10
> -#define WLAN_STATUS_REASSOC_NO_ASSOC 11
> -#define WLAN_STATUS_ASSOC_DENIED_UNSPEC 12
> -#define WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG 13
> -#define WLAN_STATUS_UNKNOWN_AUTH_TRANSACTION 14
> -#define WLAN_STATUS_CHALLENGE_FAIL 15
> -#define WLAN_STATUS_AUTH_TIMEOUT 16
> -#define WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA 17
> -#define WLAN_STATUS_ASSOC_DENIED_RATES 18 */
> -
>  /* entended */
>  /* IEEE 802.11b */
>  #define WLAN_STATUS_ASSOC_DENIED_NOSHORT 19
> @@ -552,16 +512,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
>  #define _IEEE8021X_MGT_                        1       /*  WPA */
>  #define _IEEE8021X_PSK_                        2       /*  WPA with pre-shared key */
>
> -/*
> -#define _NO_PRIVACY_                   0
> -#define _WEP_40_PRIVACY_               1
> -#define _TKIP_PRIVACY_                 2
> -#define _WRAP_PRIVACY_                 3
> -#define _CCMP_PRIVACY_                 4
> -#define _WEP_104_PRIVACY_              5
> -#define _WEP_WPA_MIXED_PRIVACY_ 6      WEP + WPA
> -*/
> -
>  /*-----------------------------------------------------------------------------
>                                 Below is the definition for WMM
>  ------------------------------------------------------------------------------*/
> --
> 2.33.0
>

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
