Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754923F3215
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhHTRPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:15:33 -0400
Received: from ms.lwn.net ([45.79.88.28]:36302 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhHTRPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:15:31 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1720A5ED5;
        Fri, 20 Aug 2021 17:14:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1720A5ED5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1629479693; bh=LEEzvaGgi9neocvERnESXJLRXIyANpPsPlpoWwhgMzg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=l71Ggs9Xm0sZMxMd3et6JCRyidOzNNhwyjPjeSM+65Hf5x9tfwSwTYnd7PxjDNhi3
         ZvqmSDepF5opOUfHAxWh7zF7ey1FJ4lTS4BN++jmPeT1RelgWEk8S58TIIrUGfmuF5
         4XVBeHrO2+Tfx8GTXvwnGNF4CH6xYZ8iil7BoeaHMu82gGG+F9MNqmaB+A1Hd4SE4c
         ItSI9ihWE/W+f5rjJbAj2rJKkAHbiSd2T9tyZfpiIqtSgYBBd6SDoNrjZzucxEn0fX
         NtQTJH7KO2phgHvr2T9EYNoaMNj0GTaYcSYJ5BNL3g75yZbbnesb1pHWYHnlH4TUSi
         H7zKkHpW1s+kA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joerg Roedel <jroedel@suse.de>, Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Peilin Ye <peilin.ye@bytedance.com>
Subject: Re: [PATCH RESEND v2] docs: x86: Remove obsolete information about
 x86_64 vmalloc() faulting
In-Reply-To: <YR4PNjIM3W5zkPnt@suse.de>
References: <20210818220123.2623-1-yepeilin.cs@gmail.com>
 <YR4PNjIM3W5zkPnt@suse.de>
Date:   Fri, 20 Aug 2021 11:14:52 -0600
Message-ID: <87bl5srqb7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Roedel <jroedel@suse.de> writes:

> On Wed, Aug 18, 2021 at 03:01:23PM -0700, Peilin Ye wrote:
>> From: Peilin Ye <peilin.ye@bytedance.com>
>> 
>> x86_64 vmalloc() mappings are no longer "synchronized" among page tables
>> via faulting since commit 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD
>> pages for vmalloc area"), since the corresponding P4D or PUD pages are
>> now preallocated at boot, by preallocate_vmalloc_pages().  Drop the
>> "lazily synchronized" description for less confusion.
>> 
>> While this file is x86_64-specific, it is worth noting that things are
>> different for x86_32, where vmalloc()-related changes to `init_mm.pgd` are
>> synchronized to all page tables in the system during runtime, via
>> arch_sync_kernel_mappings().  Unfortunately, this synchronization is
>> subject to race condition, which is further handled via faulting, see
>> vmalloc_fault().  See commit 4819e15f740e ("x86/mm/32: Bring back vmalloc
>> faulting on x86_32") for more details.
>> 
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
>
> Reviewed-by: Joerg Roedel <jroedel@suse.de>

Applied, thanks.

jon
