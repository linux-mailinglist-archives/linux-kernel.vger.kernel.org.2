Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59354223BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhJEKoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhJEKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:44:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4676C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 03:42:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m42so5432798wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pVmRMn4rUtOm+1OEO0FywEMDowWiLVKHkRDbrijKrwg=;
        b=ZS4YWF0OVkd9jDh40UlLY2uWt9d78SYkfjqGVKzM8G7JktwnA3ZteL30wEy+4PTRQ4
         XemlL5BOCByzoBuNx8gMHUkinaI3VAsxs3agCljtjM2BJ4R7QMgIr2glQ/g0PXhB2nCR
         tsfYgj9lJY3iPWBf/OmK4QTrupPJGVj1MdGUb2lHG5tt3aYvEPIFvmZPqkNkvOHH2EqN
         juUBaWFSztsy/ioPPpV+e4Vr+Iv7Ce5UflDsH3oMJUoTR8y9CjLz6P/xHautUGrUdYNm
         8nDQjmCoHgV7KEXm3LLN3JPxmk+wXRxcZ1j7ig9qgk6ZPKxaQxptiOnOorsFd6RyEciP
         AKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pVmRMn4rUtOm+1OEO0FywEMDowWiLVKHkRDbrijKrwg=;
        b=lwWo3iH7Dv0c6D1xXecGrkqAs8JE7TBMZfyLiMSK3Jh3MxirAhQsUltufkAtxkl0Kv
         ib96Z/BxM13j01EC7R3XujhBeJiHhQHut5bS8oe2l11leJ0+yv22OznPTwt8z7KaCouD
         nLh1mJi9PHQP2yGgQsAPfOW79iIAWgohaiRBWqDAguoUOJ3JOepFTKgS9kKBgiSm/RKp
         41YkXShMNDJ9bFADEWIVoXBIi+t34A7gEWjbdbTPbgs8Stt763e4sfG8FTlGb5vg2XSj
         orLDAnuYZx1/UYfYpapSgziXQNuoOtoFVFDB27i78QD2sPs92VNTT/mfEuYm4+fRDQPz
         TiNQ==
X-Gm-Message-State: AOAM533dSxyee0EHrEQ3eHPsYYWZfxPDa+QD7o60CqUqi09CbNoTst2f
        sRt6cGygzxTMjyMCWkaSGS45ig==
X-Google-Smtp-Source: ABdhPJzk4476G45fhoT/tD2ExwshD2DdotRERLbyFyzc5wY17wFdvvLODEf4w4SPO9mjXk77xKdD6w==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr2588809wmb.140.1633430539291;
        Tue, 05 Oct 2021 03:42:19 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id k18sm699320wrn.81.2021.10.05.03.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 03:42:18 -0700 (PDT)
Date:   Tue, 5 Oct 2021 11:42:16 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] backlight: qcom-wled: Validate enabled string
 indices in DT
Message-ID: <20211005104216.7hqqdyqcqekqhg56@maple.lan>
References: <20211004192741.621870-1-marijn.suijten@somainline.org>
 <20211004192741.621870-5-marijn.suijten@somainline.org>
 <20211005091452.4ecqhlhrdxdgvs3c@maple.lan>
 <20211005100350.p56xuq74qsc7vhyp@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005100350.p56xuq74qsc7vhyp@SoMainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 12:03:50PM +0200, Marijn Suijten wrote:
> On 2021-10-05 10:14:52, Daniel Thompson wrote:
> > On Mon, Oct 04, 2021 at 09:27:35PM +0200, Marijn Suijten wrote:
> > > The strings passed in DT may possibly cause out-of-bounds register
> > > accesses and should be validated before use.
> > > 
> > > Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> > 
> > The first half of this patch actually fixes patch 1 from this patch set.
> > It would be better to move that code there.
> 
> It only helps guarding against a maximum of 3 leds for WLED3, while
> using string_len instead of an unintentional sizeof(u32) (resulting in
> a fixed size of 4) is a different issue requiring a separate patch to
> fix.
> 
> Would it help to reorder this patch before 1/10, and mention in patch
> 1/10 (then 2/10) that, besides properly using string_len instead of
> hardcoded 4 (which causes wrong reads from DT on top of this), it relies
> on the previous patch to prevent against an array longer than 3 for
> WLED3?

Reordering is OK for me.


Daniel.


> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > ---
> > >  drivers/video/backlight/qcom-wled.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> > > index 29910e603c42..27e8949c7922 100644
> > > --- a/drivers/video/backlight/qcom-wled.c
> > > +++ b/drivers/video/backlight/qcom-wled.c
> > > @@ -1526,6 +1526,12 @@ static int wled_configure(struct wled *wled)
> > >  						     "qcom,enabled-strings",
> > >  						     sizeof(u32));
> > >  	if (string_len > 0) {
> > > +		if (string_len > wled->max_string_count) {
> > > +			dev_err(dev, "Cannot have more than %d strings\n",
> > > +				wled->max_string_count);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > >  		rc = of_property_read_u32_array(dev->of_node,
> > >  						"qcom,enabled-strings",
> > >  						wled->cfg.enabled_strings,
> > > @@ -1537,6 +1543,14 @@ static int wled_configure(struct wled *wled)
> > >  			return -EINVAL;
> > >  		}
> > >  
> > > +		for (i = 0; i < string_len; ++i) {
> > > +			if (wled->cfg.enabled_strings[i] >= wled->max_string_count) {
> > > +				dev_err(dev, "qcom,enabled-strings index %d at %d is out of bounds\n",
> > > +					wled->cfg.enabled_strings[i], i);
> > > +				return -EINVAL;
> > > +			}
> > > +		}
> > > +
> > >  		cfg->num_strings = string_len;
> > >  	}
> > >  
> > > -- 
> > > 2.33.0
> > > 
