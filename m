Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522F239EA31
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhFGXe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:34:56 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:39761 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFGXez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:34:55 -0400
Received: by mail-ot1-f54.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so17435695otu.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pYTvT9ubISsRaLeWVshLEwMcGZ3wwUzz5ZnXQAq/G5Q=;
        b=hZzVb3AlblV3JxW9qSZuCfP960vfYcWuKgRWH3bncsPDWCOejXYZ091GYK1SsVvu5g
         ru4/preWElYvWI6qTf3C5f6mF3hI0Tm9eL3d5/zk+96tSrWoAS2+6lTy24rzRzrJT8XR
         6hhfrdEf16V1ZVw+vjKiNwtYqntlBVwPbyB9fSsXQOQtEv7YY49NYodA3uUryk6TUTa5
         YpK0lgMwpZXYF3z4hqK2LcP/BL1x96fIVakOkPerSpNlHfYyAROKz05e9e6ZT4Yx5SNH
         xrbJBKTlCMdhUqiN0tirP1SvqPYyHSquSORt/6crQnlBuvfpA/redOIjhCo7v3Pur4HC
         9C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pYTvT9ubISsRaLeWVshLEwMcGZ3wwUzz5ZnXQAq/G5Q=;
        b=gbItYZrBDfpQrMKWfS0QN/xd3bN09q+iIE0DVhc285wmNb69Gnc4LCpkMKn8NKdMjK
         sGTX+f4nIEe/E+PYd88BKRQgtU4cA8UGGGpyVrfnQyPUUDrHf83wNM4lU6i6TOt6BQqB
         Qh5BClX5nKiCPnHouf6zEAoSuBfbOtoWYVPgV1v8/R5356iGuYjN0KVUE6SuSfxeYKzu
         IupPgNNlTdWrKTyHYUIdtAn7XYShlY1HBqHa0LiFG+Jov597g1SVRBWAltp37ECaCFU5
         K0j3mx2GdRL2+C6mjcnP627kSH1kGOtlXef4w5vgKxAuY7jU8aUzetFoW0NO8qYB03Xh
         F2bw==
X-Gm-Message-State: AOAM532B83EYg0+2lXyAbqErlVUnkl5ny5qptvlttT0JIlrcpkYgZvHr
        Z/A4mqRdm+HCshyCg/+eMkH6tw==
X-Google-Smtp-Source: ABdhPJzYINdaU88ZN26yUyqgewxkKu3o9+qJRNCObFoRd1mEFTKoDvaEpnIK1T2HLIM/JP+kh+DtNQ==
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr15592500otl.18.1623108710244;
        Mon, 07 Jun 2021 16:31:50 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 15sm2571809oij.26.2021.06.07.16.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 16:31:49 -0700 (PDT)
Date:   Mon, 7 Jun 2021 18:31:47 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     khsieh@codeaurora.org, swboyd@chromium.org
Cc:     robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        agross@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/dts/qcom/sc7180: Add Display Port dt node
Message-ID: <YL6sY/1E5wLzMiP/@yoga>
References: <1622736555-15775-1-git-send-email-khsieh@codeaurora.org>
 <YLkI/6ItCz+SbbuJ@yoga>
 <ac326ec8689c0babb08b2311e19d52cc@codeaurora.org>
 <YLxX/YtegtbLmkri@builder.lan>
 <ef1879fa7ecfefaf0c70c7a4782240a9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef1879fa7ecfefaf0c70c7a4782240a9@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Jun 12:48 CDT 2021, khsieh@codeaurora.org wrote:

> On 2021-06-05 22:07, Bjorn Andersson wrote:
> > On Thu 03 Jun 16:56 CDT 2021, khsieh@codeaurora.org wrote:
> > 
> > > On 2021-06-03 09:53, Bjorn Andersson wrote:
> > > > On Thu 03 Jun 11:09 CDT 2021, Kuogee Hsieh wrote:
> > [..]
> > > > > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > [..]
> > > > > +				power-domains = <&rpmhpd SC7180_CX>;
> > > >
> > > > Just curious, but isn't the DP block in the MDSS_GDCS? Or do we need to
> > > > mention CX here in order for the opp framework to apply required-opps
> > > > of CX?
> > > 
> > > yes,
> > 
> > If you want me, or other maintainers, to spend any time reviewing or
> > applying your patches going forward then you need to actually bother
> > replying properly to the questions asked.
> > 
> > Thanks,
> > Bjorn
> 
> Sorry about the confusion. What I meant is that even though DP controller is
> in the MDSS_GDSC
> power domain, DP PHY/PLL sources out of CX. The DP link clocks have a direct
> impact
> on the CX voltage corners. Therefore, we need to mention the CX power domain
> here. And, since
> we can associate only one OPP table with one device, we picked the DP link
> clock over other
> clocks.

Thank you, that's a much more useful answer.

Naturally I would think it would make more sense for the PHY/PLL driver
to ensure that CX is appropriately voted for then, but I think that
would result in it being the clock driver performing such vote and I'm
unsure how the opp table for that would look.

@Stephen, what do you say?

Regards,
Bjorn
