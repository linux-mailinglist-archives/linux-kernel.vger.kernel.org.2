Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663B33A87E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFORkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhFORkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:40:52 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3AEC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:38:47 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e22so12049961pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gJUa+0hx0rbXUFX7mmxsZwfywyMDtRYFDwhkW7Df8yU=;
        b=av/65a3p3BRVNG9XKFdJYeO2wWiTcfNj42ljpHRPMF3DlyK+jxaAhqBukh2qrhdn6m
         QGmP698y/f4Yl//cY6O8iLmNL6VkQqw+FVzzydBgFDdlhSNQ9EpiFSj7/HLh4mE+9CaI
         TMk6M8DwJAwcme41wPmz/dkbmT7KMgPCbPOjc1tzRm8cdq+oaChK/q7UeiUgQJWsVPJ1
         JrzAgmitVjWOHYJoovf6Tdukxo0H3KvRKw1hKZM55d3ZiMr/axZW3yeAds7xR0gJLLIZ
         TzDdxoxwDJgp0axoJLndMMeeFEIgKtNorS7NLMYx2Lnxccy9Qqw1FUU/MvnoiiZGXyMN
         aoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gJUa+0hx0rbXUFX7mmxsZwfywyMDtRYFDwhkW7Df8yU=;
        b=cFqCCQEV8kvB/QNmHiJTKwGAs13J+VRqycjaBQLVvQcmrGO8Gq8X8PjjoCuQkVg/pv
         2VjBPz0OarnO4Hqnomj5cpyPtPh6r1CClQjF0TfjHjnsKN18qavWKJajNnPEb1ING11n
         glW9aLI3oOjrxAKRzjBEFK54OcwgJArEYwoqTPHKYix/C4SipbATtG04ZMsfb2Uhv8fD
         pTU5kuQbCzgku/0wITgaG0ck1Cv9WLsHhpSDx+x+3GNioKeFDFS+6QE9mqZoo9DftXKf
         A6+0z3WX4VYmJrsiI9KUe3BoEno599cSeauxCeLIg3y4CZDO7KBLdcCH/zRrXTBbxd+Z
         0YwQ==
X-Gm-Message-State: AOAM531DUBp18L2tErjW+5l0LalKKDSa5BCnHKj+yJIc3OP3w9Qc8zOw
        F5DuSWcIjytUA6HmWr3PVYT9KQ==
X-Google-Smtp-Source: ABdhPJzhFC5MnbVlCw95sMop5xCn8FjnlLM2ZmtVXznZRxY77CLmYGUe/53p1b9WNGHPLjw1eozhDQ==
X-Received: by 2002:a65:6884:: with SMTP id e4mr630624pgt.71.1623778726964;
        Tue, 15 Jun 2021 10:38:46 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id mr23sm16168435pjb.12.2021.06.15.10.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:38:45 -0700 (PDT)
Date:   Tue, 15 Jun 2021 11:38:44 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/4] rpmsg: ctrl: Introduce RPMSG_RELEASE_DEV_IOCTL
Message-ID: <20210615173844.GA604521@p14s>
References: <20210604091406.15901-1-arnaud.pouliquen@foss.st.com>
 <20210604091406.15901-3-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604091406.15901-3-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

On Fri, Jun 04, 2021 at 11:14:04AM +0200, Arnaud Pouliquen wrote:
> Implement the RPMSG_RELEASE_DEV_IOCTL to allow the user application to
> release a rpmsg device created either by the remote processor or with
> the RPMSG_CREATE_DEV_IOCTL call.
> Depending on the back-end implementation, the associated rpmsg driver is
> removed and a NS destroy rpmsg can be sent to the remote processor.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_ctrl.c | 7 +++++++
>  include/uapi/linux/rpmsg.h | 5 +++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
> index 4aa962df3661..cb19e32d05e1 100644
> --- a/drivers/rpmsg/rpmsg_ctrl.c
> +++ b/drivers/rpmsg/rpmsg_ctrl.c
> @@ -98,6 +98,13 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
>  		}
>  		break;
>  
> +	case RPMSG_RELEASE_DEV_IOCTL:
> +		ret = rpmsg_release_channel(ctrldev->rpdev, &chinfo);
> +		if (ret)
> +			dev_err(&ctrldev->dev, "failed to release %s channel (%d)\n",
> +				chinfo.name, ret);
> +		break;
> +

Please move the content of this patch in 1/4.  

>  	default:
>  		ret = -EINVAL;
>  	}
> diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
> index f9d5a74e7801..38639ba37438 100644
> --- a/include/uapi/linux/rpmsg.h
> +++ b/include/uapi/linux/rpmsg.h
> @@ -38,4 +38,9 @@ struct rpmsg_endpoint_info {
>   */
>  #define RPMSG_CREATE_DEV_IOCTL	_IOW(0xb5, 0x3, struct rpmsg_endpoint_info)
>  
> +/**
> + * Release a local rpmsg device.
> + */
> +#define RPMSG_RELEASE_DEV_IOCTL	_IOW(0xb5, 0x4, struct rpmsg_endpoint_info)
> +
>  #endif
> -- 
> 2.17.1
> 
