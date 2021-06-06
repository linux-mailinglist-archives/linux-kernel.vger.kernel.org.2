Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC039CD66
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 07:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhFFFNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 01:13:51 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42723 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhFFFNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 01:13:50 -0400
Received: by mail-ot1-f53.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so8988845oth.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 22:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dhdp3uNglhwNTsHHri1BRiXlcER9kLclnHgN/OT8h7c=;
        b=sn+EDz/EJCkCChBWKb/9tL+zQp5Jb+1gfVogm07usOLh1sXrIOMRHJY/sEQKcZkoK/
         kSApQEM2z2ua9vuxm3D0LmCZ9rnw8ueVrvv4RmjVdqOc/fOv3mg5A1ADlNqZNmF6zIaM
         KLT/fjR3KTwevH7sFuKzxVqxtH+zqpWVPQOe1Tt+bOS7HCIlKCeox0e7I/LkiGmDSpwB
         7N/eG4rAI+1SqVN3ns8AO6u8/h6NaEi8sAI5ic+r7FCW0fnZPzuVqG/7ofY1GP51oxyW
         NlgabchqGLK7dFcmn5pJsfvgxA8D+zxdh5nzvnt0M/q8wiPwFSZgseL9sl9+MlrHdDeL
         0meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dhdp3uNglhwNTsHHri1BRiXlcER9kLclnHgN/OT8h7c=;
        b=YFM645aXpgYt7wYp/QYEKogxLEkTKnAFnQyonupk6GpW2LXsXRbSFkJJnl79jAe7T8
         nVQK+yHuGNSS84PgM/uaLCCDFaF7KZTkp1BOAZnzkVDkvTkjaX1ZFJzU2sD/v3nHW9CV
         xOWbH6zavux1iI2I6WzNYOQ3+NIuS+luPEAnXtqr5onMDp1KfQejcg6Fw1i4vvIzhkD8
         RQCKkwWMowI6KGHtHt16PjAQA1m33+JGLHfv0fuew+X8Zb/TE94em3IirmKSMdBvGKjg
         FVFg1L8D09ts494S37yClpdh30+ZZqMyznKPs4EJcFoEoRT8LQUF/lMHwvQ7bs1+2Ekn
         ZQ0A==
X-Gm-Message-State: AOAM532AXw97u+KJ0g0Igt6neqlL7d2f7YPJs13EYrsiCDWqRRmqJvFD
        hedxLCrOjPBA/PjlRQ+uW3Q3pA==
X-Google-Smtp-Source: ABdhPJylLokjeZeh9DBiyvKHPflkIDq3GZv+lCwnvGJbU9ZKWoEZIYkXaSd11GiWy/GYFoTetvCl5A==
X-Received: by 2002:a9d:29:: with SMTP id 38mr9720065ota.30.1622956247882;
        Sat, 05 Jun 2021 22:10:47 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o20sm1532599otl.2.2021.06.05.22.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 22:10:47 -0700 (PDT)
Date:   Sun, 6 Jun 2021 00:10:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     agross@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-mtp: enable IPA
Message-ID: <YLxY1Zmznfz6UkJM@builder.lan>
References: <20200519123258.29228-1-elder@linaro.org>
 <a9904eae-3de3-8b40-f0be-790c787133bc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9904eae-3de3-8b40-f0be-790c787133bc@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Jun 13:03 CDT 2021, Alex Elder wrote:

> On 5/19/20 7:32 AM, Alex Elder wrote:
> > Enable IPA on the SDM845 MTP.
> > 
> > Signed-off-by: Alex Elder <elder@linaro.org>
> > ---
> > 
> > v2: This device uses the AP--not the modem--for early initialization.
> 
> Ping.  This patch didn't get accepted (over a year ago!),
> but it still applies cleanly on top-of-tree.  If you
> would like me to re-send it, let me know.  Thanks.
> 

I'm not able to find any reason why I didn't merge it, perhaps it was
because we had issues validating the whole thing?

Anyway, I've picked it up now.

Thanks,
Bjorn

> https://lore.kernel.org/lkml/20200519123258.29228-1-elder@linaro.org/
> 
> 					-Alex
> 
> > 
> >   arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > index 1372fe8601f5..91ede9296aff 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > @@ -448,6 +448,11 @@
> >   	clock-frequency = <400000>;
> >   };
> > +&ipa {
> > +	status = "okay";
> > +	memory-region = <&ipa_fw_mem>;
> > +};
> > +
> >   &mdss {
> >   	status = "okay";
> >   };
> > 
> 
