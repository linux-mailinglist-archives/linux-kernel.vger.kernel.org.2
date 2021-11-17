Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44874542FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhKQIzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:55:00 -0500
Received: from foss.arm.com ([217.140.110.172]:53920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231591AbhKQIy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:54:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14582D6E;
        Wed, 17 Nov 2021 00:52:00 -0800 (PST)
Received: from [10.163.79.62] (unknown [10.163.79.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E70A43F5A1;
        Wed, 17 Nov 2021 00:51:52 -0800 (PST)
Subject: Re: [RFC 1/3] mm: ptep_clear() page table helper
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, pjt@google.com, weixugc@google.com,
        gthelen@google.com, mingo@redhat.com, corbet@lwn.net,
        will@kernel.org, rppt@kernel.org, keescook@chromium.org,
        tglx@linutronix.de, peterz@infradead.org, masahiroy@kernel.org,
        samitolvanen@google.com, dave.hansen@linux.intel.com,
        x86@kernel.org, frederic@kernel.org, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com
References: <20211116220038.116484-1-pasha.tatashin@soleen.com>
 <20211116220038.116484-2-pasha.tatashin@soleen.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e461ba08-0aa8-e405-6383-5d921443135a@arm.com>
Date:   Wed, 17 Nov 2021 14:21:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211116220038.116484-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 3:30 AM, Pasha Tatashin wrote:
> diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
> index 552567d863b8..fbe06ec75370 100644
> --- a/Documentation/vm/arch_pgtable_helpers.rst
> +++ b/Documentation/vm/arch_pgtable_helpers.rst
> @@ -66,9 +66,11 @@ PTE Page Table Helpers
>  +---------------------------+--------------------------------------------------+
>  | pte_mknotpresent          | Invalidates a mapped PTE                         |
>  +---------------------------+--------------------------------------------------+
> -| ptep_get_and_clear        | Clears a PTE                                     |
> +| ptep_clear                | Clears a PTE                                     |
>  +---------------------------+--------------------------------------------------+
> -| ptep_get_and_clear_full   | Clears a PTE                                     |
> +| ptep_get_and_clear        | Clears and returns PTE                           |
> ++---------------------------+--------------------------------------------------+
> +| ptep_get_and_clear_full   | Clears and returns PTE (batched PTE unmap)       |
>  +---------------------------+--------------------------------------------------+
>  | ptep_test_and_clear_young | Clears young from a PTE                          |
>  +---------------------------+--------------------------------------------------+

Just curious. This does not have a corresponding change in mm/debug_vm_pgtable.c ?
