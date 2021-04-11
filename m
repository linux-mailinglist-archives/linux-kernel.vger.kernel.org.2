Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D2F35B44A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 14:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhDKMiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 08:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKMiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 08:38:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD6FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:37:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n2so15704378ejy.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VqHVuBSc6gFJz+YjclMf8Y/UcysXe9Kd0M+xdiqMWok=;
        b=M7uMfXLLU53sc54MPj0tms3E1t3SrseGDE/wXsp3xLKinnSiGBqu4g2x85eKNpJAwy
         aRWaXJ6EDO87zZHBARyNBi80rkUU4fygaKhs2Sgqdlmfhs7dtIFdePlZyI4PawWF+ZIH
         85Bw8x0dM0MzAsjwDn4JNyZNW6LqVXy92KKIhplT8f4FHlUJcCjWTATru86ZS63+QAcP
         SIJw88/A0XtixBE63WrFrv0UhvHObld/szD5JPuyCLgaZifj4hJkCiWi/Lca0GN9uJzE
         LPCUDLz+UoPjmX+1bNnVgNKSRdY3V2agFRionIDQlJPM2+JIm2G+diSGgR1CeznnqVyB
         80RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VqHVuBSc6gFJz+YjclMf8Y/UcysXe9Kd0M+xdiqMWok=;
        b=GBKotz/iosmKWkJAiMpoDIoquqsIZGe0PBn7cEfx0Jjx/xEQhkAh2QDt8oQpS3bW/L
         rtY/QaT7b48pdLHVOyV+EwWPDBvS+ZuJFG16oMKpLJgBb3bAa8VJGOiJMdekhmO0h+fQ
         8tRLNCMkYR621gUNmBNLi/k9p5WsqW1zOHEs5eHrME2DIcP11sKy+U6F+SLSFzta3nns
         on3VBmm6x3WbjOp3QMoeOnQbhrqDKaxL8V1l3B6yWmM37qo4DSVy2fMMbiW/5YhgHXmt
         LdIEetRIOkNQB/mIroNaYTHfPrGK3AZPiv8HCGYZZj2uD88MhXjJWldpv1kudmz6kaEm
         FVVg==
X-Gm-Message-State: AOAM533UpJetUnyDSu2ZSioDtI+UwRLHbk7PvGzRp5aN9ku6xJfFZkRu
        FJHbT+doNLW/ZhDhrxSw+uY=
X-Google-Smtp-Source: ABdhPJxcF4Y38018a86w2OHTNtAqql3A1d+bA1yeuTdtbEB1187JZnmXBKVtp7kTbBVAwCb5vCJyiA==
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr23405031ejc.502.1618144668584;
        Sun, 11 Apr 2021 05:37:48 -0700 (PDT)
Received: from gmail.com (2E8BA22B.catv.pool.telekom.hu. [46.139.162.43])
        by smtp.gmail.com with ESMTPSA id w2sm3944805eju.71.2021.04.11.05.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 05:37:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 11 Apr 2021 14:37:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, akiyks@gmail.com, elver@google.com,
        frederic@kernel.org, jiapeng.chong@linux.alibaba.com,
        lukas.bulwahn@gmail.com, mchehab+huawei@kernel.org,
        neeraju@codeaurora.org, paul.gortmaker@windriver.com,
        sangmoon.kim@samsung.com, stephenzhangzsd@gmail.com,
        urezki@gmail.com, zhouzhouyi@gmail.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU, LKMM, and KCSAN commits for v5.13
Message-ID: <20210411123746.GA1099816@gmail.com>
References: <20210331192934.GA8127@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331192934.GA8127@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo!
> 
> This pull request contains changes for RCU, KCSAN, and LKMM.  You can
> pull the entire group using branch for-mingo.  Or, if you prefer, you
> can pull them separately, using for-mingo-rcu to pull the RCU changes,
> for-mingo-kcsan to pull the KCSAN changes, and for-mingo-lkmm to pull
> the LKMM changes.
> 
> The changes are as follows:
> 
> 1.	RCU updates (for-mingo-rcu):

Pulled into tip:core/rcu.

> 2.	Kernel concurrency sanitizer (KCSAN) updates from Marco Elver.
> 
> 3.	Linux-kernel memory model (LKMM) updates.

Pulled into tip:locking/core.

Thanks a lot Paul!

	Ingo
