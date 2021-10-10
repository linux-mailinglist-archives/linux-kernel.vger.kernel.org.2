Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B681B4283DC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 23:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhJJVix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 17:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230271AbhJJViw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 17:38:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C180D610C7;
        Sun, 10 Oct 2021 21:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633901813;
        bh=DufKEuJC7yYgeMY+f5psVRbO7uxiZYwbdvgx7IkVa1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eFQKLwJbGwwvi6WmGCzsxmMLh0rLLHqSoB0GzNw8a3BZdxX82W5yCo6foc1IJwp/6
         gypDPsALymtcVqS48Rk6xgwFD61e0kZLwI1D7/Jd4WaRNdEIGmQ1QVZ8haiFVsmxpG
         Ove7wxLzkj5bDnHgEu2tQ5BUU0jfgA1h5mr4VEuA=
Date:   Sun, 10 Oct 2021 14:36:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <ryabinin.a.a@gmail.com>, <andreyknvl@gmail.com>,
        <dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <elver@google.com>, <gregkh@linuxfoundation.org>,
        <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v4 0/3] arm64: support page mapping percpu first chunk
 allocator
Message-Id: <20211010143622.18f491df5591d039cda8f7b7@linux-foundation.org>
In-Reply-To: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2021 13:33:51 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Percpu embedded first chunk allocator is the firstly option, but it
> could fails on ARM64, eg,
>   "percpu: max_distance=0x5fcfdc640000 too large for vmalloc space 0x781fefff0000"
>   "percpu: max_distance=0x600000540000 too large for vmalloc space 0x7dffb7ff0000"
>   "percpu: max_distance=0x5fff9adb0000 too large for vmalloc space 0x5dffb7ff0000"
> 
> then we could meet "WARNING: CPU: 15 PID: 461 at vmalloc.c:3087 pcpu_get_vm_areas+0x488/0x838",
> even the system could not boot successfully.
> 
> Let's implement page mapping percpu first chunk allocator as a fallback
> to the embedding allocator to increase the robustness of the system.
> 
> Also fix a crash when both NEED_PER_CPU_PAGE_FIRST_CHUNK and KASAN_VMALLOC enabled.

How serious are these problems in real-world situations?  Do people
feel that a -stable backport is needed, or is a 5.16-rc1 merge
sufficient?
