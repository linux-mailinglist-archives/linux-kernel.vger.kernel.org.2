Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD9E432F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhJSH0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhJSH0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:26:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053B2C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:24:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so1421160pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KaZumjEr6psXo+FbbHL4XPGhQeR5rsWs0ksdjltFbos=;
        b=iKsbYIVyf1QTse1ZaTXBhGEWLxMZeZ75JqdhTrf6I4RzvpYcM0aLERf/klzsonMVnE
         q0O28e58EPJ9V17z4+UmN8NE6U4cj/lDNhGU8JsFFYrzjUlP0RFwgjxgXlHnB1+j8dW/
         vESheDbnsaM69yk1W+1AqdkB0HQrK1XSwpCqX9XOMTbOuDeHZpQvc5L34JULE9BkUYfI
         bkJbHbFE5B09lnk8KwhNBQsSoeHNEU58KKX8sQvr8PKLWl0BUe32FXJIYubD2yKg5+WO
         bjlha3YCvmOp08IRsmdt+yl1vliSuNs0j49VTg1UI3AfkTSoCE7q2XGwFa9pDO23G+6H
         tKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KaZumjEr6psXo+FbbHL4XPGhQeR5rsWs0ksdjltFbos=;
        b=TXE3fBIKC6sTCVT2FfPcKvp672fb0cVcnkXkXzHXf1RK1UJUNZ7Zi1Z5cZzpiFaKeH
         p5/FX+PoKE/HZE97UrEItJnR2uIlZ8e/PCtJ7irxN/oNV9/kRiokT36dK+YWAAv4EZl/
         ehgulhlDfCA+Uz+k5S19WD+ycvyYj/HfrVv9hzr8ofHbw3iZ8cIl72DqPTLc1yQxLHJ6
         FOIDKnlW8F3/CydWI0R5VK76Ll5Ba2WC27qZA8KrISc+S1ovCjWAm/gwn1DT0i0e2Ryn
         OHjfmo+VVp7JAmMv1Rqd3e7gvCQR4Uw9Wy36urCPmcUPjjJnwiPurdegjXbrI73H8R7/
         7wHg==
X-Gm-Message-State: AOAM532peye9WprV6PqiOej0tRI0qe98RPOzhms01ic3buwrmMjs3+HS
        eU84KusV/b4jpdix+/tgJy1VdQ==
X-Google-Smtp-Source: ABdhPJyIJENFs1h9BoLqt7ZOAPWKWBNXzr8a+IsYpfIX9BnUnBqnFC397oicesZn1p5th9KDtjtJ/g==
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr4684401pjb.124.1634628269463;
        Tue, 19 Oct 2021 00:24:29 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id p3sm15074490pfb.205.2021.10.19.00.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 00:24:28 -0700 (PDT)
Date:   Tue, 19 Oct 2021 12:54:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20211019072425.dvq3ummjdkjmucgm@vireshk-i7>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com>
 <20211014145555.uoi2hyoonrptrd5m@bogus>
 <CAPDyKFppiogQ5GLQJCqvYGfDQ80HrLLiv43o4H4WBW0PqyONNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFppiogQ5GLQJCqvYGfDQ80HrLLiv43o4H4WBW0PqyONNg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-21, 11:17, Ulf Hansson wrote:
> As far as I understand, the "performance domains" DT bindings that
> $subject patch introduces, allows us to group devices into domains, to
> let them be "performance controlled" together. Right?

This and it also provides a reg space where we can get/set the
performance state.

> Unless I am missing something, it looks like power domains DT bindings
> already offer this for us. Yes, certainly, the DT doc [1] needs an
> updated description to better explain this, but other than that we
> should be fine, don't you think?

I think yes we can make it work through that as well, but I am not
sure if we will be able to use required-opp n stuff here as the DT
doesn't have the OPP table for the CPUs.

The CPU's freq table is generated at runtime, see
drivers/cpufreq/mediatek-cpufreq-hw.c for example.

-- 
viresh
