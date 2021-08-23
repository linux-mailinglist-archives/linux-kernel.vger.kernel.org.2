Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BBD3F5346
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhHWWR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhHWWRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:17:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:16:42 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y23so17928885pgi.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdZ4iTZddD0m4zP0OFHw2AjBxwujDC+cUAXvIR0buvQ=;
        b=eid8AbvNQVuxiKNXH1Jo1fBPAdWrxVTEAeRz6jqmcTi7NwrHR/jDd9hTSS8XdFnCHz
         Mm5OMIH2rEVUVJkPny/y2DNUWx+g6pJrrhDVyq35I7jqDUeZ8PyvejAj5d1//+3FinL3
         +4a0jb5nAWBl/xesZIli0mOhTV10H5Ws6WxwchwYpJnr3gkqpf8SdUOaqJ3hFmUPBjdW
         klKwXyEeFSjNoineiyUu6FHO9ayNsnNJGLG20JzJNJCwmyfGq+0fUsZMCBIn78hkDIuS
         kFzqjTUK1DEuB9TYVD0KpptPEeuzCJsj6g8rkfdNrptCCg9ynmplWBynJIoZX7DdVn7q
         kKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdZ4iTZddD0m4zP0OFHw2AjBxwujDC+cUAXvIR0buvQ=;
        b=UfafdLrLJEV37zaZscINKEQoA2QcLzgtQJ+Rc48dey9p050PrcjZbWF73ZTPDiLw9d
         86sJR1lCgKFcyyk47Zzsra/rdZLJ4CM/I4SIVVl+3ofME1nXNaP7Qb4SEzdyklsKIH+5
         LKlJqtg5v54sag0T1pPiPeeVs8IOBJgnNXsvCLxWx9nY8tgaoR7tXvRSjdmr+8cK95QR
         av5kjBZw/7YStymupjIJ9O9H7csOcfOy6kd9iEodS3KKIoEZOaphP7ePk/TuylifPZsc
         JwIWxKePnX0NzoxAtJJJyV3X9k43pZDrMeORsleeVg7wBEF5petd63ypNG3eoaJp4RwN
         jeNg==
X-Gm-Message-State: AOAM530rjw62RbO9HQTyF9yc9/gm3hCMA+AXNHsNeJrOxWJKBNaERBa3
        2houimSzbMO4KyOMz8Z+hyd6yPnikiZ0LUeTq8qe8w==
X-Google-Smtp-Source: ABdhPJxmyiNryWe3X58BfyB/SAc46dpLt8kCD8DLteyRC3k+Qk/Hfz71Z6hLrMN/IWdHb3uLlet5Ytys/TBtR9Zs7K4=
X-Received: by 2002:a05:6a00:1ac7:b0:3e2:2d05:3b31 with SMTP id
 f7-20020a056a001ac700b003e22d053b31mr36363584pfv.2.1629757001920; Mon, 23 Aug
 2021 15:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210822164435.16266-1-straube.linux@gmail.com>
In-Reply-To: <20210822164435.16266-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 23:16:31 +0100
Message-ID: <CAA=Fs0=p_wDV7Ag_pOVv1AweXSLYMMands5XihnLOU8oSQA-MA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove if_ether.h header file
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

