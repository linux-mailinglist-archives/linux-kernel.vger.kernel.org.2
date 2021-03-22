Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69F344FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhCVTfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhCVTfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:35:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31013C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ce+cxML95gmvysKXkYfHlGleyoW+MCtHlOL2pSJGm8s=; b=i8rwMiMrXDPvjAsZXt0vi6tFYu
        Q1ecQ7VtcZksMzCWvYdMqU7cyRIwBZxocs3v/Mm+AT1oqrJk7k7p3MyKb6HQh5WmpJtOGa5XB5XdA
        BwcixuzlRAsV0ugi1pZCEOPX8/2U9FJfSiTWmXyacxpa04f50ib8WbcnHeMS/mnKrlZPuixTJAvLX
        3FVwJEOaAZHdcGwhGwmDWSFo2hfd/oqPyVaDnW5Tu0OV/xIg684+WKIwWocCwGai8mv9j0q/U7yTv
        cq1omNy9DiNHaEUlk/+LnGzVgE/SH8amyD/Tns4qZw8VGf6wtHDeeBNFg/TNb9zPFZcHMM9wU8Sv+
        dRfMWMnw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOQKb-00CRNI-Sx; Mon, 22 Mar 2021 19:35:18 +0000
Subject: Re: [PATCH] lib: Fix a typo in the file bch.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        akpm@linux-foundation.org, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org
References: <20210301123129.18754-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4ba47108-35a9-1119-5a78-bc6888f675c5@infradead.org>
Date:   Mon, 22 Mar 2021 12:35:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210301123129.18754-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 4:31 AM, Bhaskar Chowdhury wrote:
> 
> s/buid/build/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  lib/bch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bch.c b/lib/bch.c
> index 7c031ee8b93b..c8095f30f254 100644
> --- a/lib/bch.c
> +++ b/lib/bch.c
> @@ -584,7 +584,7 @@ static int find_affine4_roots(struct bch_control *bch, unsigned int a,
>  	k = a_log(bch, a);
>  	rows[0] = c;
> 
> -	/* buid linear system to solve X^4+aX^2+bX+c = 0 */
> +	/* build linear system to solve X^4+aX^2+bX+c = 0 */
>  	for (i = 0; i < m; i++) {
>  		rows[i+1] = bch->a_pow_tab[4*i]^
>  			(a ? bch->a_pow_tab[mod_s(bch, k)] : 0)^
> --


-- 
~Randy

