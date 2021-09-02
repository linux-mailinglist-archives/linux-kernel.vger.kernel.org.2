Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B223FEB30
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245540AbhIBJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245139AbhIBJ2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:28:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3763661058;
        Thu,  2 Sep 2021 09:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630574837;
        bh=82jAsd5ucM4y4MfsjWEHLTMjJeY6MKU7mDhIATERYzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEKzGXZwed3XPdNAWIPWXqC5ejyCuopnYb1hCpYo979o9HHDgV56+TJ5iDQZe56t6
         OO2nptiFU3LQjnyUTzdzfVmOqz1ptMHVm5h/LQaQH99U1w2dNGZUPWdWiKVrhfFRKF
         yzkeMXoMAmL6FrQf0f8sYKZj0dSSi/okAgx4o22A=
Date:   Thu, 2 Sep 2021 11:27:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] staging: r8188eu: incorrect type in
 csum_ipv6_magic
Message-ID: <YTCY81DGMM2+bSHN@kroah.com>
References: <cover.1630148641.git.aakashhemadri123@gmail.com>
 <0b7d6e92c79a6daf55a0c3a4961df6f33a9bcf37.1630148641.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7d6e92c79a6daf55a0c3a4961df6f33a9bcf37.1630148641.git.aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 04:40:45PM +0530, Aakash Hemadri wrote:
> Fix sparse warning:
> > rtw_br_ext.c:771:84:    got restricted __be16 [usertype] payload_len
> > rtw_br_ext.c:773:110: warning: incorrect type in argument 2
>     (different base types)
> > rtw_br_ext.c:773:110:    expected int len
> > rtw_br_ext.c:773:110:    got restricted __be16 [usertype] payload_len
> 
> csum_ipv6_magic and csum_partial expect int len not __be16, use
> be16_to_cpu()
> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index aa56cd1a8490..38f1bd591da9 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -615,9 +615,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  						struct icmp6hdr  *hdr = (struct icmp6hdr *)(skb->data + ETH_HLEN + sizeof(*iph));
>  						hdr->icmp6_cksum = 0;
>  						hdr->icmp6_cksum = csum_ipv6_magic(&iph->saddr, &iph->daddr,
> -										iph->payload_len,
> +										be16_to_cpu(iph->payload_len),
>  										IPPROTO_ICMPV6,
> -										csum_partial((__u8 *)hdr, iph->payload_len, 0));
> +										csum_partial((__u8 *)hdr, be16_to_cpu(iph->payload_len), 0));
>  					}
>  				}
>  			}
> -- 
> 2.32.0
> 

Same question here, does this mean the driver is broken on little-endian
systems today?  This should be tested...

thanks,

greg k-h
