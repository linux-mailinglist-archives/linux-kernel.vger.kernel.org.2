Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B293F5355
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhHWWWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhHWWWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:22:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC67BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:21:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a5so11044816plh.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PgbvL7tZGMqN04fDtExmC53uM/OuoTpyNovFpG01h4I=;
        b=mrfk22hXw3iD2OUWsdXxuk5BJuJLQ1zikfGhw1rbU2nb8fdvWwNpPsf3sF/QHs87iH
         wm/9XU4v0sV9oZ1SaEiH2iLHsmmLbWdpXuK7SO1kTRwdpJrJcihx8lI5sV2kry9Q/cy2
         hro2P8TOOdwzdLtUcV/H3NzVbSIx+YfVLMfq8zk6IDTTBANlA1odwcPMucqGJLnf6r+2
         XKC3l+eOOgjNs7q0T8B1Hbnc5uuh1d7iuSDgNSdcQIq5f0kYF16TRnNjXHDzRc8MtwdQ
         b59dXUMgD9cp5C06cSmjHDB/uwfa75Ki50MOfuZeJiNJ8fb6C5m8+LTngHvFm7/MxcO7
         fhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgbvL7tZGMqN04fDtExmC53uM/OuoTpyNovFpG01h4I=;
        b=Szq6NhCoRVbo9GktnRg8EEuOS7tOsss4kosoSQjeRCJGNl/9K/d7WmDvPJBpRMH9jJ
         zz+PcHT2pe1SUWAboau7G9d4tr+5LLouRSTGC2LDs4MBBoFLKV6XAkI8Sje3oFHMwpPp
         k3cu6Q4vQwKQSj98Jsj74qBCMuflZDMzHWb/9tWpoOpJfCn8LKioS8ad+ou9SlJvzjA6
         UODsaEtrek/D7o5S43WEIK99WL7rZ45c5IaJTa9fQlhKg8AW3uOZK+4QZP57RfFyr4Q+
         XJvUwPC7jqskUKbR+WE2kgQm9GnlGnpOcegYQGJYEGOfSxWMsyjdxMO+1YjD+5branZM
         4/tw==
X-Gm-Message-State: AOAM533xqp6Swnk1AOM2m181XdmSrUfZ7tqRWuQiJu/pHav1JZxvncME
        ZWtahXR8VI9G7BKRn7aHJijKcbno0unRBGjjSoR8Gg==
X-Google-Smtp-Source: ABdhPJwivijEkTPOuWanRWlCqTFVzEGxja92JdtnMNzJTERT+YaM6O8hzAFMzfmiajkwskVaO4vKkUTfnlzux7LP8sk=
X-Received: by 2002:a17:90b:3748:: with SMTP id ne8mr796003pjb.162.1629757317164;
 Mon, 23 Aug 2021 15:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210823081820.9724-1-straube.linux@gmail.com>
In-Reply-To: <20210823081820.9724-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 23:21:46 +0100
Message-ID: <CAA=Fs0=6=ueb53iNhyjSE5B8CdQvrpijgihAaN9YVwdDgNGiFA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove ip.h header file
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

