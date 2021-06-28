Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365473B65F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbhF1PqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbhF1Pph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:45:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960A3C0575FC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:07:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso199600pjp.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ULn7DIu4wwa5GXTqLwaOz3Z66Z8PfP99SnS+I7xsRHs=;
        b=Km2QoyDwZDeRvpQWFJj2Oklrs8bFDQOuHnqfM/z7OkNSv+69D2qERWqZk7Xb2z44qU
         /bU5I3GyU8Oee86tFVDjufMGNPjeww1sAxP6rHtZvC4WoIPsTxNm5GFZZU9AeXpjWbgK
         uJPX5vKilC4qT3wX3aO3lLel4Bv09CM8NL7SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULn7DIu4wwa5GXTqLwaOz3Z66Z8PfP99SnS+I7xsRHs=;
        b=pOgkjxnQO1Cvpg9Fgyc3rA6R47okmTAG2u4UjS8Af84MUdPl41T6QWII5p7fNUS+O9
         ZdaVZg2Sc7qJ6V+ODGX9HscbN4nInIUChx52/K6xTZ7nxXixLFobLZ+Id42bbCMUYSB9
         ShWlfpQfJLvAmQHjKvP3E/Lpan3ATBMQwQEqCLnZFSMQB0Ebp1YrAnTNqpvctAHVyOsx
         e0YgTZF15rA6duo3aS3OQbUP9sxuAN8EpdYoNjOI8fny6boES31YVHDlOiTAE6PxNBbE
         9XNd4ThFobnyBvB/35hlcuNhXY+sMXMZjZ4IWaGx6sePCv6BTm8Nl7rmIJJrg2wXEpMt
         gdsQ==
X-Gm-Message-State: AOAM5321R0K+uMTEo3kCjDqR2/1gD7gSboS8GKuB5M31s66rc9IjxGHt
        a2hp+rbdk+uBfo0PYoSv2qfnxQ==
X-Google-Smtp-Source: ABdhPJynLhIrI4Ec/Pi8a+UDxpqcBNKVYwi1xF2Z3p9w13WpPyERu1mDpA9ujWCI8mGWcJne8PRpsQ==
X-Received: by 2002:a17:90b:30c3:: with SMTP id hi3mr27886839pjb.188.1624892823966;
        Mon, 28 Jun 2021 08:07:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v8sm14011101pff.34.2021.06.28.08.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 08:07:03 -0700 (PDT)
Date:   Mon, 28 Jun 2021 08:07:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@aculab.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [selftests/lkdtm]  7ecfffe9bc:
 kernel_BUG_at_drivers/misc/lkdtm/bugs.c
Message-ID: <202106280805.5620A53D08@keescook>
References: <20210628145922.GC22448@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628145922.GC22448@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 10:59:22PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 7ecfffe9bcb6657ae3a86c58f8eae2fe37b54807 ("selftests/lkdtm: Avoid needing explicit sub-shell")
> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git for-next/lkdtm
> 
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-f8879e85-1_20210621
> with following parameters:
> 
> 	group: lkdtm
> 	ucode: 0xe2
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt

When running the "lkdtm" subsystem of tests, CI systems should ignore
console Oopses, since those are "working as intended" for lkdtm (which
is explicitly testing for those Oopses).

-Kees

-- 
Kees Cook
