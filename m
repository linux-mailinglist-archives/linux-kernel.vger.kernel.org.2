Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9450A3B4AAB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 00:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFYWpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 18:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhFYWpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 18:45:15 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B890CC061767
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 15:42:53 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g19-20020a9d12930000b0290457fde18ad0so10990305otg.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xtN9ANVfYXkPzwu38mMzyB0Issc28w9lzEk1ITbrKYg=;
        b=sGCu/kq1nhIOE5s5PkeiJ/x0aKlD2fFX5DUoxiX85lsBv9FKyK1onolU19QQyePcRr
         hw2lGzAl97idn4S7utOdrPy6c3pq7ck/XiYl6++CCQl+KII0K9gEMhva29B52G0WkdH8
         SIGdvFgN48NCcacJqxS86jRqmv2ENn6JlFbLDy0YwWYWfpGuHNw7VYlEYeQN1Pt3XcgA
         fAHb2CgfRbQUTXvk4wPgVDRsvbOH+Xz11965TCsojw8wXkf3+f1lv7D5Dmu+lFjTtnby
         PDA541m341nAaedbwR97Lahqfxu9eHPCL/WEESE7w+tXMuqwwBwwT8KCiYoP4nxur1Qw
         qEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtN9ANVfYXkPzwu38mMzyB0Issc28w9lzEk1ITbrKYg=;
        b=m6omveeTJvDAsU4Q/rnwKHA5LA/jXp6Ou5PciuAKxuZ026UCsWjYu4xNBC7Fi2rC/r
         7kFDl9d1ewDMcLvm/Wb59BMd5at2J2PrD2LhwTH5qjZb9CyGV1ommtoPh0uvvL6t6G5f
         BVC8nXm0V9i7Ni0vqHRe+XYHSCd6bBr4cAhHgnJRfJD7qa8W+IB1g/QZTfpBCHpLbLhv
         nr8zSdEKjRkKuXqK/zXdH8ymOknP+cFYZOowp4EkAt1S92FaoPzIWkG9B0I+aEyWauNZ
         Af57wvbLBvyhrLwOoMeHcIytxp5mLZMFYM00rXu7irG5Fkfe7KjwD0ChK1zlPC98/0lM
         udNQ==
X-Gm-Message-State: AOAM5307fLRfQBYfnbb9xRZ7JHEBAf8/ihzY7TAjfAOtsVSS2fddISu5
        QZ0jUEq0mrmIFa2YdjOkIgBGaw==
X-Google-Smtp-Source: ABdhPJxL4hY1zoMOq4i+Qkhu22O0kRlynKmYAUUcmMO0c+3v0Vmu0qbFAyja7RMqCZn4DFO7Wdg3vA==
X-Received: by 2002:a9d:389:: with SMTP id f9mr11610020otf.213.1624660973107;
        Fri, 25 Jun 2021 15:42:53 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t21sm1737366otl.23.2021.06.25.15.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 15:42:52 -0700 (PDT)
Date:   Fri, 25 Jun 2021 17:42:50 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] remoteproc: qcom: pas: Add SC8180X adsp, cdsp and
 mpss
Message-ID: <YNZb6geMr5nRMpqW@builder.lan>
References: <20210608174944.2045215-1-bjorn.andersson@linaro.org>
 <20210608174944.2045215-2-bjorn.andersson@linaro.org>
 <20210625044736.GA4974@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625044736.GA4974@workstation>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 Jun 23:47 CDT 2021, Manivannan Sadhasivam wrote:

> On Tue, Jun 08, 2021 at 10:49:44AM -0700, Bjorn Andersson wrote:
> > The Qualcomm SC8180X has the typical ADSP, CDSP and MPSS remote
> > processors operated using the PAS interface, add support for these.
> > 
> > Attempts to configuring mss.lvl is failing, so a new adsp_data is
> > provided that skips this resource, for now.
> > 
> 
> What is the impact of this skipped resource? I guess it is enabled by
> the bootloader so we can't change it in runtime?
> 

The reason for voting for the "proxy" resources is such that if apss
power collapses we might cut the power before the firmware has had a
chance to tell the RPMh to keep the power on.

So, there is a chance that an unfortunately timed power collapse might
cause the modem to loose power, but given that I can't poke mss.lvl I
would expect that this is handled in some other way - if necessary...

> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Given that adsp remoteproc works without configuring mss power domain,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

Thank you!

Regards,
Bjorn

> Thanks,
> Mani
> 
> > ---
> > 
> > Changes since v1:
> > - None
> > 
> >  drivers/remoteproc/qcom_q6v5_pas.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> > index b921fc26cd04..a79bee901e9b 100644
> > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > @@ -689,6 +689,25 @@ static const struct adsp_data mpss_resource_init = {
> >  	.ssctl_id = 0x12,
> >  };
> >  
> > +static const struct adsp_data sc8180x_mpss_resource = {
> > +	.crash_reason_smem = 421,
> > +	.firmware_name = "modem.mdt",
> > +	.pas_id = 4,
> > +	.has_aggre2_clk = false,
> > +	.auto_boot = false,
> > +	.active_pd_names = (char*[]){
> > +		"load_state",
> > +		NULL
> > +	},
> > +	.proxy_pd_names = (char*[]){
> > +		"cx",
> > +		NULL
> > +	},
> > +	.ssr_name = "mpss",
> > +	.sysmon_name = "modem",
> > +	.ssctl_id = 0x12,
> > +};
> > +
> >  static const struct adsp_data slpi_resource_init = {
> >  		.crash_reason_smem = 424,
> >  		.firmware_name = "slpi.mdt",
> > @@ -811,6 +830,9 @@ static const struct of_device_id adsp_of_match[] = {
> >  	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
> >  	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
> >  	{ .compatible = "qcom,sc7180-mpss-pas", .data = &mpss_resource_init},
> > +	{ .compatible = "qcom,sc8180x-adsp-pas", .data = &sm8150_adsp_resource},
> > +	{ .compatible = "qcom,sc8180x-cdsp-pas", .data = &sm8150_cdsp_resource},
> > +	{ .compatible = "qcom,sc8180x-mpss-pas", .data = &sc8180x_mpss_resource},
> >  	{ .compatible = "qcom,sdm845-adsp-pas", .data = &adsp_resource_init},
> >  	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &cdsp_resource_init},
> >  	{ .compatible = "qcom,sdx55-mpss-pas", .data = &sdx55_mpss_resource},
> > -- 
> > 2.29.2
> > 
