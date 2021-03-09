Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7C331B94
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhCIAUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCIATu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:19:50 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C311C06174A;
        Mon,  8 Mar 2021 16:19:50 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E8E6231A;
        Tue,  9 Mar 2021 00:19:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E8E6231A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615249190; bh=T4xWyxHpUqwiXaFkeoxDy/DZL6aBJz4AVIJoA7yp9OY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=q2ad1gQVW08cNOw6C/8T1MyNt9GrekRvDqbVWDoRXmxOUWEXvQT75EJX8vkBESpzM
         XeSU/zZ+wmpbPCicbX0mHoIg8JpJiw6bFFPth4sPzLBlg10EcJwTvbjgKzO7684+k4
         5wKcucjGNP0/qW02BzQqGZDxUeVhvQktgZ3P7Gsf88gvWS6ZHTwDRF7acLWJ6qiVM9
         uOtQM7EOnMMAMUGKef8D8X4gtUC338FLP6/XS4TU+817YGgh5vPayf3tHVCuUf07Or
         7lIwUeIb6+PjIkStlrxPfJWQca2nIL71N6eHoovM4acgKQAeo+KaFl3RjbnmiJgOcG
         1pwVYlRMJ7+QA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Barry Song <song.bao.hua@hisilicon.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mel Gorman <mgorman@suse.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Documentation/admin-guide: kernel-parameters: correct
 the architectures for numa_balancing
In-Reply-To: <20210302084159.33688-1-song.bao.hua@hisilicon.com>
References: <20210302084159.33688-1-song.bao.hua@hisilicon.com>
Date:   Mon, 08 Mar 2021 17:19:49 -0700
Message-ID: <87sg5541qy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Barry Song <song.bao.hua@hisilicon.com> writes:

> X86 isn't the only architecture supporting NUMA_BALANCING. ARM64, PPC,
> S390 and RISCV also support it:

Applied, thanks.

jon
