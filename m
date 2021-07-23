Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CEB3D36BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 10:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhGWHvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 03:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbhGWHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:50:56 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40D8C061575;
        Fri, 23 Jul 2021 01:31:29 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id d3so976511qvq.6;
        Fri, 23 Jul 2021 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=dAq3FMH3xWIDd4rB9QkghoTPee5euqoWAeHWd9uubt8=;
        b=uA1/HeoTMzshvJyEK4GqyvadbsSf9RoceDgiRI7W8gzZr2ehF3//XfGp9AGne+zWyx
         J/ragQAfhPYdTmRkKNyrBjZJSI1e+kktIjF/KG2R7ElpU/dh4VI7ZPoMDxu70yUQS01O
         5/SeqNCqP3aihjAQfXjNcHw3upZ0YB5J6fPzRpDMJ0phy7foGtuJFXF01bBEsD2JUXoU
         Fa8zsC8A/8q80fgn/s5J1hRhugYVRZjm4V5mLO1SqFKZxegGXD5MvmVUD4a6LIlPiONV
         mD+xI83tLMaCVAYyaQS6dIhVHzz6eyEQBGMR3mlw0120EOiuZvcg9VtU8q60h9nuRKxU
         v3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=dAq3FMH3xWIDd4rB9QkghoTPee5euqoWAeHWd9uubt8=;
        b=Xs+x5mNVtXM67aVFTMdIrHMcI3fOypvipjxZ/qRLbZDdkyW7zUF2UKjyZXZrDiBwzj
         7kmWdOLY96kWAQSp6CeszNhYsap09Mcvu9qiityq9NccLPotiQ4p6kbKtDe8C+TCTQ8J
         otJwzH83vJuTLGt6nUDogsvphChUv8eSZkSGSG36qKnXTbHdi67POwMNSqQEPlNgvl8Z
         5R0ECCTcgV0VeLBicISLrGDCcfCzbDbNU/MqHWe8NMqTSlKVzt1zVgmIQaTvHW1kRDyB
         rgNWt9/YgpErYKJf8lzOfpQtc/f5k+HCmN65vhyZdAokt8Z1FWBqd34o0dHZuGkrhZhq
         bUZg==
X-Gm-Message-State: AOAM530aDQtvhXgYvbcS7HOai1QajoVXDAmKsQIZAv45kKizevUpgy8n
        RIdj8sgCRR4YWJIArLg1J6I=
X-Google-Smtp-Source: ABdhPJwRJXGqsUHc9QN0NQ0FWqeQq61fC4Ywk9uzSIjFPCfg/WSBSdcCNKlEtOuZyDzj7PbnIM8zRQ==
X-Received: by 2002:a05:6214:5085:: with SMTP id kk5mr3783472qvb.25.1627029089060;
        Fri, 23 Jul 2021 01:31:29 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h201sm1806494qke.40.2021.07.23.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 01:31:28 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Dongjoo Seo <dseo3@uci.edu>
Cc:     SeongJae Park <sj38.park@gmail.com>,
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
Date:   Fri, 23 Jul 2021 08:30:41 +0000
Message-Id: <20210723083042.2720-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2E16FC36-18B4-4F92-86AE-51249CCDB1A4@uci.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Dongjoo,


On Fri, 23 Jul 2021 16:02:44 +0900 Dongjoo Seo <dseo3@uci.edu> wrote:

> Hello, I am new user of this amazing tool.

Thank you!  It's always great to meet a new user!

> I want to use this tool for Nvidia tx2 board with kernel version 4.9.140.
> 
> Do you guys have any timeline or update schedule for different kernel version compatibility?

I didn't have such a plan until now, but I think I can find a time slot to do
one-time back porting of current DAMON on 4.9.140.  I think continuous support
would be not so easy, though.  Nevertheless, if you need that, please feel free
to let me know.  Once it's done, I will notify you.


Thanks,
SeongJae Park

> 
> Best
> Dongjoo Seo
