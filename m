Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246B53D36F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 10:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhGWIAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 04:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbhGWIAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 04:00:07 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAB6C061575;
        Fri, 23 Jul 2021 01:40:40 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o13so673228qkk.9;
        Fri, 23 Jul 2021 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=5fHOWqJ8qh0WwR9vw60QMKf5JORbjfW0NMV+4iT7I6w=;
        b=tTj5kE3E1A4aR+RRnZGKWdDEH8JLh4yP9kt680dTW6xjBwBfV942ghN1IRoaIsihID
         Fq3ntV/U9GGC5L2GxV/cnFRA17KepG50tEV1gYy0GB7m5NHn4woQ9pTuTYFf02lrjGOQ
         AqsnGyyGHJYIEm93hWMt4huH4/bC0Ic4MbfiblMpMJQPaqv5JP2w3qPk6TadjZyM8MuB
         mBWlNzUXHkQE1OYxhpgiKmTwzd6CDt094wddLKcZvG5H4pGTabceNPjJHJnL8c0E/4Xj
         2yBGWabfH2iQfBNtzi1MyOltVKPtd0mvBZAg4NypM9y7GcgF1YQ3ZFhu17defB60pbAH
         rmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=5fHOWqJ8qh0WwR9vw60QMKf5JORbjfW0NMV+4iT7I6w=;
        b=i92g81igNm1nU0v4hQclZ0b0Dln+5faix3/KFR78K2G4+eW/8D7u8aU0orp16qhRHn
         rzSadgr5VjbdWEjVDey8bjYZtuCpb8MLmbi4pfDzRAQYj2v1HiadZCNdUlugzFAAkCS2
         Ya+nARSx3ZAq2k0TQy6teQz1oox+xS9jQLyMnlu20fzaqmHoe4EcvNmXbX9T5RlUfpsx
         4bky4plNDfs3iTEaqPh07XCiPgjbRq4Y1xtyEHcPl4bF69eKWzmjYKF07MdqsJA/tb9o
         nuXVB1wL1KS0gyGcE48oWKSpbI3E5j2l56RiHi8hTuPVqOtCm8Yyzm7kNyenanPj7/RF
         jcnQ==
X-Gm-Message-State: AOAM530mhXs8TT75JE5roeV8NIRh8M3ZKHAPtMBkKJ15Gw9TXojgCFNG
        C0wXQ2oaXq5Fim7a2yM0hSk=
X-Google-Smtp-Source: ABdhPJzOHyPxVKfFwgTUboDXq2NPyhFtWQ1kiQEeENNEWaCTpqjquv6jAZ18ejSXY418BqdpbT2Zwg==
X-Received: by 2002:ae9:ed05:: with SMTP id c5mr3466245qkg.24.1627029639612;
        Fri, 23 Jul 2021 01:40:39 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id z12sm11105576qtw.90.2021.07.23.01.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 01:40:39 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Dongjoo Seo <dseo3@uci.edu>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@Huawei.com>,
        acme@kernel.org, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        greg@kroah.com, gthelen@google.com, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, joe@perches.com, linux-damon@amazon.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, mheyne@amazon.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sieberf@amazon.com, sjpark@amazon.de,
        snu@zelle79.org, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Date:   Fri, 23 Jul 2021 08:40:32 +0000
Message-Id: <20210723084032.2935-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723083042.2720-1-sjpark@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Fri, 23 Jul 2021 08:30:41 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Hello Dongjoo,
> 
> 
> On Fri, 23 Jul 2021 16:02:44 +0900 Dongjoo Seo <dseo3@uci.edu> wrote:
> 
> > Hello, I am new user of this amazing tool.
> 
> Thank you!  It's always great to meet a new user!
> 
> > I want to use this tool for Nvidia tx2 board with kernel version 4.9.140.
> > 
> > Do you guys have any timeline or update schedule for different kernel version compatibility?
> 
> I didn't have such a plan until now,

BTW, note that we are supporting latest two LTS kernels:

    For people who want to test DAMON but using LTS kernels, there are another
    couple of trees based on two latest LTS kernels respectively and containing the
    'damon/master' backports.
 
    - For v5.4.y: https://github.com/sjp38/linux/tree/damon/for-v5.4.y
    - For v5.10.y: https://github.com/sjp38/linux/tree/damon/for-v5.10.y


Thanks,
SeongJae Park

[...]
