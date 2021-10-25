Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92DD4390B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhJYIBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:01:19 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:34498 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhJYIBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:01:17 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id D5D1CB006C7; Mon, 25 Oct 2021 09:58:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C88E4B00100;
        Mon, 25 Oct 2021 09:58:54 +0200 (CEST)
Date:   Mon, 25 Oct 2021 09:58:54 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Taht <dave.taht@gmail.com>
Subject: Re: [RFC PATCH] mm, slob: Rewrite SLOB using segregated free list
In-Reply-To: <20211021114112.GA4004@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Message-ID: <alpine.DEB.2.22.394.2110250957040.2528@gentwo.de>
References: <20211020135535.517236-1-42.hyeyoo@gmail.com> <cf8ef7b4-ca18-064f-9c5d-01047e40446b@suse.cz> <20211021114112.GA4004@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021, Hyeonggon Yoo wrote:

> But on the contrary, I wonder when SLOB is useful than SLUB.
> is it for really tiny linux systems that has under 1M of RAM?
> But can linux be that small?

SLOB I think is mainly a nice intro into how slab allocators work. It is a
simple architecture and the code is to read and therefore easily
understood. I heard of some use cases from  others but I have only ever
been able to run a kernel boot in KVM with SLOB.
