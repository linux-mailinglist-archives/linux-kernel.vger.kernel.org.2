Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A0432E1A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 06:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCEFhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 00:37:46 -0500
Received: from foss.arm.com ([217.140.110.172]:48094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEFhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 00:37:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFDB531B;
        Thu,  4 Mar 2021 21:37:44 -0800 (PST)
Received: from [10.163.68.69] (unknown [10.163.68.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43E1B3F73B;
        Thu,  4 Mar 2021 21:37:39 -0800 (PST)
Subject: Re: [PATCH V3 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Veronika Kabatova <vkabatov@redhat.com>
References: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d7470949-0d9d-0863-f5d1-9391134a5e5e@arm.com>
Date:   Fri, 5 Mar 2021 11:08:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/5/21 10:54 AM, Anshuman Khandual wrote:
> This series fixes pfn_valid() for ZONE_DEVICE based memory and also improves
> its performance for normal hotplug memory. While here, it also reorganizes
> pfn_valid() on CONFIG_SPARSEMEM. This series is based on v5.12-rc1.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Veronika Kabatova <vkabatov@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Changes in V3:
> 
> - Validate the pfn before fetching mem_section with __pfn_to_section() in [PATCH 2/2]

Hello Veronica,

Could you please help recreate the earlier failure [1] but with this
series applies on v5.12-rc1. Thank you.

[1] https://lore.kernel.org/linux-arm-kernel/cki.8D1CB60FEC.K6NJMEFQPV@redhat.com/

- Anshuman
