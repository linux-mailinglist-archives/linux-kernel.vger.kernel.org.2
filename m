Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE193AB038
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFQJwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhFQJwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:52:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4046CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:50:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o3so6022410wri.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+H6wKF7xQqNDFdYl9az7WY1nv2FLyIYMEfN7sgkUEiY=;
        b=hF8XnvEXgLP2ROnnuJGuHofsPQsTcvxklfJnozKtQ8v0kfdn3LQMQnUyx52IkmJs48
         28av2eC5sXu/LuF5QawXFF3a0GYNEOLjTGA+UeIPqH9eelnaCqHDaypRq+R18b3d+yv2
         byhBC0Asb1jBvCaz2ycl7FcQCw12oUsM/sVx7Y2jVAWO/vlZk715TyaXc+EVaa7czF30
         gJshpjuCG1CnYThSBeDCy5znZoIl+PkntuqTUXVj7Npv2OwYXxCRIp8zBft5EWd7TzS4
         8osbHqBFdqwa6qBd6vr6L3UwrqQpLdzOkOKhF0php4qDQ+w+kH4qxvOV3zZDfbqj3T2k
         DKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+H6wKF7xQqNDFdYl9az7WY1nv2FLyIYMEfN7sgkUEiY=;
        b=cUlyiW9lvFOB0f1JeW+xXnXBzSLLTyrst8KDMpG/roekGEpT+w7F5KM80Pl2q8jWio
         DvjS3WS/fTi+WFKHFRjjHrYB7Tc4GTa2XoYWPvdMlwSV7lD3sJV0uKf1SL4sgA+j7uTn
         7oWQC+6IlQtXz6VSRPabCax/CSJxbITwOd2eqNBzAcb3fMJQj5HC6/qTWF8N9JIUhqQn
         BXqhMLG4LbJE5O1ILSbqFsXnXwW3hDAlkuGAVX2TaoHQw7vyTS8i6433PEbQAP3D8AEQ
         1MZbhkraekvRWNeT3KoL5RGd/4INLdKZDFua7CZozgeD47LmNCoqWwJkHz1Q9y/gqSe1
         MyYg==
X-Gm-Message-State: AOAM531b282pDYqoSboMiHAFt002rN4COjv3T81lcO4RVnekfwrK4x1e
        HgfBPreffjNGuXeVxPzi82KdHQ==
X-Google-Smtp-Source: ABdhPJzbnOjdea5+8A1wqVqc/KbTUeYF9C+JRetN46EbNO3fLfhkVr94LppHFXoFPVqUNzu8ZJI25g==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr4555597wrd.186.1623923401873;
        Thu, 17 Jun 2021 02:50:01 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id a1sm6390704wra.63.2021.06.17.02.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:50:01 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:49:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>, ATI Inc <hyu@ati.com>,
        benh@kernel.crashing.org, Mark Lord <mlord@pobox.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 00/11] Rid W=1 warnings from ATA
Message-ID: <YMsaxwTWvbABmA1c@dell>
References: <20210528090502.1799866-1-lee.jones@linaro.org>
 <463f14c8-c597-2b29-88ff-2929df55acdd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <463f14c8-c597-2b29-88ff-2929df55acdd@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021, Jens Axboe wrote:

> On 5/28/21 3:04 AM, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> 
> Queued up for 5.14, thanks.

Ideal.  Thanks a bunch Jens.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
