Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489963DC71D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhGaRNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 13:13:16 -0400
Received: from smtprelay0171.hostedemail.com ([216.40.44.171]:38420 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229449AbhGaRNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 13:13:14 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 22371182CED2A;
        Sat, 31 Jul 2021 17:13:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 22581C4182;
        Sat, 31 Jul 2021 17:13:06 +0000 (UTC)
Message-ID: <72be13936ca341897d2fd7c65fb4345a8467c571.camel@perches.com>
Subject: Re: [PATCH 4/4] memblock: stop poisoning raw allocations
From:   Joe Perches <joe@perches.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Sat, 31 Jul 2021 10:13:04 -0700
In-Reply-To: <20210714123739.16493-5-rppt@kernel.org>
References: <20210714123739.16493-1-rppt@kernel.org>
         <20210714123739.16493-5-rppt@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.06
X-Stat-Signature: yj9zkob6dcque4mf7j5834161m7hf6mi
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 22581C4182
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19ko8q83D4fbzHA4YVPHk7tHYLcyeYYJGs=
X-HE-Tag: 1627751586-362545
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-07-14 at 15:37 +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Functions memblock_alloc_exact_nid_raw() and memblock_alloc_try_nid_raw()
> are intended for early memory allocation without overhead of zeroing the
> allocated memory. Since these functions were used to allocate the memory
> map, they have ended up with addition of a call to page_init_poison() that
> poisoned the allocated memory when CONFIG_PAGE_POISON was set.
> 
> Since the memory map is allocated using a dedicated memmep_alloc() function
> that takes care of the poisoning, remove page poisoning from the
> memblock_alloc_*_raw() functions.
[]
> diff --git a/mm/memblock.c b/mm/memblock.c
[]
> @@ -1490,18 +1490,12 @@ void * __init memblock_alloc_exact_nid_raw(
>  			phys_addr_t min_addr, phys_addr_t max_addr,
>  			int nid)
>  {
> -	void *ptr;
> -
>  	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
>  		     __func__, (u64)size, (u64)align, nid, &min_addr,
>  		     &max_addr, (void *)_RET_IP_);

unassociated trivia:

casting _RET_IP_ back to void * seems odd as the define is
include/linux/kernel.h:#define _RET_IP_         (unsigned long)__builtin_return_address(0)

It's probably easier to understand as just __builtin_return_address(0)

> @@ -1528,18 +1522,12 @@ void * __init memblock_alloc_try_nid_raw(
>  			phys_addr_t min_addr, phys_addr_t max_addr,
>  			int nid)
>  {
> -	void *ptr;
> -
>  	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
>  		     __func__, (u64)size, (u64)align, nid, &min_addr,
>  		     &max_addr, (void *)_RET_IP_);

here too

