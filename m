Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630473AA36F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhFPSrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhFPSrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:47:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FF50613EF;
        Wed, 16 Jun 2021 18:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623869145;
        bh=cGUCVYHomHwqNgu6aUOX7H52KAGhAXiilh/Q/DUf0fM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Nn2kI+GV0anZTeOFWqbRiCO2sMskw9+VzvHl2Ld/a92jKx9LcsBZVS/Ug3ZBy/BBQ
         KOJvjbD8pMnDelhQRWr0FfkF+XXmNJAubFJhpE+QUlUjG59prJ6oJ5JRVE7dE/4K1p
         HsBxB6uVHVE/MPh6aZ0d2DSGxPiLe8lf5R2hhxpq7VadUQTDPilKxg2unVn/NI0BlG
         OQqXVHlspHAvO7QtYecgk43UHoDoFPPxVVem+dk8lQfqB4cGlVt3xXAeJeqv99PcTQ
         kdUSToNm2S/ISvtwKvUde6ANF2jgYWZkCGFP+PDy+1+8xzRjxmXfGVqms3WOwLEf/N
         CaeTIh64/frOA==
Subject: Re: [PATCH 5/8] membarrier, kthread: Use _ONCE accessors for task->mm
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     x86 <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1623813516.git.luto@kernel.org>
 <74ace142f48db7d0e71b05b5ace72bfe8e0a2652.1623813516.git.luto@kernel.org>
 <987970694.9105.1623866911729.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <7e411333-2fbc-6254-671f-bf2cba486bcd@kernel.org>
Date:   Wed, 16 Jun 2021 11:45:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <987970694.9105.1623866911729.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 11:08 AM, Mathieu Desnoyers wrote:
> ----- On Jun 15, 2021, at 11:21 PM, Andy Lutomirski luto@kernel.org wrote:
> 
>> membarrier reads cpu_rq(remote cpu)->curr->mm without locking.  Use
>> READ_ONCE() and WRITE_ONCE() to remove the data races.
> 
> I notice that kernel/exit.c:exit_mm() also has:
> 
>         current->mm = NULL;
> 
> I suspect you may want to add a WRITE_ONCE() there as well ?

Good catch.  I was thinking that exit_mm() couldn't execute concurrently
with membarrier(), but that's wrong.

--Andy
