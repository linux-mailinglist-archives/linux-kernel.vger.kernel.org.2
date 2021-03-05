Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80F932F265
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhCESXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:23:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhCESWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:22:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A50CC650A3;
        Fri,  5 Mar 2021 18:22:50 +0000 (UTC)
Date:   Fri, 5 Mar 2021 18:22:48 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH V3 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
Message-ID: <20210305182247.GJ23855@arm.com>
References: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com>
 <d7470949-0d9d-0863-f5d1-9391134a5e5e@arm.com>
 <2001895867.30197818.1614947320141.JavaMail.zimbra@redhat.com>
 <1890909388.30244858.1614968188922.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1890909388.30244858.1614968188922.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 01:16:28PM -0500, Veronika Kabatova wrote:
> > > On 3/5/21 10:54 AM, Anshuman Khandual wrote:
> > > > This series fixes pfn_valid() for ZONE_DEVICE based memory and
> > > > also improves its performance for normal hotplug memory. While
> > > > here, it also reorganizes pfn_valid() on CONFIG_SPARSEMEM. This
> > > > series is based on v5.12-rc1.
[...]
> > > Could you please help recreate the earlier failure [1] but with this
> > > series applies on v5.12-rc1. Thank you.
> > 
> > the machine in question is currently loaned to a developer. I'll reach
> > out to them and will let you know once I have any results.
> 
> I'm happy to report the kernel boots with these new patches. I used the
> 5.12.0-rc1 kernel (commit 280d542f6ffac0) as a base. The full console log
> from the boot process is available at
> 
> https://gitlab.com/-/snippets/2086833

That's great Veronika. Thanks for confirming.

-- 
Catalin
