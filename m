Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF5402288
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 05:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhIGDlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 23:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbhIGDlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 23:41:47 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379FAC061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 20:40:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id n18so8533102pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 20:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLF8sSQwhUS0+086sW1fmjexR33ZrApxSNSkWts8YRM=;
        b=nzh+u2Y81255wZnH+V4MUL8B8sO+5Od0TvnyoGtBXBxvY3GWkCS05hqcZ1FiPp66Y+
         H/aLuFSamvMQxn4nX3sCYvr1vDDohLl/5eNT3FtPx/KARSpyx2ftPvZz45NpEUAFAaN3
         nuqAcYDkZ/HcRrm6WqcyMuKl29Fr4l0lLirCtuq68ivwpbzUOj+5jaU/S74iEUJoxRqV
         Z/OLrLKs0O9bgfqMMgAsFQe8eBvb5Apzznl+Q3EF6QquxxEgfL1NhqCeEOD/tzrOfVQc
         j9FiRz3DOiSqILowuXrF1KILiP0Y/bHQvTid/J3SQIpAupZty6vyz4/uTkMkih+VObuO
         /YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLF8sSQwhUS0+086sW1fmjexR33ZrApxSNSkWts8YRM=;
        b=auTtPWTsHnYM40Xul58CeAvdq1hXgwlo0f7/XR260ZWwcYvJ9kR6mmMTBT//As8gdZ
         u4Bpuka9BLiPv+mIqvgtzwSGQMJNn8EL0TEKhQkVzis42ijPqSXHhcGOoLxhCjY29HFb
         J6bKAH3tRkQ42UmcMt7lylE7sTiLrK644ujeRBunhwYcONNUv7tPRySEHjh0Soxe7jPi
         RvRyWqLBjHAiXtbrvyAHESLTxTKP3UXyzw9bhBsq8XAbrxugai4tlHKicFjQxv95iRUf
         ITzvy2Hw6wgjTGipbRWtf+tG+QLnkKR0mE46Qva/b4LJZ0L8yanOzSNGxNb5/lfn8jr6
         ZLwA==
X-Gm-Message-State: AOAM530bRKWArnjFs098nvmm5xY0IkcMb1/33VNVjxHpTj1/9NvYM/vy
        nhGir4DfC6beXQXCNIeBK0axJw==
X-Google-Smtp-Source: ABdhPJzsv/eia/hjQn1pbmQ2OENxmUodBBxcmYX5Fn6l3uMclKCItBuOiSE4NrFHNe0VdaUoPx8Y0A==
X-Received: by 2002:a63:3c4d:: with SMTP id i13mr15152019pgn.54.1630986041664;
        Mon, 06 Sep 2021 20:40:41 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id b16sm8897166pfr.138.2021.09.06.20.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 20:40:40 -0700 (PDT)
Date:   Tue, 7 Sep 2021 09:10:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
Message-ID: <20210907034038.ncx5nas6mhrk4u3r@vireshk-i7>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-4-ulf.hansson@linaro.org>
 <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
 <CAPDyKFr2oQnKOhKhWt_9VyBoe=HQ7Y0uZUMKTcZ05a7G9RaBYA@mail.gmail.com>
 <1124dae5-478f-f0ca-ea91-b6945f7c9254@gmail.com>
 <CAPDyKFqE+thX0pLTg9d-ds7Tj3hsB78EmDB1Cryh26tN3kvQDA@mail.gmail.com>
 <3d92711f-ce30-2c19-c6a4-bb77d32df2dd@gmail.com>
 <CAPDyKFpJU3g2OzJeR9KUdtN-8wJsDckqVAMQMHBV=enu=DfURg@mail.gmail.com>
 <fbca049a-e673-1598-658f-a7bb5de52f18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbca049a-e673-1598-658f-a7bb5de52f18@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-09-21, 17:35, Dmitry Osipenko wrote:
> Viresh, are you okay with going back to the variant with the
> dev_pm_opp_sync() helper?

I have missed a lot of stuff in between and wasn't following this
carefully as I thought my half was resolved :)

Can you describe what to propose to do again ? From what I remember,
doing this one time from probe() is okay, doing it from
suspend/resume, not so much.

-- 
viresh
