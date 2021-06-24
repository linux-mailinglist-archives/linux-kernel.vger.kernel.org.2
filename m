Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00C73B3838
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhFXU7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhFXU7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:59:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 475FF60FF1;
        Thu, 24 Jun 2021 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1624568244;
        bh=u/gehyKLEMLPDqkaXJpcfLQFYkfHJRSEg6Syn2xn4YI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d375zGYlRkEZ2Yb4UxAtr5w7JBXVAWDc0shJglPVjCxKXOoatFiaMGjvNe7jXcm+t
         khcbiaVCziTXa4PhCK/5rwOdmvOb2UTcR0eJGPDhhmVE4pD/nzy05Cm0BzLyjFerZN
         7BK1it2C9BX7LoB51jRIwMSnVd30rIzbE/WjILsA=
Date:   Thu, 24 Jun 2021 13:57:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     alfalco@gmail.com, Borislav Petkov <bp@alien8.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        robert.shteynfeld@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix memory map initialization for
 descending nodes
Message-Id: <20210624135723.3b2b25de43e22ab4275ea273@linux-foundation.org>
In-Reply-To: <20210624062305.10940-1-rppt@kernel.org>
References: <20210624062305.10940-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 09:23:05 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> On systems with memory nodes sorted in descending order, for instance
> Dell Precision WorkStation T5500, the struct pages for higher PFNs and
> respectively lower nodes, could be overwritten by the initialization of
> struct pages corresponding to the holes in the memory sections.
> 
> For example for the below memory layout
> 
> [    0.245624] Early memory node ranges
> [    0.248496]   node   1: [mem 0x0000000000001000-0x0000000000090fff]
> [    0.251376]   node   1: [mem 0x0000000000100000-0x00000000dbdf8fff]
> [    0.254256]   node   1: [mem 0x0000000100000000-0x0000001423ffffff]
> [    0.257144]   node   0: [mem 0x0000001424000000-0x0000002023ffffff]
> 
> the range 0x1424000000 - 0x1428000000 in the beginning of node 0 starts in
> the middle of a section and will be considered as a hole during the
> initialization of the last section in node 1.
> 
> Reorder order of the memory map initialization so that the outer loop will
> always iterate over populated memory regions in the ascending order and the
> inner loop will select the zone corresponding to the PFN range.
> 
> This way initialization of the struct pages for the memory holes will
> be always done for the ranges that are actually not populated.

Changelog doesn't tell us what are the user-visible effects of the bug.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=213073

But that does.  Panic during boot.

> Fixes: 0740a50b9baa ("mm/page_alloc.c: refactor initialization of struct page for holes in memory layout")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

So I think we want a cc:stable here?


