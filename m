Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685B139187D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhEZNGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231189AbhEZNGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:06:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BBA0611CD;
        Wed, 26 May 2021 13:04:28 +0000 (UTC)
Date:   Wed, 26 May 2021 14:04:26 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Arm64 crash while reading memory sysfs
Message-ID: <20210526130426.GD19992@arm.com>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
 <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 12:09:14PM +0000, Qian Cai (QUIC) wrote:
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000090000000-0x0000000091ffffff]

Maybe de-selecting HOLES_IN_ZONE is not correct for arm64 in all
circumstances. In a configuration with 64K pages, MAX_ORDER is 14,
MAX_ORDER_NR_PAGES is 8192, so a 2^29 address range. However, the above
range starts on 2^28 boundary.

SECTION_SIZE_BITS is 29 in this configuration but the corresponding
mem_map[] in the first half of the first section is probably not marked
as reserved as we'd do for NOMAP.

-- 
Catalin
