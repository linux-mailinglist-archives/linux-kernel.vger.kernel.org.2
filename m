Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72D5450625
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhKOOBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbhKOOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:00:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D558C061714
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r8IGU963lEQVH+Im4QzL/H6LDlFZrB01JAXnEqj9dhE=; b=QF6PQmS+MdU8npd8i7JfRrcYd0
        jNGbjW8658UbN63zyaUcW0HkELMI3y4qUerLOo/QEsCamN+pGRlDsB0a/NQ8vSXraWDuTrlFF4GPw
        EWmWOWFcIEQ38nm/XcL6gdXilw4YEJyLiF7uOwpmvPoq4EFMoSRaC1soa6rcwDwtIJVoW2yDRF9Mz
        P9j85vOQS6VRQ+jzPUjTEQHGEsC02JB0Wglk3wuWe5iDL0NE8VbWhjr27ywOuVIEUu6cpHAXWUYfw
        3Ol1gjCFOPxz/ICsDuHSKsjaQOSPuXSugY1/HEDP4aSEuhXGqA0zNQzcArcpQMCSQqhoNvcpegt01
        0GuuaN9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmcUH-005k3T-0t; Mon, 15 Nov 2021 13:57:33 +0000
Date:   Mon, 15 Nov 2021 13:57:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 2/2] mm: Rework swap handling of zap_pte_range
Message-ID: <YZJnTKKXDqKWZ6UP@casper.infradead.org>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115134951.85286-3-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 09:49:51PM +0800, Peter Xu wrote:
> Clean the code up by merging the device private/exclusive swap entry handling
> with the rest, then we merge the pte clear operation too.
> 
> struct* page is defined in multiple places in the function, move it upward.

Is that actually a good thing?  There was a time when declaring
variables more locally helped compilers with liveness analysis and
register allocation.  Compilers are probably smarter now.

