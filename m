Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF63E511F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhHJCnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhHJCne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:43:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E5CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 19:43:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so2149762pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 19:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mEtO03OIc860qDPInvLz3qFGfUeCouJ7pFCU8dty4U0=;
        b=eNbU18LmLOH3wLADwMkysokDiIfwMd9Pc2dqHuLtIEFJf75LTAJKNVd2ve1+YdL64C
         +6BCavcHfWuIgrH+fbd/kD5XTBlN0BU9XAa60Xhb1HpO6+YG8HMQxkC+G6yW0/UD4FTh
         3ErovM0ZfBqzEM1Uo0VzmVOgQWDgN/C++aNs0jRsyznmSGQcG3k8AzE2QBg4404aychg
         e3C6dMdT7hVb0v9zYTwHzBiEyuMs7K7f7pVDk3GIYehZzIkOKLjt/93SAAH6YV2TPGMF
         yRWA+3q9wdfsvTb5IHmhoHuxre8zSMGdrTDgPYwRfl5MrIEwqtfN3ghHEcwua98yW/JI
         AjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mEtO03OIc860qDPInvLz3qFGfUeCouJ7pFCU8dty4U0=;
        b=qst28ls7a+kScm7v71ZO95yu9V4JfsTD6uK2spi1q3F8rYNXAGVSRQzsYfhkKsDylf
         0j6zxGyO98VBfjB2k1JwIobqxEL9YIJkRwXef0m3K0A9FAQjjw4J7DWqwn4YxEVAH+uz
         bBqtAotWLZCc5RfHRP9bSH3t79iU990NFb51tGSH+PhW+GIewvckg1Bogz+zmnE32kWn
         cTo+f90SCq4gmmW7lLDJTVbd+X6CeSLnf8dcOXbUMZVh80QhNMeaAxlf9F10xRRFpPy4
         huu66hbcJFrwR9eSV4SCXh7SgXYiKBwpW5tSlie0AyxMD1TR2rZGMSemnHN7EbsUvGGy
         0G8w==
X-Gm-Message-State: AOAM533E6+DiN3bZEL8RyCRnQjLcpXjCq5+0g316nqRuF5ZY04hIZFV7
        mrwYO37TQ9UHLf5JVgylMrVmfA==
X-Google-Smtp-Source: ABdhPJzvKKIhjbuNi3WfN/Mlyc/ZFUy4MKEae9P0opKTsgMcUjH38p9Kxd6cmuaYHjdfKvKNlowjDg==
X-Received: by 2002:a17:90a:bb0b:: with SMTP id u11mr2412472pjr.18.1628563393258;
        Mon, 09 Aug 2021 19:43:13 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id v63sm23343203pgv.59.2021.08.09.19.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 19:43:12 -0700 (PDT)
Date:   Tue, 10 Aug 2021 08:13:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v6 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
Message-ID: <20210810024308.gurvzpbe2bc2bhky@vireshk-i7>
References: <1628074696-7979-1-git-send-email-rnayak@codeaurora.org>
 <1628074696-7979-2-git-send-email-rnayak@codeaurora.org>
 <CAPDyKFrebwt5=S7hqXvcqRvt+-EXLcVmRSRZt1uPf-9n7_pRDg@mail.gmail.com>
 <2afd0fac-ed28-c090-a345-3fd4284b4125@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2afd0fac-ed28-c090-a345-3fd4284b4125@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-08-21, 16:38, Rajendra Nayak wrote:
> Sure, I can do that, apart from the error print, the function currently also
> returns a -EINVAL in case of the missing 'required-opps', are we suggesting
> we change that to not return an error also?

No.

> Since this is completely optional in the device node, we would want the function to
> ideally not return error and only do so in case 'required-opps' exists and the
> translation to performance state fails.

Not really. The function should return failure if the property isn't
there, but it shouldn't be EINVAL but ENODEV.

-- 
viresh
