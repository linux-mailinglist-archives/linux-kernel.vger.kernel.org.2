Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0822636ECEE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbhD2PDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhD2PDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:03:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFD4C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:03:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f15-20020a05600c4e8fb029013f5599b8a9so9521513wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r6wOCcmiBlb8lWL4m0uSoL/yJ4kij8/CEtIGBy66+xU=;
        b=cprz0HqGRQvivCFFMCuh7YgBRziJcnI01d7hW2in83PPpVl3mzTgU4C2kG3nUqQnaN
         ERiIzd0oGNadP9/UMI2A7iwXNNEbGUMZNF89viXiEG5sFhZD3K823o1U5r0O2bQXWsRc
         qDZwuaCsdtNmIRe7ZFR5UPIlmFOqt4TCkMeNOdFJVmMue1Yv3u5Mtdo9HCRT2E8cjeKH
         9+0DGIjhpWHmQd2kpxPwaQ67FQl3OGJXny+EvRjQ3dtW6kdg6V3Pb9i+tAMj+zEjXoeN
         TnGJ2GjKxJ22i3VDv9WvEXwtB6zyX9YFI0Kwoa+Fcmd2aAIzilIqNCdr/HJb5l69sqL2
         lflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r6wOCcmiBlb8lWL4m0uSoL/yJ4kij8/CEtIGBy66+xU=;
        b=LMVsFp3Lzd2njGSMdSpi6ndujvMBWtqLt0Ifbg2+hHfTQ9CyBykP4Er+j/d/xkfBQB
         5a2axUokRh1RSy2UtG04zYIqwKxZbGoIkpSyPorRzlHs2nGUQoXW6BwI0LoTM4rBRwg5
         jdaqnzxsRVZ2wx0kHU6MWFkQOn+jQTQOOpFp7KqbBBXYJoqBPe9nMplJtGetX8mjlcq5
         5mP/WbhBcnbSOLPxQ2PzgnC8W8vGmPwvZiae2cr1fx1KMn6ptjN4HUKYmT0+s1TecU+Y
         mUfhv0smtM1MVSs+mQDNGSkW3h5T565tsN7rfdo7+8S0uZD/MZrbbSfrRje7XlOcetz8
         vNDw==
X-Gm-Message-State: AOAM533Ie2OeH0w7SqKjp6DxSgxfKqFLI5U21m557H5X0olu3MF+bAZR
        U29eZIW0fSn18x6DCBd2hqFpIg==
X-Google-Smtp-Source: ABdhPJwt+WSkG3r/o4v4gq1/F1/F8IXU0gebADzc9fR6SWiN/EYcgmCl/N3SMBNwUqJukbIWzxHYqg==
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr5807968wme.151.1619708582118;
        Thu, 29 Apr 2021 08:03:02 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id q4sm4927563wrs.21.2021.04.29.08.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:03:01 -0700 (PDT)
Date:   Thu, 29 Apr 2021 15:02:58 +0000
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, qais.yousef@arm.com,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net
Subject: Re: [PATCH] sched: Fix out-of-bound access in uclamp
Message-ID: <YIrKos+40mQnqFMR@google.com>
References: <20210428172722.3908735-1-qperret@google.com>
 <b30e5815-441c-b4d3-85ad-65a4020f6d93@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30e5815-441c-b4d3-85ad-65a4020f6d93@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 Apr 2021 at 14:34:14 (+0200), Dietmar Eggemann wrote:
> On 28/04/2021 19:27, Quentin Perret wrote:
> > Util-clamp places tasks in different buckets based on their clamp values
> > for performance reasons. However, the size of buckets is currently
> > computed using a rounding division, which can lead to an off-by-one
> > error in some configurations.
> > 
> > For instance, with 20 buckets, the bucket size will be 1024/20=51.2,
> > rounded to the closest value: 51. Now, a task with a clamp of 1024 (as
> > is the default for the min clamp of RT tasks) will be mapped to bucket
> > id 1024/51=20 as we're now using a standard integer division. Sadly,
> > correct indexes are in range [0,19], hence leading to an out of bound
> > memory access.
> > 
> > Fix this by using a rounding-up division when computing the bucket size.
> 
> But in case you use e.g. 16 buckets, wouldn't you still end up with this
> task mapped into bucket_id=16?
> 
> 1024/16=64
> 
> 1024/64=16

Hrmpf, you're right ...

So I guess the following will do:

    #define UCLAMP_BUCKET_DELTA (SCHED_CAPACITY_SCALE / UCLAMP_BUCKETS + 1)

Thanks,
Quentin
