Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C9402E12
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345474AbhIGR7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345207AbhIGR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:59:33 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90255C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:58:25 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x10-20020a056830408a00b004f26cead745so92457ott.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hl2Csvq846iKyuS39mKTxO6Jzoq1ExZ8Eura3xQjYvM=;
        b=OM9NZKY2jZgZJfh4/UmCLw38Qlz8QNV1v75OFPQmQmRuckesTd0mxecCfK7gk7hqzt
         1DazSrPOEfOU1KmZ/gCnFhpfDSsRN2a3RNENrmIkfguMVQAutrBjIVkI8eI9oi/MLZv2
         QSYRX9fLWGsOFYA6YAQYu5lVpuxgY8tuXzMNQVmGfEXt0N9MYdwYCwrFd3UX3TxIDO4K
         BLUlHiXxlTciWQcNlwIrYk4zrpmuFcfX25yzcq3Vvevalzlq0hCKkLTBik8StqcgcfzX
         Pq+ed0menXMO/OmrwEUlts0Jf67qLe1DwoRPIupYgN0c5d5+l0MlmqCzESn8avoEdiE+
         +eIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Hl2Csvq846iKyuS39mKTxO6Jzoq1ExZ8Eura3xQjYvM=;
        b=mw64487xwlEo5G2SCOJp5Ue4BWREV+cPkLiYmsAiWDm/wDnUjE2gxLFlvFEeOwYBg9
         tqW5smxGRb9ZuHyT2ubstSPQcCF3mbA/Md1XOT9FiqIXBx3nEurOjFOX4eLsQQxaJ8T/
         y5EOJ/KefQS3PtPhH3PwEvpsNOsrr64b4xCQ2pqxP/Ed6paxEgc6chF+keZy3JVTMtDe
         87nnyvmmLz+gG/ZrPzOSh1n5okRWU6m+DSw5MHvky32eER71PMt8SjmQptjXpt0OQD/L
         X1aETtkboMTh2oBpqRPBj3oM+nL5PkqiBgKsHcv8BepfI+hlyWn3MWh14I/9sZFuybtm
         j0Hg==
X-Gm-Message-State: AOAM533eVRgwcnLTC4W2TGDRAyY+J9wlUXpeEv6ATF18Fd2AXZ9WWwlR
        Azo8jJqN0Y8iLYWGMJ5id+8=
X-Google-Smtp-Source: ABdhPJxhXyI+zeNbqvhHfUkj+1PsmnOF/C08n+LAOLflDMVGnJz4gAqeor2uJGg2P6ZWRRrlt5TF2A==
X-Received: by 2002:a9d:5a81:: with SMTP id w1mr12973775oth.307.1631037504911;
        Tue, 07 Sep 2021 10:58:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k24sm2521611otp.31.2021.09.07.10.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 10:58:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Sep 2021 10:58:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jian Cai <jiancai@google.com>,
        Mike Leach <mike.leach@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>, coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] coresight: syscfg: fix compiler warnings
Message-ID: <20210907175823.GB235361@roeck-us.net>
References: <20210830172820.2840433-1-jiancai@google.com>
 <20210906150625.GA1228692@p14s>
 <CAD=FV=Ukx_PRpfnLXEBajtts78ays=6+nGb+CRVn76xjyNkn5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Ukx_PRpfnLXEBajtts78ays=6+nGb+CRVn76xjyNkn5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 10:51:53AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 6, 2021 at 8:06 AM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > On Mon, Aug 30, 2021 at 10:28:19AM -0700, Jian Cai wrote:
> > > This fixes warnings with -Wimplicit-function-declaration, e.g.
> > >
> > > drivers/hwtracing/coresight/coresight-syscfg.c:455:15: error:
> > > implicit declaration of function 'kzalloc' [-Werror,
> > > -Wimplicit-function-declaration]
> > >         csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev),
> > >                              GFP_KERNEL);
> > >
> > > Fixes: 85e2414c518a ("coresight: syscfg: Initial coresight system configuration")
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Jian Cai <jiancai@google.com>
> > > ---
> > >
> > > Changes v1 -> v2:
> > >   Format the commit message and add Fixes and Reviewed-by tag.
> > >
> > >  drivers/hwtracing/coresight/coresight-syscfg.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> >
> > I have applied this patch to my local tree.  I will push it to the coresight-next
> > branch when 5.15-rc1 is published next week.
> 
> Out of curiosity, does the fact that it'll be in coresight-next mean
> that this will target v5.15 or v5.16? I usually think of "-next"
> branches as targeting one major version later, so I'd assume v5.16?
> ...but it would be nice if this warning could get fixed somewhere in
> v5.15.
> 
Normally "when 5.15-rc1 is published" would imply v5.16.

Note that warnings are now reported as errors in mainline,
since -Werror is now enabled by default.

Guenter
