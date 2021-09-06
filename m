Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88344019CA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241933AbhIFKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhIFK37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:29:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18102C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 03:28:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id v123so5290168pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 03:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fvZXVV85/s4AjD1wuy4nnogb77GBdqQBnM+gFPv7hp4=;
        b=rWpVyoEz6ooASN69jfven5KswMvr4pZ2m9DWxV2wnaaqIduFfVX70JSaThM7cmgzqT
         ZXMG8dBcBoMpcOlQVCmF1N/RW68098glPqFH7nZwJ1int91kEIyQdGZq3cCW9HlHZIob
         2uOIpBWg5hkQDmo6eKIavah6jx0VEX+LwtuRPTTbsm1UqeGDxxzixyhYqRGVj1qfSA+g
         ENjYJyes/FMUDDn1T0cwLG652WxslJxO3L6ern/h9Gt8TcTS10GRz/3e6QN1SbpwxMLU
         0Iv24y59E0JDDO8Pg7AWR3W6izGT3tR5dOj/SSBh0rNCEXvhn5VUtxkLVAbzynr7GJyB
         rbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fvZXVV85/s4AjD1wuy4nnogb77GBdqQBnM+gFPv7hp4=;
        b=UJY/twNCEISMV8yBa8c07pS7jBXRTCrno1iMopmrmyzMHC08P5plPfFhg+sZBECKdC
         xU6vCO5VQ4kbwZH2IedrJpVpGTK63nhOK0Ro9RpEDDZa5AzTjW+Am3TBVC0hiLvsblWQ
         lrlWwQQc8BvjePnPVJY+Mc6iQN/jhtjPJNrvqimdKlY21L1BWpORPt/KC8/qBStPOe4Z
         oAulrYHoIsPFVZpVRt6nGJt7YtMjyWBvHGIKKTQASjGE6/5Cie2KKhYnhY9ZxUY7SCCb
         iSqurLCnaRaAgGdCE1vGx0JTu97/UQmibppN5uR0OqkD6EUNqTTrbUAXWLG0jGoZ/0Jh
         vz9w==
X-Gm-Message-State: AOAM532jtOzKyL1g1nQbQO7hHE9B5pI9bA/k/6BILniw3Nm277nAXGvi
        nYzWu2e6MvNbIEWWWqgBFrqRMg==
X-Google-Smtp-Source: ABdhPJxnIe5XYTWYsXfNTqNFF6TgdI7wdrDsf/DD902XuTrdjoUZ9a2zqhT5U3Ftukb28wsPZGv4uQ==
X-Received: by 2002:a63:9752:: with SMTP id d18mr11523854pgo.320.1630924134481;
        Mon, 06 Sep 2021 03:28:54 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.226])
        by smtp.gmail.com with ESMTPSA id j6sm8665586pgh.17.2021.09.06.03.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 03:28:53 -0700 (PDT)
Date:   Mon, 6 Sep 2021 18:28:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] coresight: Update comments for removing
 cs_etm_find_snapshot()
Message-ID: <20210906102849.GA1164772@leoy-ThinkPad-X240s>
References: <20210905131237.1035322-1-leo.yan@linaro.org>
 <20210905131237.1035322-3-leo.yan@linaro.org>
 <4db83b64-445d-2a04-a130-fd95f9157702@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db83b64-445d-2a04-a130-fd95f9157702@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Mon, Sep 06, 2021 at 10:51:02AM +0100, Suzuki Kuruppassery Poulose wrote:
> Hi Leo
> 
> 
> On 05/09/2021 14:12, Leo Yan wrote:
> > Commit 2f01c200d440 ("perf cs-etm: Remove callback cs_etm_find_snapshot()")
> > has removed the function cs_etm_find_snapshot() from the perf tool in the
> > user space, now CoreSight trace directly uses the perf common function
> > __auxtrace_mmap__read() to calcualte the head and size for AUX trace data
> > in snapshot mode.
> > 
> > Updates the comments in drivers to reflect the changes.
> 
> As such I would avoid referencing "userspace" function names in the
> kernel driver. Please could we remove it or make it generic ?

Okay, I'd like to remove the specific function name from the comment so
can make the comment generic as:

"User space will figure out how many bytes to get from the AUX buffer
based on the position of the head."

This info can remind us how the userspace and kernel co-work for
snapshot mode if later we read the code.

If no objection, I will respin with this way.

> Also, remember, perf is not the only userspace tool driving the kernel
> perf.

Good point.

Thanks for review,
Leo
