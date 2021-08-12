Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226ED3E9BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhHLBhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233345AbhHLBhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:37:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D748560EE5;
        Thu, 12 Aug 2021 01:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628732242;
        bh=3yliXKYml5z2kI731mSBDWtqWccUdEBlEAHRlw7CWUE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XSP8c6dj01Dk9xwmmCsAnKzMr571Sw7AQT6DrDOZ10jM+pq7m+CbeVj11JDdHOQ2C
         VFgaP3oaWAa2+t7CW4ieuADIZLAIQtsWckJFx+PTLLi+BffLv5xS3ZFvcDBTnyxct4
         u/bUfqsNxdvVo6/YmLqhl1r5jrt9rZ1SrIg6BqgQD8EIQikxB6H3tG1Xg7dJf4vQXg
         oNsbfhIrYyYrTgAxI3zz2v1gni2bwmvWWr9QOBHAwo5rUdAotCas1aRMWCjXm+xxVD
         rUGcoXSY3mPJWYU6xYuufe8XfNGS1jcy0Rhi4S6zJKGLNEONxZFU2O/x/eaLOEhEov
         EcT6M9P/HJgbQ==
Subject: Re: [PATCH 09/18] ARC: mm: non-functional code cleanup ahead of 3
 levels
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-10-vgupta@kernel.org> <YRPDL90Qr5RLDmnT@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <7d022d55-c70b-b3ac-4f0b-1faa26c0d4bd@kernel.org>
Date:   Wed, 11 Aug 2021 18:37:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRPDL90Qr5RLDmnT@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 5:31 AM, Mike Rapoport wrote:
>> +/*
>> + * For ARC, pgtable_t is not struct page *, but pte_t * (to avoid
>> + * extraneous page_address() calculations) hence can't use
>> + * use asm-generic/pgalloc.h which assumes it being struct page *
>> + */
> Another reason to leave ARC without asm-generic/pgalloc.h was
> __get_order_pte() that other arches don't have.
> So this and pgtable_t aliased to pte_t * seemed to me too much to bother
> then, but probably it's worth reconsidering with addition of 3rd and 4th
> levels.

I agree that savings of not havign page_address() might not be huge. 
However asm-generic/pgalloc.h only has pte allocation routines and all 
other allocation levels come from arch file

Also for ARCv2, given the arbitrary address split and ensuing paging 
levels (as well as support for different page sizes) we will need to 
make sure that one page is enough to hold any level's paging using say 
BUILD_BUG_ON. In fact that should also be done for 3rd and 4th levels 
for sanity.

-Vineet


