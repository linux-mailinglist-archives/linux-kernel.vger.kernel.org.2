Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918DC405A77
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhIIPzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhIIPzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:55:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C260C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 08:54:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w17so1816949qta.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lNkOobc3fvllVNhfS015DlznHrwl6HCxnMSWZ4cncKQ=;
        b=hOeCR/JJuW3vq5krtQ04NqAe3NRp9UNakz/JaDhHfDTZXY284UOdc/H3BIkQrQt4D3
         2keTTfRtZtd8VXUfZ9/WHkaa+4yY59N15v5RRRDVZXIiZR5oQRWBUAsmXgDywC8AXUQf
         p1lc2oep7lRHbwWCCMkvGXUqRXldKb0T4q/tnxwLCMFvMPsE0mAiF3B1M7CxRRNDbJTJ
         VCEbEW3/BeqBqzXEJ1QPMMO7xwsBOyNng46vZOrHKngRonUTKFTflKhBX++Cbjrb3/k0
         hMP7o1hCue6h2FAzSthtp4Xs9izE3FJcX9Ye+xndsOvyNsj9U5Hzylw5CFHQ8HvW7TMS
         9OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lNkOobc3fvllVNhfS015DlznHrwl6HCxnMSWZ4cncKQ=;
        b=QHAR7UqAQHd3Q5Potf9hnayHwae/3CuoNoc2gFX6/G02d80bI+qc5rgJUmbbzZOqnf
         kJSEKru3qsk3d7gU0IVtyzbJAJ/YvW12WYz3nCN1fE5nkl3ASKgZrL2ei/3doFP2UZns
         Qm1hCs3BVxyr/wEpB9unQcpr4Ngty0MvXZ1Rvu9BiHm35bDQIuUSoffaZ9NwAXJYxa4X
         AbvE4HbITTB+RQKJzKSbOjdQrAW2WAvT9cLYFrSKzqMyLIa0xtiiKjgg1ce2GT/KVFqK
         0i+2CdBJhpgDHf3RStIZzwxe2DOUvYb2wUa9eIUhvZFQMlfaabK7haa+ibpxaPDRi0Gr
         iGkg==
X-Gm-Message-State: AOAM531aPMp8BGcbXm0XMM9CCw3ssxeYDi2FJb/Wfy32WCDczB5WUCmS
        8azJToZP6gNYqcog5UDh92+S3UQd2K7hMw==
X-Google-Smtp-Source: ABdhPJyAenaHR8h2iXKo1iDFqmURb78xjYil4jnfjAijvBPE9Zc4iIAAq2xHYlW/b76M4RVxlmECMA==
X-Received: by 2002:ac8:6a0c:: with SMTP id t12mr3427239qtr.159.1631202875799;
        Thu, 09 Sep 2021 08:54:35 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id f6sm1523925qko.85.2021.09.09.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 08:54:35 -0700 (PDT)
Date:   Thu, 9 Sep 2021 11:56:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        ke.wang@unisoc.com
Subject: Re: [RFC PATCH] psi : calc psi memstall time more precisely
Message-ID: <YTouqsXeAGV6c5oV@cmpxchg.org>
References: <1631188824-25623-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631188824-25623-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 08:00:24PM +0800, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> psi's memstall time is counted as simple as exit - entry so far, which ignore
> the task's off cpu time. Fix it by calc the percentage of off time via task and
> rq's util and runq load.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Can you please explain what practical problem you are trying to solve?

If a reclaimer gets preempted and has to wait for CPU, should that
stall be attributed to a lack of memory? Some of it should, since page
reclaim consumed CPU budget that would've otherwise been available for
doing real work. The application of course may still have experienced
a CPU wait outside of reclaim, but potentially a shorter one. Memory
pressure can definitely increase CPU pressure (as it can IO pressure).

Proportional and transitive accounting - how much of total CPU load is
page reclaim, and thus how much of each runq wait is due to memory
pressure - would give more precise answers. But generally discounting
off-CPU time in a stall is not any more correct than including it all.

This is doable, but I think there needs to be better justification for
providing this level of precision, since it comes with code complexity
that has performance and maintenance overhead.
