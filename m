Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000A43507F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhCaUPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:15:47 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:40150 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236341AbhCaUPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:15:14 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ADZrJb6A/ejYtlaLlHela55DYdL4zR+YMi2QD?=
 =?us-ascii?q?/UZ3VBBTb4ikh9mj9c5rtyPcpT4NVBgb6LS9EYaaR3e0z/9IyK0wGZvnYwX8om?=
 =?us-ascii?q?uvK+hZnOjf6hntATf3+OIY9aoISdkaNPTKAVJ3jdn37WCDer5KquWvy6ywgPeb?=
 =?us-ascii?q?8nEFd2FXQpt95AR0ABvzKCFLbTRBbKBVKLOsou5Opz+tYh0sAPiTNz09ftGGgc?=
 =?us-ascii?q?bKmpLgaQMHABBi0gOUjSq0gYSULySl?=
X-IronPort-AV: E=Sophos;i="5.81,293,1610406000"; 
   d="scan'208";a="500981972"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 22:15:13 +0200
Date:   Wed, 31 Mar 2021 22:15:13 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deborah Brouwer <deborahbrouwer3563@gmail.com>
cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 2/3] staging: rtl8723bs: core: fix
 block comment warning
In-Reply-To: <5ff15315036be9bdf2059bab2ddd00f7dce0d20a.1617221075.git.deborahbrouwer3563@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2103312213050.3008@hadrien>
References: <cover.1617221075.git.deborahbrouwer3563@gmail.com> <5ff15315036be9bdf2059bab2ddd00f7dce0d20a.1617221075.git.deborahbrouwer3563@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Mar 2021, Deborah Brouwer wrote:

> Fix checkpatch warning:
> WARNING: Block comments use * on subsequent lines

Try to find some way to express what you are doing without using Fix.
It's pretty obvious that a patch fixes something, so the work Fix is not
very useful.  What is your fix and why have you chosen to do that?
Something like the following would be more informative.

Add *s at the begiinning of each line in a block comment to conform to the
Linux kernel coding style.  Issue detected using checkpatch.

julia

>
> Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_xmit.c | 59 +++++++++++------------
>  1 file changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index 3878caf0b56c..428c71ce0334 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -46,8 +46,8 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  	init_completion(&pxmitpriv->terminate_xmitthread_comp);
>
>  	/*
> -	Please insert all the queue initializaiton using _rtw_init_queue below
> -	*/
> +	 * Please insert all the queue initializaiton using _rtw_init_queue below
> +	 */
>
>  	pxmitpriv->adapter = padapter;
>
> @@ -60,10 +60,10 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  	_rtw_init_queue(&pxmitpriv->free_xmit_queue);
>
>  	/*
> -	Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
> -	and initialize free_xmit_frame below.
> -	Please also apply  free_txobj to link_up all the xmit_frames...
> -	*/
> +	 * Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
> +	 * and initialize free_xmit_frame below.
> +	 * Please also apply  free_txobj to link_up all the xmit_frames...
> +	 */
>
>  	pxmitpriv->pallocated_frame_buf = vzalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4);
>
> @@ -1069,17 +1069,15 @@ u32 rtw_calculate_wlan_pkt_size_by_attribue(struct pkt_attrib *pattrib)
>  }
>
>  /*
> -
> -This sub-routine will perform all the following:
> -
> -1. remove 802.3 header.
> -2. create wlan_header, based on the info in pxmitframe
> -3. append sta's iv/ext-iv
> -4. append LLC
> -5. move frag chunk from pframe to pxmitframe->mem
> -6. apply sw-encrypt, if necessary.
> -
> -*/
> + * This sub-routine will perform all the following:
> + *
> + * 1. remove 802.3 header.
> + * 2. create wlan_header, based on the info in pxmitframe
> + * 3. append sta's iv/ext-iv
> + * 4. append LLC
> + * 5. move frag chunk from pframe to pxmitframe->mem
> + * 6. apply sw-encrypt, if necessary.
> + */
>  s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct xmit_frame *pxmitframe)
>  {
>  	struct pkt_file pktfile;
> @@ -1693,23 +1691,22 @@ static void rtw_init_xmitframe(struct xmit_frame *pxframe)
>  }
>
>  /*
> -Calling context:
> -1. OS_TXENTRY
> -2. RXENTRY (rx_thread or RX_ISR/RX_CallBack)
> -
> -If we turn on USE_RXTHREAD, then, no need for critical section.
> -Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
> -
> -Must be very, very cautious...
> -
> -*/
> + * Calling context:
> + * 1. OS_TXENTRY
> + * 2. RXENTRY (rx_thread or RX_ISR/RX_CallBack)
> + *
> + * If we turn on USE_RXTHREAD, then, no need for critical section.
> + * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
> + *
> + * Must be very, very cautious...
> + */
>  struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pfree_xmit_queue) */
>  {
>  	/*
> -		Please remember to use all the osdep_service api,
> -		and lock/unlock or _enter/_exit critical to protect
> -		pfree_xmit_queue
> -	*/
> +	 *	Please remember to use all the osdep_service api,
> +	 *	and lock/unlock or _enter/_exit critical to protect
> +	 *	pfree_xmit_queue
> +	 */
>
>  	struct xmit_frame *pxframe = NULL;
>  	struct list_head *plist, *phead;
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/5ff15315036be9bdf2059bab2ddd00f7dce0d20a.1617221075.git.deborahbrouwer3563%40gmail.com.
>
