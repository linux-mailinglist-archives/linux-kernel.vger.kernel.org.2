Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5543061C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhA0RT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:19:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235671AbhA0RR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:17:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3543864D99;
        Wed, 27 Jan 2021 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611767772;
        bh=QEn3AwN++ibSZJbYsfjHXLopDcjytE0gWYxS4s3GF0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxjRVJoX2E1b3ub3NeXROX65hjFV/n3ruiDX3Jg2rFspZSMEQYHzkQ+DhSocI9MFy
         V8Lz947ClecGI7JzSVvBD/apXNXAhwDvaLSvB2bcZCdqBFnXa8fT/mkjSts7uCMtyB
         gqZfF4y8iSF+TZHdXCMMdKG3qBmTEQVqKIY6e9eIGl3/X6fQSg0G6uWAC1c0GNEoWB
         aubrx1wrsptYu8LS0SrOkAvUpdzrOjM3QNohwquR8iCEJ9osuK8FLOSD39IJ7igtle
         BDYb9/BUm/2uZaTUzqkUE/xOApbDCFLdUpxLTFQhwy4h7JWwNFCXuWfFv6+guQPdNX
         CDEkII+uEdF1w==
Date:   Wed, 27 Jan 2021 17:16:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 0/8] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
Message-ID: <20210127171605.GD358@willie-the-truck>
References: <20210120173612.20913-1-will@kernel.org>
 <20210126230851.GE30941@willie-the-truck>
 <alpine.LSU.2.11.2101261522260.2650@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2101261522260.2650@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 03:28:22PM -0800, Hugh Dickins wrote:
> On Tue, 26 Jan 2021, Will Deacon wrote:
> > On Wed, Jan 20, 2021 at 05:36:04PM +0000, Will Deacon wrote:
> > > Hi all,
> > > 
> > > This is version four of the patches I previously posted here:
> > > 
> > >   v1: https://lore.kernel.org/r/20201209163950.8494-1-will@kernel.org
> > >   v2: https://lore.kernel.org/r/20210108171517.5290-1-will@kernel.org
> > >   v3: https://lore.kernel.org/r/20210114175934.13070-1-will@kernel.org
> > > 
> > > The patches allow architectures to opt-in at runtime for faultaround
> > > mappings to be created as 'old' instead of 'young'. Although there have
> > > been previous attempts at this, they failed either because the decision
> > > was deferred to userspace [1] or because it was done unconditionally and
> > > shown to regress benchmarks for particular architectures [2].
> > > 
> > > The big change since v3 is that the immutable fields of 'struct vm_fault'
> > > now live in a 'const' anonymous struct. Although Clang will silently
> > > accept modifications to these fields [3], GCC emits an error. The
> > > resulting diffstat is _considerably_ more manageable with this approach.
> > 
> > The only changes I have pending against this series are cosmetic (commit
> > logs). Can I go ahead and queue this in the arm64 tree so that it can sit
> > in linux-next for a bit? (positive or negative feedback appreciated!).
> 
> That would be fine by me: I ran v3 on rc3, then the nicer smaller v4
> on rc4, and saw no problems when running either of them (x86_64 only).

Thanks, Hugh. I'll stick these into -next later today and we'll see how we
get on.

Will
