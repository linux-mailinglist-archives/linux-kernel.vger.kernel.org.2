Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1860E367E32
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhDVJ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:58:58 -0400
Received: from foss.arm.com ([217.140.110.172]:49274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhDVJ65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:58:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0593711D4;
        Thu, 22 Apr 2021 02:58:23 -0700 (PDT)
Received: from [10.163.75.119] (unknown [10.163.75.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39A503F774;
        Thu, 22 Apr 2021 02:58:19 -0700 (PDT)
Subject: Re: [RFC V2] mm: Enable generic pfn_valid() to handle early sections
 with memmap holes
To:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210422061902.21614-1-rppt@kernel.org>
 <1619077823-3819-1-git-send-email-anshuman.khandual@arm.com>
 <ce4f8045-2481-103f-f418-28cb43c7c7ff@redhat.com>
 <YIFFIiuy+z3WLHDi@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d82ee03f-71da-e0ab-def0-306236b00e8d@arm.com>
Date:   Thu, 22 Apr 2021 15:29:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YIFFIiuy+z3WLHDi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/21 3:12 PM, Mike Rapoport wrote:
> The "generic" pfn_valid() is only available with CONFIG_SPARSEMEM.
> With FLATMEM it's wild west:
> 
> $ git grep -w "define pfn_valid" arch/*/include/asm/ | wc -l
> 22
> 
> This would actually mean that we still need arm64::pfn_valid() for the
> FLATMEM case.

SPARSEMEM would be the only memory model going forward.

https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210420093559.23168-1-catalin.marinas@arm.com/ 
