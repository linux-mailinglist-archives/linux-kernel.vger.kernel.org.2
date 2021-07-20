Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96F63D04F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 01:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhGTWVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhGTWUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:20:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA91060FE7;
        Tue, 20 Jul 2021 23:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626822089;
        bh=lhlyWhR+QA4Nadqw1+VqW7eaBbIYDw7UbLsHTU9xbhY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V/662+P5ivjol8w6OJbAwEaweq5TCtv8b9Jjg4sr8Cd4Gs4pMT+f23E5iYP4JVCWL
         X2qp4Uww4hZy5suv3t9jXoj1MxuRFaMdAE9ZGIbW19hP/Ic76San87002DiYtCj5nA
         cWRVtgTjpydexo+YCb8olMEuy7sZRNjt5RsYQt04=
Date:   Tue, 20 Jul 2021 16:01:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/rmap: Convert from atomic_t to refcount_t on
 anon_vma->refcount
Message-Id: <20210720160127.ac5e76d1e03a374b46f25077@linux-foundation.org>
In-Reply-To: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 11:23:35 +0800 Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote:

> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.

Grumble.

For x86_64 defconfig this takes rmap.o text size from 13226 bytes to
13622.

For x86_64 allmodconfig this takes rmap.o text size from 66576 bytes to
67858.

I didn't check which config option is making the bloat so much worse,
but this really is quite bad.  We bust a gut to make savings which are
1% the size of this!  Is the refcount_t really so much better than a
bare atomic_t that this impact is justified?

Can someone pleeeeeeze take a look at what is happening here and put
the refcount code on a very serious diet?


