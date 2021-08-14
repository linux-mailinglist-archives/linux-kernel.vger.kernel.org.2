Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A83EC421
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbhHNRha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 13:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhHNRhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:37:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9E9C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:36:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l11so15988437plk.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+PGN1P4CCQfdrmi2TEua0XeKzgQPJ/6EHD4I6/2Dow=;
        b=dykmCarnzbku1la7Qw32+cr7iPDn74d6I3CVKEzHbG5wLZcjnNpywSF8oRsToaV03T
         CtR5gdIvh4ONFOtRKz8xFsi8wPKQRuBWOQ0ldNA2pdAMpuU92XVVL8TZagVNvW4hIpKh
         5aqC9o+0W5lMsRzX30Xes039dmvSJyw0a4/P1AMFZ7XR/a3dHc4FC6rcscOLHE8lauLs
         XUkVXapfe8WqbNhNtt3a/xNFibVJyZuVtJPVgQo8gxIduO4qzcU88mcRG5ABVCO0cUBM
         khh64lDg/6jBD6TdosQTWQ1RyI9UwXStFVENWNqvrr7UJu3tNoHMkZpkyj7bDlBey1UI
         Bwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+PGN1P4CCQfdrmi2TEua0XeKzgQPJ/6EHD4I6/2Dow=;
        b=foaZVCkBBF11atAuJycdfWCkw3GrDlMm7rfQLKWHtZsVOMZWoe5XQ/Gfb8PNvI2kzA
         GJoSI03yLAWJzBiozsEstiL1cRcjn4bXTC9N8kbrOxK9dqJEDI1BaTplNzYvQlqyA9Q6
         VqrLJsBCR5jgmh7/m+7eYgP1+bKjOurFa9vNl9wGYw6hBeGPxrhY5k8WUcgi8jTUG/XD
         VrGkRd9NBU9/ZXKcTLz+0OBcAoVKLurAjaJLAWFObGb9wcfcdIzVO7x8oEQHPxYihG9C
         mopp5ihlezm2d0MZYv8a8DuGe4tjVkaK195zE5JxGIx8Pn04MikJ0RQsAd4hy1aSta7Z
         FOcA==
X-Gm-Message-State: AOAM533uYflMbRyosU2SdovsQOwqcUhNnx1ZLo6TXkWCAvCdp1kUHmnX
        74vUsr2WYnagB3WPwFJ5tHZJaNT1zPBKUZPIcjgfjg==
X-Google-Smtp-Source: ABdhPJy5o1zJqY5PcOgAGbRgehzN5l952Z+tGfO+SWpjBv2jGgh76rRH0Wl4eQ2tZwr8h73GVJt1xUuq0JqNbArym3k=
X-Received: by 2002:a17:902:8c81:b029:12c:ee37:3f58 with SMTP id
 t1-20020a1709028c81b029012cee373f58mr6460881plo.45.1628962611382; Sat, 14 Aug
 2021 10:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210814165518.8672-1-straube.linux@gmail.com>
