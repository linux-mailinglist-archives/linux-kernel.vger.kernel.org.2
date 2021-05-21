Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02138C90D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhEUOUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:20:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:22002 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhEUOUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:20:10 -0400
IronPort-SDR: xRka2Kvcn026PumFp2Mjk4OVkjMw+sfGKpuzja+JPrL89tMB/+gFB4ukIWyo/fAUQt5qdtw83r
 gemUdpqOoogg==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188620875"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188620875"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 07:18:44 -0700
IronPort-SDR: Y8B2V9pG4zU1h574leCcO4GyuAAn9IviARI98NRIx453kZW82MWNXl14DQuIeyBqKFZL9FuAMx
 sahezND45uXA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441099752"
Received: from orxpovpvmu02.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.181.51])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 07:18:44 -0700
Subject: Re: [PATCH v4 1/1] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
To:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <CAJZ5v0hFfVCm25wUCetOm4YdZKwt5h2jknN9ad1nnpxuR16KkQ@mail.gmail.com>
 <20210513213732.418398-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4ee1a3a4-9d9c-4bb3-20ac-9f70e754de1b@linux.intel.com>
Date:   Fri, 21 May 2021 07:18:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513213732.418398-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 5/13/21 2:37 PM, Kuppuswamy Sathyanarayanan wrote:
> As per ACPI specification r6.4, sec 5.2.12.19, a new sub
> structure – multiprocessor wake-up structure - is added to the
> ACPI Multiple APIC Description Table (MADT) to describe the
> information of the mailbox. If a platform firmware produces the
> multiprocessor wake-up structure, then OS may use this new
> mailbox-based mechanism to wake up the APs.
> 
> Add ACPI MADT wake table parsing support for x86 platform and if
> MADT wake table is present, update apic->wakeup_secondary_cpu with
> new API which uses MADT wake mailbox to wake-up CPU.
> 
> Co-developed-by: Sean Christopherson<sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson<sean.j.christopherson@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen<ak@linux.intel.com>
> ---

Any comments on this patch?

> 
> Changes since v3:
>   * Removed acpi_mp_wake_mailbox_init() and moved init code to
>     acpi_wakeup_cpu().
>   * Removed redundant NULL pointer check for acpi_mp_wake_mailbox.
>   * Added comments/debug prints as per Rafael's suggestion.
>   * Removed MADT/SVKL ACPI patches from this patchset. It will be
>     merged via ACPICA submission.
> 
>   arch/x86/include/asm/apic.h |  3 ++
>   arch/x86/kernel/acpi/boot.c | 95 +++++++++++++++++++++++++++++++++++++
>   arch/x86/kernel/apic/apic.c |  8 ++++
>   3 files changed, 106 insertions(+)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
