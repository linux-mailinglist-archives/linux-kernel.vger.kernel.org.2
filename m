Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6315D34FE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhCaK2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234666AbhCaK1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:27:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4905561990;
        Wed, 31 Mar 2021 10:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617186475;
        bh=POFYW6ppDl60/r0ymeE58Xy5GnEKMtFjnA12DkmNL8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svM+D3ItRTMZDPtZxLQMP+I8VJL2SsL2vaqprNxSyY/g6Z8jIzzExydBlrxjdWxyU
         9c9H69TbJUIjHapcw+5QFb6pGMJ1WPKMYwyfeZozGFijnfdSCkkCm9qmHbIXxDzDFs
         F+S2k+hTNuEdVnjLkV1Rt+yacBvp9OvcDlBIO+s0=
Date:   Wed, 31 Mar 2021 12:27:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH -next] staging: rtl8723bs: os_dep: remove unused variable
 'ret'
Message-ID: <YGROp83Mnf8hGjY4@kroah.com>
References: <20210331094247.2169606-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210331094247.2169606-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 05:42:47PM +0800, Yang Yingliang wrote:
> GCC reports the following warning with W=1:
> 
> drivers/staging/rtl8723bs/os_dep/recv_linux.c:101:6: warning:
>  variable ‘ret’ set but not used [-Wunused-but-set-variable]
>   101 |  int ret;
>       |      ^~~
> 
> This variable is not used in function , this commit
> remove it to fix the warning.
> 
> Fixes: de69e2b3f105 ("staging: rtl8723bs: remove DBG_COUNTER calls from os_dep/recv_linux.c")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/recv_linux.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
> index fbdbcd04d44a..f6a9482be8e3 100644
> --- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
> @@ -98,7 +98,6 @@ struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_L
>  void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib)
>  {
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> -	int ret;
>  
>  	/* Indicate the packets to upper layer */
>  	if (pkt) {
> @@ -140,7 +139,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, str
>  
>  		pkt->ip_summed = CHECKSUM_NONE;
>  
> -		ret = rtw_netif_rx(padapter->pnetdev, pkt);
> +		rtw_netif_rx(padapter->pnetdev, pkt);

Why not handle the result of this call properly?

