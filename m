Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD7345AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCWJgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhCWJfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:35:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1555FC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:35:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u9so25954285ejj.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T8ujadlsfMOs83cAs9UtDu2l6f6I0ppOLicLa7+9n6s=;
        b=rhGUZpU3lq5FuN30OA5Lu/hODznQG1MHp3rCnsMvUr+jaUOk5+8issQpgldBzkuSw9
         i2fmo6f9WkqeLOhkE75LJsZtyjw4jy0BOeMgVvkPN/mQM7cm5q00oNKE19Q+Lfwf3hND
         d3Vyr2vaKckTtvJRZJagY+VMVZB220QmCBLiF1zJdopIMcih5ZmHvEr2Hic6fmNOmtJl
         YI5o5EuJYApg+IDqrgbWj/QogHm2uvark0SAUYZDxVJvfy4hhXJP3rg+Qg30zMFARi5s
         +McQ5ehedTb4vloDDhWhPsNV/y5IWPY5wkGxTNxserKwKfhgwYHJPf8bpefB68WXf4Lc
         G4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T8ujadlsfMOs83cAs9UtDu2l6f6I0ppOLicLa7+9n6s=;
        b=AzpsivuU+nodU1++O+p8Mxku4kLAx3WHfuAEYUIPX/NjwPIBRRZKNnJxllBKOd5Nc2
         tPoEr3LKGJkeKlXaTAm9nCezyp1eCC6HALw2HiSzJYKRjgQJkRoQF0SL4VSeLq3Do947
         oOZsa5MaME+op3GLsqAGsLQ20ezBPRrLhUAJ0J1QpZm/Cejvyp7zcnkeBjGmCfbIWOsX
         0bZj5UGxvvCMmppkpV/WL8LJlMUDanX1DZvuVQ2ehfF1tWH304zbuNaPzMOFUngf/J7h
         RAF7GZH+4ergbah+VP8ce08QAW5tpn10Sc+iMSxpslFIrredexnZZ/6WfTORjbthGIN/
         7SyQ==
X-Gm-Message-State: AOAM533zpidQXZy7/1XdBHh7PawYYCUb9FyWq8P5JB3R0EOVr8IRV64/
        iucQ8Zov9MlOPJdZAPAP0KCR/A==
X-Google-Smtp-Source: ABdhPJznA5cuEOX+OJTa2zs2ul2EylGfPKzOYpS/rjV0k2ciZGN4I3439arfs0FK6NUztAu3QzBrnA==
X-Received: by 2002:a17:907:2809:: with SMTP id eb9mr3935111ejc.204.1616492142655;
        Tue, 23 Mar 2021 02:35:42 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id a9sm12701859eds.33.2021.03.23.02.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:35:42 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:35:40 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] video: backlight: qcom-wled: Add PMI8994 compatible
Message-ID: <20210323093540.dqrhjlvr6oza3hvt@maple.lan>
References: <20210228124106.135812-1-konrad.dybcio@somainline.org>
 <20210228124106.135812-2-konrad.dybcio@somainline.org>
 <20210322161810.biagj2qro66rv4gt@maple.lan>
 <20210323083935.GF2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323083935.GF2916463@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 08:39:35AM +0000, Lee Jones wrote:
> On Mon, 22 Mar 2021, Daniel Thompson wrote:
> 
> > On Sun, Feb 28, 2021 at 01:41:05PM +0100, Konrad Dybcio wrote:
> > > Add a compatible for PMI8994 WLED. It uses the V4 of WLED IP.
> > > 
> > > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > 
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Why are you Reviewing/Acking a patch that was applied on the 10th?

Simply an oversight. Looks like I forgot to remove it from my backlog
when it was applied.


Daniel.


> 
> > > ---
> > >  drivers/video/backlight/qcom-wled.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> > > index 3bc7800eb0a9..497b9035a908 100644
> > > --- a/drivers/video/backlight/qcom-wled.c
> > > +++ b/drivers/video/backlight/qcom-wled.c
> > > @@ -1704,6 +1704,7 @@ static int wled_remove(struct platform_device *pdev)
> > >  
> > >  static const struct of_device_id wled_match_table[] = {
> > >  	{ .compatible = "qcom,pm8941-wled", .data = (void *)3 },
> > > +	{ .compatible = "qcom,pmi8994-wled", .data = (void *)4 },
> > >  	{ .compatible = "qcom,pmi8998-wled", .data = (void *)4 },
> > >  	{ .compatible = "qcom,pm660l-wled", .data = (void *)4 },
> > >  	{ .compatible = "qcom,pm8150l-wled", .data = (void *)5 },
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
