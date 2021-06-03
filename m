Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8FD399801
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFCC0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhFCC0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:26:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB0CC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 19:24:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so4572743pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 19:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fme9lwaPd+erkgXoIvHB43i1V/M18jnZzcTan+3LUa4=;
        b=Xn4+QbVWUhFIxX+RZIr6cAQsf6LaS6it+SNJI0TCHr+/DjgW3jIk7QnCiOep5OqslH
         gQx2tSCtDHSiEL7rDWypqdw3Hxi+fYnFUo4T4MZ5W0+LlJwfktlbFlhMXfxJNa8Te+Vt
         lNgNvQ/qK7G7m6enjMEceQn6g32Q5eNhMLM24BkM1aAryDdLwn7e9bslL6fgMEGkkGzN
         6/7NuQT8SNWs1fUk75O5ataPY7GbZ+Fjt79Zd7U2ngXPR1ccQ0LojmfLZyaInCGGZgSz
         qZNC9W2M1RI1Rm5Vq6XswcZKljnAsjALYN3PNQefhBpqtGJSRYM+8rQOwOa6mvfMO0ou
         nQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fme9lwaPd+erkgXoIvHB43i1V/M18jnZzcTan+3LUa4=;
        b=gMKqRBQm55hlnmEgWbZ5SmoyZo98yrZTV1YoK4AuhppljFJ1ZYD/davFiIq5leSZPc
         VDh/EQWxAeD20MLFYXIVJgjZIbzeVUH7Ih+5topPt6If0RShcJsC76pQiwja3cUXhZsB
         7qxj4zEUM+FHavO7ObGqRnMAe/7jyVEdTOexYV+iQca6VDum8FRV72END81t94QVbxHP
         ai2TR5Fa4k7BLUNnDcjkXbYl2cnSm2IWQao7KFUhmO7NWGaCRGZyXy1DVegedpighf6f
         amVrbozN0sXghV4anp1CYKhj47EeaKKP5cyQPUA20OLWkvVWEitEa1Lrm5hd3RtraEd8
         aK3w==
X-Gm-Message-State: AOAM531vs+bKNyYRLcAv9gl/BdMO36fNs1N7XjLkGPagIyyZs2iSScBt
        hluG7hXUBOo9ibY9EhKh+1gvFTckxDOgWA==
X-Google-Smtp-Source: ABdhPJwr11DIVHIertb7BWXiBE2m9ehQglYnvNEdgIJ18aVT5rpAverffYZKh47liDDpBYwRRa/PtQ==
X-Received: by 2002:a17:90b:354:: with SMTP id fh20mr16448957pjb.67.1622687043173;
        Wed, 02 Jun 2021 19:24:03 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id v18sm746852pff.90.2021.06.02.19.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 19:24:02 -0700 (PDT)
Date:   Thu, 3 Jun 2021 07:54:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PM: domains: Split code in
 dev_pm_genpd_set_performance_state()
Message-ID: <20210603022400.idphwyporxezzrvs@vireshk-i7>
References: <20210602101215.78094-1-ulf.hansson@linaro.org>
 <20210602101215.78094-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602101215.78094-2-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-06-21, 12:12, Ulf Hansson wrote:
> To prepare some of the code in dev_pm_genpd_set_performance_state() to be
> re-used from subsequent changes, let's split it up into two functions.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
