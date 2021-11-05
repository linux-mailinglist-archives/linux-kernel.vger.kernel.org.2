Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD4644625B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhKEKwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhKEKwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:52:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 160CF610A8;
        Fri,  5 Nov 2021 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636109394;
        bh=flL52suMqN/frqIhABji+kP/KZLf7M9LOU0RKHo6DLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHIkVgQ6n5Zyxz0A4kkUqNx//vww03JEjx7BVRVBn8g1SzYXC5XpSbyPhTc/6CQp4
         7VvwqDdzpzd5lnQZuG1gkrjKQUw/axAdmhmkty0yFl7yf4j5fZ1+WDyQbYBQ+CR5iL
         uKM5GooAJ9Dk/qzcZ2aGLEpvAzSxszQO3tKsKlusWO6SZ9ay3dcZVq7BZ6YAxjKpBt
         Loq6f+itdJBPQRJ3z2TK7BwsVXHVaHayAVENKVzqG8b3o/UxRLB5xDvAuuRvJOlwQv
         OSBPYK6iOpIBiL9CWWeclndyZnEpXH7fodmG5ZzSqos+qgsxd46iR9l4dybgF4jTyU
         GRhROeEeCPH3g==
Date:   Fri, 5 Nov 2021 12:49:47 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Track no early_pgtable_alloc() for kmemleak
Message-ID: <YYUMSwqqW2MHKKuT@kernel.org>
References: <20211104155623.11158-1-quic_qiancai@quicinc.com>
 <YYQTKRrDIJbkcplr@kernel.org>
 <9bb6fe11-c10a-a373-9288-d44a5ba976fa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bb6fe11-c10a-a373-9288-d44a5ba976fa@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 01:57:03PM -0400, Qian Cai wrote:
> 
> 
> On 11/4/21 1:06 PM, Mike Rapoport wrote:
> > I think I'll be better to rename MEMBLOCK_ALLOC_KASAN to, say,
> > MEMBLOCK_ALLOC_NOKMEMLEAK and use that for both KASAN and page table cases.
> 
> Okay, that would look a bit nicer.
> 
> > But more generally, we are going to hit this again and again.
> > Couldn't we add a memblock allocation as a mean to get more memory to
> > kmemleak::mem_pool_alloc()?
> 
> For the last 5 years, this is the second time I am ware of this kind of
> issue just because of the 64KB->4KB switch on those servers, although I
> agree it could happen again in the future due to some new debugging
> features etc. I don't feel a strong need to rewrite it now though. Not
> sure if Catalin saw things differently. Anyway, Mike, do you agree that
> we could rewrite that separately in the future?

Yeah, the rework can definitely go on top. 

-- 
Sincerely yours,
Mike.
