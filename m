Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433933A9387
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhFPHMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhFPHL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:11:56 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA49DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:09:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t17so1215567pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4CeozNUOSo7JNO0SdE4eBYUm8yjNmhyI3EkMHK4ZYCo=;
        b=T9UcDa/O1MWYuIl/fjBIPlPegx8/qNmOWMqdMm7cR973LLccoOhuaUbfA9J6Irn6+v
         V7drkaLVFFhgDRv7ErHu66U3KI+SxKvWoG+m2CiqoR8g7/c/TtoEt8yQ5ee6434sc/rj
         HWhQKIq2yPWyaeOXzUdKIy6nie7oJZ22z4lWDBNbPralJ8CBkt/jMoqlhPv6Nf7f0K0o
         BFqiz/a0O2I6MA4EXuxHgghZfZOUKyHYFgiOy8A8YUXWshx5jBy+wJCiVN0P3mj8/QdC
         qxU1B4QdoYWW0S/V99EJ13guIZG1n1A7FyYNsE3MIKD6AB7g6qBcysB5VPbrU0u+7JJi
         gCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4CeozNUOSo7JNO0SdE4eBYUm8yjNmhyI3EkMHK4ZYCo=;
        b=qs1/p2AUF+9wzvdBnlPFiCAa/rYlSf7xwFfN8kE0mf+jE+BNDGA9zrQNFYfCrtiJkR
         yiLPpq2IrmYD+WZUKOxUzuTzUHkOuofrDr/bHh1dMBksggHGO0VwnyQGWOlZD+LvyFNk
         7ulCiX7UDfFtfq9N6Hwdo64T5xbvZQw5tbPWI3WxkGsf56IqnWIR26TGnH8/v/MSpqy8
         ByArzMd7+KmjWKWMdeXmgXZpI/Wen0bBgfJsTepRPMtg1nwwrvXvT3fXuZrymZkTurS0
         x62sF+S6Vws8uMedF3kKRrexoaR8V7pI5jU+T22SHQw5oJDM558NkmI6LZ04A/BSKgDf
         8bjA==
X-Gm-Message-State: AOAM530kM/cdIsb3fJMD8bh/8PTvw6cOBhyf55SYRzPwuhVY+QVI5Gnc
        FsJ7z/BnJ0/i81z6sioxO5EeRA==
X-Google-Smtp-Source: ABdhPJzjvwaUuUBUNhnqGrqOvqCL30qt5DaJ6L0ucGmNCVdVKmXA+PIwYppsx/yBzW7bICbEx4b/fw==
X-Received: by 2002:a05:6a00:1808:b029:2f0:53eb:6645 with SMTP id y8-20020a056a001808b02902f053eb6645mr6879518pfa.46.1623827390354;
        Wed, 16 Jun 2021 00:09:50 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id 18sm1101934pfx.71.2021.06.16.00.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:09:49 -0700 (PDT)
Date:   Wed, 16 Jun 2021 12:39:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "Viresh Kumar )" <vireshk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non genpd
Message-ID: <20210616070948.2oaxc54p5uxknw36@vireshk-i7>
References: <20210616053335.4181780-1-hsinyi@chromium.org>
 <20210616055841.4m7y6nxnxbgw5rzi@vireshk-i7>
 <CAJMQK-h2R5s6rWWjr1YHO1jqZdtBkT3LYjcVg4QNMUuXJSiMTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-h2R5s6rWWjr1YHO1jqZdtBkT3LYjcVg4QNMUuXJSiMTg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-06-21, 14:25, Hsin-Yi Wang wrote:
> When cpufreq changes, the (cpufreq based) passive governor will
> calculate a target devfreq based on that, and the device governor
> (mt8183-cci-devfreq) will change the actual opp of the device.
> 
> The required-opp is set in the cpufreq table:
> 
> cpufreq_opp_table: opp_table0 {
>     compatible = "operating-points-v2";
>     opp-shared;
>     ...
>     opp0_01 {
>         opp-hz = /bits/ 64 <910000000>;
>         opp-microvolt = <687500>;
>         required-opps = <&opp2_01>;
>     };
>     ...
> };
> 
> devfreq_opp_table: opp_table2 {
>     compatible = "operating-points-v2";
>     opp-shared;
>     ...
>     opp2_01: opp-338000000 {
>         opp-hz = /bits/ 64 <338000000>;
>         opp-microvolt = <687500>;
>     };
>     ...
> };

Ah, you aren't using dev_pm_opp_set_opp() or dev_pm_opp_set_rate()
interfaces.

Looks okay then.

-- 
viresh
