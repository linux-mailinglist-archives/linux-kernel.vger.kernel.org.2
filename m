Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A87C42050A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 05:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhJDDDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 23:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhJDDDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 23:03:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D4C061782
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 20:01:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g14so13289749pfm.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 20:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TjNWNuR+gMWf2t1n3s/D7Jq0z4ZiFV+w9SGfLF5kxQg=;
        b=luns9ZSXpq0KwYmC30LME0ipn/Lhv8Yc/t39g1t4rSTQ+iFcOhBgGlExIX37NFUhbZ
         UaTJcfqDK0CKntIhETTytNStKpEhyWRnVsUW8cNqFrA8dzM5rgNDOQn5RW7cD4D/E63Y
         KrsltA8CCHxXkhKbsSNyFUrhxDCfowCmtCBTQ4hHx+YsmrwWUh2+HwiLk8Hs+wIhsQcm
         +wH+OiQMG8XFTB/o8n0eKyOUDztOs1MMG1bYOTKZEfosWVRY/egh6kHWy/rK9GzD7tGs
         HrwSr0yzEDxi5nSqgG+41GwZdW+eFpI/fGRp9/aHYhKcc24xmF1Sq9/GVnZd5cUhYhIa
         Jp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TjNWNuR+gMWf2t1n3s/D7Jq0z4ZiFV+w9SGfLF5kxQg=;
        b=mmn154QYuCYNY6O38gFj3hv+NIZih8yXxMcWhzzAIMhP5+Pip10Y30rLmTvoZCPapU
         eioKMHWtHmooZwYoNIvF9SrbPGu+13y6Aw8PG9y4GWCYGTnMcGm/fhK3DvGnKnFKetW7
         em+R56RxO3zr4S6N8N9HdVckS9r1sCjjoEa69uj+XWwJ5qpm7Emdagdp+s50ly4alnIk
         gm00+Gk+PXr6EyYUOXlpu1YcT4Oo9FuBWV86MM5G617IjE01wgQZ00iY/GdpH9MJI+SU
         14bYHPp8YYcWVHBjh9NB56vrphnMlh83XsXh+4LMAGWctqjT2aKf4PDvWZYlBh7KaGHT
         OT1A==
X-Gm-Message-State: AOAM5330j4lidFOnMOAA9eAUqHjQEAztoNhD0UArBzfVbdjkUTBd1MqD
        ZkaXz8sONyrbfxd4kPUYc2kG3w==
X-Google-Smtp-Source: ABdhPJx8e9TmH82hx3DHUZCdh+Mi5WHU8V7twDoiKMJ9iWdcG6G1h07M6jVbiAmzYwvghqe9IEqi/A==
X-Received: by 2002:a63:c5d:: with SMTP id 29mr5780720pgm.100.1633316495627;
        Sun, 03 Oct 2021 20:01:35 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id t1sm11656919pgf.78.2021.10.03.20.01.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Oct 2021 20:01:35 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:01:29 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jami Kettunen <jamipkettunen@gmail.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add missing vdd-supply for QUSB2 PHY
Message-ID: <20211004030128.GC13320@dragon>
References: <20210928022002.26286-1-shawn.guo@linaro.org>
 <YVbD12kTfbGmRYId@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVbD12kTfbGmRYId@matsya>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Fri, Oct 01, 2021 at 01:46:23PM +0530, Vinod Koul wrote:
> Hi Shawn,
> 
> On 28-09-21, 10:19, Shawn Guo wrote:
> > The series adds missing vdd-supply for QUSB2 PHY which is required for
> > digital circuit.  The driver works right now likely because firmware
> > already sets it up.  Add it to bindings, driver and DTS that miss the
> > supply.
> > 
> > It should not cause problem for existing DTBs:
> > - SC7180, SDM630, SDM845 based platforms already specified vdd-supply
> >   in the DTBs.
> > - MSM8996 and MSM8998 platform DTBs miss vdd-supply, but dummy regulator
> >   will ensure QUSB2 PHY driver works as before on these platforms.
> 
> What about the rest.. I checked SM8350 and SM8250 mtp ones are missing
> this. With the property made mandatory, I guess it would cause these to
> fail right..

From what I can see, SM8350 and SM8250 use qcom-snps-femto-v2 PHY
rather than qcom-qusb2.  So they should not be affected by this series.

Shawn
