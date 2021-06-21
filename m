Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA2D3AE48C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFUIIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUIIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:08:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30DFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:06:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624262779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bv66guGPURdvi5EgNyQkHAh60w+8Jwry+B/iwalVowc=;
        b=Tnd+7bCuUo+RBZVxPDqgxN+AUYCjS/AKbrSLLFZ/S4ULfRaKyCQ7V1hNFo2ff0/PEWWoPo
        Sun65P294D+FEdqlkEGIaWzuTsmaS9Mz+1maN7ZNdN5VM/Hl1oAXgWlnix3vKwhL/csnHd
        QtA/jtsWoWWCp9HbcNTRnpRxtZJlzgOtTTR8DTLm6wIRJZLyIQXdCaAXHwn2I03JGd4V03
        d0f+F/riQmMDuntoyZsRaJ6vrpJJoiBiGjO2UYVGV6qzM9V82rLoQbsCy0W6ZfU4rKYY7q
        dh9/ZyD/gX2XDARPd4mXVngQbomfYeWgTdS+GQRN43TVM/mOUWbwT5LLwo+5Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624262779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bv66guGPURdvi5EgNyQkHAh60w+8Jwry+B/iwalVowc=;
        b=SvHJolxxMr26rz0YAAQ51L2dWeqdg1NiTWP77L/xaI87JhUdK0oWJMlFEffGDlSwExl63C
        QXs5sCwjBUNCsNBg==
To:     Yaohui Wang <yaohuiwang@linux.alibaba.com>,
        dave.hansen@linux.intel.com
Cc:     luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        Ben Luo <luoben@linux.alibaba.com>,
        Yahui Wang <yaohuiwang@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] mm: fix the pfn calculation mistake in __ioremap_check_ram
In-Reply-To: <87r1gxh7nj.ffs@nanos.tec.linutronix.de>
References: <20210611042147.80744-1-yaohuiwang@linux.alibaba.com> <20210611042147.80744-2-yaohuiwang@linux.alibaba.com> <87r1gxh7nj.ffs@nanos.tec.linutronix.de>
Date:   Mon, 21 Jun 2021 10:06:19 +0200
Message-ID: <87sg1bfxqc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19 2021 at 23:22, Thomas Gleixner wrote:
> Please make that:
>
>        start_pfn = PFN_DOWN(res->start);
>        stop_pfn = PFN_UP(res->end);

That should obviously be PFN_DOWN(res->end) as well.
