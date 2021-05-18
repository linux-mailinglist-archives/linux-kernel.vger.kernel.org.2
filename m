Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC938703A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 05:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbhERD15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 23:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbhERD14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 23:27:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF7C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 20:26:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b13so2645874pfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 20:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gSlfi5pe5PLCHs4qxj0x9tC+/q+cC9GpxiU+FFOaO+g=;
        b=bld/DE/aCUjkHorAIcIjHBRGK52T4rWdfsVwouPKK9lFRPpWijXKaLQNzmkBBQmXUr
         24umuVkuoMfd3gmrkEKP6N01vhFryU3VvlGwagUttTUNnAbVgcmO4edjbFV3VH1FYZwo
         ESom++KoeRROQAdzHNURhA0HMOX2y56Vqi4lAL6wghJmbddSK8wPIZI54Qu549EpYFft
         YNxjux4Xv9EaG7VNC/XH2qhDzrcpkxReCRJzCd1+wC5SwAIzskjzNIt7McL75b+malaf
         fFBqSzXNYKB5OeQE0sMsNZLue19H2qUFTsteaZGFrehjm7p7Tx8fASH9yFbEjsyZAsCB
         87iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gSlfi5pe5PLCHs4qxj0x9tC+/q+cC9GpxiU+FFOaO+g=;
        b=JTIozxnyzgRQEb5B8etknUcYZU/HTsSvCaF7GgiySgwphqdbVAZsQ7TjGxQooRqs1k
         9vqxD6YAmIwJy2QNz38nsVj1lfL2C3r1zhmAXShBS38/Jg0MoRev24yN5ry8CrAhqPvt
         lU1SaEcoK9fbcCR3sVSx2T8MWjyZiw9ffXCbUWgseI1u7B+PsevKdr464uhlq/dBvpRw
         nODXcglJS946vrm7l18640jbYpMtVRIC87t6my+7uFKzuma7WvVEmFAE1QVhLeTOmvA0
         9EttX/bcG5sHDwIsPbIPt9I3RfXzCs2LcSQdmQXd2XZWK+P/RSTEZ1RDzGR8qDgUePoT
         nI2A==
X-Gm-Message-State: AOAM533BL1WfRysWw8/18sf/IPSGqD2phHMJRR/pQgrEEuZrUsOpjZXk
        cSk0g4n19MBpEuujzKgziEpLIQ==
X-Google-Smtp-Source: ABdhPJwOxE6Hs/7clpwDkT7FyMw+sNuZdJa9knB4waVyQ9YA0DkxstZI98z4775x+3n467psyHuNvg==
X-Received: by 2002:aa7:8a18:0:b029:2dd:42f3:d42f with SMTP id m24-20020aa78a180000b02902dd42f3d42fmr2801847pfa.70.1621308397503;
        Mon, 17 May 2021 20:26:37 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id q196sm3312681pfc.208.2021.05.17.20.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:26:36 -0700 (PDT)
Date:   Tue, 18 May 2021 08:56:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] soc/tegra: Add
 devm_tegra_core_dev_init_opp_table()
Message-ID: <20210518032634.4ek6gpjjagtxptpv@vireshk-i7>
References: <20210516205138.22501-1-digetx@gmail.com>
 <20210516205138.22501-2-digetx@gmail.com>
 <20210517033705.uw5kfj46k6w6ptcl@vireshk-i7>
 <d43f5c65-eacc-e953-f2ef-3151d9229729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d43f5c65-eacc-e953-f2ef-3151d9229729@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-21, 17:09, Dmitry Osipenko wrote:
> 17.05.2021 06:37, Viresh Kumar пишет:
> > I am not sure why you divided this into three different patchsets,
> > while it should really have been one. Like this one just adds the API
> > but doesn't use it.
> 
> Previously Krzysztof Kozlowski asked to split the large series into smaller sets which could be reviewed and applied separately by maintainers. He suggested that the immutable branch is a better option, I decided to implement this suggestion. So far I only sent out the memory patches which make use of the new helper, there will be more patches. The memory patches are intended to show that this helper can be utilized right now. My plan was to finalize this patch first, then Thierry will apply it and I will be able to sent the rest of the patches telling that they depend on the immutable branch.
> 
> I'll merge this helper patch and the memory patches into a single series in v2. 

Diving the series is fine, but an API and its users should always be
in the same series. You can still apply them differently anyway.

> The previous versions of this patch had this comment:
> 
> /*
>  * dev_pm_opp_set_rate() doesn't search for a floor clock rate and it
>  * will error out if default clock rate is too high, i.e. unsupported
>  * by a SoC hardware version.  Hence find floor rate by ourselves.
>  */
> 
> I removed it because it appeared to me that it should be obvious why this is needed.

It can never be obvious to anyone without looking at the API in
detail. So if it is indeed required, please keep the comment as is.

-- 
viresh
