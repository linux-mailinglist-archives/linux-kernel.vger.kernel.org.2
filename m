Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13F333A8A7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhCNWvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCNWvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:51:05 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFFDC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:51:05 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a9so29982076qkn.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yxi1lydKMWjN82a7Fd+FpDe2Rj0hmb6QP6tPPhMWVIw=;
        b=lYAu15rjfEJlPLMbYe3ofGtugJSP4S3UHE+XQ2ROBsoJg4LQfHnizFixBc5YdoamTs
         uhTOQr08O9J9XTN08NKAjSmAIF+fnn6HLff+3l7TV4BYtlks6BMGA3SxGeJQrVvvtLI8
         YxQcz9zg+FA5ffcB/ehtLoT5A7se3VNKwTmkLsADvwUcu+HwrsTGSQx4j6EqgDoi8baT
         SdF21ARoje6bfWMFzg80oNj3JevhLX5lcXv1Hbz46SwVcnXvhs296sqLFKYxNyFWjj8i
         tztGUs6Ua4BJoSizUkVBoH4xDDG8oM5Gxms2Tq0W4Bdae10a8wEGsbKDfoz2QKuPLTTC
         egTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yxi1lydKMWjN82a7Fd+FpDe2Rj0hmb6QP6tPPhMWVIw=;
        b=QUMDGdbgyAlvq77eraK1MmQD9Wyc0RVK9FluwKlVmswY3FTPQSOgxS68qoScGzN3oo
         4+noHtMbWq8lTn0O8YbUlTZrwdFpUiWb7K6Mc40Aij2uOFglCyzK+d3G3l7cbQ/38I4A
         XHQGea9hDo1MqUEgaaqC2OI6kI7skmQUZ849fkDphIaeNz2LMqrEs8190FEhXd6/WpAX
         rNHpLvjY2H1AMZk7ryTOWybD18iWqPIXZLolx5CUUdda+gvtX6FRaP4CMwPVqpM1BjLh
         MpkC8RM8B27u/tnt8hAQraXOF3gWTNybCp1Uewa8rSchPs0iUMx1UQ3dAz6b/aBwI0Io
         2Ezg==
X-Gm-Message-State: AOAM533NjKIBF5wDqa2CsM8TPpRKTiHl8brCeXRzg57t19e5Fu07dYSb
        ZaUSgMaXW7ubvht1VlQbrdnaP8RQ83llIQ==
X-Google-Smtp-Source: ABdhPJzGlY7vE2KKLHORP80o9phIQwX6iO8oRBseQCWbHWCL9pXUzz43G1ePZqigVxoExad+Y65zZw==
X-Received: by 2002:ae9:d60a:: with SMTP id r10mr22025057qkk.411.1615762264070;
        Sun, 14 Mar 2021 15:51:04 -0700 (PDT)
Received: from localhost (2603-7000-9602-8233-06d4-c4ff-fe48-9d05.res6.spectrum.com. [2603:7000:9602:8233:6d4:c4ff:fe48:9d05])
        by smtp.gmail.com with ESMTPSA id l129sm10803181qkd.76.2021.03.14.15.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:51:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 14 Mar 2021 18:51:02 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] vmscan: retry without cache trim mode if nothing scanned
Message-ID: <YE6TVtA2EuagQAtj@slm.duckdns.org>
References: <20210311004449.1170308-1-ying.huang@intel.com>
 <CALvZod7QNEXdKCJ3H3eoZKsRj5jtOESkmHm1dTC-ZjSBAcW7ng@mail.gmail.com>
 <87v99yvzq8.fsf@yhuang-dev.intel.com>
 <CALvZod6HC-oDQJgQxh=sJi91y0_SK2xuMMW35aac0YURjbPEOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6HC-oDQJgQxh=sJi91y0_SK2xuMMW35aac0YURjbPEOQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Mar 14, 2021 at 01:58:33PM -0700, Shakeel Butt wrote:
> > If my understanding were correct, what Tejun suggested is to add a fast
> > read interface to rstat to be used in hot path.  And its accuracy is
> > similar as that of traditional per-CPU counter.  But if we can regularly
> > update the lruvec rstat with something like vmstat_update(), that should
> > be OK for the issue described in this patch.
> >
> 
> This is also my understanding. Tejun, please correct us if we misunderstood you.

Yeah, that was what I had on mind. Instead of always flushing on read, have
a variant where flushing is explicit and trigger that periodically (or
whichever way appropriate).

Thanks.

-- 
tejun
