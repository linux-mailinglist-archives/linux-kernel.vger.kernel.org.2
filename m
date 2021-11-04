Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220E3445647
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhKDP1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhKDP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:27:10 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6620CC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 08:24:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u11so7792073plf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gTtZOfoLPio4IJ+Btl36fSghDYz/De1HPU3//sxJBKc=;
        b=JCJJxA7FaVceWPKad16Ia+EUEGP5vWwZM6kMtupGgdtn1dQL4KaSTxcgdKDQ1guKC2
         CirJoj5Hq4vKw6PEw6wgy+2HRLHXZFAt6T5uBwZA02MguPgCCcGU6WT+RKkFZHlUduQl
         BsXM8pWkIQc60EzOKXKWBrLYdEpvPmx6SgmDCUihbvfBapFze+bbILWZ6wDPScO2XuGx
         XI3/sFjzFUkfNjwjpi6G8I2oUxUcUYObMKr4z/RsmoRB67LZ+sqcnYBw/VpTzrbIPuwh
         qJjen8h/RQnkOFKcutAI3Lt9N/3GMNNs2rohVR2fXsNqcqbxo3kHmOTR2yu9Vke2nZXc
         4d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gTtZOfoLPio4IJ+Btl36fSghDYz/De1HPU3//sxJBKc=;
        b=0LtESOBVPiumQ6JvUlQK81RTSj/sWzegV98OygSpKI+l24hgCIJ6ZyWOq3JqgIof3T
         GeR6/GhLYmOLBHBauhs76gk7Cq/ySPiKTvTy68ADJgjr3uCdj7N1g5xN6n/xe6AWKuwJ
         k4s65fCmwNJb1kPuarF0Y8f4WY6520LYJ4Ukj12yUf1v4hKLRCVlTLf1f1f5LT67QLPD
         HTH4J7+vUEZcSnNN8wZQqA8A0FXIy8jGacqmqF5F2OC9NI4hH5DWJIqa9Fb/C5AYV/BQ
         uHvl6fKHE7vTGhqMXUR3tH5YX4dl90WCZ1ut76gGl0EhWivdFVrkcCUXzOAGkDfdrfRR
         2qBg==
X-Gm-Message-State: AOAM531mGPg1xaKKdNc+3oRnq/Q5cSMBW+K1g1cxN7Nwpf+nOtWCtAWU
        jeF032Nahb3oCjXNQlllba/ZKUnSsz84PBDuHOE=
X-Google-Smtp-Source: ABdhPJwEdK3pIqoRs2Z3rDz6RANwPTSrWN8cUHPhDaSlDkXjwJdq9RIVHIoW3OzqbMhT8EhVBPEBAQ==
X-Received: by 2002:a17:90a:8b08:: with SMTP id y8mr23426464pjn.148.1636039471789;
        Thu, 04 Nov 2021 08:24:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.48])
        by smtp.gmail.com with ESMTPSA id f11sm4194159pga.11.2021.11.04.08.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 08:24:31 -0700 (PDT)
Date:   Thu, 4 Nov 2021 23:24:26 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] coresight: etm4x: Don't use virtual contextID for
 non-root PID namespace
Message-ID: <20211104152426.GD743063@leoy-ThinkPad-X240s>
References: <20211031144214.237879-1-leo.yan@linaro.org>
 <20211031144214.237879-3-leo.yan@linaro.org>
 <2cd79645-2f1f-1e59-1a26-5540aa7b6f3b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd79645-2f1f-1e59-1a26-5540aa7b6f3b@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 03:07:45PM +0000, Suzuki Kuruppassery Poulose wrote:

[...]

> > @@ -2111,6 +2111,13 @@ static ssize_t vmid_val_show(struct device *dev,
> >   	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
> >   	struct etmv4_config *config = &drvdata->config;
> > +	/*
> > +	 * Don't use virtual contextID tracing if coming from a PID namespace.
> > +	 * See comment in ctxid_pid_store().
> > +	 */
> > +	if (task_active_pid_ns(current) != &init_pid_ns)
> > +		return -EINVAL;
> > +
> >   	spin_lock(&drvdata->spinlock);
> >   	val = (unsigned long)config->vmid_val[config->vmid_idx];
> >   	spin_unlock(&drvdata->spinlock);
> > @@ -2125,6 +2132,13 @@ static ssize_t vmid_val_store(struct device *dev,
> >   	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
> >   	struct etmv4_config *config = &drvdata->config;
> > +	/*
> > +	 * Don't use virtual contextID tracing if coming from a PID namespace.
> > +	 * See comment in ctxid_pid_store().
> > +	 */
> > +	if (task_active_pid_ns(current) != &init_pid_ns)
> 
> Please could we add a helper function to make this obvious ?
> 
> e.g: task_is_in_root_ns(task) ?

Yeah, I will use a separate patch set to add this helper function and
polish relevant codes in the kernel.  Thanks for suggestion.

Leo
