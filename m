Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2029D3EAC72
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 23:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbhHLVi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 17:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbhHLVi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:38:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9DFC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:38:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q2so9100640plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zfF8/Nsamf3gvlzzJDOp8kdlxHU7XATBW3Znyt06h8s=;
        b=WGhh/zN0AhUSZ/Of+jVjg62dYsndSFONf9oP8kDje/H6VqyU+3u3YkWLm+ucSUNOTo
         KwRZcCwqLtfIi7pTYCuVlc7oJB8Fc8ce3SMGzDOaT5bMeTleDh6ud3x6+USYe/zeJhv6
         8atJ6XZpzP1eCtep4r9apCAkE71oVy858ulnb02Ujgh3OcC8sGapDKYLb6qUyH5nli0T
         6iwN7/3wk7zUneLV6tjAF0ZByMgDdHHIom+tkIDpUSk1fJDm5+ZeYZNIEMZ3vCMpawQQ
         rqVSJIiTlcxs3v7Y8AM/gP4JkWVe+PS6+w7Jf3JEhrx9R0a9YptVyZu8xKDOW960WgSH
         u4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zfF8/Nsamf3gvlzzJDOp8kdlxHU7XATBW3Znyt06h8s=;
        b=V+Du1gSpR1CIF0OjEnsi0Iz72K7sD0UNKgN0wE+SlnJ/HN5ZYR22nJ05GOQeA6YixE
         xBUByBd1UVpAU/hGPQwOl2i58myy0A5QawQ3vduN8WFBwvkpC0uTjs4ViJfjLOSbv60q
         LAfwJ1vXPIvnNpimdTW4j5oicWy77qgjhl+GX9Xz4EnnA9ord149Py4u0G+x9VTe/o0v
         K36wSJEHSCqgsiBIkN2CDszD59wmaPgtb8lE++7EluLgXvxiYC1EYzTXSLDy/X6Unsbl
         z/QC2+tFRtR4521S0qkoLZ2SRDC0ZYn5tFO+Xzmb9vAeVmHv9wyJnXnhfaQ3rgDknj3r
         6g2A==
X-Gm-Message-State: AOAM533xkRMRQpX+37Xu0giPF+/WZ6AeONHxefbdcv1D98HACDAG/DgF
        9dK1MPxIfgN2Ze2nw9aUHFo=
X-Google-Smtp-Source: ABdhPJxzUV+E6x2NsvqoerGW6WDd1xj+03g4JZ0FKVHawFpxbgWhwnsUasg7J51v84euyBRbjQrXBg==
X-Received: by 2002:a17:902:c401:b0:12d:8258:e07e with SMTP id k1-20020a170902c40100b0012d8258e07emr3107434plk.51.1628804310886;
        Thu, 12 Aug 2021 14:38:30 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id f66sm4594547pfa.21.2021.08.12.14.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 14:38:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Aug 2021 11:38:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     peterz@infradead.org, anderson@cs.unc.edu, baruah@wustl.edu,
        bsegall@google.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH 0/2] Add statistics and ducument for cfs bandwidth burst
Message-ID: <YRWU1avTzLoCqivI@slm.duckdns.org>
References: <20210730070956.44019-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730070956.44019-1-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:09:54PM +0800, Huaixin Chang wrote:
> Huaixin Chang (2):
>   sched/fair: Add cfs bandwidth burst statistics
>   sched/fair: Add document for burstable CFS bandwidth

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
