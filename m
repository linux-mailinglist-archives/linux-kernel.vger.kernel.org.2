Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8369D357BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhDHFS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:18:26 -0400
Received: from foss.arm.com ([217.140.110.172]:39490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhDHFS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:18:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B43C1424;
        Wed,  7 Apr 2021 22:18:15 -0700 (PDT)
Received: from [10.163.67.84] (unknown [10.163.67.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2EE3F73D;
        Wed,  7 Apr 2021 22:18:11 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC/RFT PATCH 0/3] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        James Morse <james.morse@arm.com>
References: <20210407172607.8812-1-rppt@kernel.org>
Message-ID: <2f68ea11-7c56-1c55-f0be-3aad7188c00a@arm.com>
Date:   Thu, 8 Apr 2021 10:49:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210407172607.8812-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding James here.

+ James Morse <james.morse@arm.com>

On 4/7/21 10:56 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially hardwire
> pfn_valid_within() to 1. 

That would be really great for arm64 platform as it will save CPU cycles on
many generic MM paths, given that our pfn_valid() has been expensive.

> 
> The idea is to mark NOMAP pages as reserved in the memory map and restore

Though I am not really sure, would that possibly be problematic for UEFI/EFI
use cases as it might have just treated them as normal struct pages till now.

> the intended semantics of pfn_valid() to designate availability of struct
> page for a pfn.

Right, that would be better as the current semantics is not ideal.

> 
> With this the core mm will be able to cope with the fact that it cannot use
> NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER blocks
> will be treated correctly even without the need for pfn_valid_within.
> 
> The patches are only boot tested on qemu-system-aarch64 so I'd really
> appreciate memory stress tests on real hardware.

Did some preliminary memory stress tests on a guest with portions of memory
marked as MEMBLOCK_NOMAP and did not find any obvious problem. But this might
require some testing on real UEFI environment with firmware using MEMBLOCK_NOMAP
memory to make sure that changing these struct pages to PageReserved() is safe.


> 
> If this actually works we'll be one step closer to drop custom pfn_valid()
> on arm64 altogether.

Right, planning to rework and respin the RFC originally sent last month.

https://patchwork.kernel.org/project/linux-mm/patch/1615174073-10520-1-git-send-email-anshuman.khandual@arm.com/
