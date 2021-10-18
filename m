Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B754325D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 20:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhJRSCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 14:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhJRSCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:02:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2CB260F02;
        Mon, 18 Oct 2021 18:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634580005;
        bh=BzISW9vyCKuOW8xX5ed1YJPxUHasRv0VhWVr0H1nVr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YltaWPEDnGWX746jv/XUcHZOMV4RwfbENAUTpboIsTVBKh+ca3cfqONB/Y0mICkxm
         0w+TSJa8mzhTYVDo1si/VhBrStWjlpvlwzJG/TxNjFYFgyelmdqbGhYSikzy8TJeiM
         U4mH1DEmzSHdLMfCIObWdyYMdwnEDfpG6Dge+yvQ=
Date:   Mon, 18 Oct 2021 11:00:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        guptap@codeaurora.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4] mm: page_alloc: Add debug log in free_reserved_area
 for static memory
Message-Id: <20211018110002.596d03206aa849eec06d11f5@linux-foundation.org>
In-Reply-To: <1634540053-23304-1-git-send-email-faiyazm@codeaurora.org>
References: <1634540053-23304-1-git-send-email-faiyazm@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 12:24:13 +0530 Faiyaz Mohammed <faiyazm@codeaurora.org> wrote:

> For INITRD and initmem memory is reserved through "memblock_reserve"
> during boot up but it is free via "free_reserved_area" instead
> of "memblock_free".
> For example:
> [    0.294848] Freeing initrd memory: 12K.
> [    0.696688] Freeing unused kernel memory: 4096K.
> 
> To get the start and end address of the above freed memory and to account
> proper memblock added pr_debug log in "free_reserved_area".
> After adding log:
> [    0.294837] 0x00000083600000-0x00000083603000 free_initrd_mem+0x20/0x28
> [    0.294848] Freeing initrd memory: 12K.
> [    0.695246] 0x00000081600000-0x00000081a00000 free_initmem+0x70/0xc8
> [    0.696688] Freeing unused kernel memory: 4096K.

The above log appears to have things backwards.  I assume you meant

> [    0.294848] Freeing initrd memory: 12K.
> [    0.294837] 0x00000083600000-0x00000083603000 free_initrd_mem+0x20/0x28
> [    0.696688] Freeing unused kernel memory: 4096K.
> [    0.695246] 0x00000081600000-0x00000081a00000 free_initmem+0x70/0xc8


