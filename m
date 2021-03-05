Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153E832DF1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 02:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhCEBbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 20:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhCEBbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 20:31:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9966D6500D;
        Fri,  5 Mar 2021 01:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614907894;
        bh=TVVHEOGdTssyL6W7mFsjyWsrBlLds9RsYXTrSkzq1MQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lFKVIahp6sdscK6IX/YgKYxBNui1HmTR6eJLBDBGaUV9QxAvi0H+gUeQ0SQSSqlWa
         u4R7Y3LdaXzTNkdArTyMO9+RJOXkypXQCA/S4Kp+kWT19YDSEe/7elMyaIOQA0TbfM
         d+EbARdgXmccivmLoVT8aV8GVikR+4mWaV1l5AjY=
Date:   Thu, 4 Mar 2021 17:31:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH mm] kfence, slab: fix cache_alloc_debugcheck_after() for
 bulk allocations
Message-Id: <20210304173132.6696eb2a357edf835a5033ee@linux-foundation.org>
In-Reply-To: <CAG_fn=XVAFjgkFCj8kc6Bz4rvBwCeE4HUcJPBTWQcNjrBLaT=g@mail.gmail.com>
References: <20210304205256.2162309-1-elver@google.com>
        <CAG_fn=XVAFjgkFCj8kc6Bz4rvBwCeE4HUcJPBTWQcNjrBLaT=g@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 22:05:48 +0100 Alexander Potapenko <glider@google.com> wrote:

> On Thu, Mar 4, 2021 at 9:53 PM Marco Elver <elver@google.com> wrote:
> >
> > cache_alloc_debugcheck_after() performs checks on an object, including
> > adjusting the returned pointer. None of this should apply to KFENCE
> > objects. While for non-bulk allocations, the checks are skipped when we
> > allocate via KFENCE, for bulk allocations cache_alloc_debugcheck_after()
> > is called via cache_alloc_debugcheck_after_bulk().
> 
> @Andrew, is this code used by anyone?
> As far as I understand, it cannot be enabled by any config option, so
> nobody really tests it.
> If it is still needed, shall we promote #if DEBUGs in slab.c to a
> separate config option, or maybe this code can be safely removed?

It's all used:

#ifdef CONFIG_DEBUG_SLAB
#define	DEBUG		1
#define	STATS		1
#define	FORCED_DEBUG	1
#else
#define	DEBUG		0
#define	STATS		0
#define	FORCED_DEBUG	0
#endif

