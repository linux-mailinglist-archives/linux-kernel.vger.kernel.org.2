Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27C735081A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhCaUR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:17:58 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:40264 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236529AbhCaURY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:17:24 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ASC6Gq6Dx/0pOM+TlHei9sceALOonbusQ8zAX?=
 =?us-ascii?q?/mp2TgFYddHdqtC2kJ0gpGLJoRsyeFVlo9CPP6GcXWjRnKQf3aA9NaqvNTOGhE?=
 =?us-ascii?q?KGII1u5oPpwXnBNkTFh4hg/Ih6dawWMrHNJH17l9u/wCTQKadY/PCj8Lq0wdvY?=
 =?us-ascii?q?1WtnVwtwa6pthj0JcTqzN01tWU17AoAkH4CX/cpNq36Yf24LB/7LfEUte8jmi5?=
 =?us-ascii?q?n1mIn9YRgAbiRXlDWmqT+z8rb1H1y5834lMw9n+rsp/WjbnwGR3MzK2c2T8RPE?=
 =?us-ascii?q?0n+W0pI+orTc4+FeD8+BgNV9EFjRozuvDb4OZ5Sy+Bg+quey70s2gMDByi1QR/?=
 =?us-ascii?q?hb2jf6dmWtqRvi3GDboVQTwk6n7XXdvWHuuqXCNVUHIvsEoYpYdxfDgnBQ3+1U?=
 =?us-ascii?q?4eZx03uerIcSJRjdhiiV3amtazha0kC9pWMrkeAVj3E3a/p6VINs?=
X-IronPort-AV: E=Sophos;i="5.81,293,1610406000"; 
   d="scan'208";a="500982150"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 22:17:23 +0200
Date:   Wed, 31 Mar 2021 22:17:23 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deborah Brouwer <deborahbrouwer3563@gmail.com>
cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 1/3] staging: rtl8723bs: core: fix
 repeated word warning
In-Reply-To: <14c1a1f1f0a34fb821d47ddab6e7e63800ec2736.1617221075.git.deborahbrouwer3563@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2103312215430.3008@hadrien>
References: <cover.1617221075.git.deborahbrouwer3563@gmail.com> <14c1a1f1f0a34fb821d47ddab6e7e63800ec2736.1617221075.git.deborahbrouwer3563@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Mar 2021, Deborah Brouwer wrote:

> Fix checkpatch warning:
> WARNING: Possible repeated word: 'very'

This is a simple but clear example of how "Fix" doesn't help one
understand the patch.  In reading the log message, one would probably
assume that you removed the repetition, but actually you added a comma.
So it would be better to explain what you did and why.  It's good to
acknowledge checkpatch, but the text of the warning message is not that
useful.

julia

>
> Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index 2daf5c461a4d..3878caf0b56c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -1700,7 +1700,7 @@ Calling context:
>  If we turn on USE_RXTHREAD, then, no need for critical section.
>  Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
>
> -Must be very very cautious...
> +Must be very, very cautious...
>
>  */
>  struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pfree_xmit_queue) */
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/14c1a1f1f0a34fb821d47ddab6e7e63800ec2736.1617221075.git.deborahbrouwer3563%40gmail.com.
>
