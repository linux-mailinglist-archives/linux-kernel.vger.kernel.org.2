Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756944207B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhJDJBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhJDJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:01:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156BC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 01:59:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s11so15872979pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xctOnjrfnqdPEoa3tip3/LlkAqa1IsoEyPkzXNFOgl4=;
        b=vD0cU/s1vm+3nN3lc+qpbOlY1NZ1fr0ctroE7oqMauOwCiUPyYuFmJq2iHdj2yHSx9
         EiHX3gnukAK5oNEdfYHdgNjabX0okaUXHKZV0xiX2RaGT2lLxg1fYfi//6zJGwUdt+SY
         6BOCQO3a9i70wemWlftieZo7eGP2Wr3PQ1ffejuZ3hT7lGtrevzshVjLoXv7AcKUJpli
         CGZSFFeFtfihedDziaakSFO46idMianbhp9G9y+bwfSdj8uOL7ppMkYEu7t8FlVnmkTn
         P36E16bLWmXY5v5vwxtlsKffKjhKBwedcJx4nIH4iyzzaXuacMz9J59SzoxdFULOmpYF
         QDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xctOnjrfnqdPEoa3tip3/LlkAqa1IsoEyPkzXNFOgl4=;
        b=jz/1qzQXoELXUqWYv/TiQiNkMmaJVSt9k5fvwd0AV4GS3c9Id6uWsKoAAnNqAo8xd3
         t/uZGCh4d3+FjxD17WRzznzfUafrw1EwZwNip7c5gd4yI5nEt/+hbEfuBW2qTzsoPSO4
         dVB2zkOu/dZfJnQFZOQdSdzRzCV8Yj1P/7bd8WRiIL3JrQ7iZedBJ6X2KotI0hg7v/Wp
         R8PmzdoCc8Lg5kDcyHulMXDdQMRdTqJ71y0HOldvNRCrlVx9dapVePPiOYuW02VTw/3H
         3GL8TGXNPyb0Mgbp542vez/SQLtAaZCrqJKZg9JPMNk9eLv4wt+yLVW+tg7Zc3HWmJkB
         xDkA==
X-Gm-Message-State: AOAM532I1L+X4k11NoyfHCMcn2TlsFakBPOt5NoHmt3hdWThREp4/yox
        Y+0s5xo/hITQZhjLhk2QJHxstg==
X-Google-Smtp-Source: ABdhPJwSNvRu3CTp59vBuvr4RaMFcbMupvPQgnOOoX2hPpfzNEnqMHeDbG4cz+HBTly8u85sYIveag==
X-Received: by 2002:a63:a03:: with SMTP id 3mr9931268pgk.326.1633337994442;
        Mon, 04 Oct 2021 01:59:54 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id d24sm13622896pgv.52.2021.10.04.01.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 01:59:53 -0700 (PDT)
Date:   Mon, 4 Oct 2021 14:29:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rafael@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML
 bindings
Message-ID: <20211004085952.3k7efa3lxlll3ivy@vireshk-i7>
References: <20211004044317.34809-1-manivannan.sadhasivam@linaro.org>
 <20211004070531.sexvnqmnkoe4j6a2@vireshk-i7>
 <20211004072222.GE16442@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004072222.GE16442@workstation>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-10-21, 12:52, Manivannan Sadhasivam wrote:
> On Mon, Oct 04, 2021 at 12:35:31PM +0530, Viresh Kumar wrote:
> > On 04-10-21, 10:13, Manivannan Sadhasivam wrote:
> > > Convert Qualcomm cpufreq devicetree binding to YAML.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > I am not sure if Rob ever gave this.
> > 
> 
> I'm not fooling you :)
> https://patchwork.kernel.org/project/linux-pm/patch/20210701105730.322718-5-angelogioacchino.delregno@somainline.org/#24312445

I did read that email but somehow missed the RBY :)

-- 
viresh
