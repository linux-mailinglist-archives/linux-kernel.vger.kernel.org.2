Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBAF3DD1E2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhHBIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhHBIYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:24:47 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA9FC06175F;
        Mon,  2 Aug 2021 01:24:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t68so15864245qkf.8;
        Mon, 02 Aug 2021 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=ftTeMsaFnDexLSsj0nGTDXOHs2swkIukHz+IHoPpb08=;
        b=C6cZSCXNc/U/zMxeSznrfNGCQDPT9YaWeg7N83KUpHQbZ9lqWaKc4y1rutI0uqYtox
         VPwgdxAESB1yAOtySnvc2+qFvTpoTPZsNBU4NiuoYgKF+NeHXQitootbEoJm/Ghhx9gn
         UVo2GjCg8sWEumHX/8vWA6lck+OGXkEQcl+/jAzHPxYzVu/cm441rheh7jYW8Rfw3fN2
         LTHPiRjaoBq5JgB8atin5L2zRw/4KvRoa17Vexso+TXxUeX4OHEVIhDsinNmYQctd7Y8
         XsHu5juyI1gWKMKJiiboxPVgZ1PEW8qI2PzifuMLr8j7TDFITmFUzt6b7vxhUm1wyvVx
         eGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=ftTeMsaFnDexLSsj0nGTDXOHs2swkIukHz+IHoPpb08=;
        b=bHz3cj0O8qDpSonrCExUbOVVXh2LG0TAZdkz0iIrQZItrOPCCvXwTcWYvqzxWi1e3V
         2d320Spg8sd1RPI0z/GwPfItihahebUmEQi4etVbk48/JczR6IcYipGNScBW2hiwWDLt
         apWAazl7v2cXYpW4bWM3YuoKsBh728Oq/4mtqDynScOGh5SXtpG4WI5bgt1eCXa0gPdE
         1FRnl4RcPvCHZeMOY1cXVdrWiGJH9YSnYFwKBoaogxOAjMwi+MPDgef9ttyGUpmS1Kk7
         IqYDNvNPR8fsYfUGVAnCE56PVLUIhMmEr+F84WQEZ74OZcDGGjfj2XDrREpat7YHA/Wm
         EHFQ==
X-Gm-Message-State: AOAM533tX5hubH/e1LXszqwIXNnFOHWKaoS9q7LKQ3dMA4qVpMADSO/o
        8/ObuiMO30d9xAbblaIBegQ=
X-Google-Smtp-Source: ABdhPJzuef6atXq/Y4rgBbRia4RuROrkMmcvKkZwi4YHK3ZuGrSmQ27cOTbRwdc1AP9x9tWnCDXxXg==
X-Received: by 2002:a05:620a:903:: with SMTP id v3mr14231864qkv.235.1627892676371;
        Mon, 02 Aug 2021 01:24:36 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id l12sm4427681qtx.45.2021.08.02.01.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 01:24:35 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        amit@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        jgowans@amazon.com, mheyne@amazon.de,
        David Rientjes <rientjes@google.com>, sieberf@amazon.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Wei Xu <weixugc@google.com>,
        Paul Turner <pjt@google.com>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Date:   Mon,  2 Aug 2021 08:24:24 +0000
Message-Id: <20210802082424.19584-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210728083643.5873-1-sjpark@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Andrew,

On Wed, 28 Jul 2021 08:36:43 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

[...]
> Now all the patches have at least one 'Reviewed-by:' or 'Acked-by:' tags.  We
> didn't find serious problems since v26[5], which was posted about four months
> ago. so I'm thinking this patchset has passed the minimum qualification.  If
> you think there are more things to be done before this patchset is merged in
> the -mm tree or mainline, please let me know.  If not, Andrew, I'd like you to
> consider merging this patchset into '-mm' tree.

I'm wondering if you had a chance to consider that.  If you had the chance but
this patchset didn't convince you, could you please let me know your concerns
so that I can make some progress?


Thanks,
SeongJae Park

[...]
