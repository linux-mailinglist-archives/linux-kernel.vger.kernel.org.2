Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6E03923CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 02:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhE0AdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 20:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232903AbhE0AdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 20:33:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 993CC613B4;
        Thu, 27 May 2021 00:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622075502;
        bh=VElGUCrEdn4IEvlrz/77la9T537zZI/H+mQPAk6Ho7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tCZQFp45TvATQFhyf65Vg+kZ83gR68JXy9JrNNG4+13t348+QLndujSLgkJA/+wpn
         dGbvBHxKi3OBmVJLg7uzmBd66H5vOwF0IG8gdo9FrWTXT0gayR5ka1LuOxiICYKZzq
         d+ioj6kiemxaF0+q+3g8PWYz+LYGH14Roj6MKhKE=
Date:   Wed, 26 May 2021 17:31:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Arm64 crash while reading memory sysfs
Message-Id: <20210526173141.f1b511816fb33eab881e0c8f@linux-foundation.org>
In-Reply-To: <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
        <YK3tQ0a0S/CLxyyb@linux.ibm.com>
        <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
        <YK6EXNZHY1xt7Kjs@linux.ibm.com>
        <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 20:16:14 -0400 Qian Cai <quic_qiancai@quicinc.com> wrote:

> 
> 
> On 5/26/2021 1:24 PM, Mike Rapoport wrote:
> > On Wed, May 26, 2021 at 12:09:14PM +0000, Qian Cai (QUIC) wrote:
> >>>
> >>> On Tue, May 25, 2021 at 03:25:59PM +0000, Qian Cai (QUIC) wrote:
> >>>> Reverting the patchset "arm64: drop pfn_valid_within() and simplify pfn_valid()" [1] from today's linux-next fixed a crash while
> >>> reading files under /sys/devices/system/memory.
> > 
> > Does the issue persist of you only revert the latest patch in the series?
> > In next-20210525 it would be commit 
> > 89fb47db72f2 ("arm64-drop-pfn_valid_within-and-simplify-pfn_valid-fix")
> > and commit
> > dfe215e9bac2 ("arm64: drop pfn_valid_within() and simplify pfn_valid()").
> 
> Reverting those two commits alone is enough to fix the issue.

(cc Stephen)

Thanks, I'll drop

arm64-drop-pfn_valid_within-and-simplify-pfn_valid.patch
arm64-drop-pfn_valid_within-and-simplify-pfn_valid-fix.patch

