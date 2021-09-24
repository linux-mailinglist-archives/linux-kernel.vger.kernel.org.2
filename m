Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAD1417AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 20:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348135AbhIXS0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 14:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348141AbhIXS0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 14:26:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4E2C06173F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 11:24:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l6so7037915plh.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EP6W0vCV7VcCce2x/TM6UlI/+w3odhYij8dAWhkxhMI=;
        b=YMGHnaA/QZw6ZKa/+vjlDAM7oxvtvPbnihzCpr3uaLFIXyjVA5gYfyzMNdXSeYTGFu
         nHUrQm3jQchTZI7ZInkcZzjP/dLhj6Pm5cDonjfmXDN2VnF4lvKjnqWMeZgcJClWzpMa
         O+tQCrZewlEAiLhYB2sigsDNnWIthCJ8syZUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EP6W0vCV7VcCce2x/TM6UlI/+w3odhYij8dAWhkxhMI=;
        b=YoYvWM6onXaLxBFjHmEcWd00Nfih5un9PjqOC5wfrhE7/u8zSTEcYnrzmyClsPDBE8
         UZLqe97S+BAuR+Yj8R2SmRw62GW5FVh5LSqMpvvRP1UmN/YYesXkeXGk7j3SvUcVBIuv
         l3AFWCbQVERUy/r7lK8WOGsyIUoQKsce8GlI9wK5dpjx1T/+nTdm5qj/S5ZvMBeK1wXK
         7IUdJZL6Hr1Uir6ZqxA6/4mKCgzXl/09xBH3Aj7mMXwHrf6/0i3yABtqx9k75hx7+j7T
         6R1icNenxHiOyF8g6rqnB8ozkS2nqsnTlF0frB5jY54KIbDtXxAQ0ddIFO7JaiThTHfy
         NXcQ==
X-Gm-Message-State: AOAM532RRylgKsJp1H4N4c7WuGtMRk+6WHsZp3OJGwBGcoGhVzP9vBQ+
        PQ3TIaeP9QI9Y1DF4dL8wwvPLg==
X-Google-Smtp-Source: ABdhPJwQEXsZUJWmec8W7daR+8cixMG9ht80xnAs+Z3lg833vui4wbCsw1k1sco9vou06/mSZM+vjw==
X-Received: by 2002:a17:90b:4f4d:: with SMTP id pj13mr3876535pjb.47.1632507899355;
        Fri, 24 Sep 2021 11:24:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:ce0f:b846:1471:cf7e])
        by smtp.gmail.com with UTF8SMTPSA id a10sm9431081pfn.48.2021.09.24.11.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 11:24:58 -0700 (PDT)
Date:   Fri, 24 Sep 2021 11:24:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Base homestar's power
 coefficients in reality
Message-ID: <YU4X+QH2X00ah7Gh@google.com>
References: <20210923081352.1.I2a2ee0ac428a63927324d65022929565aa7d8361@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923081352.1.I2a2ee0ac428a63927324d65022929565aa7d8361@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 08:14:04AM -0700, Douglas Anderson wrote:
> The commit 82ea7d411d43 ("arm64: dts: qcom: sc7180: Base dynamic CPU
> power coefficients in reality") and the commit be0416a3f917 ("arm64:
> dts: qcom: Add sc7180-trogdor-homestar") passed each other in the
> tubes that make up the Internet. Despite the fact the patches didn't
> cause a merge conflict, they need to account for each other. Do that.
> 
> Fixes: 82ea7d411d43 ("arm64: dts: qcom: sc7180: Base dynamic CPU power coefficients in reality")
> Fixes: be0416a3f917 ("arm64: dts: qcom: Add sc7180-trogdor-homestar")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> index cd3054226865..382f8c6f1576 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> @@ -51,7 +51,7 @@ skin_temp_thermal: skin-temp-thermal {
>  			polling-delay = <0>;
>  
>  			thermal-sensors = <&pm6150_adc_tm 1>;
> -			sustainable-power = <814>;
> +			sustainable-power = <965>;

Just as a note: the original values corresponded to the modelled power
consumption of two big cores at 1.55 GHz. The value was based on
'/sys/kernel/debug/energy_model/pd6/cs:1555200/power' and multiplied
by two. So the new values could be determined in the same manner.

In any case these values are approximations, it's not really important
that they match exactly those of the energy model, as long as they stay
in the right ballpark, which the new ones do.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
