Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2F4359BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 06:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhJUEMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 00:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJUEMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 00:12:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2944DC061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 21:10:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so2116665pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 21:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yLK4NxbVqDLH3nRLVYQccxDS/5AO+FQ5rIKLjjCYFX0=;
        b=jfZWIuznt21Lek3cIqItyOPu5IOr0TBTScrFk1fyO29je7a+YB158rIbSrQ3p8IUCR
         RPWttendbmEAlB0am37fji3QCDgtRuJIHPmCsYVZYI4qj2o7Nj+odrQRAWFh5S9D5ii7
         io+MBLQt3oOz+yM3qKHtYi+SxX3SV5uF/2m1kwjMwvmyKXqp+UaGQ77LsBg6uvcj5c6g
         MQckYoZmlMyjYNgrIadAr+juQbuEVrnJi27bhJ4l0Ct59mtf7aEL161ozflqPSN3Rd1E
         RvpyIO+BFhxbFP1ydxnYIPZq9ZEp4dqm1K+UQS78qOvy9Rd1yayucIg5nZ3vGO7Tvt/B
         kCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yLK4NxbVqDLH3nRLVYQccxDS/5AO+FQ5rIKLjjCYFX0=;
        b=tv6VUL30zd68+lCRZVoKxgEIuzQFNUK22ASVA7gqo3mSVx8bWmak12sdxofnHLmEsh
         JEc0yszZGB4d510i+Xb+Lc4lwniutgth/9VZodBrUmicNEv55H4r69GLT1x3bJOiMwHx
         0O0cD9/uHK7ZwgjRdkPt7L9NrjYqvuiEKaYKdEvh4UAWQbXmd9NTQR3ruIU7ll1Z1dPL
         vReR2cGBe1fJNsbSEZZ8WctTdCgQFRet+qjvH9rU2xEgGX7O1O4hOyCNv74fiG44JTVg
         kB7a+Yl1Ut/Gcw/yEVIoeS/oxBVTUDWMuEOl9CLOOBYIsHxty1wkSgtoAoHAkL9DUkI0
         FBPA==
X-Gm-Message-State: AOAM530PvvvtjS5bXLDmvGfJz8ZGXC/JH9YijfkFNr5tWoxSAf1ZqZui
        2lAEd7rPyhKLFGwZWN7yMdoC8g==
X-Google-Smtp-Source: ABdhPJy+Bk9B2LacGLYy31NgFsLeXyeX3jUeC89nXJZGJcjbQCASaWxgmUhmeCJUSwOdq5oy4qD6ZA==
X-Received: by 2002:a17:902:6808:b0:13e:a85b:52bd with SMTP id h8-20020a170902680800b0013ea85b52bdmr2940449plk.76.1634789406546;
        Wed, 20 Oct 2021 21:10:06 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id p25sm4986407pfh.86.2021.10.20.21.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 21:10:05 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:40:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Fix typo in cpufreq.h
Message-ID: <20211021041001.nbtra55ziwi2d7xb@vireshk-i7>
References: <11860065.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11860065.O9o76ZdvQC@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-21, 21:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> s/internale/internal/
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/cpufreq.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -398,7 +398,7 @@ struct cpufreq_driver {
>  /* flags */
>  
>  /*
> - * Set by drivers that need to update internale upper and lower boundaries along
> + * Set by drivers that need to update internal upper and lower boundaries along
>   * with the target frequency and so the core and governors should also invoke
>   * the diver if the target frequency does not change, but the policy min or max
>   * may have changed.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
