Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0779C44E73C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhKLN0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhKLN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:26:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B096C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:23:40 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d24so15576194wra.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=02F/d82Dv5J0ghwlMisFlWdCmAUwQ0DAdk18ZSOkpFw=;
        b=SvJLLdpyF3SSSiTlAYmOpa6ZgStvxCKQeEuFYDONsZidEXTrU6xu771ccaw17ALyD4
         CtV7JIvP34Gwg4WBMQkLXKAIbctCicDYIz95fprmrwjyNxzmrY4N7MwxBVF6aOQ6D0aZ
         dQz2SL1ti+VXB1qJSzMkKkDWlwmHNsLTR6PCsMhsQt52IgaKc7EarkZYrnJpX6V/gZX0
         SjkTfLYBcDrF9m4P2/ij7pwzbf9roWdNR1AwMy0TPLosw6xjn/RfqocxU/zRTT1WgypE
         xW/c1mHpyoXSd+eQV9hVCdl+2MRFDNAP3xZeMFQtNXVU940kTgDDuMPFVLx5WEa6pXph
         SzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=02F/d82Dv5J0ghwlMisFlWdCmAUwQ0DAdk18ZSOkpFw=;
        b=fMamelZtUYtNku/C2O+2SO1UP704LCTNJa7pUqdhSJYqCSDUsh8VMtfHQrbAt4UjGY
         XMxNh/B0ZvowQ/l4QzuYawLeJyM8/HoublE6nQHUKwINH5NB+9Q3iAtuvI+8g/UKGmz+
         RUXa0HgOXIq1qjau/SUwGO4i07RcGnFHG98t4gbVBY/kd4dk8reS+fTcz0C7FJJbv0a/
         1CX9AN0zvsoceg2n2Qf/7skYxV4ca9qDXTjzVzzziBDOtEbEmY+sp8tr0qEMEUZ6quHD
         AR51JsXsGMgcLyPKMrFPFbDR9+5NLwlGzdByY3bUGRhBJXsK/uKujYpFYWL+X3XswH8V
         S5xQ==
X-Gm-Message-State: AOAM532hxeSoCmbeJE9+xWNN4QYytG4y06SwWwpRPH8ZV9Q3BitD/Pgm
        DVl0CMElOX1ngkiAMISuHEOm1g==
X-Google-Smtp-Source: ABdhPJwcyZkEOCkjfNZQaL+Oh4iQ1CcSgH8jFbjI9XgbrvnN5WJtc4Sj5+iD/+0FjB9rIkKVy0VGDw==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr19111085wrm.280.1636723418610;
        Fri, 12 Nov 2021 05:23:38 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id be3sm1422460wmb.1.2021.11.12.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:23:38 -0800 (PST)
Date:   Fri, 12 Nov 2021 13:23:36 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [RESEND PATCH v2 05/13] backlight: qcom-wled: Override default
 length with qcom,enabled-strings
Message-ID: <20211112132336.z2x4bzrfqr4u3jol@maple.lan>
References: <20211112002706.453289-1-marijn.suijten@somainline.org>
 <20211112002706.453289-6-marijn.suijten@somainline.org>
 <20211112121238.kb3kkt6xzv5so26j@maple.lan>
 <20211112124522.g7e3m7l2oxxxobof@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112124522.g7e3m7l2oxxxobof@SoMainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 01:45:22PM +0100, Marijn Suijten wrote:
> On 2021-11-12 12:12:38, Daniel Thompson wrote:
> > On Fri, Nov 12, 2021 at 01:26:58AM +0100, Marijn Suijten wrote:
> > > The length of qcom,enabled-strings as property array is enough to
> > > determine the number of strings to be enabled, without needing to set
> > > qcom,num-strings to override the default number of strings when less
> > > than the default (which is also the maxium) is provided in DT.
> > > 
> > > Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > ---
> > >  drivers/video/backlight/qcom-wled.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> > > index c5232478a343..9bfbf601762a 100644
> > > --- a/drivers/video/backlight/qcom-wled.c
> > > +++ b/drivers/video/backlight/qcom-wled.c
> > > @@ -1518,6 +1518,8 @@ static int wled_configure(struct wled *wled)
> > >  				return -EINVAL;
> > >  			}
> > >  		}
> > > +
> > > +		cfg->num_strings = string_len;
> > 
> > I still don't really understand why this wants to be a separate patch.
> 
> I'm viewing this as a separate issue, and this makes it easier to
> document the change in a loose commit.
> 
> > The warning text emitted by the previous patch (whatever text we agree
> > on) will be nonsense until this patch is applied.
> > 
> > If this patch cannot appear before the warning is introduces then there
> > is no correct order for patches 4 and 5 (which implies they should be the
> > same patch).
> 
> Agreed, this is a weird way of doing things in v2 - the error message is
> printed yet the length of qcom,enabled-strings is always ignored before
> this patch.
> 
> If we were to reorder patch 5 before patch 4 that should also
> temporarily move `cfg->num_strings = cfg->num_strings + 1;` right below
> this `if` so that `qcom,num-strings` remains the definitive way to
> set/override length.  That's doable, and makes it easier to read patch 4
> as that bit of code will be replaced by of_property_read_u32 on that
> exact line.  Let me know which method you prefer.

Personally I would just squash them together. There are no redundant
values in the DT that could be fixed until we can use the string_len
to set num_strings.

However I won't object to the other approach providing the result is
bisectable.


Daniel.
