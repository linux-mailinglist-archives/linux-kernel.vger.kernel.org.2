Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24413AC1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhFREUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhFREUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:20:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88F2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:18:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u18so1337041pfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A7veP2+rvJhREGxZ7bA2MKokj7fOMWmnWBdu22Gjixs=;
        b=plDYr7URR38B4jGYMsxSURthpcFrTWdDpgkJZiOYCuF4iliXpJ56Mn3TIhtq6Hj3Ko
         DcJqLB0QmDx+XU5q97EHRY8Z+3l44WgV8KsrWl60QLCgykxwjoenpSzt8r2PsJABEnbV
         jnUqsGTAemSR2cNPF1fsD5PWJxUjOSGKN7tNFoyi8QHGOfI8Oe9DhyP6lplAOsox9rYM
         ToHvttUNsT80qTybhX19aohlNodJS1Z9II5W3Ul1On1PDhnZ8W8YRoo7Uz+uitlVLP7s
         NQ8zh9QQXrgGvYeR/5Vu3hiRaPODOYGYDR6en/M34Md65klj78jhxoKpPolvM3Pjk9BT
         KtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A7veP2+rvJhREGxZ7bA2MKokj7fOMWmnWBdu22Gjixs=;
        b=PDg7zPTsVbUpzJVEeGNTnUPR/Y5CfVlxK5KXo1AUSKM+LVd0Dw6x6SwGX5imb+6/vt
         JJcDOajYVAe2TlRzypkgZQtGkyujG3cRZ48gfi4eQGVidLPcTcEwF+RMXqtxv7DFnCmL
         EgO5YRfKmMKAFN0VESZ0gjdcw0nOyMYLa5bpxJW5TKX9vA4aQVion4ZNXZdFlEyuLtYZ
         QBMrSYMgA76j2wuRbdq7720zzbGTxrMLyjBxdFOuPozMR7c5F6g4B0eH+s6Dbpv9ZqHi
         FSD+23wSL4mvNKQoD8bO+9SX92ZHI1We6hN2DhLYnzA4iuxjzfjxrTNX3u2yrBu/fu++
         ieKA==
X-Gm-Message-State: AOAM530TAAjqAyejbCZ7EhBTp9cLr8oN8VjaSNtcwgmKAHTRHOqPYhWI
        8/qmZd0zA9OLphM1LD0Zdxcw
X-Google-Smtp-Source: ABdhPJz5nIO0obUzGfQWU2OY7LlyNmGKp7Hy07h54AzlLuFHm3eedis+rYyTYKWqhR+BwvY3pYmALw==
X-Received: by 2002:a63:3246:: with SMTP id y67mr8193050pgy.244.1623989917247;
        Thu, 17 Jun 2021 21:18:37 -0700 (PDT)
Received: from workstation ([120.138.13.238])
        by smtp.gmail.com with ESMTPSA id s13sm6431308pjm.34.2021.06.17.21.18.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jun 2021 21:18:35 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:48:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jassisinghbrar@gmail.com,
        agross@kernel.org, rananta@codeaurora.org, vnkgutta@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mailbox: qcom-ipcc: Fix IPCC mbox channel exhaustion
Message-ID: <20210618041831.GA3682@workstation>
References: <1623865378-1943-1-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623865378-1943-1-git-send-email-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:12:58PM +0530, Sibi Sankar wrote:
> Fix IPCC (Inter-Processor Communication Controller) channel exhaustion by
> setting the channel private data to NULL on mbox shutdown.
> 
> Err Logs:
> remoteproc: MBA booted without debug policy, loading mpss
> remoteproc: glink-edge: failed to acquire IPC channel
> remoteproc: failed to probe subdevices for remoteproc: -16
> 
> Fixes: fa74a0257f45 ("mailbox: Add support for Qualcomm IPCC")
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Cc: stable@vger.kernel.org
> ---
>  drivers/mailbox/qcom-ipcc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> index 2d13c72944c6..584700cd1585 100644
> --- a/drivers/mailbox/qcom-ipcc.c
> +++ b/drivers/mailbox/qcom-ipcc.c
> @@ -155,6 +155,11 @@ static int qcom_ipcc_mbox_send_data(struct mbox_chan *chan, void *data)
>  	return 0;
>  }
>  
> +static void qcom_ipcc_mbox_shutdown(struct mbox_chan *chan)
> +{
> +	chan->con_priv = NULL;
> +}
> +
>  static struct mbox_chan *qcom_ipcc_mbox_xlate(struct mbox_controller *mbox,
>  					const struct of_phandle_args *ph)
>  {
> @@ -184,6 +189,7 @@ static struct mbox_chan *qcom_ipcc_mbox_xlate(struct mbox_controller *mbox,
>  
>  static const struct mbox_chan_ops ipcc_mbox_chan_ops = {
>  	.send_data = qcom_ipcc_mbox_send_data,
> +	.shutdown = qcom_ipcc_mbox_shutdown,
>  };
>  
>  static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
