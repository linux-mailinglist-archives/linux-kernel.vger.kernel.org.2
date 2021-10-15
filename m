Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA642F4FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhJOOSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhJOOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:18:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822D1C061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:16:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i76so6333309pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cQSzYDsggFl8upEXTgG7vVR8z62QkXf5gqGOcLIHjKU=;
        b=PssTITKzkxd85I31lnbK8Qyd73nN6bTOOJVVoXTE9dvERrfkP18XLbw0lx8tCBqrEA
         M8QMbXwKY9XT3GoEM1gJvF4+5DL4rrjMuJKcVNukCOM1HfTawPUNxZVzjPyIuY0PAGDK
         s1JtlONXeEAg+ZHhq0bDSRbXFwmTAZ6TH8CHrRChf2phLcQFsnQSHyNEFpRBwuPTsz+9
         FCfxs0CClDQkS/a6aONvB75KEX+KhKeK465GvX+Y2+29O6m3TUmK95wnoPK+tyQeJxk1
         F+Zkv1LGtV6b09o/enW7PEhnbhCfbc3LKUQBuvEAMx76bjUYbPs6pHcmeRezXKZajbVu
         1naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cQSzYDsggFl8upEXTgG7vVR8z62QkXf5gqGOcLIHjKU=;
        b=dmOIp/MKjrVz8gQryY1GGQS52T06Add90TfM1lzzJxcoOdIEysL8YuW/g5CEDVTCHY
         cI1+0oYoIKWSh6LqeKBg9N4UGG/4nUFlRPelCg/74iUSp+UctlaoIG5uf3rkYarVtddE
         O2ZonPy7I14m6+k8FQkQOKdQe/5N5h2i4qcBntR+1OLFcocE9oEOrsxPjbIH1oLWAbro
         1IBk/G5XvLIt2RFtWThK31/tMmbi7tc0DMVE4Y1rnbw7y6hl3Xe+11RHdZvy5sqAE263
         2+Q8cxIyRiv/qvYoBVbkIM0EpoCsPGWnbrIVg8aT+bB2wl5tur7ZoA6qPI01jkK/oVps
         8dEQ==
X-Gm-Message-State: AOAM533RC2uMcV5PL7fE6Jz2wiwHZR6xyevs3L2ZggJanch5N6mYsmpX
        fW6JJQIZNO4KIE+L6PbIGRkJZw==
X-Google-Smtp-Source: ABdhPJyPAWpWo3XYeTjPeOZKWB1JZNg/wgaZ79old44NbH90CBBxxA99HJEp2zv6WP0pJ73o5gmGug==
X-Received: by 2002:a62:7506:0:b0:44c:efe8:4167 with SMTP id q6-20020a627506000000b0044cefe84167mr12018725pfc.59.1634307372973;
        Fri, 15 Oct 2021 07:16:12 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (23.83.225.140.16clouds.com. [23.83.225.140])
        by smtp.gmail.com with ESMTPSA id c12sm4973471pgw.39.2021.10.15.07.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:16:12 -0700 (PDT)
Date:   Fri, 15 Oct 2021 22:16:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211015141601.GA66946@leoy-ThinkPad-X240s>
References: <20210923135016.GG400258@leoy-ThinkPad-X240s>
 <20210923144048.GB603008@leoy-ThinkPad-X240s>
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
 <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
 <20211006095124.GC14400@leoy-ThinkPad-X240s>
 <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
 <20211013003916.GA130842@leoy-ThinkPad-X240s>
 <20211013075125.GA6701@willie-the-truck>
 <35209d5c-6387-5248-ab61-a1e1cb0553de@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35209d5c-6387-5248-ab61-a1e1cb0553de@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Fri, Oct 15, 2021 at 01:33:39PM +0100, German Gomez wrote:
> Hi Leo,
> 
> Would you be ok with the current patch the way it is?

Sorry for my failure to catch up the discussion.

As you and Will have mentioned in other emails that it will lead to
breakage if we change to monotonical increasing head, I read the code
and realized the difficulty to use monotonical increasing head in Arm
SPE driver.  So let's use the way as this patch set is.

> In case it's of
> any help, I'm sharing the testing steps that James and I went through
> when testing this internally, if you want to add to it
> 
> - Test that only a portion of the buffer is saved until there is a wraparound
> 
> $ ./perf record -vvv -e arm_spe/period=148576/u -S -- taskset --cpu-list 0 stress --cpu 1 & while true; do sleep 0.2; killall -s USR2 perf; done
> 
> - Test snapshot mode in CPU mode
> 
> $ sudo ./perf record -vvv -C 0 -e arm_spe/period=148576/u -S -- taskset --cpu-list 0 stress --cpu 1 &
> 
> - Test that auxtrace buffers correspond to an aux record
> - Test snapshot default sizes in sudo and user modes
> - Test small snapshot size
> 
> $ ./perf record -vvv -e arm_spe/period=148576/u -S1000 -m16,16 -- taskset --cpu-list 0 stress --cpu 1 &
> 
> If there are any concerns with the patches, please let me know and I
> will try to address them.

Thanks for sharing the testing cases.  Could give me a bit more time for
the test at my side?  And please expect I might give some comments if
I think it's necessary.

Thanks,
Leo
