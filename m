Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485E1413DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhIUW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhIUW6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:58:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABEAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:57:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so781967pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bqpSXa1bC3SUh8grq2uEmyOAGunLA8G1syV0zRquB/0=;
        b=j2T/acSaeDxamzvs+PwEfV0JMg2R6ljc5aUzX/ln6BbTzr5bIx/fqRx+tXVkCs7p7n
         S1+whhJBhQiQ03XMiIE5yilr9rGq8K1DhXUT8ky4uU+p3l5Ov3qGUcoH9oG/1lF9cITp
         hBp9mBFBUu01Jsoc23lqYRRDMZldkf4La5mozqTbkU6z8GAaqjdaaOyDucTxoYxROmjz
         vq1FxlIrnSgX6BIvvsEo6q3CCKrAkovm7cYQYuoA3mIq1+gN/QXNr6OSl2e0WxYV6oTR
         MOOgfkoyrtuxX3h3KbVun6/kk9XJf3V2N0OP6qPuLg7UoWRS3jsuSMVYlPlKHMADMmuU
         QJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bqpSXa1bC3SUh8grq2uEmyOAGunLA8G1syV0zRquB/0=;
        b=FT7gWRKkHAbD7kp4gGMbQ3KwPm24Xe4Z6mIW3wsN2NBDRv7OU2YjnQcZr/AwiIGbjs
         aVPji9U/zSN8443cDHm905YcUwhxNFgH8ZwkSRTvbXq92r975mMQI2RDIn1VpaZsSf0g
         RyqetTxN4iB8D2YraCignXa6LVc2BMo5kD7kmo3n0f+DRIx7juOJgafijlgLzntAq6St
         3vI1vXfBlI8erg7Xs+Gt97GofHQKlN7H//LwkReEg+9ULJj/hWnIUOqq91EpdMWLfwAn
         o9bTrUwiAepwthxr9iDqrI3DBHzc8C+pBBEwjHpDsnYJ/KYyViwbTRTKfKZsgSCBlbRY
         wCFw==
X-Gm-Message-State: AOAM533en/d5610DDX38fSkCgkHvuvZQj1dX+2eN5Ts20TEQ2avqcwZL
        04XtS7Jt4i+vjQS/lNUEiPuPAA==
X-Google-Smtp-Source: ABdhPJwH6i7qtp/ZQcEIFzsXeukFyZKSJJdooX6PnRSRf7g3owTSBpnjmqWZrEn0avut5YOuh+B4hA==
X-Received: by 2002:a17:90a:198b:: with SMTP id 11mr7744685pji.209.1632265020574;
        Tue, 21 Sep 2021 15:57:00 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i19sm178028pfo.101.2021.09.21.15.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:56:59 -0700 (PDT)
Date:   Tue, 21 Sep 2021 22:56:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, xudong.hao@intel.com
Subject: Re: [KVM]  816be9e9be: kernel-selftests.kvm.smm_test.fail
Message-ID: <YUpjOO3bq/SMFN7A@google.com>
References: <20210912155933.GI25450@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912155933.GI25450@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 816be9e9be8d2e19dcea35fbec06f00cd5749fed ("KVM: nVMX: Don't evaluate "emulation required" on nested VM-Exit")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-d0cba0d1-1_20210907
> with following parameters:
> 
> 	group: kvm
> 	ucode: 0xe2
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 28G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>

Maxim has a fix in the works.
