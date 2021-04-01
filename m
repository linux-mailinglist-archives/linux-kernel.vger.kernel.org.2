Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325A2352166
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhDAVQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:16:07 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:38738 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234406AbhDAVQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:16:05 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AhvtUpagYSEDpkH6znjKDNKNDPHBQX4lx3DAb?=
 =?us-ascii?q?vn1ZSRFFG/Gwv9yynfgdyB//gCsQXnZlotybJKycWxrnmKJdy48XILukQU3ao2?=
 =?us-ascii?q?OuNo5v9s/PxDfnFi34+IdmpMBdWoJ5D8D9CkU/sNbi7GCDYrId6fSO7azAv5a9?=
 =?us-ascii?q?815DVgdvApsB0y5cKiK2VnJ7XxNHA51RLvuhz+5KvSCpd3hSTunTPAh9Y8H5q9?=
 =?us-ascii?q?fGlI3rbHc9bnZNgmbhsRqS5LT3EweV01Mlahwn+9sf2FPIjhDj4eGbu+y7oyWs?=
 =?us-ascii?q?sVP71Yhcm9fq17J4damxo/USQw+c6TqAVcBMfYSroS0voOqy9VomtNXXuR8vM6?=
 =?us-ascii?q?1ImgjsV1Dwjh331wb61jEyr1fk1F+DmHPm5ff0XTQgFqN69PJkWyqcz3BlkMB3?=
 =?us-ascii?q?0apN0W7cnYFQFwn4hyj458LFTVVDkVe1u2MrlaoohXRZe40YdbNBsOUkjQ1oOa?=
 =?us-ascii?q?ZFOBi/xJEsEeFoAs2Zzu1Ra0midHzcvnNi2piFQmkzNg3ueDlMhuWllxxt2Fxp?=
 =?us-ascii?q?xUoRw8IS2l0a8ogmcoJJ4+TfPr4tvK1ST/URcbl2CI46MIeKI12IZSiJHHOZIF?=
 =?us-ascii?q?zhGq1CEWnKsYTP+7kw5PunYtgv15s9mJPIVXlctWI0ZmLWIcCCx5FQ6Hn2MS+A?=
 =?us-ascii?q?dAWo7vsby4lyu7X6SrauGzaEUkoWiMelo+8SGInjQPC4NIhND/KmBnurOoBUxA?=
 =?us-ascii?q?r3XplUJxAlIY0ok+d+f2jLjtPAK4XsuOCeWu3UPqDVCjohWnnyGD84dh2bHrQA?=
 =?us-ascii?q?0mmbHlvDxDTBUXLkfULyubhqFrLBxvMezIgWOpcJjxMcjk6h4NqXFCZLvaM3dn?=
 =?us-ascii?q?ZvOb+PqNL3mUCGuULzq0l5MBtUCUhYpJ/6VWlRmAMMO0ToNZ4eptS2YwlprTK6?=
 =?us-ascii?q?Dy46a/mTPB9Uplxx967yBYeX3zoeB9WuNX/fp2cPpUiNU4wXlsS4lLHYU6J9Kq?=
 =?us-ascii?q?xjdL16FA3NGRAwsx1tsn1/ZAgNQVKaOSjpjYmjkZwIFMDSf9Rxm26QUIZpgEOa?=
 =?us-ascii?q?kX/ZidAkR3MdUTLre9WQmxwSSz1dgUA006J3usv1pR+fbU8ExMgoOlxFb2qaRJ?=
 =?us-ascii?q?hcCh6eWYlSkrf3PCZ9UHmNnj7frx0oYGLl+wEziwXaXFipUMCOJmAYlmFT067s?=
 =?us-ascii?q?/l8xXH6aZVhMZndztpA4M3/HtHZ12eqifbGyzGOVV1sHzogmQUP4SApXBjkr68?=
 =?us-ascii?q?G81RaTljrHP24h3I8SMuvUC6lmVarS1HOrIIihiLwcH/RJ4ZppCdzouugXe+SZ?=
 =?us-ascii?q?fAOeMTP+BcMxsjbl0UoNCW1Rkj0JgPno0Brq4CyEx3Y5G+PVO0kjbaocOcug42?=
 =?us-ascii?q?/tQOuo3J11gckuh/a5Nnz8Z7e9uOrqRg8GDimWh2G4T+sl888J+Y0zsaZ+BJnd?=
 =?us-ascii?q?X3/j0mpd0BA3Mcfzkwc/Tc1Akc38E74qW/ZXXSRTumcNvpCoCmAAtwTtGO8wfV?=
 =?us-ascii?q?03lRbgTqy0youNjYBqO1GLoQv7BEKW/CJc9crURifr789hN4sAZUBtLHUm4Hts?=
 =?us-ascii?q?/Om+Z5TdJQWjeeZE5ke7OBaGAcNgYZnAPbUbtRBh5d6U28eRairjwQjV1AELXJ?=
 =?us-ascii?q?5mwiKCQcmoBhiLFvMN29umOU6Uiq/vxMKolj/4RX+abEsf7Lc1BHA4X4BkkTcr?=
 =?us-ascii?q?i40l2jWzTKvXrkopn0BF2CpqjFL3xYSqiV2rXn1uAEn+mZVZXT5aN1CSlsTb+e?=
 =?us-ascii?q?2k1HDwiQI1oaXrJQN3ZdFBG98ZU47tCTxhQPJgz4KVww=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,296,1610406000"; 
   d="scan'208";a="501210527"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 23:16:04 +0200
Date:   Thu, 1 Apr 2021 23:16:03 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: emxx_udc: Ending line with
 argument
In-Reply-To: <20210401195457.24512-1-martinsdecarvalhobeatriz@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2104012314480.2908@hadrien>
References: <20210401195457.24512-1-martinsdecarvalhobeatriz@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Apr 2021, Beatriz Martins de Carvalho wrote:

> Cleans up check of "Lines should not end with a '('"
> with argument present in next line in file emxx_udc.c

The coding style documentation encourages remaining within 80 characters.
I'm not sure that the ( warning is worth increading the excess beyond 80
characters (or introducing it in the last case).

julia

>
> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index 741147a4f0fe..20f53cf6e20f 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -1073,9 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
>  		i_word_length = length / sizeof(u32);
>  		if (i_word_length > 0) {
>  			for (i = 0; i < i_word_length; i++) {
> -				_nbu2ss_writel(
> -					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
> -					p_buf_32->dw);
> +				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
> +					       p_buf_32->dw);
>
>  				p_buf_32++;
>  			}
> @@ -1225,8 +1224,7 @@ static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
>  		return;
>
>  	if (ep->epnum > 0) {
> -		length = _nbu2ss_readl(
> -			&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
> +		length = _nbu2ss_readl(&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
>
>  		length &= EPN_LDATA;
>  		if (length < ep->ep.maxpacket)
> @@ -1462,8 +1460,7 @@ static void _nbu2ss_epn_set_stall(struct nbu2ss_udc *udc,
>  		for (limit_cnt = 0
>  			; limit_cnt < IN_DATA_EMPTY_COUNT
>  			; limit_cnt++) {
> -			regdata = _nbu2ss_readl(
> -				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
> +			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
>
>  			if ((regdata & EPN_IN_DATA) == 0)
>  				break;
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20210401195457.24512-1-martinsdecarvalhobeatriz%40gmail.com.
>
