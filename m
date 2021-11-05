Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922E744602C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhKEHic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhKEHi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:38:29 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F94CC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 00:35:50 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1A09A3FF; Fri,  5 Nov 2021 08:35:47 +0100 (CET)
Date:   Fri, 5 Nov 2021 08:35:40 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [git pull] IOMMU Updates for Linux v5.16
Message-ID: <YYTezKfKDCTiDcij@8bytes.org>
References: <YYPrNkweZahTdAbA@8bytes.org>
 <CAHk-=whX_ygSHr02mhWXO38kddFE_t7ntBHf_sehz=asFfzFKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whX_ygSHr02mhWXO38kddFE_t7ntBHf_sehz=asFfzFKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 11:10:53AM -0700, Linus Torvalds wrote:
> That too seems to be stale and unused since commit 9bfecd058339
> ("x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove
> update_pasid()")
> 
> I left it alone because I didn't want to do any extra development in
> the merge commit itself, but it looks to me like there's some room for
> more cleanips. No?

Yes, looks like this define is unused now. I talk to Baolu whether this
can be cleaned up too, Baolu?

Thanks,

	Joerg
