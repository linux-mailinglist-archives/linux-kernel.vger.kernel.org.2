Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1EB39CD62
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 07:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhFFFJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 01:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFFJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 01:09:01 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602EFC061767
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 22:07:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u11so14503366oiv.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 22:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yS6q0T3N9afYQN5HdfWE5z7pv3ReU18X80dOdXsawn0=;
        b=F2tuo+vePIjuZq6maCAptHCP9qgP3Apo2dhGkToFBYsgQdS2L6KJYf4SOxlHZjH2q3
         EZ3tuCclRrjKH1U+Q8NXEqvjUwcKpxhUOhlP4Ocs5B8IwJwNKBJnPWswJTXxLPh2Rns0
         ahKPWlSSOGkau6mcxd86A91vqGNXDSRwgWCuhlS7UZJLhpeuwJt8OyLa8GREd4p3Efrg
         scPUoR8t+/KNb/DMHoL1gVHTkMrQlVzE+KhkPPvMmQa7W70sa3W2fFiCXGiJ30oT9SYm
         9pnWP5wM1ur9GWhqelEhR4TcHMr6Gz2FUnMjHk6Yyq9E6FptvVK1nmQIi70zdgjQCu2q
         qc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yS6q0T3N9afYQN5HdfWE5z7pv3ReU18X80dOdXsawn0=;
        b=Nvl/zNYyTKhQRAUk4Htag6Xi3Su+4AjXgRZ7sN69bpzGe+gDNXSor4ovZmOCpsB4pF
         ZsdBe9hEj0qVxErcwpEDzQe3by2t6CxScEcGDGCs3mA9y+Pkfm2MmWxiJyBIyIO4EviF
         EgZuKPl0S8os0UcYan4a5PECylqu/s3QFlXT6uJlk+RKlDah7A3TyYzDEaAviz6/aHf8
         NjCJEUof6rfN3DGNz3gOrDxleATzy1u1uT0rmME5HMkyEJJ8rGUvfVJpsiN7DMVPbWv0
         F2Qtpu+QCp+TQeqOTBX1ytCEcCn3TWp2m/Hpp6hd8eF8DLcfnsNG+V2/vu5fOOsJpXE6
         BK5w==
X-Gm-Message-State: AOAM532asY4AHu1bAH7jYnPqh0N0RgSjEwOAbtjLHAKnMlDU/Ov2MKyv
        FWKfVbcsEjhz0D2zEjQdeFPDAg==
X-Google-Smtp-Source: ABdhPJxq+wFGA2yHIm0XUjuXzAIZpsyd09ngggNZe3/Va1Pg+/uWCcOXkmOOvCcKNZfj57WIIzO/AA==
X-Received: by 2002:a54:4e82:: with SMTP id c2mr15961103oiy.137.1622956031734;
        Sat, 05 Jun 2021 22:07:11 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 123sm555226ooe.24.2021.06.05.22.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 22:07:11 -0700 (PDT)
Date:   Sun, 6 Jun 2021 00:07:09 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     khsieh@codeaurora.org
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, agross@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/dts/qcom/sc7180: Add Display Port dt node
Message-ID: <YLxX/YtegtbLmkri@builder.lan>
References: <1622736555-15775-1-git-send-email-khsieh@codeaurora.org>
 <YLkI/6ItCz+SbbuJ@yoga>
 <ac326ec8689c0babb08b2311e19d52cc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac326ec8689c0babb08b2311e19d52cc@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Jun 16:56 CDT 2021, khsieh@codeaurora.org wrote:

> On 2021-06-03 09:53, Bjorn Andersson wrote:
> > On Thu 03 Jun 11:09 CDT 2021, Kuogee Hsieh wrote:
[..]
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
[..]
> > > +				power-domains = <&rpmhpd SC7180_CX>;
> > 
> > Just curious, but isn't the DP block in the MDSS_GDCS? Or do we need to
> > mention CX here in order for the opp framework to apply required-opps
> > of CX?
> 
> yes,

If you want me, or other maintainers, to spend any time reviewing or
applying your patches going forward then you need to actually bother
replying properly to the questions asked.

Thanks,
Bjorn
