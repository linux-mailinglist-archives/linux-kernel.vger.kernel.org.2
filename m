Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638CC3EAA81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhHLS6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 14:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234882AbhHLS63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:58:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 236EC61077;
        Thu, 12 Aug 2021 18:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628794684;
        bh=qInDITMHlKZExB3w3owcOP9e470UVRLbvU7avF4jbl8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O8jhfdOWyyaLym8+6X2BZWzwaLe2fLqCOanrK2udvM8aquWfSiWF1pjewgQzxDAPL
         vQismJEz4AhBVaavdyc5nXhmSUoeJfpekbERnI61osLXV8kY4L9ym+/mgI5b7/jkuJ
         2KlU82IYMPi4qgxp8llZFr6q9/qFdcnKKh09kwBSd2V1RhICi+JJjRjBq+bKH2o+DG
         YRlMFtLaQgn3zV+0Y1oV+DbP32ss8RBc4BGYfyaNkDs0WeyBP0bm7KP6eU3vrByPCh
         eOEhufPXNMcVr6FWJgSU4yrw/LI0TiX3IUHAMubZ3cnQTn6m20bZGDZhhdrk9aTApN
         aUW9tGPMQ+Gdg==
Subject: Re: [PATCH 09/18] ARC: mm: non-functional code cleanup ahead of 3
 levels
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-10-vgupta@kernel.org> <YRPDL90Qr5RLDmnT@kernel.org>
 <7d022d55-c70b-b3ac-4f0b-1faa26c0d4bd@kernel.org>
 <YRS9OvkgaQxOfkkg@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <f77ac5df-c92c-321a-7624-35520b386f6f@kernel.org>
Date:   Thu, 12 Aug 2021 11:58:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRS9OvkgaQxOfkkg@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 11:18 PM, Mike Rapoport wrote:
> On Wed, Aug 11, 2021 at 06:37:19PM -0700, Vineet Gupta wrote:
>> On 8/11/21 5:31 AM, Mike Rapoport wrote:
>>>> +/*
>>>> + * For ARC, pgtable_t is not struct page *, but pte_t * (to avoid
>>>> + * extraneous page_address() calculations) hence can't use
>>>> + * use asm-generic/pgalloc.h which assumes it being struct page *
>>>> + */
>>> Another reason to leave ARC without asm-generic/pgalloc.h was
>>> __get_order_pte() that other arches don't have.
>>> So this and pgtable_t aliased to pte_t * seemed to me too much to bother
>>> then, but probably it's worth reconsidering with addition of 3rd and 4th
>>> levels.
>> I agree that savings of not havign page_address() might not be huge. However
>> asm-generic/pgalloc.h only has pte allocation routines and all other
>> allocation levels come from arch file
> asm-generic/pgalloc.h has allocation routines up to PUD.
> There is also pgtable_pmd_page_ctor() and pgtable_pmd_page_dtor() called in
> the generic versions of PMD allocation, it seems they are not called in ARC
> implementation.

:-(

> So using asm-generic/pgalloc.h would probably save you some THP debugging ;-)
>
> We may even probably accommodate multi-page PTEs in asm-generic/pgalloc.h
> with something like
>
> #ifndef __HAVE_ARCH_PTE_GET_ORDER
> static inline int __pte_get_order(void)
> {
> 	return 0;
> }
> #endif

Not needed - those cases are unreal, esoteric at best. I'm working on 
switching back to canonical struct page based pgtable_t, will do that in v2.

>> Also for ARCv2, given the arbitrary address split and ensuing paging levels
>> (as well as support for different page sizes) we will need to make sure that
>> one page is enough to hold any level's paging using say BUILD_BUG_ON. In
>> fact that should also be done for 3rd and 4th levels for sanity.
> Right, these sanity checks would be useful, but they may live in one of .c
> files in arch/arc/mm.

Sure !

Thx,
-Vineet
