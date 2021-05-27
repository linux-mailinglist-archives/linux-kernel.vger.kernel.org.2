Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C2D3938D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 00:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhE0W6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 18:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233203AbhE0W6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 18:58:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 017166135C;
        Thu, 27 May 2021 22:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622156205;
        bh=ZVPbH5HQA5QJ3IYjGRfYN9DLXdb7eKyi5B1fvwZKHCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qnYWqjPDdyZAlY7nCZx/PAyGK2OTuEaicJBV84zkM5rbnOPiaudihJrvRqGue8pxb
         672OCCfUVuubWYdRZEMw+CMYUiMuhcPCY0b95aJTHoxGO95d7fOnIXcCmLz3jHaEQR
         3bvygjhz7SeiiUGLt8zH8q6A1kWvDhp7pwsxvlBs=
Date:   Thu, 27 May 2021 15:56:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Arm64 crash while reading memory sysfs
Message-Id: <20210527155644.7792b4eaa16ec56645e1080c@linux-foundation.org>
In-Reply-To: <20210527175047.GK8661@arm.com>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
        <YK3tQ0a0S/CLxyyb@linux.ibm.com>
        <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
        <YK6EXNZHY1xt7Kjs@linux.ibm.com>
        <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
        <YK9e0LgDOfCFo6TM@linux.ibm.com>
        <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
        <YK/HKMgajBCwpLt8@linux.ibm.com>
        <20210527175047.GK8661@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 18:50:48 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> > Can you please try Anshuman's patch "arm64/mm: Drop HAVE_ARCH_PFN_VALID":
> > 
> > https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
> > 
> > It seems to me that the check for memblock_is_memory() in
> > arm64::pfn_valid() is what makes init_unavailable_range() to bail out for
> > section parts that are not actually populated and then we have
> > VM_BUG_ON_PAGE(PagePoisoned(p)) for these pages.
> 
> I acked Anshuman's patch, I think they all need to go in together.

That's neat.   Specifically which patches are we referring to here?
