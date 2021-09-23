Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46882416145
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbhIWOmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241670AbhIWOm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:42:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC6EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:40:55 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m21so6507503pgu.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZVVMJVPFsNXmZGKzivyU4QHm7thdKZguG8bvbRK2DOs=;
        b=P7UvALqxYFavU1TphCxKmENJ/2iPpRlOl/QmYzMMvXYOHsDD1dqp/P0ahXgLz0TkI3
         mHmIkVdLM4katXdOUk41wy6qf+dj/5S4AHHDXa5foihlpS5P/fgozIKDAp4pt4tB7hq1
         IWOZ3Fwz1SDwMY7BBf5VtWyGsI3ZHEN4rXhDzQJHKdngJ/ywyBG55XBU6u/BoEpxEEoM
         wE21gZ4l8ZjZwvp4U4N7oxJJtmkKPdzkMQazs8W7Z5qWdK1uHJWbczmN+d0W1vhnzf9/
         +Axn868G1Plo9aWuipufakzEtdvy47SBkVUq3nxNDDzKeGDpt0/W1coZfclyDom4wlMb
         HBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZVVMJVPFsNXmZGKzivyU4QHm7thdKZguG8bvbRK2DOs=;
        b=jd5XyaqAUbuy5ujaN7d39DSpB3Yb/3Gpi/soF++LKlH5+D1kuDuV/QDxh3/jSv+8Fr
         WHZkRoMtFKLPPvJZ1k1aXEY1OkkKoOPnhfWeT2SBWgJRkmKPc3b1LK4KW9sEZxLbBMNR
         iniNwuBtQpyEhb7tYxjmg60klqQcA1SuRUgWUieyMf9Y1PDG/YvQ8BTilaGY9D90Umfo
         gPcgtRJB5V2wbIOLXfLpefgjdIwa/ZB/82k5KWOYTilvilf1vKI6mCWVy0hLuKjl/XUy
         wTijygwskbFjqgklUiJDCoy3QrUYeD1Qw4RU6/KHlqgYqwxrBF8gaIIBLQJUwW7q12QK
         szMw==
X-Gm-Message-State: AOAM532TeqUor/UxZ3NmsHkuR6w/LVmh+Er3TS5qM6blwKJWEBAYngHt
        OY5+bDPaZLWQsETFdXi3WqXRWA==
X-Google-Smtp-Source: ABdhPJxJA0nGspazLI8+ZUM60xIDNYcbqDjq+DbuNpYFOISL1AgZ+BLdMdGRbFWZw3qMvFVrhaKSKg==
X-Received: by 2002:a63:4301:: with SMTP id q1mr2098898pga.430.1632408055121;
        Thu, 23 Sep 2021 07:40:55 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id x1sm6212112pfc.53.2021.09.23.07.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 07:40:54 -0700 (PDT)
Date:   Thu, 23 Sep 2021 22:40:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20210923144048.GB603008@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20210923135016.GG400258@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923135016.GG400258@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 09:50:16PM +0800, Leo Yan wrote:

[...]

> > @@ -336,6 +480,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
> >  	sper->itr.pmu = arm_spe_pmu;
> >  	sper->itr.snapshot_start = arm_spe_snapshot_start;
> >  	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
> > +	sper->itr.find_snapshot = arm_spe_find_snapshot;
> 
> If I understand correctly, this patch copies the code from cs-etm for
> snapshot handling.  About 2 months ago, we removed the Arm cs-etm's
> specific snapshot callback function and directly use perf's function
> __auxtrace_mmap__read() to handle 'head' and 'tail' pointers.  Please
> see the commit for details:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f01c200d4405c4562e45e8bb4de44a5ce37b217
> 
> Before I review more details for snapshot enabling in patches 03 and
> 04, could you confirm if Arm SPE can use the same way with cs-etm for
> snapshot handling?  From my understanding, this is a better way to
> handle AUX buffer's 'head' and 'tail'.

In other words, if we can only apply patch 03 and can pass the testing
in patch 05, then it would be a very neat implementation.

I will try to verify these patches and will get back result.

Thanks,
Leo
