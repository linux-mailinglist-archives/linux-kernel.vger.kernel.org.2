Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A25631D4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 05:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhBQEx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 23:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBQExy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 23:53:54 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82001C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 20:53:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c19so788609pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 20:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cfHhu8b/DSuN84mGnUY4TvtViOFknwehSZS3tkNZ1rU=;
        b=XLt/sIMUzHVyKH+pYrFGrY9/jnBlg8/T42pCP76+Ho03XYmCg+DM9bSrRIJp5khnCZ
         GW3Pr37f+O2SVhUfkXUq9akhkd9IK0P4zBEbsYcdjR0Qqx1GZVCDiIgmu9vMYxts/1uv
         50MQPx6ot1e3O+HXMrZ9YvYOaCWrBRfi2vUU3d6IySCDUe2VJEmdC9jrh04B0wRA6iw8
         wQ+fKxQd3MW0j8kr4XnQCCECxF4S6rYF7s23mZnmVZf4AuCPqGpsbQ1mmSpurwLlfdun
         D/Iu5mBJCea8aVTR7dQ4nahAsrVhnGVS6k51ypbH6BbVjsJ8fnmjr3q3nYoMc+eVo6GE
         G7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cfHhu8b/DSuN84mGnUY4TvtViOFknwehSZS3tkNZ1rU=;
        b=VdqA914JfQCFGYSdAQfVr4Gbt3YwDQAxcOPNaUoC/wXppVswwTbcOne7pOdZJ7mCvw
         9UsafYuCvWHNn9RpfBslv90l7/D2yJxSkXyMufTUW70Xy7z7vqIOEpJ+mAPuMS2LvNeF
         iomlcU3rBcdOUl+FABSvca5NCw0cJQjV/pIhX2AAhzU88lkR4qwoWi5pNVhUCUlIS+yf
         Lh8m82EFgvT/VEnteOBXTQPvQpBsjxZJVIuQFBGvCjXgS5sjdG+IZ8/OEc402mrpmWTX
         Z7DjRAA0HOS52HwtwtqM2o+ujWJLf/CFmlGnCiemqK0sxgh8ap8/8u8WZQrD8Z0LzXHG
         QkZQ==
X-Gm-Message-State: AOAM530XBQMFOzs9EvU7llX7s6MIAg8wgidDCcgec0ppuNgTwwi5ECw4
        v0udus8L40LfpMqddcpyuLuxGQ==
X-Google-Smtp-Source: ABdhPJzkDf1zRl/nRDIYF7W7d6comfPb1j3nTTtgN0W5qNeNi+/cH5FaqaP37xiQA4mA/dXdQ3khsw==
X-Received: by 2002:a17:902:d901:b029:e3:8f73:e759 with SMTP id c1-20020a170902d901b02900e38f73e759mr1672499plz.63.1613537593933;
        Tue, 16 Feb 2021 20:53:13 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id v9sm557810pjd.30.2021.02.16.20.53.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 20:53:12 -0800 (PST)
Date:   Wed, 17 Feb 2021 10:23:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "open list:OPERATING PERFORMANCE POINTS (OPP)" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] opp: fix dev_pm_opp_set_rate for different frequency at
 the same opp level
Message-ID: <20210217045310.thfl7ckxzfiqjlu6@vireshk-i7>
References: <20210216201030.19152-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216201030.19152-1-jonathan@marek.ca>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-21, 15:10, Jonathan Marek wrote:
> There is not "nothing to do" when the opp is the same. The frequency can
> be different from opp->rate.

I am sorry but I am not sure what are you trying to fix here and what exactly is
broken here. Can you provide a usecase for your platform where this doesn't work
like it used to ?

> Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/opp/core.c | 7 +++++--
>  drivers/opp/opp.h  | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)

-- 
viresh
