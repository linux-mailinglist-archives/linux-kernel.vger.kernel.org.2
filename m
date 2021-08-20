Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD23F31F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhHTRFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhHTRFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:05:30 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92C2C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:04:52 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i3-20020a056830210300b0051af5666070so5544107otc.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qq2zv8NidueXDY9RTP1XJuRvSThnlS4Tgw1w5ySGQso=;
        b=Ytw/TvevBJJxmZa6v3680rG8IdGuSSouHc+vk1jAd56rLtVmS0gGLVXQtUg/J3egdM
         K2ob+s5ABx/4KKfUf4O2M/c143PU72dI09LGRepF7DGG3feZgUwIDijuB2P+vrs29rN6
         0hjjPEeYGP5HUOY4RuHR2Wy6ebUz402nb49W4is+Itpa1cp6j9eN2X+zRb026WCwTJZP
         BaLMM2CfHKKtnDuV2CFyfYMRk/N6d02okEsyBaoSAwHH/uzht9GWm9S3Rqrz/FgWG1gn
         RqmDyzVc+WpK7PvSwRP6NchHXiMEcw7buAVCB9PJRvaNsz9RCg3XPb8FN02TzqR+/ByH
         DZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qq2zv8NidueXDY9RTP1XJuRvSThnlS4Tgw1w5ySGQso=;
        b=bPwzGh2MT7+Sr4ZlDdXXpq2+golTwRyAFc8I4gAt2fzSChJWecU1PLsy9uDCv0qXx/
         HiWSLvx+haEfSPBzxbFC2ynBSb+9WHP2YgOfh9RcYXiuFnlY6ShGvPcwhIXFSJjwxEr4
         vxD3Crelguy2NTFbbOFCHTADbMwyr4OooAWH38EgmWOBE6jltXZusLTojWMMHhaxDYY0
         FRpcBvdP+B2I4PDnsvButSmgw5gIPtPgGQhFuguaUBDkNNNLMf0+qONCmplCHEmUeZ5m
         L6+mDnRBCj8xqJPD6txBfpVTBFrYQzueKLqFbHDpG2FdpLp/z0iWGXQySKtMtjqMQFOW
         Y3vg==
X-Gm-Message-State: AOAM532Zeg6YYTm/rrGVHoEDE/TK1kZBQ/S2vkcPu4DO140JKsBEe7WK
        +KfqK907HmdjbTW4jLxK6mrYuw==
X-Google-Smtp-Source: ABdhPJzf9sPEVI5OzR130ghE05XTbi5B3J4mkCHel8gpOF4PQEyk1+jhfPwySwCC8YhKiqcXpJYHKw==
X-Received: by 2002:a05:6830:2808:: with SMTP id w8mr15018728otu.244.1629479092057;
        Fri, 20 Aug 2021 10:04:52 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u27sm1720689otj.6.2021.08.20.10.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:04:51 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:06:13 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Vinod Koul <vkoul@kernel.org>, robh+dt@kernel.org, will@kernel.org,
        saiprakash.ranjan@codeaurora.org, swboyd@chromium.org,
        mka@chromium.org, ohad@wizery.com, agross@kernel.org,
        mathieu.poirier@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        evgreen@chromium.org, dianders@chromium.org
Subject: Re: [PATCH v3 06/10] arm64: dts: qcom: sc7280: Update reserved
 memory map
Message-ID: <YR/hBYyYuYWN68LV@ripper>
References: <1629344185-27368-1-git-send-email-sibis@codeaurora.org>
 <1629344185-27368-7-git-send-email-sibis@codeaurora.org>
 <YR3gAD68xRtNJRhi@matsya>
 <39da02506af192de14d346cdf80d0e4c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39da02506af192de14d346cdf80d0e4c@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Aug 07:09 PDT 2021, Sibi Sankar wrote:

> On 2021-08-19 10:07, Vinod Koul wrote:
> > Hi Sibi,
> > 
> > On 19-08-21, 09:06, Sibi Sankar wrote:
> > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > index 5e4f4f3b738a..894106efadfe 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > @@ -48,6 +48,16 @@
> > >  		#size-cells = <2>;
> > >  		ranges;
> > > 
> > > +		hyp_mem: memory@80000000 {
> > > +			reg = <0x0 0x80000000 0x0 0x600000>;
> > > +			no-map;
> > 
> > This should conflict with the memory defined in this file:
> > 
> >         memory@80000000 {
> >                 device_type = "memory";
> >                 /* We expect the bootloader to fill in the size */
> >                 reg = <0 0x80000000 0 0>;
> >         };
> > 
> > I think this should be updated?
> 
> Vinod,
> 
> I prefer we leave ^^ node untouched.  For platforms using hyp_mem, the
> regions defined in the memory map are valid and for the other
> platforms not using hyp_mem we would just delete them in the board
> files anyway.

Logically this node describes where there is RAM, the reserved-memory
then subtracts blocks of memory out of that. So I think it's perfectly
legal for a region at the base to be marked as no-map.

That said, isn't the address in the memory node just a placeholder?

Regards,
Bjorn
