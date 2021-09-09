Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D236404803
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhIIJtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:49:51 -0400
Received: from 8bytes.org ([81.169.241.247]:53256 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231793AbhIIJtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:49:47 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E116560F; Thu,  9 Sep 2021 11:48:34 +0200 (CEST)
Date:   Thu, 9 Sep 2021 11:48:17 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu: Clarify default domain Kconfig
Message-ID: <YTnYYd+DWwpKAfEf@8bytes.org>
References: <69a0c6f17b000b54b8333ee42b3124c1d5a869e2.1631105737.git.robin.murphy@arm.com>
 <CAHk-=whm5tP-JDnZ=LCr2ZpnPaAZakZyN=wD_tY7pydQJRtJXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whm5tP-JDnZ=LCr2ZpnPaAZakZyN=wD_tY7pydQJRtJXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 09:47:03AM -0700, Linus Torvalds wrote:
> I'm assuming I'll get it through the iommu tree eventually (no need to
> expedite this)

Yes, I just applied it along with a couple of other fixes to the iommu
tree and will send a pull-request tomorrow.

Thanks,

	Joerg