On Mon, 23 Aug 2021 at 09:19, Michael Straube <straube.linux@gmail.com> wrote:
>
> The struct ip_options declared in ip.h is only unsed in the optlength
> macro which is also defined in ip.h. All other definitions/declarations
> in ip.h are duplicated from <include/uapi/linux/ip.h>. Remove the ip.h
> header file and its includes.
>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c      |   1 -
>  drivers/staging/r8188eu/core/rtw_xmit.c      |   1 -
>  drivers/staging/r8188eu/hal/rtl8188eu_recv.c |   1 -
>  drivers/staging/r8188eu/include/ip.h         | 109 -------------------
>  drivers/staging/r8188eu/os_dep/xmit_linux.c  |   1 -
>  5 files changed, 113 deletions(-)
>  delete mode 100644 drivers/staging/r8188eu/include/ip.h
>
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 52236bae8693..8802f24fec3a 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -7,7 +7,6 @@
>  #include "../include/drv_types.h"
>  #include "../include/recv_osdep.h"
>  #include "../include/mlme_osdep.h"
> -#include "../include/ip.h"
>  #include "../include/if_ether.h"
>  #include "../include/ethernet.h"
>  #include "../include/usb_ops.h"
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index f242f3ffca70..38183fd37b93 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -7,7 +7,6 @@
>  #include "../include/drv_types.h"
>  #include "../include/wifi.h"
>  #include "../include/osdep_intf.h"
> -#include "../include/ip.h"
>  #include "../include/usb_ops.h"
>  #include "../include/usb_osintf.h"
>
> diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
> index a44c9598186c..216a752e6246 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
> @@ -6,7 +6,6 @@
>  #include "../include/drv_types.h"
>  #include "../include/recv_osdep.h"
>  #include "../include/mlme_osdep.h"
> -#include "../include/ip.h"
>  #include "../include/if_ether.h"
>  #include "../include/ethernet.h"
>
> diff --git a/drivers/staging/r8188eu/include/ip.h b/drivers/staging/r8188eu/include/ip.h
> deleted file mode 100644
> index b7388c8c1b8a..000000000000
> --- a/drivers/staging/r8188eu/include/ip.h
> +++ /dev/null
> @@ -1,109 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> -/* Copyright(c) 2007 - 2011 Realtek Corporation. */
> -
> -#ifndef _LINUX_IP_H
> -#define _LINUX_IP_H
> -
> -/* SOL_IP socket options */
> -
> -#define IPTOS_TOS_MASK         0x1E
> -#define IPTOS_TOS(tos)         ((tos)&IPTOS_TOS_MASK)
> -#define        IPTOS_LOWDELAY          0x10
> -#define        IPTOS_THROUGHPUT        0x08
> -#define        IPTOS_RELIABILITY       0x04
> -#define        IPTOS_MINCOST           0x02
> -
> -#define IPTOS_PREC_MASK                0xE0
> -#define IPTOS_PREC(tos)                ((tos)&IPTOS_PREC_MASK)
> -#define IPTOS_PREC_NETCONTROL           0xe0
> -#define IPTOS_PREC_INTERNETCONTROL      0xc0
> -#define IPTOS_PREC_CRITIC_ECP           0xa0
> -#define IPTOS_PREC_FLASHOVERRIDE        0x80
> -#define IPTOS_PREC_FLASH                0x60
> -#define IPTOS_PREC_IMMEDIATE            0x40
> -#define IPTOS_PREC_PRIORITY             0x20
> -#define IPTOS_PREC_ROUTINE              0x00
> -
> -/* IP options */
> -#define IPOPT_COPY             0x80
> -#define IPOPT_CLASS_MASK       0x60
> -#define IPOPT_NUMBER_MASK      0x1f
> -
> -#define        IPOPT_COPIED(o)         ((o)&IPOPT_COPY)
> -#define        IPOPT_CLASS(o)          ((o)&IPOPT_CLASS_MASK)
> -#define        IPOPT_NUMBER(o)         ((o)&IPOPT_NUMBER_MASK)
> -
> -#define        IPOPT_CONTROL           0x00
> -#define        IPOPT_RESERVED1         0x20
> -#define        IPOPT_MEASUREMENT       0x40
> -#define        IPOPT_RESERVED2         0x60
> -
> -#define IPOPT_END      (0 | IPOPT_CONTROL)
> -#define IPOPT_NOOP     (1 | IPOPT_CONTROL)
> -#define IPOPT_SEC      (2 | IPOPT_CONTROL | IPOPT_COPY)
> -#define IPOPT_LSRR     (3 | IPOPT_CONTROL | IPOPT_COPY)
> -#define IPOPT_TIMESTAMP        (4 | IPOPT_MEASUREMENT)
> -#define IPOPT_RR       (7 | IPOPT_CONTROL)
> -#define IPOPT_SID      (8 | IPOPT_CONTROL | IPOPT_COPY)
> -#define IPOPT_SSRR     (9 | IPOPT_CONTROL | IPOPT_COPY)
> -#define IPOPT_RA       (20 | IPOPT_CONTROL | IPOPT_COPY)
> -
> -#define IPVERSION      4
> -#define MAXTTL         255
> -#define IPDEFTTL       64
> -#define IPOPT_OPTVAL 0
> -#define IPOPT_OLEN   1
> -#define IPOPT_OFFSET 2
> -#define IPOPT_MINOFF 4
> -#define MAX_IPOPTLEN 40
> -#define IPOPT_NOP IPOPT_NOOP
> -#define IPOPT_EOL IPOPT_END
> -#define IPOPT_TS  IPOPT_TIMESTAMP
> -
> -#define        IPOPT_TS_TSONLY         0       /* timestamps only */
> -#define        IPOPT_TS_TSANDADDR      1       /* timestamps and addresses */
> -#define        IPOPT_TS_PRESPEC        3       /* specified modules only */
> -
> -struct ip_options {
> -       __u32           faddr;                  /* Saved first hop address */
> -       unsigned char   optlen;
> -       unsigned char srr;
> -       unsigned char rr;
> -       unsigned char ts;
> -       unsigned char   is_setbyuser:1, /* Set by setsockopt?           */
> -                       is_data:1,      /* Options in __data, rather than skb*/
> -                       is_strictroute:1,/* Strict source route         */
> -                       srr_is_hit:1,   /* Packet destn addr was ours */
> -                       is_changed:1,   /* IP checksum more not valid   */
> -                       rr_needaddr:1,  /* Need to record addr of out dev*/
> -                       ts_needtime:1,  /* Need to record timestamp     */
> -                       ts_needaddr:1;  /* Need to record addr of out dev  */
> -       unsigned char router_alert;
> -       unsigned char __pad1;
> -       unsigned char __pad2;
> -       unsigned char __data[0];
> -};
> -
> -#define optlength(opt) (sizeof(struct ip_options) + opt->optlen)
> -
> -struct iphdr {
> -#if defined(__LITTLE_ENDIAN_BITFIELD)
> -       __u8    ihl:4,
> -               version:4;
> -#elif defined(__BIG_ENDIAN_BITFIELD)
> -       __u8    version:4,
> -               ihl:4;
> -#endif
> -       __u8    tos;
> -       __u16   tot_len;
> -       __u16   id;
> -       __u16   frag_off;
> -       __u8    ttl;
> -       __u8    protocol;
> -       __u16   check;
> -       __u32   saddr;
> -       __u32   daddr;
> -       /*The options start here. */
> -};
> -
> -#endif /* _LINUX_IP_H */
> diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> index 60e0eea7ad84..80546a886c0e 100644
> --- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> @@ -6,7 +6,6 @@
>  #include "../include/osdep_service.h"
>  #include "../include/drv_types.h"
>  #include "../include/if_ether.h"
> -#include "../include/ip.h"
>  #include "../include/wifi.h"
>  #include "../include/mlme_osdep.h"
>  #include "../include/xmit_osdep.h"
> --
> 2.32.0
>

Dear Michael,

Thanks for the patch. Sorry, but it seems to conflict with your
earlier patch titled: "[PATCH] staging: r8188eu: remove if_ether.h
header file". They apply fine individually, but not together - can you
confirm this is the case for you as well and not just me?

Regards,
Phil
