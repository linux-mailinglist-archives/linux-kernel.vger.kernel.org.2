Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE73E982E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhHKTBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231350AbhHKTBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:01:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7292E6105A;
        Wed, 11 Aug 2021 19:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628708487;
        bh=m9TeT/3Nd18chDNafC9ANZmnNV4sJc+ahNObhasQTPk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QBaZL2cZuYfjROADUeXkULhwxf64s73vOFLrYymG/psmdKrMoXjYDHDEmePv590bF
         IVvrRH6Htrh+OmRTd1Iv0sBWHCrvFYrExdJibMFkaC6wImWqZHc9RLBRdLSGz686il
         5x6iqjckarrUAJCOn6JblgdRpHlBlwVDFyra4nQvgpj0TQmm5Ai0S+oY/bvv86GTV+
         Ky/EBnrSo7k6hKlOMM/JMZZi1KkcY+9BvfKl2yZD4IbkGvzBXzf2AqTh01jGfMVVAI
         Qp96pVknD/jTeXDhdBpj0SmVxxQY5V+Ie28Vy/PkfS4a0AWqD+UXz9RYXUfnUZT1mT
         xayhdmktl1S3g==
Subject: Re: [PATCH 06/18] ARC: mm: Enable STRICT_MM_TYPECHECKS
To:     Mike Rapoport <rppt@kernel.org>, Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-7-vgupta@kernel.org> <YRO8xUlAtMeJnDbe@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <ecbba2ab-6d05-cbbf-9545-01a62c722e5c@kernel.org>
Date:   Wed, 11 Aug 2021 12:01:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRO8xUlAtMeJnDbe@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 5:04 AM, Mike Rapoport wrote:
> On Tue, Aug 10, 2021 at 05:42:46PM -0700, Vineet Gupta wrote:
>> In the past I've refrained from doing this (atleast 2 times) due to the
>                                              ^ at least
>
>> slight code bloat due to ABI implications of pte_t etc becoming sttuct
>                                                                   ^ struct
>> Per ARC ABI, functions return struct via memory and not through register
>> r0, even if the struct would fits in register(s)
>                                ^ fit

Fixed.

>>   - caller allocates space on stack and passes the address as first arg
>>     (r0), shifting rest of args by one
>>
>>   - callee creates return struct in memory (referenced via r0)
>>
>> This time around the code actually shrunk slightly (due to subtle
>> inlining heuristic effects), but still slightly inefficient due to
>> return values passed through memory. That however seems like a small
> Out of curiosity, is this actually measurable on real world applications?

Not really, but they look hideous to an objdump hunkie like me (who 
treats waste of electrons like wasting food) and wondering what piece of 
art your compiler is spitting out ;-) only to realize that is source 
code induced.