In-Reply-To: <20210814165518.8672-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 14 Aug 2021 18:36:40 +0100
Message-ID: <CAA=Fs0kkhzvu134zOpb69Z6WFCCpmcfGLR-4KJeDd3n1d8g-qw@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: use common ieee80211 constants
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2021 at 17:56, Michael Straube <straube.linux@gmail.com> wrote:
>
> Many defined constants in wifi.h are unused and/or available from
> <linux/ieee80211.h>, some with slightly different names. Remove
> the constants from wifi.h and use the common ones. Rename where
> necessary.
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_ap.c        | 12 ++---
>  drivers/staging/r8188eu/core/rtw_mlme.c      |  8 ++--
>  drivers/staging/r8188eu/include/wifi.h       | 50 --------------------
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c |  2 +-
>  4 files changed, 11 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
> index bc4c6dbd5aa3..f1b519d20989 100644
> --- a/drivers/staging/r8188eu/core/rtw_ap.c
> +++ b/drivers/staging/r8188eu/core/rtw_ap.c
> @@ -630,7 +630,7 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
>                         phtpriv_sta->sgi = true;
>
>                 /*  bwmode */
> -               if ((sta_cap_info & ap_cap_info) & IEEE80211_HT_CAP_SUP_WIDTH) {
> +               if ((sta_cap_info & ap_cap_info) & IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
>                         phtpriv_sta->bwmode = pmlmeext->cur_bwmode;
>                         phtpriv_sta->ch_offset = pmlmeext->cur_ch_offset;
>                 }
> @@ -1015,12 +1015,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>
>                 if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
>                     (psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_CCMP))
> -                       pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY&(0x07<<2));
> +                       pht_cap->ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_DENSITY & (0x07 << 2));
>                 else
> -                       pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY&0x00);
> +                       pht_cap->ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
>
>                 /* set  Max Rx AMPDU size  to 64K */
> -               pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_FACTOR & 0x03);
> +               pht_cap->ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_FACTOR & 0x03);
>
>                 if (rf_type == RF_1T1R) {
>                         pht_cap->mcs.rx_mask[0] = 0xff;
> @@ -1447,7 +1447,7 @@ static int rtw_ht_operation_update(struct adapter *padapter)
>             (pmlmepriv->ht_op_mode & HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT))
>                 new_op_mode = OP_MODE_MIXED;
>         else if ((le16_to_cpu(phtpriv_ap->ht_cap.cap_info) &
> -                 IEEE80211_HT_CAP_SUP_WIDTH) &&
> +                 IEEE80211_HT_CAP_SUP_WIDTH_20_40) &&
>                  pmlmepriv->num_sta_ht_20mhz)
>                 new_op_mode = OP_MODE_20MHZ_HT_STA_ASSOCED;
>         else if (pmlmepriv->olbc_ht)
> @@ -1597,7 +1597,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
>                                    pmlmepriv->num_sta_ht_no_gf);
>                 }
>
> -               if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH) == 0) {
> +               if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH_20_40) == 0) {
>                         if (!psta->ht_20mhz_set) {
>                                 psta->ht_20mhz_set = 1;
>                                 pmlmepriv->num_sta_ht_20mhz++;
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index 5088b555f55d..9189f5c845f3 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -2001,7 +2001,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
>
>                 memset(&ht_capie, 0, sizeof(struct ieee80211_ht_cap));
>
> -               ht_capie.cap_info = cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH |
> +               ht_capie.cap_info = cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
>                                                 IEEE80211_HT_CAP_SGI_20 |
>                                                 IEEE80211_HT_CAP_SGI_40 |
>                                                 IEEE80211_HT_CAP_TX_STBC |
> @@ -2019,9 +2019,9 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
>                 ht_capie.ampdu_params_info = (max_rx_ampdu_factor&0x03);
>
>                 if (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
> -                       ht_capie.ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY&(0x07<<2));
> +                       ht_capie.ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_DENSITY & (0x07 << 2));
>                 else
> -                       ht_capie.ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY&0x00);
> +                       ht_capie.ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
>
>                 rtw_set_ie(out_ie+out_len, _HT_CAPABILITY_IE_,
>                            sizeof(struct ieee80211_ht_cap), (unsigned char *)&ht_capie, pout_len);
> @@ -2072,7 +2072,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
>         p = rtw_get_ie(pie+sizeof(struct ndis_802_11_fixed_ie), _HT_CAPABILITY_IE_, &len, ie_len-sizeof(struct ndis_802_11_fixed_ie));
>         if (p && len > 0) {
>                 pht_capie = (struct ieee80211_ht_cap *)(p+2);
> -               max_ampdu_sz = (pht_capie->ampdu_params_info & IEEE80211_HT_CAP_AMPDU_FACTOR);
> +               max_ampdu_sz = (pht_capie->ampdu_params_info & IEEE80211_HT_AMPDU_PARM_FACTOR);
>                 max_ampdu_sz = 1 << (max_ampdu_sz+3); /*  max_ampdu_sz (kbytes); */
>                 phtpriv->rx_ampdu_maxlen = max_ampdu_sz;
>         }
> diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
> index f4212c4f4ada..0b3fd94cea18 100644
> --- a/drivers/staging/r8188eu/include/wifi.h
> +++ b/drivers/staging/r8188eu/include/wifi.h
> @@ -597,10 +597,6 @@ struct rtw_ieee80211_bar {
>         __le16 start_seq_num;
>  } __packed;
>
> -/* 802.11 BAR control masks */
> -#define IEEE80211_BAR_CTRL_ACK_POLICY_NORMAL     0x0000
> -#define IEEE80211_BAR_CTRL_CBMTID_COMPRESSED_BA  0x0004
> -
>  /**
>   * struct ieee80211_ht_cap - HT additional information
>   *
> @@ -662,52 +658,6 @@ enum ht_cap_ampdu_factor {
>         MAX_AMPDU_FACTOR_64K    = 3,
>  };
>
> -/* 802.11n HT capabilities masks */
> -#define IEEE80211_HT_CAP_SUP_WIDTH             0x0002
> -#define IEEE80211_HT_CAP_SM_PS                 0x000C
> -#define IEEE80211_HT_CAP_GRN_FLD               0x0010
> -#define IEEE80211_HT_CAP_SGI_20                        0x0020
> -#define IEEE80211_HT_CAP_SGI_40                        0x0040
> -#define IEEE80211_HT_CAP_TX_STBC               0x0080
> -#define IEEE80211_HT_CAP_RX_STBC               0x0300
> -#define IEEE80211_HT_CAP_DELAY_BA              0x0400
> -#define IEEE80211_HT_CAP_MAX_AMSDU             0x0800
> -#define IEEE80211_HT_CAP_DSSSCCK40             0x1000
> -/* 802.11n HT capability AMPDU settings */
> -#define IEEE80211_HT_CAP_AMPDU_FACTOR          0x03
> -#define IEEE80211_HT_CAP_AMPDU_DENSITY         0x1C
> -/* 802.11n HT capability MSC set */
> -#define IEEE80211_SUPP_MCS_SET_UEQM            4
> -#define IEEE80211_HT_CAP_MAX_STREAMS           4
> -#define IEEE80211_SUPP_MCS_SET_LEN             10
> -/* maximum streams the spec allows */
> -#define IEEE80211_HT_CAP_MCS_TX_DEFINED                0x01
> -#define IEEE80211_HT_CAP_MCS_TX_RX_DIFF                0x02
> -#define IEEE80211_HT_CAP_MCS_TX_STREAMS                0x0C
> -#define IEEE80211_HT_CAP_MCS_TX_UEQM           0x10
> -/* 802.11n HT IE masks */
> -#define IEEE80211_HT_IE_CHA_SEC_OFFSET         0x03
> -#define IEEE80211_HT_IE_CHA_SEC_NONE           0x00
> -#define IEEE80211_HT_IE_CHA_SEC_ABOVE          0x01
> -#define IEEE80211_HT_IE_CHA_SEC_BELOW          0x03
> -#define IEEE80211_HT_IE_CHA_WIDTH              0x04
> -#define IEEE80211_HT_IE_HT_PROTECTION          0x0003
> -#define IEEE80211_HT_IE_NON_GF_STA_PRSNT       0x0004
> -#define IEEE80211_HT_IE_NON_HT_STA_PRSNT       0x0010
> -
> -/* block-ack parameters */
> -#define IEEE80211_ADDBA_PARAM_POLICY_MASK 0x0002
> -#define IEEE80211_ADDBA_PARAM_TID_MASK 0x003C
> -#define RTW_IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK 0xFFC0
> -#define IEEE80211_DELBA_PARAM_TID_MASK 0xF000
> -#define IEEE80211_DELBA_PARAM_INITIATOR_MASK 0x0800
> -
> -/*
> - * A-PMDU buffer sizes
> - * According to IEEE802.11n spec size varies from 8K to 64K (in powers of 2)
> - */
> -#define IEEE80211_MIN_AMPDU_BUF 0x8
> -
>  /* Spatial Multiplexing Power Save Modes */
>  #define WLAN_HT_CAP_SM_PS_STATIC       0
>  #define WLAN_HT_CAP_SM_PS_DYNAMIC      1
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 38ee41f9d2ba..0f82ed1b4469 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -195,7 +195,7 @@ static char *translate_scan(struct adapter *padapter,
>                 pht_capie = (struct ieee80211_ht_cap *)(p+2);
>                 memcpy(&mcs_rate, pht_capie->mcs.rx_mask, 2);
>                 bw_40MHz = (le16_to_cpu(pht_capie->cap_info) &
> -                           IEEE80211_HT_CAP_SUP_WIDTH) ? 1 : 0;
> +                           IEEE80211_HT_CAP_SUP_WIDTH_20_40) ? 1 : 0;
>                 short_GI = (le16_to_cpu(pht_capie->cap_info) &
>                             (IEEE80211_HT_CAP_SGI_20|IEEE80211_HT_CAP_SGI_40)) ? 1 : 0;
>         }
> --
> 2.32.0
>

Dear Michael,

Constants seem to be correct values still, nice. That said, the other
patches that have come through from others before this prevent this
applying to my copy of staging-testing branch. Assuming Greg takes the
patches in order, this will therefore need reworking. That said, it
builds fine for me when applied directly to fresh staging-testing tip
without the patches that have come in since, so:

Acked-by: Phillip Potter <phil@philpotter.co.uk>

By all means apply that Acked-by to v2 if needed. Many thanks.

Regards,
Phil
