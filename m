Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14784581B2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 05:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhKUEjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 23:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhKUEjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 23:39:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6507C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 20:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mWmY95qzcIu+QFXWIBrvCEFwFTYhVHEPwdMiIBYqp1E=; b=a07kKpKxLi4wdtGUdaMADCxgf2
        4RpGW6Wv/QDLL/H+0vFpp+2I+dzjKncNuAIr1Gv0CFRHeR7LiTDxm4YwEfSosqUPynNhD9ZHPQCdw
        HFgR/4IRhzNOcw3o1tV9WBnkkKs4FBVJgEm2rlEoNmGxMXVWdptq2RTQVMJBIpBb3dbEwE+Ry8tZ3
        x2/vpYeZ+AXWtcpc34Zel55/LvJxntUT2UllncwrORTRLuM8mXNNfhIA2hC8GuA1K9/PFfSfeKzje
        L9Im739hSqlOHiiz4IzSb6tc4Br2hMTPFU2BRWsRO8Ihw+rxP7D0kuXIxs4IGa5o3G7zTBIrcP19I
        IMtL5Ghg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1moeZr-00Bapo-DZ; Sun, 21 Nov 2021 04:35:43 +0000
Date:   Sun, 21 Nov 2021 04:35:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Message-ID: <YZnMnyKRk8d/Ilyo@casper.infradead.org>
References: <20211120201230.920082-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120201230.920082-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 12:12:30PM -0800, Shakeel Butt wrote:
> This patch let such applications not worry about the low level handling
> of THPs in the kernel and splits the THPs synchronously on
> MADV_DONTNEED.

I don't mind the synchronous split, but I have concerns about the
implementation.  I don't think it's worth another pointer in task_struct.
It's also the case that splitting is likely to succeed, so I think a
better implementation would try to split and then put the page on the
global deferred list if splitting fails.

