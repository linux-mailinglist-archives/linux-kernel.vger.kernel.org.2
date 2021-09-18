Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FDF41052D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 10:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhIRIir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 04:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhIRIiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 04:38:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CFF061244;
        Sat, 18 Sep 2021 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631954242;
        bh=5rf6GNCOG0zu4pGRCwF+YbXBBU6EolzS6vCH7c+IvKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yxwy2HNMi9dHgQj9qCv86MXaNJJQWiUl6Ksd+njViNwepR7JvlYUW8CuXfggEoyh1
         1kjY23zZPcRybB1El/UDq0QsV7kCY4jWKNWZjepFw+IZ88p2Jsk6rsbJ7zuYHhNCwG
         3Tjn+d5c2zpVrD7ebKQ/1M8Bog6vuuATN1lzFh9U/yIjtxbtAPKtASHMjiO3YQ7bNC
         Ozj+nv19D8498bWxx85KY23BA62zLoM6nwgUujOiQCP/852Y5mTI3M1QCogtYlPkWP
         DUJOdp0voj9dTCR4xtk1S/KJ8rLJgQvCx//iI4e2CNUJlrLcWU9prfnhsNnzTLFGLw
         HpsMCtbBGCEag==
Date:   Sat, 18 Sep 2021 11:37:15 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <YUWlO2tZC5IwCAHV@kernel.org>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
 <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
 <YUUHJ5EI+6Mop4Wu@kernel.org>
 <20210918051843.GA16104@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918051843.GA16104@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 07:18:43AM +0200, Christoph Hellwig wrote:
> On Sat, Sep 18, 2021 at 12:22:47AM +0300, Mike Rapoport wrote:
> > I did some digging and it seems that the most "generic" way to check if a
> > page is in RAM is page_is_ram(). It's not 100% bullet proof as it'll give
> > false negatives for architectures that do not register "System RAM", but
> > those are not using dma_map_resource() anyway and, apparently, never would.
> 
> The downside of page_is_ram is that it looks really expensiv for
> something done at dma mapping time.

Indeed :(
But pfn_valid is plain wrong...
I'll keep digging.

-- 
Sincerely yours,
Mike.
