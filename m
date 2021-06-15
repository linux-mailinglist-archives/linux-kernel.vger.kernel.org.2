Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C193A7B94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhFOKRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbhFOKRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:17:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51BB861443;
        Tue, 15 Jun 2021 10:15:18 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:15:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        gregkh@linuxfoundation.org
Subject: Re: kmemleak memory scanning
Message-ID: <20210615101515.GC26027@arm.com>
References: <YMe8ktUsdtwFKHuF@nuc10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMe8ktUsdtwFKHuF@nuc10>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rustam,

On Mon, Jun 14, 2021 at 01:31:14PM -0700, Rustam Kovhaev wrote:
> a) kmemleak scans struct page (kmemleak.c:1462), but it does not scan
> the actual contents (page_address(page)) of the page.
> if we allocate an object with kmalloc(), then allocate page with
> alloc_page(), and if we put kmalloc pointer somewhere inside that page, 
> kmemleak will report kmalloc pointer as a false positive.
> should we improve kmemleak and make it scan page contents?
> or will this bring too many false negatives?

This is indeed on purpose otherwise (1) we'd get a lot of false
negatives and (2) the scanning would take significantly longer. There
are a lot more pages allocated for user processes than used in the
kernel, we don't need to scan them all.

We do have a few places where we explicitly call kmemleak_alloc():
neigh_hash_alloc(), alloc_page_ext(), blk_mq_alloc_rqs(),
early_amd_iommu_init().

> b) when kmemleak object gets created (kmemleak.c:598) it gets checksum
> of 0, by the time user requests kmemleak "scan" via debugfs the pointer
> will be most likely changed to some value by the kernel and during
> first scan kmemleak won't report the object as orphan even if it did not
> find any reference to it, because it will execute update_checksum() and
> after that will proceed to updating object->count (kmemleak.c:1502).
> and so the user will have to initiate a second "scan" via debugfs and
> only then kmemleak will produce the report.
> should we document this?

That's a mitigation against false positives. Lot's of objects that get
allocated just prior to a memory scan have a tendency to be reported as
leaks before they get referenced via e.g. a list (and the in-object
list_head structure updated). So you'd need to get the checksum
identical in two consecutive scans to report it as a leak.

We should probably document this.

-- 
Catalin
