Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277E43EDDFF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhHPTpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhHPTpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:45:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54AF560EE5;
        Mon, 16 Aug 2021 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629143104;
        bh=3vUrvHO/jx7yMiBOS4Ce94K+3n61pUF9j/jGzg2zV9I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VGOxvHxh1BCCnbf10ZKR6ppPnPP765JjvB4BCCBoKklLLLuZa3JvHqCkjV5C0mfbz
         0TLHlEK9WW+FCeV/V9otKetcGSk4DbaunraYixObvbL92zaNQalSVjHsUSup7acKwc
         3+z43KH44NP+WMgic/J3eF6BUPxXW2HQGh9gE83xkkdtXAaHhjD5suq5r0M6HKvL+f
         Y6sH5LLpPBNZJw130ooco3Ma3yVmGKegEtbOc5i3LinMUZyQ4bUfjt7EIyikrTkxWg
         qVNT/y/p7/0rmID/2u5nO10Nn42FPaZwtHsVEVtPvtmuJWxhXb7eBx7slrLwcDd1+y
         4sgwUgRK+UyJA==
Subject: Re: [PATCH v2 01/19] ARC: mm: use SCRATCH_DATA0 register for caching
 pgdir in ARCv2 only
To:     Mike Rapoport <rppt@kernel.org>, Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210812233753.104217-1-vgupta@kernel.org>
 <20210812233753.104217-2-vgupta@kernel.org> <YRjd5N012YInbZqX@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <e524546f-92e3-38b9-c72f-ac8ac0c013c9@kernel.org>
Date:   Mon, 16 Aug 2021 12:45:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRjd5N012YInbZqX@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/21 2:27 AM, Mike Rapoport wrote:
> On Thu, Aug 12, 2021 at 04:37:35PM -0700, Vineet Gupta wrote:
>> MMU SCRATCH_DATA0 register is intended to cache task pgd. However in
>> ARC700 SMP port, it has to be repurposed for reentrant interrupt
>> handling, while UP port doesn't. We  currently ahandle boe usecases
> 					       ^ handle both
>
> maybe ':set spell' for changelog editing? ;-)

Seriously, about time I stopped fat-fingering
