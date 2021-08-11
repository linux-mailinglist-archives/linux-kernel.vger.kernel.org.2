Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F73E97E3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhHKSqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhHKSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:46:52 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED845C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:46:28 -0700 (PDT)
Subject: Re: [PATCH 03/18] ARC: mm: move mmu/cache externs out to setup.h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1628707586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SK25dEcn466Z3Vi0DqLxIySdCp5Mv9jbvw0c3iJwG8U=;
        b=ErI1vkw1xnLMlIRzSuseZUPuXhb4a1szsgUdHWTiWa11I+f0/0hXcmuO8ezyEZFEr+Ug/B
        LQ2mc53++4EVYazWQ9RdU9yCcvWmN1NnHGek2T0hMrH8lGTiC1axkwon0TTjv6uR6jvYNA
        TgKsIEgUiph6Nmrwms/LjP5RJ6KlDkc=
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Vineet Gupta <vgupta@kernel.com>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-4-vgupta@kernel.org> <YRNb0EbPzejXJdax@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vineet Gupta <vineet.gupta@linux.dev>
Message-ID: <fe3a8a38-69ef-ff4b-6e63-b110ffc188e7@linux.dev>
Date:   Wed, 11 Aug 2021 11:46:21 -0700
MIME-Version: 1.0
In-Reply-To: <YRNb0EbPzejXJdax@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: vineet.gupta@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 8/10/21 10:10 PM, Mike Rapoport wrote:
> Hi Vineet,
>
> On Tue, Aug 10, 2021 at 05:42:43PM -0700, Vineet Gupta wrote:
>> Signed-off-by: Vineet Gupta <vgupta@kernel.com>
> Hmm, this one seems odd. Try https://www.kernel.com/ ;-)

Oops, last minute switch to my kernel.org address - this update was not 
atomic ;-)

>> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
>> ---
>>   arch/arc/include/asm/cache.h |  4 ----
>>   arch/arc/include/asm/mmu.h   |  4 ----
>>   arch/arc/include/asm/setup.h | 12 ++++++++++--
> A sentence about why these move would have been nice.

Sure
---->
"Don't pollute mmu.h and cache.h with some of ARC internal bootlog/setup 
related functions.
move them aside to setup.h"

Thx for taking the time to review !

-Vineet
