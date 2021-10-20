Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A4343451C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 08:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhJTG0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 02:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTG0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 02:26:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80506C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 23:24:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n11so15408112plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZMa8oCiSPBB4qo4oZt/cEUfPi1StRHdqetrtRfqP29Y=;
        b=kTa0oB0oyUuF2eXHW8FxZr/FXVaCNsZ3FWzqfiNr+TmvWIino64ikTH55/AD8Y8WMW
         Ks+c1IsZxgXGEKBPkE//6YEXeWwlkwR6T64Iy0NHqc76Tkl/OBpu3QR/Afe7N3+QdCLE
         AkJs5N6rmLHSRqIo1aiA6vQGGiMxWWFQ+I5FzZ+DlUG+Sy8VFX9V9pXsN0X3/e+9C4wr
         x2P3ao+F/hIq2Eg1FmSscVgt/Sp6Rl8lh7b2h1r6czNZqAI/rhABg0IPHCLJ5HQnHCly
         sQP4OL78IkBOIaSBjk1lQlbJ7dCXTq9rVjoQqwSvj8LH1hU0OYs23KqTas+DT2bvXt79
         eAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZMa8oCiSPBB4qo4oZt/cEUfPi1StRHdqetrtRfqP29Y=;
        b=kej2Sru6dyBUPLwBT7WpiDTokP7HAyxmufZq4/v02B6q+wMffUvB4sKZBtW8l96EjS
         JxWCUvIVWSP62LeXpjpNQRVEqvPlnqxqsL1ODO6tWefMn/9S+6EL1GQ7A4A/kR6CRd8e
         VKmXsGKQqX3+9Z41aoBasYlvzDxwJayNmq3Hb5hEcDmDx1nMnHX3Iy9Bltac+sRGXIlH
         D/k4Ka6Jn0LredFG/+zHOElDt0NvwAAW8lCrpO9UKrHf6Lbn0zl0kVvcbTafv3XavpLC
         pXeO2HwYv9TwmvFsSv6FWxtG4RiF0UHxJaQFXyIkHpxvhihQKA1JMyrniiNoYMsPm3kI
         hLXA==
X-Gm-Message-State: AOAM531ea3pMSopEzHFg9n36J0u+dMAFDhkcS9k+KgmdtUQGALEynPS4
        qHmgy3zOCTU3k/QHf5hZ5Leh8w==
X-Google-Smtp-Source: ABdhPJzc0yxm5eltZXJQ58Hmi+kcJAwZ05JeeKVXS9q3nCMOCBxWVA6imYyNjUY9sOcnWe4NzkhJvg==
X-Received: by 2002:a17:90b:3b52:: with SMTP id ot18mr5246540pjb.77.1634711063022;
        Tue, 19 Oct 2021 23:24:23 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id w2sm1176538pfq.207.2021.10.19.23.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 23:24:22 -0700 (PDT)
Date:   Wed, 20 Oct 2021 11:54:20 +0530
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
Message-ID: <20211020062420.fcckkt2f55b54ipq@vireshk-i7>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com>
 <20211014145555.uoi2hyoonrptrd5m@bogus>
 <CAPDyKFppiogQ5GLQJCqvYGfDQ80HrLLiv43o4H4WBW0PqyONNg@mail.gmail.com>
 <20211019072425.dvq3ummjdkjmucgm@vireshk-i7>
 <CAPDyKFqk_-YQjEECLm_gM6UpMahRok4vNnxCv3i614OEvPuD2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqk_-YQjEECLm_gM6UpMahRok4vNnxCv3i614OEvPuD2Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-21, 15:58, Ulf Hansson wrote:
> To me, this looks doable from a genpd provider too. Of course, we may
> need to extend the genpd interface a bit to make it fit well for this
> new use case, of course. And I am happy to help, if that is needed.
> 
> One thing though; how is the aggregation of the OPP votes expected to
> be done? Is that entirely managed by FW - or is it expected that the
> cpufreq driver, in this case, keeps track of the aggregated votes too?

In case of cpufreq drivers, the voting is never required since there
is always a single request from cpufreq core to change the freq for a
group of devices (CPUs). And these genpds will only have a bunch of
CPUs to serve.

> Don't get me wrong, I am not pushing for these DT bindings to be
> deprecated (at least not yet :-)), but I would certainly like to
> understand more about them. In the end, we haven't walked this far, by
> extending genpd and inventing new DT bindings to enable it to support
> "performance management" - then just to just forget about them again.
> :-)

I am happy to move to genpd if this can be done in a sane way there :)

-- 
viresh
