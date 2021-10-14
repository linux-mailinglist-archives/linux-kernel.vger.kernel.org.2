Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6545142E33A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhJNVZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhJNVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:25:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0476FC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:23:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso7866254pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VSUU/L5fDuJ+ECPOKm0ljaiEhq13igOZMXExTv1jJyU=;
        b=iPz8uGum5x2Rr5CkOXdxaIJIh8b2rszzTAl2wHw1nJB+qWEMTuwUrStmxiu55shJ1H
         zg9/kvLswiHKzHJ23jv8Y4Gld6jgM+TF6jVYLbtxMB17EgKpI3OjW/USc9tS3/M+phpA
         M5Uo1ofWoHl60Y0Po3ZyK9lehtVJazaZTBGOcsBhQGZhXlJ+iAif7Iiwn73uGfqpRFQ6
         2gftKjdJtD9COMn0O+7aNRblDfNP8kFYRICwnyMYEF5mEB37PLVszRDXsj2tmnayxewx
         tE/9TulE/ZCTbRAWYug+UzcqutSTgmI76H9NfHnCxC974Iw0l2WK2t440U9w9eSgv8S5
         7RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VSUU/L5fDuJ+ECPOKm0ljaiEhq13igOZMXExTv1jJyU=;
        b=DdiS8yGKIjTun336Cx4apH0VOUF512O9VZdYjHkIOldA0ZGF6/gryH/Wtafe+D2Xei
         HBBrIJjF0SwFIYWfx+vX4SOFZtUkHbjsPS0y8dgpdaPkoxVR1emFB9yWg+P5VCAT0tvq
         7yM33CMFP/d0FLrtZU27OpQWYupmM0RQjNuOV1FBHjlqVYlf3Xcxu1299Bzfb1sXdRTD
         VSDdyniNizJTMVDkaMr+XFvCpUcxMDaTrjSmbccMRVEBFvWRQSAOmsKpTzO05avLPrIF
         itTzaN53Vujxi43elw1Ia2w23pSeIoHroCGHQmGFUlH6N23teYIXum+eqbfcziJvGE13
         uGAQ==
X-Gm-Message-State: AOAM530qjCvSE58uaLuv9ae+SJEUU8HL10dOEN83xdwM/wCZkDiuttos
        wab4nug2AjaDJh1EAIWYZ38=
X-Google-Smtp-Source: ABdhPJxaTx/txQIzkBzm6yXMFVyCMpUoBf09VBCz7o1nDLYIMK6IK7rfqdLsz81mQ1VZhxcZJ/xOtw==
X-Received: by 2002:a17:90b:3a88:: with SMTP id om8mr8843140pjb.164.1634246628323;
        Thu, 14 Oct 2021 14:23:48 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id me12sm5149636pjb.27.2021.10.14.14.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 14:23:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 14 Oct 2021 11:23:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Mengen Sun <mengensun@tencent.com>
Subject: Re: [PATCH] hotfix: make sysfs of unbound kworker cpumask more clever
Message-ID: <YWif4n0UhaJTf7cp@slm.duckdns.org>
References: <20211014030641.2182803-1-mengensun@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014030641.2182803-1-mengensun@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Oct 14, 2021 at 11:06:41AM +0800, menglong8.dong@gmail.com wrote:
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 1b3eb1e9531f..8216fc45c77b 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5394,6 +5394,11 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
>  	cpumask_and(cpumask, cpumask, cpu_possible_mask);
>  	if (!cpumask_empty(cpumask)) {
>  		apply_wqattrs_lock();
> +		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
> +			apply_wqattrs_unlock();
> +			free_cpumask_var(saved_cpumask);

A few nitpicks:

* Please replace "hotfix:" with "workqueue:".

* Can you reorganize the code so that it doesn't have to alloc and free the
  saved_mask?

Thanks.

-- 
tejun
