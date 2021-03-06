Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8339E32F75B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhCFAog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhCFAoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:44:04 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE906C061760
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:44:03 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id y131so1632814oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 16:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wljdg2Ulm2u3Dpzx8Iq4uzqIrv5JdcAhx+0eauq9coc=;
        b=IJ+cvLOg/toHpJIFHESEiOn/U6WxswcFCFnETj9qi98y89NZi/M/Jz0aDlrz1QOsxV
         IY8HknqMCZh8ybLBTVSaDR36oWTg9UCXJuZZSnTLZjrvUXSPFtwmHicqH+iXO9F5IlIp
         qyQa1YLCDIsA4IouvThH4c1Xc6hrkt2o8yAlwJk4InggOF4WNFgyTpO9MkuEFSc9bmxr
         6Fhe4aMKGQTKW/wlpzsRAJMV8iZvYAsF6SALlOrKrFfeXz7n5tN4ZdyPa1GmVmC9VkFT
         VrHTkRBYD1tvbOFOKnQFuVoGFH2tFB/PiVTr7ukomW/IV5xgyA2uvUSbJNgXAb73LwYn
         2CvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wljdg2Ulm2u3Dpzx8Iq4uzqIrv5JdcAhx+0eauq9coc=;
        b=OJkF+S1X1C1Efu04oTqMAeWd0mIXTY+/am0HwXUAcAOneSBeRXGv+y5L0UZeWIwvdd
         +E2aZjcbz4aE91r+v2zCG3+V2G+n6K7pXk9zMAvhFuNAXS22hbyg+62oh6YfYanZ7Ltc
         5sCSW80iNwCv5LgPSAS+Hezr7rNx55zSEiTZk+L5LayePFmfb8GzQI5k9fs5yLIKxv+L
         2iGMuc/Ys9VyQMhpsEKBB2z33yBOXrjPKJwEZUPgt+kDb3rhQno0VsInO1ogsBUmA7tG
         mieTXVc+9ulLs/MeoYUAMbaxb1R1hGJMghb5GWUdEiwuErm40exxh+yM+f4HK0A3Pj5z
         +KuA==
X-Gm-Message-State: AOAM533NcRzwaFSmZnTY0Z576IYhStp97KKwTmuT2bXp28Jyab75jt+l
        ZymZWIHF66Cr+FvUQvmDtVNZ5w==
X-Google-Smtp-Source: ABdhPJwaUlESQTDr6uRL3opuUdtoNtjtVPl0s2jwKflYDEbRC2BlspmSEcEJ53RbG5R8hYVCQeYarA==
X-Received: by 2002:aca:5cd6:: with SMTP id q205mr9100063oib.94.1614991443260;
        Fri, 05 Mar 2021 16:44:03 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f193sm866606oig.8.2021.03.05.16.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 16:44:02 -0800 (PST)
Date:   Fri, 5 Mar 2021 18:44:01 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/6] firmware: qcom_scm: Make
 __qcom_scm_is_call_available() return bool
Message-ID: <YELQUXSI4J2w/6oO@builder.lan>
References: <20210223214539.1336155-1-swboyd@chromium.org>
 <20210223214539.1336155-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223214539.1336155-2-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Feb 15:45 CST 2021, Stephen Boyd wrote:

> Make __qcom_scm_is_call_available() return bool instead of int. The
> function has "is" in the name, so it should return a bool to indicate
> the truth of the call being available. Unfortunately, it can return a
> number < 0 which also looks "true", but not all callers expect that and
> thus they think a call is available when really the check to see if the
> call is available failed to figure it out.
> 
> Cc: Elliot Berman <eberman@codeaurora.org>
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 0f206514749b ("scsi: firmware: qcom_scm: Add support for programming inline crypto keys")
> Fixes: 0434a4061471 ("firmware: qcom: scm: add support to restore secure config to qcm_scm-32")
> Fixes: b0a1614fb1f5 ("firmware: qcom: scm: add OCMEM lock/unlock interface")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/firmware/qcom_scm.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index f57779fc7ee9..2be5573dce53 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -113,9 +113,6 @@ static void qcom_scm_clk_disable(void)
>  	clk_disable_unprepare(__scm->bus_clk);
>  }
>  
> -static int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
> -					u32 cmd_id);
> -
>  enum qcom_scm_convention qcom_scm_convention;
>  static bool has_queried __read_mostly;
>  static DEFINE_SPINLOCK(query_lock);
> @@ -219,8 +216,8 @@ static int qcom_scm_call_atomic(struct device *dev,
>  	}
>  }
>  
> -static int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
> -					u32 cmd_id)
> +static bool __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
> +					 u32 cmd_id)
>  {
>  	int ret;
>  	struct qcom_scm_desc desc = {
> @@ -247,7 +244,7 @@ static int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
>  
>  	ret = qcom_scm_call(dev, &desc, &res);
>  
> -	return ret ? : res.result[0];
> +	return ret ? false : !!res.result[0];
>  }
>  
>  /**
> @@ -585,9 +582,8 @@ bool qcom_scm_pas_supported(u32 peripheral)
>  	};
>  	struct qcom_scm_res res;
>  
> -	ret = __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
> -					   QCOM_SCM_PIL_PAS_IS_SUPPORTED);
> -	if (ret <= 0)
> +	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
> +					  QCOM_SCM_PIL_PAS_IS_SUPPORTED))
>  		return false;
>  
>  	ret = qcom_scm_call(__scm->dev, &desc, &res);
> @@ -1060,17 +1056,18 @@ EXPORT_SYMBOL(qcom_scm_ice_set_key);
>   */
>  bool qcom_scm_hdcp_available(void)
>  {
> +	bool avail;
>  	int ret = qcom_scm_clk_enable();
>  
>  	if (ret)
>  		return ret;
>  
> -	ret = __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_HDCP,
> +	avail = __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_HDCP,
>  						QCOM_SCM_HDCP_INVOKE);
>  
>  	qcom_scm_clk_disable();
>  
> -	return ret > 0;
> +	return avail;
>  }
>  EXPORT_SYMBOL(qcom_scm_hdcp_available);
>  
> -- 
> https://chromeos.dev
> 
