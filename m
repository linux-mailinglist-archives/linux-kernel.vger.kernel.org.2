Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24383424051
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbhJFOqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhJFOql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:46:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493D6C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:44:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o20so9580827wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D8IjD/aX+SAqkEjm7xgEe5lxocD/PXw4l5YWyLqfbtc=;
        b=sjymcv1htUJfHr/ek8Mjj/Jzt/jL4wvmG/taOYRNvKcZWk9BkgQtJjHgO7wbXBFrHy
         meZmY5A0tTIXo7CrDb1wtV1kVUe0zpcretTP/oJR1dUYtCogFfD4itlw7SlETG69n6Xi
         cRM1/7X/fYoubACDyBPEiCkkKuAUi0hY2aAzKxEFA/nDteTiuhRMStnHbhpfANKS6SOo
         aZ2uU5GuqODutpS9OMjadts9W8OOjuOAgFSiKeYSCLDwsbW9Cov/zeNYAJFIXp8iKB4R
         qB3jLqqhLJY0SdzrfSgr+y6OWem7CqBIbjFWChJaTT0M0IN9Rp0D7UjF4OBKnk8d1pUl
         rGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8IjD/aX+SAqkEjm7xgEe5lxocD/PXw4l5YWyLqfbtc=;
        b=hrPTqhOXliocvDRWmyEdTEab+A4mffZZ7IzqhTt3f12pBc6Yn/i2BWqsrfcywNZSag
         ExB5yyNr7GTTPFr4GEdCCCBWBI/bULSyTjo5vB3iuAQd4j7iugmJamklUoLklOh7wPwb
         LTdLdbUO9W2zGCm8jA3iMi39jqYpTkJLLKeqmR6P1M0oo4HdqDDkQNnf9yRh6DPbtdvj
         scyWY7+0FTCA+hQsqztwKrWW8QH/7+XSr8VobIqwPakf7CN02jjtq3/z3nC5wi7D87RX
         hhYezhQbTaCHp2flWZPHLmKbaIABSLtktboTZwRQloJMFk49/6Y6mK4eKC022ay85Kd9
         IAWw==
X-Gm-Message-State: AOAM5308hVF2pICQI0wFxy93ksNyTfhu6irc2WijhwPfKoSQJXe/qOsR
        RaMOOCQzEMDucWE1tzNmq6GpDg==
X-Google-Smtp-Source: ABdhPJzOIM/pk9tWOTUWl5e+TDTH0xpNOQTnfj4KEfoU6EtOZONtFMHK6lwbDtQM4rXB6YpRldnDdg==
X-Received: by 2002:a1c:5413:: with SMTP id i19mr10372676wmb.31.1633531487682;
        Wed, 06 Oct 2021 07:44:47 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f7sm3104178wmj.20.2021.10.06.07.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:44:46 -0700 (PDT)
Date:   Wed, 6 Oct 2021 15:44:44 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] backlight: qcom-wled: Fix off-by-one maximum with
 default num_strings
Message-ID: <20211006144444.6q3qm3bzfrhzwa46@maple.lan>
References: <20211004192741.621870-6-marijn.suijten@somainline.org>
 <20211005091947.7msztp5l554c7cy4@maple.lan>
 <20211005100606.faxra73mzkvjd4f6@SoMainline.org>
 <20211005103843.heufyonycnudxnzd@maple.lan>
 <20211005105312.kqiyzoqtzzjxayhg@maple.lan>
 <20211005114435.phyq2jsbdyroa6kn@SoMainline.org>
 <20211005140349.kefi26yev3gy3zhv@maple.lan>
 <20211005152326.5k5cb53ajqnactrg@SoMainline.org>
 <20211005162453.ozckxhm47jcarsza@maple.lan>
 <20211005173400.lyu3gabbalv2l3uq@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005173400.lyu3gabbalv2l3uq@SoMainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 07:34:00PM +0200, Marijn Suijten wrote:
> On 2021-10-05 17:24:53, Daniel Thompson wrote:
> > On Tue, Oct 05, 2021 at 05:23:26PM +0200, Marijn Suijten wrote:
> > > Since there don't seem to be any substantial platforms/PMICs using this
> > > functionality in a working manner, can I talk you into agreeing with
> > > fixing the DT instead?
> > 
> > I've no objections to seeing the DT updated. However I don't really see
> > what benefit we get from breaking existing DTs in order to do so.
> > 
> > "Cleaning up annoying legacy" is seldom a good reason to break existing
> > DTs since, if we could break DTs whenever we choose, there would never
> > be any annoying legacy to worry about. When conflicting properties
> > result in uninterpretable DTs then a break may be justified but that is
> > not the case here.
> 
> As mentioned in my message and repeated by Konrad, the only "existing
> DT" that could possibly be broken is a platform that's brought up by us
> (SoMainline) and we're more than happy to improve the driver and leave
> legacy DT behind us, unless there's more DT in circulation that hasn't
> landed in Linux mainline but should be taken into account?

Devicetrees are supposed to be the domain of firmware (e.g. not part of
the kernel).

I'm therefore reluctant to adopt an "it only exists if it is upstream"
approach for documented DT bindings. Doubly so when it is our bugs that
causes DTs to be written in a manner which we then retrospectively
declare to be wrong.


> Anyway the plan is to leave qcom,num-strings in place so that the
> default enabled_strings list in this driver actually serves a purpose.
> Then, if num-strings and enabled-strings is provided the former has
> precedence (assuming it doesn't exceed the size of the latter) but
> we'll print a warning about this (now unnecessary) ambiguity, and if
> possible at all - haven't found an example yet - make the properties
> mutually exclusive in dt-bindings.
> 
> Disallowing both cases would only simplify the code in the end but we
> can spend a few lines to support the desired legacy.

Yes, warning is OK for me.


Daniel.
