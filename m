Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A67345991
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCWIUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCWIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:20:24 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBD3C061574;
        Tue, 23 Mar 2021 01:20:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l13so14310550qtu.9;
        Tue, 23 Mar 2021 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=2Cn69MEEfHDPkVQCHTCmSgTsdeCi6G8turRRImnbPC0=;
        b=RkEbwv/49H7heXZkj9pzrtLiuwUUOVBWvsU/KJRxHoTRjaLLybAWeEZSX6OnaiMRAQ
         ThzwJ2LqHR1c+f0tU3+0sAKWNp1GDBQbg7ue19R2V8giuWqVRWAyiXw8qd1IMcp/uYDR
         8MtaJ4N6ByWE/6NmQhr5zgD813OH6EJpjmCGi5YYySXz1/Ihi3S/Lc0ZNuzObuNJ/tVh
         0dHjdcUMzM3oNo9gVa0XUZE4VoJp1Bj4h5LQNFqGVV4Ayn15cg53pBNk5U15HHmfYUJV
         ObxDuMul7bXs8xQ2O0V3B4NAfcEBxDTm96jSkkrxZ7/ccBHVi9qc0sxs8A7CZnHt7+LR
         UxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=2Cn69MEEfHDPkVQCHTCmSgTsdeCi6G8turRRImnbPC0=;
        b=Rudgqy8d4wHSCCCSWoaf4F1akL00eH5nzP7na/a80h8tUe0ve3TObpD3Y3D7AEoCLS
         Z0iTxo08IyjREaCop9CK/OQ3z+lVTBNjIPm2YkI3nUjxGWV5wOLsqbi+Er/9pyZUb0ZV
         /igbSC2iRNMRbtLySP6KKGpVMuOjKESF7/PdOlyuuWCCF5KBUqd9Qe8ENkIe8N0tL5NU
         8aQ472+v2DPNdq+8+NKvk78ge6VjozCnLvU6flahdNQ3ddpJqcXSH7qPB0jwR6hIgRLj
         +/2iOr52VbjbNgdbg00xOX4ykB72s1yxJsIUQytgonMQ3Qiys+Twk0YihaeTPeEmtdjf
         k4eQ==
X-Gm-Message-State: AOAM532p2og9PnaSQq3dniWjGZ3kw12xYhVbZZWkC/BlLijzUt9gs6KQ
        UFc0g+9Zc+xhAUt4trmwxOA=
X-Google-Smtp-Source: ABdhPJyG169JTKXFsTFhRb08TMe1alqs5IES2KXQDXaSZLOV1M/0R5GVjIYJY28WeqJHMvm5kBgghg==
X-Received: by 2002:ac8:7b23:: with SMTP id l3mr3375699qtu.165.1616487623298;
        Tue, 23 Mar 2021 01:20:23 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id u12sm8581459qkk.129.2021.03.23.01.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 01:20:22 -0700 (PDT)
From:   sj38.park@gmail.com
To:     sj38.park@gmail.com
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        gthelen@google.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        snu@amazon.de, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v25 12/13] mm/damon: Add user space selftests
Date:   Tue, 23 Mar 2021 08:20:11 +0000
Message-Id: <20210323082011.3273-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318100856.34715-13-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 10:08:55 +0000 sj38.park@gmail.com wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit adds a simple user space tests for DAMON.  The tests are
> using kselftest framework.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  tools/testing/selftests/damon/Makefile        |   7 +
>  .../selftests/damon/_chk_dependency.sh        |  28 +++
>  tools/testing/selftests/damon/_chk_record.py  | 109 ++++++++++++
>  .../testing/selftests/damon/debugfs_attrs.sh  | 161 ++++++++++++++++++
>  .../testing/selftests/damon/debugfs_record.sh |  50 ++++++

Because the monitoring results 'recording' feature removed from this patchset,
related tests and files including '_chk_record.py' and 'debugfs_record.sh'
should be removed from this patch.  Similarly, the related tests in kunit tests
also need to be removed.  I will do so in the next version.


Thanks,
SeongJae Park
