Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79BC33CC40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhCPDoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbhCPDnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:43:50 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:43:49 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id n9so20756729pgi.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uxr2m0FiTZh4KFjOCM24FocxhgXF+YWdGzAOvysdsM0=;
        b=arnSuW55TZsRmWRjreBLCaSYHaTpBuRzlY25weP7Onw92s9FLWJQviRw/uA4RVwv0s
         nkrA5/OHnbMbt31db1v6HvN2axZqlsFTN5GFUY5xIkF2Bu/pirCC48WlBmFRxj+KajJ3
         XGwnUP5X730xBzGt2vdHknfFhIINwSDXv8wnNzRDLdEopqykbRvwFO2IdccSIzTy/ihZ
         D+J4UQRwc/0EVB/RjPRioa20Amwu/v5VhQJ5/cS0Dee8OJ2NWMS19MhyDsNrRB5d/aMU
         M4aqbLCzqcsZGoIulFSbFBEw9qeOmzDyx6Q6eruUnJy4vs/1pPkC+a9B6rKb8iXCzjkp
         IvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uxr2m0FiTZh4KFjOCM24FocxhgXF+YWdGzAOvysdsM0=;
        b=Ng29Eizu/4XOlOnxYaqnFi5WL0VL7Dvzytmx8P3UErZoOGWKYs/wI0GtsbSQWSPWer
         Bsqmh5npxC6/IxzolPRAjfb5daWlzHQHKae/a63RdoJM1HMYhVmuO0MWiZYDkpIoXhpJ
         wLdMn2xFHaoPWpyLyC9Jc83uB6QAYj9jU+MfXnh9x3Oj79mrc5SOz6v0SLApI8+5HhdN
         lYpggL290vp3K5YL5UMb68q7Gp/XF1DlEHITymbZ113TaSGAAcBcjNySfbbDvS5L3XzQ
         KlK67vSbsHr08vGKvwHMuxZJuG3R7PNlk9n4EDZ87MciqhjRP0MrAVbdf+DBF3BSqacV
         m7/Q==
X-Gm-Message-State: AOAM5326VVhLbEdpY7fJkXXDVGB+3xT8gnvhPrMiJ7b0mfuW0q2zo44x
        Wjn5GH10X9yIJCP8WDRGw59IcwNR/PqT9No=
X-Google-Smtp-Source: ABdhPJxH3pMCOApgk7m4mcqvxeX9KDrxn/0hSUW72YaU2c1wfMUgRi/QUf+J31Nm/YoWtQ3Xk9JetA==
X-Received: by 2002:aa7:92cb:0:b029:1f1:542f:2b2b with SMTP id k11-20020aa792cb0000b02901f1542f2b2bmr26847305pfa.31.1615866229437;
        Mon, 15 Mar 2021 20:43:49 -0700 (PDT)
Received: from work ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id e131sm15524876pfh.176.2021.03.15.20.43.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Mar 2021 20:43:49 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:13:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: ipa: extend the INDICATION_REGISTER
 request
Message-ID: <20210316034344.GE29414@work>
References: <20210315152112.1907968-1-elder@linaro.org>
 <20210315152112.1907968-4-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315152112.1907968-4-elder@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:21:12AM -0500, Alex Elder wrote:
> The specified format of the INDICATION_REGISTER QMI request message
> has been extended to support two more optional fields:
>   endpoint_desc_ind:
>     sender wishes to receive endpoint descriptor information via
>     an IPA ENDP_DESC indication QMI message
>   bw_change_ind:
>     sender wishes to receive bandwidth change information via
>     an IPA BW_CHANGE indication QMI message
> 
> Add definitions that permit these fields to be formatted and parsed
> by the QMI library code.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/net/ipa/ipa_qmi_msg.c | 40 +++++++++++++++++++++++++++++++++++
>  drivers/net/ipa/ipa_qmi_msg.h |  6 +++++-
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/ipa_qmi_msg.c b/drivers/net/ipa/ipa_qmi_msg.c
> index e4a6efbe9bd00..6838e8065072b 100644
> --- a/drivers/net/ipa/ipa_qmi_msg.c
> +++ b/drivers/net/ipa/ipa_qmi_msg.c
> @@ -70,6 +70,46 @@ struct qmi_elem_info ipa_indication_register_req_ei[] = {
>  		.offset		= offsetof(struct ipa_indication_register_req,
>  					   ipa_mhi_ready_ind),
>  	},
> +	{
> +		.data_type	= QMI_OPT_FLAG,
> +		.elem_len	= 1,
> +		.elem_size	=
> +			sizeof_field(struct ipa_indication_register_req,
> +				     endpoint_desc_ind_valid),
> +		.tlv_type	= 0x13,
> +		.offset		= offsetof(struct ipa_indication_register_req,
> +					   endpoint_desc_ind_valid),
> +	},
> +	{
> +		.data_type	= QMI_UNSIGNED_1_BYTE,
> +		.elem_len	= 1,
> +		.elem_size	=
> +			sizeof_field(struct ipa_indication_register_req,
> +				     endpoint_desc_ind),
> +		.tlv_type	= 0x13,
> +		.offset		= offsetof(struct ipa_indication_register_req,
> +					   endpoint_desc_ind),
> +	},
> +	{
> +		.data_type	= QMI_OPT_FLAG,
> +		.elem_len	= 1,
> +		.elem_size	=
> +			sizeof_field(struct ipa_indication_register_req,
> +				     bw_change_ind_valid),
> +		.tlv_type	= 0x14,
> +		.offset		= offsetof(struct ipa_indication_register_req,
> +					   bw_change_ind_valid),
> +	},
> +	{
> +		.data_type	= QMI_UNSIGNED_1_BYTE,
> +		.elem_len	= 1,
> +		.elem_size	=
> +			sizeof_field(struct ipa_indication_register_req,
> +				     bw_change_ind),
> +		.tlv_type	= 0x14,
> +		.offset		= offsetof(struct ipa_indication_register_req,
> +					   bw_change_ind),
> +	},
>  	{
>  		.data_type	= QMI_EOTI,
>  	},
> diff --git a/drivers/net/ipa/ipa_qmi_msg.h b/drivers/net/ipa/ipa_qmi_msg.h
> index 12b6621f4b0e6..3233d145fd87c 100644
> --- a/drivers/net/ipa/ipa_qmi_msg.h
> +++ b/drivers/net/ipa/ipa_qmi_msg.h
> @@ -24,7 +24,7 @@
>   * information for each field.  The qmi_send_*() interfaces require
>   * the message size to be provided.
>   */
> -#define IPA_QMI_INDICATION_REGISTER_REQ_SZ	12	/* -> server handle */
> +#define IPA_QMI_INDICATION_REGISTER_REQ_SZ	20	/* -> server handle */
>  #define IPA_QMI_INDICATION_REGISTER_RSP_SZ	7	/* <- server handle */
>  #define IPA_QMI_INIT_DRIVER_REQ_SZ		162	/* client handle -> */
>  #define IPA_QMI_INIT_DRIVER_RSP_SZ		25	/* client handle <- */
> @@ -44,6 +44,10 @@ struct ipa_indication_register_req {
>  	u8 data_usage_quota_reached;
>  	u8 ipa_mhi_ready_ind_valid;
>  	u8 ipa_mhi_ready_ind;
> +	u8 endpoint_desc_ind_valid;
> +	u8 endpoint_desc_ind;
> +	u8 bw_change_ind_valid;
> +	u8 bw_change_ind;
>  };
>  
>  /* The response to a IPA_QMI_INDICATION_REGISTER request consists only of
> -- 
> 2.27.0
> 
