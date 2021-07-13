Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522CC3C6E55
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhGMKZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235143AbhGMKZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:25:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A92FE611CB;
        Tue, 13 Jul 2021 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626171733;
        bh=S4DYoR9vB4H4k1IjW6dUgtFP/bjqo4vpc0Qfg9yYKco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFZNjRNL1kq3sX7/5bp5TZPoTN+tD1OvV04aki0pPrHpKKlOIv+oAfGTOfqZ0Fppa
         blAz6lnKF3FhfMbT+dSfeh9x0jCTkEvChlJfrvhNLa9oJQrGrFlfSnZ9NrHOIVYdRD
         q1PfMdb01UIZ0ZncIBns8zkRluEKBiRQYALj/fIDddDdvXbd2XAKw6fJoUJucEIcxO
         6xVMqsWHr643fRL8rXMVhbuYlF3LFoujvTp6ADa2LaY4s02C5jd+K06VeExaWv68RE
         nJ7S8IhQuzmQ7K0nvAp94YZRbtmT7lPkd+ym1ui8tEDgRsHNhE4qjFgDT+Ser2n80L
         KYfyyZVq1wdow==
Date:   Tue, 13 Jul 2021 13:22:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: remove pfn_valid_within() and
 CONFIG_HOLES_IN_ZONE
Message-ID: <YO1pT1bjMfldbQKg@kernel.org>
References: <20210713080035.7464-1-rppt@kernel.org>
 <20210713080035.7464-2-rppt@kernel.org>
 <7300dfe1-0c6a-ae2e-2c48-c885248ec263@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7300dfe1-0c6a-ae2e-2c48-c885248ec263@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 11:51:46AM +0200, David Hildenbrand wrote:
> On 13.07.21 10:00, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > After recent changes in freeing of the unused parts of the memory map and
> > rework of pfn_valid() in arm and arm64 there are no architectures that can
> > have holes in the memory map within a pageblock and so nothing can enable
> > CONFIG_HOLES_IN_ZONE which guards non trivial implementation of
> > pfn_valid_within().
> > 
> > With that, pfn_valid_within() is always hardwired to 1 and can be
> > completely removed.
> > 
> > Remove calls to pfn_valid_within() and CONFIG_HOLES_IN_ZONE.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> There is currently the discussion to increase MAX_ORDER, for example, to
> cover 1GiB instead of 4MiB on x86-64. This would mean that we could
> suddenly, again, have holes insides MAX_ORDER - 1 pages.
> 
> So I assume if we ever go down that path, we'll need something like this
> again.

It depends whether pageblock_order will be also increased. PFN walkers rely
on continuity of pageblocks rather than MAX_ORDER chunks, so if
pageblock_order won't change, there won't be need to check for pfn_valid()
inside a pageblock.
 
> For now, this looks like the right thing to do
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Sincerely yours,
Mike.
