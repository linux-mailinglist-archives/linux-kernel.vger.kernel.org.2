Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE242BF02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhJMLh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhJMLh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:37:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF65561027;
        Wed, 13 Oct 2021 11:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634124924;
        bh=Ew/eQo/93Bchex5IgKhMWzqA884BlihcmHekA2AuKz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPmjnkDSb5sEEV9uMRXqRJjVTS54T4sJ05ja57VRtyZIWHEKgub42Srx6oyMcYT1l
         PcWjzt8lTQDDy6ZJ5mTzNPT9AbPVz7zSGaA9DGYWHKk/7lBkLceOdG0b3XCAnfkoOG
         0aA4dIgsbxchHemPZpgxcxHY+8UgRo6w5uE+S+JfLG5lq1QLLeisNnD53bLshcYVGG
         PeG8C/LI8r4nrNSa8dFbxuJ3kKdfZ2nrI0RvcVuurF49uu8lckjDa2NU3vrmU7DVMm
         9sZMMn1UFT8+PxUUhEbxmItW3oDgFp2y9yfOwIhJZklvj4GhBeNWigGQhbk2j4Wo1N
         vIiNHwTnMx35g==
Date:   Wed, 13 Oct 2021 14:35:18 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: exclude NOMAP regions from kmemleak
Message-ID: <YWbEdklkUD3uIePa@kernel.org>
References: <20211013054756.12177-1-rppt@kernel.org>
 <YWaOpMhO6LoiiD+S@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWaOpMhO6LoiiD+S@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 08:45:40AM +0100, Catalin Marinas wrote:
> On Wed, Oct 13, 2021 at 08:47:56AM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Vladimir Zapolskiy reports:
> > 
> > commit a7259df76702 ("memblock: make memblock_find_in_range method private")
> > invokes a kernel panic while running kmemleak on OF platforms with nomaped
> > regions:
> > 
> >   Unable to handle kernel paging request at virtual address fff000021e00000
> >   [...]
> >     scan_block+0x64/0x170
> >     scan_gray_list+0xe8/0x17c
> >     kmemleak_scan+0x270/0x514
> >     kmemleak_write+0x34c/0x4ac
> > 
> > Indeed, NOMAP regions don't have linear map entries so an attempt to scan
> > these areas would fault.
> > 
> > Prevent such faults by excluding NOMAP regions from kmemleak.
> > 
> > Link: https://lore.kernel.org/all/8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org
> > Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

I'm going to take it via memblock tree if that's fine with everybody.

-- 
Sincerely yours,
Mike.
