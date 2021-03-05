Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2332F072
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhCEQz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhCEQzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:55:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFDDC061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 08:55:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ch11so2409203pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 08:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5oX7JDjpyFM6sShOZapWIE6sOYsNksokkCB2Em8FcMw=;
        b=EqxN9e8rDjI2I2gJOSPPG/q05JnU5yymLBDDd9p6ny16eovxkKkAUbrCkuQSTOB2WH
         g6zlxso1OMmg9Ebdk6Nbnx5o4aQNreFt48edMlEaavtiJJ7mCrS65A3BOLEdjVhSZ+mg
         svQQmF4n7dUqon7+f5JiNK/WxfI40+U7YPB4bBRw/Kp+EaQmtNgMxtI9sp7A7OxE3EjE
         o7KtladbbuHryn65Vt1m/aXtqDmcRDiV/Bass2bcD0rWOKHvsdb54zCUGsLPAeLZK2Qu
         kwjtxw9epGtY+6puNn5zLVMj+37z++zRhGSFrBWhgb8EC2qCS0sCjNMal2DihjLtBYY/
         lBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5oX7JDjpyFM6sShOZapWIE6sOYsNksokkCB2Em8FcMw=;
        b=eAzAcFe1OsSA2HURLQbTZKlJYP/K1iIIN2GQy0Yhl76mCF5mQcdULY44fX1AL5AzoL
         dV7FFNIBRrZGIPHeknMLAsVeV767ec71OoHZkQvSZFmOBx96EKiT/W3QQcd0AlxtVsEv
         3V/g54eRHuqeCnXuOlTctWxWJvNq7TMMYCOvhyyTtsWjUajlz60VnlBemc8ygoDjrqrE
         aNIPFlnbm7Yizn4ygZ6+/xeE9uGoxxbfZuESZIedYq/WxFlKz8lRZMLY24mVTbtIX9kj
         hOL+l0Nkef5oO9TZeoo3Xm0oVnikqYProJW/1jbohWCZ9TxuRZ3ERpEfkQ1blBcTPsqe
         9K/A==
X-Gm-Message-State: AOAM531IS7nf4eGYIfj7UKyyMaAaRi9BRrF+mByVSbC6wdCfz2/nC8lG
        TKiOEbn5v4DFLefKyje3lm8sWg==
X-Google-Smtp-Source: ABdhPJxstzqvocrEH0wIvecZMQR/AbxctNSmn+OMgpLPNverTVBu8owjd2rr+kRGcTeQBx+lLo4/RQ==
X-Received: by 2002:a17:90a:4d07:: with SMTP id c7mr11296018pjg.104.1614963313231;
        Fri, 05 Mar 2021 08:55:13 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id mw13sm2794442pjb.42.2021.03.05.08.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 08:55:12 -0800 (PST)
Date:   Fri, 5 Mar 2021 09:55:10 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 08/16] rpmsg: glink: add sendto and trysendto ops
Message-ID: <20210305165510.GA3885132@xps15>
References: <20210219111501.14261-1-arnaud.pouliquen@foss.st.com>
 <20210219111501.14261-9-arnaud.pouliquen@foss.st.com>
 <20210304191129.GE3854911@xps15>
 <e0f60693-3184-55c1-db67-1725a5f9c24d@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0f60693-3184-55c1-db67-1725a5f9c24d@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >>  }
> >>  
> >> +static int qcom_glink_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
> >> +{
> >> +	struct glink_channel *channel = to_glink_channel(ept);
> >> +
> >> +	return __qcom_glink_send(channel, data, len, true);
> >> +}
> >> +
> >> +static int qcom_glink_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
> >> +{
> >> +	struct glink_channel *channel = to_glink_channel(ept);
> >> +
> >> +	return __qcom_glink_send(channel, data, len, false);
> >> +}
> > 
> > Just rename send() to sendto() and trysend() to trysendto() and ignore the
> > destination address.  
> 

Apologies for not being clear.

> Function prototypes have to match with rpmsg_endpoint_ops structure defined
> below. So seems to me not possible to just rename the functions.
> Please could you clarify if i missed something?

I don't think rproc_ops::send() and rproc_ops::trysend() are used anywhere else.
So replace them with rproc_ops::sendto() and rproc_ops::trysendto() where the
destination address would be ingnored.

> 
> > The same goes for the next patch.  I would fold patch 08
> > and 09 into 10 to help get the big picture.
> 
> I'm going to squash all in one.

Perfect

> 
> Thanks,
> Arnaud
> 
> > 
> >> +
> >>  /*
> >>   * Finds the device_node for the glink child interested in this channel.
> >>   */
> >> @@ -1364,7 +1378,9 @@ static const struct rpmsg_device_ops glink_device_ops = {
> >>  static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
> >>  	.destroy_ept = qcom_glink_destroy_ept,
> >>  	.send = qcom_glink_send,
> >> +	.sendto = qcom_glink_sendto,
> >>  	.trysend = qcom_glink_trysend,
> >> +	.trysendto = qcom_glink_trysendto,
> >>  };
> >>  
> >>  static void qcom_glink_rpdev_release(struct device *dev)
> >> -- 
> >> 2.17.1
> >>
