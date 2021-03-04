Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E320F32DA24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhCDTMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhCDTMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:12:13 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D838C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 11:11:32 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id a4so19496372pgc.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 11:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V8gX6BLRp5VTtpTwGxCWHd1uYqGAa6Y56JCNNo50CEo=;
        b=ipvXcYweUEz5TS/xc4BHVGvCyArCaLaHVI1tfvZ5BJHQyXql9vlhqf3PZTWCX9Jc6r
         s5RxCEH5BO7F5NoKO6+sGuKvkfOYCCzweKWKQ+6JNpBhXMPP7BqHW3SwpogalD0OeRn/
         QOCEwo0swmxcHL+e0NQIGKyNmSxHigpv4swqVTBDJpL+hNngdx5N7g/PfMBQiv/jN82k
         oav1PrsZIdfGZJgWScHC6Dmq9rgtf0Od8PRi0L+SrZRUlmfS2kMOuh9LdIdazP0Dxw9L
         dkbTaioQ+P6Jfm/w9Q/WE53mTfvQ6fLIcmq6YSmpf/VUf0M9LnbNQdkrVVLdf2WFr0Mu
         UGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V8gX6BLRp5VTtpTwGxCWHd1uYqGAa6Y56JCNNo50CEo=;
        b=WI1dShWkz+f6/7eybuDpj2ULNC1O5FkOOGOeVz6AKfqfzvDVNr7GbeyYABee+8Z3lm
         g+ST96iH4M9hYaxIiQF4GRY9T0+a2Kg7z18/lLWXe376KiuW8tzpKrcXY/9Al92tLon0
         S9++Qc13lIWPFfjMhtJvlpYeLHlNoeId2RKne94TFvhLVYUvbJdTGpKvmDnzpJdrxtf/
         o2Pv337DdYV+R2iy1ohXF7krg3iyxA3t32o8XSrNImg7krWFl6ZPcUSC8gJe1+E9tVIR
         UqG9lMQlYMqOqb2mGGxSUeaA/ISVPp5yl91hJ8sYF6DcTRkv4aszqeoSxCLFC8BvguVr
         UpPQ==
X-Gm-Message-State: AOAM531hL3b1RxJ1qwhGICo+M5jddKoPp11Focf+98X31GsoP0FitCL8
        kOcSY3TrcSZOZwzhbVpGaqRHtQ==
X-Google-Smtp-Source: ABdhPJyaBnKH+Hurc5YUT8rqKvUynaxhKbr/WowkCCfpFo2hdsry+fYZiqjB+V75/Hs+Yxi3DttC9g==
X-Received: by 2002:a62:1e41:0:b029:1e6:fe13:b78e with SMTP id e62-20020a621e410000b02901e6fe13b78emr5177583pfe.26.1614885092044;
        Thu, 04 Mar 2021 11:11:32 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m12sm37318pjk.47.2021.03.04.11.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 11:11:31 -0800 (PST)
Date:   Thu, 4 Mar 2021 12:11:29 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 08/16] rpmsg: glink: add sendto and trysendto ops
Message-ID: <20210304191129.GE3854911@xps15>
References: <20210219111501.14261-1-arnaud.pouliquen@foss.st.com>
 <20210219111501.14261-9-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219111501.14261-9-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 12:14:53PM +0100, Arnaud Pouliquen wrote:
> Implement the sendto ops to support the future rpmsg_char update for the
> vitio backend support.

Add a new line, otherwise it is very easy to read.

> The use of sendto in rpmsg_char is needed as a destination address is
> requested at least by the virtio backend.

Same here and throughout the patchset.

> The glink implementation does not need a destination address so ignores it.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index d4e4dd482614..ae2c03b59c55 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1332,6 +1332,20 @@ static int qcom_glink_trysend(struct rpmsg_endpoint *ept, void *data, int len)
>  	return __qcom_glink_send(channel, data, len, false);
>  }
>  
> +static int qcom_glink_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
> +{
> +	struct glink_channel *channel = to_glink_channel(ept);
> +
> +	return __qcom_glink_send(channel, data, len, true);
> +}
> +
> +static int qcom_glink_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
> +{
> +	struct glink_channel *channel = to_glink_channel(ept);
> +
> +	return __qcom_glink_send(channel, data, len, false);
> +}

Just rename send() to sendto() and trysend() to trysendto() and ignore the
destination address.  The same goes for the next patch.  I would fold patch 08
and 09 into 10 to help get the big picture. 

> +
>  /*
>   * Finds the device_node for the glink child interested in this channel.
>   */
> @@ -1364,7 +1378,9 @@ static const struct rpmsg_device_ops glink_device_ops = {
>  static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
>  	.destroy_ept = qcom_glink_destroy_ept,
>  	.send = qcom_glink_send,
> +	.sendto = qcom_glink_sendto,
>  	.trysend = qcom_glink_trysend,
> +	.trysendto = qcom_glink_trysendto,
>  };
>  
>  static void qcom_glink_rpdev_release(struct device *dev)
> -- 
> 2.17.1
> 
