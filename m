Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C113F389C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhETD4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhETD4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:56:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A098C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:54:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 6so10907288pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KZRGLyGlYpZs7oxsD7Yo4EaDAarVQQHn0bIE9uF59k0=;
        b=Ly58M6479wTJyMHgE/6HMIPI0JxrknZ0fzRgcXjYd901K5hE5hOsQRHLlQDZKU2mm/
         Go6sZo1IAf0ujxCsdN7quwS0hKJcPynecIsUnIG9UHdWaAEqd7S9LhgXOOIJOFCpDNOi
         0fJAZPSVjh3v6/0ATh/cK5GKKy+YkQn6wIqAxY1wmZTjYh1aC7pUvANmGFfo+92t8f/A
         21yTv7cGt5Yog3FxYrZA2bGzdGfTKfRAwD9ji1hia+uUf/f7emVMNm6LBNaSPoyoSr1u
         ahRt8jPCFsy+PPmXWrujwPuoiEDEezqOODAReKr09YjdeFutZXjQwR8uCfJhA/cA9m7w
         u1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZRGLyGlYpZs7oxsD7Yo4EaDAarVQQHn0bIE9uF59k0=;
        b=lf+GINnfYg8txO7EM5//HoyQnAMr5+seqpwg2gnBPvfE4QWKT8WC3FnN5MAF6K2Wsw
         Y8BN/AoG7XcQ9ILAOcIOOPEFMyCmxBo5OOIg7sL8VGHk0dmhAtPi1/mEbT2J8zMycR3F
         N9qhqCeWdraf4OBwDH7uFyrQfKRxxfmtOMuTGS5tdSLniCg8BeHnnueVCSutgdVIKfTv
         EpZw8ToNgTBhvfqOgbhFZS/eibD4Is+ejx1LLi/1uoUzl1b33QViRKqt3ZYBl6srZK1f
         5v+Ckx0IlVnkuJ3gCmbFmjO1fr4GBGn7zqaXqxOTNcQS+5dOIgERvY9vRa1d1nSk2c4j
         jxcw==
X-Gm-Message-State: AOAM530PthjPsuBrkjeFMyJ2tlgU3sqznFLYV6FLpqvxvs+0yzt/KU6E
        C04bun7HbhxLLUVcfPh9yTkffgqteHO8jw==
X-Google-Smtp-Source: ABdhPJztS1QqD1LiTXn/SocQZq9tDzxtlj38Ux6iQAOUyHioscpcGVHK6n78sJUY0NNB19zVqkoY1Q==
X-Received: by 2002:a63:2444:: with SMTP id k65mr2447534pgk.1.1621482885418;
        Wed, 19 May 2021 20:54:45 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id b15sm672895pfi.100.2021.05.19.20.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 20:54:44 -0700 (PDT)
Date:   Thu, 20 May 2021 09:24:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20210520035442.qvpsonhifozzrspo@vireshk-i7>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <CAL_JsqK6B40D8dRu8KoOsx6eSzRXx6KsSEu5mjDokPEAy+p4oA@mail.gmail.com>
 <20210519112308.umxriuv75onuwvmc@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519112308.umxriuv75onuwvmc@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-21, 12:23, Sudeep Holla wrote:
> I noticed I haven't cc-ed linux-pm list, do you need me to post there or
> are you happy to pick it up from here when Hector's mediatek cpufreq drivers
> using this are ready to be merged ?

Applied. Thanks.

-- 
viresh
