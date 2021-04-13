Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E735E275
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbhDMPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:16:39 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:2237 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhDMPQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:16:38 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ad3T76KCOq5atsSjlHei9sceALOonbusQ8zAX?=
 =?us-ascii?q?/mp2TgFYddHdqtC2kJ0gpGLJoRsyeFVlo9CPP6GcXWjRnKQf3aA9NaqvNTOGhE?=
 =?us-ascii?q?KGII1u5oPpwXnBNkTFh4hg/Ih6dawWMrHNJH17l9u/wCTQKadY/PCj8Lq0wdvY?=
 =?us-ascii?q?1WtnVwtwa6pthj0JcTqzN01tWU17AoAkH4CX/cpNq36Yf24LB/7LfEUte8jmi5?=
 =?us-ascii?q?n1mIn9YRgAbiRXlDWmqT+z8rb1H1y5834lMw9n+rsp/WjbnwGR3MzK2c2T8RPE?=
 =?us-ascii?q?0n+W0pI+orTc4+FeD8+BgNV9EFjRozuvDb4OZ5Sy+Bg+quey70s2gMDByi1QR/?=
 =?us-ascii?q?hb2jf6dmWtqRvi3GDboVQTwk6n7XXdvWHuuqXCNVUHIvsEoYpYdxfDgnBQ3+1U?=
 =?us-ascii?q?4eZx03uerIcSJRjdhiiV3amtazha0kC9pWMrkeAVj3E3a/p6VINs?=
X-IronPort-AV: E=Sophos;i="5.82,219,1613430000"; 
   d="scan'208";a="503037566"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 17:16:18 +0200
Date:   Tue, 13 Apr 2021 17:16:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: core: Remove
 unused but set variable
In-Reply-To: <20210413150517.12533-1-fmdefrancesco@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2104131715560.8430@hadrien>
References: <20210413150517.12533-1-fmdefrancesco@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:

> Removed "ledBlink_param" because it was set to the value of "pbuf" but was
> never reused. This set was made by direct assignment (no helper had been
> called), therefore it had no side effect to the location pointed by "pbuf".
>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index f19a15a3924b..440e22922106 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -6191,12 +6191,10 @@ u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf)
>
>  u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf)
>  {
> -	struct LedBlink_param *ledBlink_param;
>
>  	if (!pbuf)
>  		return H2C_PARAMETERS_ERROR;
>
> -	ledBlink_param = (struct LedBlink_param *)pbuf;
>  	return	H2C_SUCCESS;
>  }

Is this function actually useful?

julia
