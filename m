Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FFE33F729
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhCQRek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhCQRef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:34:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A349C06174A;
        Wed, 17 Mar 2021 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=899uy+opuBYMan6yzLPG9/V5iogxQaeqI/5Fsy2GYy8=; b=pPunVPMIc6x2/TQzWdqa6GjxNe
        snj+Qpc884RUynHAwC08mrBSdj/rbnbg0UhhHxF0Zm+HSqI1usAX0XDRtzw3rXtoe7kGczwf9V7PM
        53ziD1KW8Crr9UjlcRhGH8orc0I19W/q1QGOLAeZKF0gEG5kjcv3KgizMv980TDLThM9bVYtSBEvT
        csccGPHMXlo05mhemj2Vxwligt7Hc7T95dlQ21ziQK6zCKffmPRHqMhCIXVUC4yqqm87MnMajflrR
        LLe8BB30Q0j9inBdWupmlsqPCWZB78Tkjt3mA1OHRCyqDRAuecO2z4zyLE8QkDX00Q8CEnIOM5SLa
        aUPqQlNA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMa3z-001fW4-EO; Wed, 17 Mar 2021 17:34:31 +0000
Subject: Re: [PATCH] crypto: inside-secure: Minor typo fix in the file
 safexcel.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, atenart@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210317091445.614865-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2b589f48-164b-2079-a1a7-5befa66a3564@infradead.org>
Date:   Wed, 17 Mar 2021 10:34:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317091445.614865-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 2:14 AM, Bhaskar Chowdhury wrote:
> 
> s/procesing/processing/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/crypto/inside-secure/safexcel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
> index 6364583b88b2..9ff885d50edf 100644
> --- a/drivers/crypto/inside-secure/safexcel.c
> +++ b/drivers/crypto/inside-secure/safexcel.c
> @@ -688,7 +688,7 @@ static int safexcel_hw_init(struct safexcel_crypto_priv *priv)
>  		/* Leave the DSE threads reset state */
>  		writel(0, EIP197_HIA_DSE_THR(priv) + EIP197_HIA_DSE_THR_CTRL(pe));
> 
> -		/* Configure the procesing engine thresholds */
> +		/* Configure the processing engine thresholds */
>  		writel(EIP197_PE_OUT_DBUF_THRES_MIN(opbuflo) |
>  		       EIP197_PE_OUT_DBUF_THRES_MAX(opbufhi),
>  		       EIP197_PE(priv) + EIP197_PE_OUT_DBUF_THRES(pe));
> --


-- 
~Randy