On Sun, 22 Aug 2021 at 17:45, Michael Straube <straube.linux@gmail.com> wrote:
>
> All constants, declarations and macros in if_ether.h are either
> duplicated from <uapi/linux/if_ether.h> or unused. Remove the file
> if_ether.h and its includes.
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c      |  1 -
>  drivers/staging/r8188eu/hal/rtl8188eu_recv.c |  1 -
>  drivers/staging/r8188eu/include/if_ether.h   | 94 --------------------
>  drivers/staging/r8188eu/os_dep/xmit_linux.c  |  1 -
>  4 files changed, 97 deletions(-)
>  delete mode 100644 drivers/staging/r8188eu/include/if_ether.h
>
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 52236bae8693..08066c9587f9 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -8,7 +8,6 @@
>  #include "../include/recv_osdep.h"
>  #include "../include/mlme_osdep.h"
>  #include "../include/ip.h"
> -#include "../include/if_ether.h"
>  #include "../include/ethernet.h"
>  #include "../include/usb_ops.h"
>  #include "../include/wifi.h"
> diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
> index a44c9598186c..3a2c7090cd7b 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
> @@ -7,7 +7,6 @@
>  #include "../include/recv_osdep.h"
>  #include "../include/mlme_osdep.h"
>  #include "../include/ip.h"
> -#include "../include/if_ether.h"
>  #include "../include/ethernet.h"
>
>  #include "../include/usb_ops.h"
> diff --git a/drivers/staging/r8188eu/include/if_ether.h b/drivers/staging/r8188eu/include/if_ether.h
> deleted file mode 100644
> index 5bb79fddeec6..000000000000
> --- a/drivers/staging/r8188eu/include/if_ether.h
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> -/* Copyright(c) 2007 - 2011 Realtek Corporation. */
> -
> -#ifndef _LINUX_IF_ETHER_H
> -#define _LINUX_IF_ETHER_H
> -
> -/*
> - *     IEEE 802.3 Ethernet magic constants.  The frame sizes omit the preamble
> - *     and FCS/CRC (frame check sequence).
> - */
> -
> -#define ETH_ALEN       6               /* Octets in one ethernet addr   */
> -#define ETH_HLEN       14              /* Total octets in header.       */
> -#define ETH_ZLEN       60              /* Min. octets in frame sans FCS */
> -#define ETH_DATA_LEN   1500            /* Max. octets in payload        */
> -#define ETH_FRAME_LEN  1514            /* Max. octets in frame sans FCS */
> -
> -/*
> - *     These are the defined Ethernet Protocol ID's.
> - */
> -
> -#define ETH_P_LOOP     0x0060          /* Ethernet Loopback packet     */
> -#define ETH_P_PUP      0x0200          /* Xerox PUP packet             */
> -#define ETH_P_PUPAT    0x0201          /* Xerox PUP Addr Trans packet  */
> -#define ETH_P_IP       0x0800          /* Internet Protocol packet     */
> -#define ETH_P_X25      0x0805          /* CCITT X.25                   */
> -#define ETH_P_ARP      0x0806          /* Address Resolution packet    */
> -#define        ETH_P_BPQ       0x08FF          /* G8BPQ AX.25 Ethernet Packet  */
> -#define ETH_P_IEEEPUP  0x0a00          /* Xerox IEEE802.3 PUP packet   */
> -#define ETH_P_IEEEPUPAT        0x0a01          /* Xerox IEEE802.3 PUP          */
> -#define ETH_P_DEC       0x6000          /* DEC Assigned proto           */
> -#define ETH_P_DNA_DL    0x6001          /* DEC DNA Dump/Load            */
> -#define ETH_P_DNA_RC    0x6002          /* DEC DNA Remote Console       */
> -#define ETH_P_DNA_RT    0x6003          /* DEC DNA Routing              */
> -#define ETH_P_LAT       0x6004          /* DEC LAT                      */
> -#define ETH_P_DIAG      0x6005          /* DEC Diagnostics              */
> -#define ETH_P_CUST      0x6006          /* DEC Customer use             */
> -#define ETH_P_SCA       0x6007          /* DEC Systems Comms Arch       */
> -#define ETH_P_RARP      0x8035         /* Reverse Addr Res packet      */
> -#define ETH_P_ATALK    0x809B          /* Appletalk DDP                */
> -#define ETH_P_AARP     0x80F3          /* Appletalk AARP               */
> -#define ETH_P_8021Q    0x8100          /* 802.1Q VLAN Extended Header  */
> -#define ETH_P_IPX      0x8137          /* IPX over DIX                 */
> -#define ETH_P_IPV6     0x86DD          /* IPv6 over bluebook           */
> -#define ETH_P_PPP_DISC 0x8863          /* PPPoE discovery messages     */
> -#define ETH_P_PPP_SES  0x8864          /* PPPoE session messages       */
> -#define ETH_P_ATMMPOA  0x884c          /* MultiProtocol Over ATM       */
> -#define ETH_P_ATMFATE  0x8884          /* Frame-based ATM Transport
> -                                        * over Ethernet
> -                                        */
> -
> -/*
> - *     Non DIX types. Won't clash for 1500 types.
> - */
> -
> -#define ETH_P_802_3    0x0001          /* Dummy type for 802.3 frames  */
> -#define ETH_P_AX25     0x0002          /* Dummy protocol id for AX.25  */
> -#define ETH_P_ALL      0x0003          /* Every packet (be careful!!!) */
> -#define ETH_P_802_2    0x0004          /* 802.2 frames                 */
> -#define ETH_P_SNAP     0x0005          /* Internal only                */
> -#define ETH_P_DDCMP     0x0006          /* DEC DDCMP: Internal only     */
> -#define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN PPP frames*/
> -#define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP MP frames */
> -#define ETH_P_LOCALTALK 0x0009         /* Localtalk pseudo type        */
> -#define ETH_P_PPPTALK  0x0010          /* Dummy type for Atalk over PPP*/
> -#define ETH_P_TR_802_2 0x0011          /* 802.2 frames                 */
> -#define ETH_P_MOBITEX  0x0015          /* Mobitex (kaz@cafe.net)       */
> -#define ETH_P_CONTROL  0x0016          /* Card specific control frames */
> -#define ETH_P_IRDA     0x0017          /* Linux-IrDA                   */
> -#define ETH_P_ECONET   0x0018          /* Acorn Econet                 */
> -
> -/*
> - *     This is an Ethernet frame header.
> - */
> -
> -struct ethhdr {
> -       unsigned char   h_dest[ETH_ALEN];       /* destination eth addr */
> -       unsigned char   h_source[ETH_ALEN];     /* source ether addr    */
> -       unsigned short  h_proto;                /* packet type ID field */
> -};
> -
> -struct _vlan {
> -       unsigned short       h_vlan_TCI;        /*  Encap prio and VLAN ID */
> -       unsigned short       h_vlan_encapsulated_proto;
> -};
> -
> -#define get_vlan_id(pvlan)                             \
> -       ((ntohs((unsigned short)pvlan->h_vlan_TCI)) & 0xfff)
> -#define get_vlan_priority(pvlan)                       \
> -       ((ntohs((unsigned short)pvlan->h_vlan_TCI))>>13)
> -#define get_vlan_encap_proto(pvlan)                    \
> -        (ntohs((unsigned short)pvlan->h_vlan_encapsulated_proto))
> -
> -#endif /* _LINUX_IF_ETHER_H */
> diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> index 60e0eea7ad84..d35e92c17a5e 100644
> --- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> @@ -5,7 +5,6 @@
>
>  #include "../include/osdep_service.h"
>  #include "../include/drv_types.h"
> -#include "../include/if_ether.h"
>  #include "../include/ip.h"
>  #include "../include/wifi.h"
>  #include "../include/mlme_osdep.h"
> --
> 2.32.0
>

Built and runtime tested, thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
