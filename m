Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1526345B29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhCWJnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhCWJmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:42:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ABDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:42:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jy13so25960172ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RJI1ZulJI/N1c2SHSzXG2bAltLew6mzjF/sjYCXcM5o=;
        b=JUN66A/8cTYU/eCzY1rGy5pu3Ui6LtQGLfl6KYjMr29YoVG/cdEJDdLL3Rx7rc5i2l
         QtXpb4pWe9w0bC1DCL7OK/oYYh+mOMk9IAxiy2bA4M8WH+Njssh46rgJrBNVNOhpAKIV
         VMXATaJV4nZUAxzKlMh2F06xFz+zdQwrb2BJv2VNWWIbB0utRYUhknkLfmbQSr7VGycf
         1w3WosdRggV3OYeQOERJdI4dNRjvCEwSlEAUsSGgeCWWyRWjEOHRCUDdNu3dO4GPwUGi
         TIW0ZgHSwC5mRhD3CUAVE533pNm9bdOIDFmJiagr5hE/VViE+ajDPRfkOJZh7hdjpZk/
         L/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RJI1ZulJI/N1c2SHSzXG2bAltLew6mzjF/sjYCXcM5o=;
        b=oM+dzplhcFI3otoiwsvzTb0tfX9qM/oXeC1iFoEetlFVWME1XILpWDJIG8qbnikYiL
         8bBKp/qbMNA4yta5u3H4pJzvqI5pE1Pm9/UQBQeg0kGst3FpJgkVolbvN4PRlL6lZ8F5
         prNwCMJM5M/WVXOFuHJyu4SW+7UbZwdE3r7JHWrFZkLvD/9fefriC4SrNuX+i/G2n0EH
         QPm62danAYS1seYwCiCvYsM4u1bQNKKh+goGGsdKvo2mCvFHXch9RqQRAvMh3OW23+BN
         K0jO8Qz0IM0E6rVvJuoHF9FJ/cofoXyy/gEklRjdMv3Jgp6K91lzBxe44+G+l+F5R/YA
         Sx5w==
X-Gm-Message-State: AOAM532aD2tzWzQoivFmkQL7ryBuUzRTTFG8exKySB4FAj7iXYvWigzF
        8WEYA58JDYMc3Ru5LIyZIb43EA==
X-Google-Smtp-Source: ABdhPJxpkafTXkKvGJHA7aA0u50WutkG/PVWSHFxm9DTViiMH8PsMPRMvCNLbKu9rHqMZj1o5whwtg==
X-Received: by 2002:a17:906:ca50:: with SMTP id jx16mr4131927ejb.72.1616492553383;
        Tue, 23 Mar 2021 02:42:33 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g11sm12635053edt.35.2021.03.23.02.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:42:32 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:42:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
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
Message-ID: <20210323094229.GU2916463@dell>
References: <20210228124106.135812-1-konrad.dybcio@somainline.org>
 <20210228124106.135812-2-konrad.dybcio@somainline.org>
 <20210322161810.biagj2qro66rv4gt@maple.lan>
 <20210323083935.GF2916463@dell>
 <20210323093540.dqrhjlvr6oza3hvt@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323093540.dqrhjlvr6oza3hvt@maple.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021, Daniel Thompson wrote:

> On Tue, Mar 23, 2021 at 08:39:35AM +0000, Lee Jones wrote:
> > On Mon, 22 Mar 2021, Daniel Thompson wrote:
> > 
> > > On Sun, Feb 28, 2021 at 01:41:05PM +0100, Konrad Dybcio wrote:
> > > > Add a compatible for PMI8994 WLED. It uses the V4 of WLED IP.
> > > > 
> > > > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > 
> > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > 
> > Why are you Reviewing/Acking a patch that was applied on the 10th?
> 
> Simply an oversight. Looks like I forgot to remove it from my backlog
> when it was applied.

I wondered if I'd made a mistake.

No problem.  Thanks for the clarification.

> > > > ---
> > > >  drivers/video/backlight/qcom-wled.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> > > > index 3bc7800eb0a9..497b9035a908 100644
> > > > --- a/drivers/video/backlight/qcom-wled.c
> > > > +++ b/drivers/video/backlight/qcom-wled.c
> > > > @@ -1704,6 +1704,7 @@ static int wled_remove(struct platform_device *pdev)
> > > >  
> > > >  static const struct of_device_id wled_match_table[] = {
> > > >  	{ .compatible = "qcom,pm8941-wled", .data = (void *)3 },
> > > > +	{ .compatible = "qcom,pmi8994-wled", .data = (void *)4 },
> > > >  	{ .compatible = "qcom,pmi8998-wled", .data = (void *)4 },
> > > >  	{ .compatible = "qcom,pm660l-wled", .data = (void *)4 },
> > > >  	{ .compatible = "qcom,pm8150l-wled", .data = (void *)5 },
> > 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
