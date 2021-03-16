Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFA633CC38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhCPDms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbhCPDmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:42:24 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A53C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:42:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v14so14787737pgq.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GJXTGY660PRr+gnuulp4+I5fDAsuE0mVZ6I0ohXJicw=;
        b=zAsLbHuhdlOu5KU9tf3K1SgC76BOiciQU8aL6JiNurJf12fViKj8GaNqJI3dHZNLW3
         EOjDVa1thkLQsvdBluva8crhFVynyirwCg+hIsdvgQRUpRSziE1kXummnh9R142I8jgy
         0u+VoStOB1Pgw99FSJuxvvGkZY0qip9jBjA8z4NGbr9vEcznyaJA+WDeE735BT/FMXjT
         76oVWaPaAl9OndST/OxHC9461ESDRFs+vJYg3j8mPc61dFbT31cHCx7lDoLjwrVubkIS
         5PPYQ9VtvqtFpsEBceVI24h/G8I7QI9WyvcHGbfzLEv95MH6WWKUPAYYtfZvdD0/VqHu
         kumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJXTGY660PRr+gnuulp4+I5fDAsuE0mVZ6I0ohXJicw=;
        b=q0HJNoaZQzOfuz1YZ0UtgzCaU0YfB4kb+eEmm13ZV+pDUWOHU5XU1dy7au+6zLxorS
         5meWG/zqIoWOQw8LcZXSGNrNpODSptf+r9j53sLpo5GYko1k1LtmKBjoRDJ29H+R5oWD
         gbok4yA66HT5093DoAr3mKOX1i62KAp1pja/6smwYzrtUZudHJtjHjZs98DaY79qcsJx
         PIeLzoGVPeoCBRr3a6cskcJQIz3u+qZfj4d0++IaBmBqwDZgqqv+5QI9YqihQcEbRMfG
         zdEfFcPorCvqa0pWE/NYYWQnXlp5M4gO+cLAs/lXRw86TpAsVsVtGnulHK3IPKE3l5J0
         MX/g==
X-Gm-Message-State: AOAM533ksDwb0A5NDIFJEv/EocZDVG1RVKCODEfGP8TzsHpBN8zHfE4i
        Js50HnqrPc6i06AJ6iW9pHeUudcoMsCALNk=
X-Google-Smtp-Source: ABdhPJw4pPvqmyVw/yH3AtZEdnZ83L8E/Q2AQTVoYtUN+Q4v3ymg3b452NCoXpIobX8NcHb0YvSShg==
X-Received: by 2002:a63:460e:: with SMTP id t14mr2014811pga.230.1615866132635;
        Mon, 15 Mar 2021 20:42:12 -0700 (PDT)
Received: from work ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id p20sm14460942pgb.62.2021.03.15.20.42.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Mar 2021 20:42:12 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:12:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: ipa: fix another QMI message definition
Message-ID: <20210316034208.GD29414@work>
References: <20210315152112.1907968-1-elder@linaro.org>
 <20210315152112.1907968-3-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315152112.1907968-3-elder@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:21:11AM -0500, Alex Elder wrote:
> The ipa_init_modem_driver_req_ei[] encoding array for the
> INIT_MODEM_DRIVER request message has some errors in it.
> 
> First, the tlv_type associated with the hw_stats_quota_size field is
> wrong; it duplicates the valiue used for the hw_stats_quota_base_addr
> field (0x1f) and should use 0x20 instead.  The tlv_type value for
> the hw_stats_drop_size field also uses the same duplicate value; it
> should use 0x22 instead.
> 
> Second, there is no definition for the hw_stats_drop_base_addr
> field.  It is an optional 32-bit enumerated type value.
> 
> Finally, the hw_stats_quota_base_addr, hw_stats_quota_size, and
> hw_stats_drop_size fields are defined as enumerated types; they
> should be unsigned 4-byte values.
> 
> Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Alex Elder <elder@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/net/ipa/ipa_qmi_msg.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_qmi_msg.c b/drivers/net/ipa/ipa_qmi_msg.c
> index e00f829a783f6..e4a6efbe9bd00 100644
> --- a/drivers/net/ipa/ipa_qmi_msg.c
> +++ b/drivers/net/ipa/ipa_qmi_msg.c
> @@ -530,7 +530,7 @@ struct qmi_elem_info ipa_init_modem_driver_req_ei[] = {
>  					   hw_stats_quota_base_addr_valid),
>  	},
>  	{
> -		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
> +		.data_type	= QMI_UNSIGNED_4_BYTE,
>  		.elem_len	= 1,
>  		.elem_size	=
>  			sizeof_field(struct ipa_init_modem_driver_req,
> @@ -545,37 +545,57 @@ struct qmi_elem_info ipa_init_modem_driver_req_ei[] = {
>  		.elem_size	=
>  			sizeof_field(struct ipa_init_modem_driver_req,
>  				     hw_stats_quota_size_valid),
> -		.tlv_type	= 0x1f,
> +		.tlv_type	= 0x20,
>  		.offset		= offsetof(struct ipa_init_modem_driver_req,
>  					   hw_stats_quota_size_valid),
>  	},
>  	{
> -		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
> +		.data_type	= QMI_UNSIGNED_4_BYTE,
>  		.elem_len	= 1,
>  		.elem_size	=
>  			sizeof_field(struct ipa_init_modem_driver_req,
>  				     hw_stats_quota_size),
> -		.tlv_type	= 0x1f,
> +		.tlv_type	= 0x20,
>  		.offset		= offsetof(struct ipa_init_modem_driver_req,
>  					   hw_stats_quota_size),
>  	},
> +	{
> +		.data_type	= QMI_OPT_FLAG,
> +		.elem_len	= 1,
> +		.elem_size	=
> +			sizeof_field(struct ipa_init_modem_driver_req,
> +				     hw_stats_drop_base_addr_valid),
> +		.tlv_type	= 0x21,
> +		.offset		= offsetof(struct ipa_init_modem_driver_req,
> +					   hw_stats_drop_base_addr_valid),
> +	},
> +	{
> +		.data_type	= QMI_UNSIGNED_4_BYTE,
> +		.elem_len	= 1,
> +		.elem_size	=
> +			sizeof_field(struct ipa_init_modem_driver_req,
> +				     hw_stats_drop_base_addr),
> +		.tlv_type	= 0x21,
> +		.offset		= offsetof(struct ipa_init_modem_driver_req,
> +					   hw_stats_drop_base_addr),
> +	},
>  	{
>  		.data_type	= QMI_OPT_FLAG,
>  		.elem_len	= 1,
>  		.elem_size	=
>  			sizeof_field(struct ipa_init_modem_driver_req,
>  				     hw_stats_drop_size_valid),
> -		.tlv_type	= 0x1f,
> +		.tlv_type	= 0x22,
>  		.offset		= offsetof(struct ipa_init_modem_driver_req,
>  					   hw_stats_drop_size_valid),
>  	},
>  	{
> -		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
> +		.data_type	= QMI_UNSIGNED_4_BYTE,
>  		.elem_len	= 1,
>  		.elem_size	=
>  			sizeof_field(struct ipa_init_modem_driver_req,
>  				     hw_stats_drop_size),
> -		.tlv_type	= 0x1f,
> +		.tlv_type	= 0x22,
>  		.offset		= offsetof(struct ipa_init_modem_driver_req,
>  					   hw_stats_drop_size),
>  	},
> -- 
> 2.27.0
> 
