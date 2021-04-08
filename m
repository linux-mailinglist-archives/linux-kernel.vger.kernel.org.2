Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C8E357E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhDHIaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:30:25 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:1753 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhDHIaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:30:23 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AAevAdamIDo+F1C89bdmhHNmfatTpDfIk3DAb?=
 =?us-ascii?q?vn1ZSRFFG/GwusiykJ0guSPcpy0WXBgb9OyoHKWbW3vT+dpU7OAqU4uKZwXttG?=
 =?us-ascii?q?u2IIwK1+KLqAHIITH09eJWyM5bHJRWNduYNzJHsfo=3D?=
X-IronPort-AV: E=Sophos;i="5.82,205,1613430000"; 
   d="scan'208";a="502143081"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 10:30:10 +0200
Date:   Thu, 8 Apr 2021 10:30:09 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mitali Borkar <mitaliborkar810@gmail.com>
cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8712: added spaces around
 '+'
In-Reply-To: <YG690ZIRdCEcjoM6@kali>
Message-ID: <alpine.DEB.2.22.394.2104081027100.3155@hadrien>
References: <YG690ZIRdCEcjoM6@kali>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject line should be in the imperative, so "add" instead of "added".

On Thu, 8 Apr 2021, Mitali Borkar wrote:

> Clean up Check:spaces preferred around that '+' (ctx:VxV)
> Reported by checkpatch

Please try to rephrase to explain what you did and why.  "Clean up" kind
of states what the goal is, but your opinion about what is a clean up
might be different than someone else's.  It's also not necessary to cite
the checkpatch warning exactly.

julia

>
> Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> ---
>  drivers/staging/rtl8712/wlan_bssdef.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8712/wlan_bssdef.h b/drivers/staging/rtl8712/wlan_bssdef.h
> index b54ccaacc527..ec3749813728 100644
> --- a/drivers/staging/rtl8712/wlan_bssdef.h
> +++ b/drivers/staging/rtl8712/wlan_bssdef.h
> @@ -176,7 +176,7 @@ struct NDIS_802_11_WEP {
>  #define MIC_CHECK_TIME	60000000
>
>  #ifndef Ndis802_11APMode
> -#define Ndis802_11APMode (Ndis802_11InfrastructureMax+1)
> +#define Ndis802_11APMode (Ndis802_11InfrastructureMax + 1)
>  #endif
>
>  struct	wlan_network {
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/YG690ZIRdCEcjoM6%40kali.
>
