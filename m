Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE0038C9E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhEUPSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:18:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:18969 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230420AbhEUPSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:18:23 -0400
IronPort-SDR: iHBLMnWL4lgjH4Gpg7SFLOJ/IqgoGKi/EhflCj5yV33bfh1rMji45Deg6NNu0+UkfShSYMWVaY
 AwK2NhVwesBw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="265412629"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265412629"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 08:14:48 -0700
IronPort-SDR: oEtiD6YgMkzm2w8WU4o39RGvQMeb9lpDhES1B0lI2E1vV3WproXwAnk2lNRncoEqhfl2s/yQDE
 0V5W4T1urDSw==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441115153"
Received: from orxpovpvmu02.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.181.51])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 08:14:47 -0700
Subject: Re: [PATCH v4 1/1] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <CAJZ5v0hFfVCm25wUCetOm4YdZKwt5h2jknN9ad1nnpxuR16KkQ@mail.gmail.com>
 <20210513213732.418398-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YKfHiu/a/V/0DS3V@hirez.programming.kicks-ass.net>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <e4dc31d5-d897-50fa-34e7-f5c033d5f5db@linux.intel.com>
Date:   Fri, 21 May 2021 08:14:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKfHiu/a/V/0DS3V@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/21 7:45 AM, Peter Zijlstra wrote:
> On Thu, May 13, 2021 at 02:37:32PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
>> +{
>> +	u8 timeout = 0xFF;
>> +
>> +	/* Remap mailbox memory only for the first call to acpi_wakeup_cpu() */
>> +	if (physids_empty(apic_id_wakemap))
>> +		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
>> +						sizeof(*acpi_mp_wake_mailbox),
>> +						MEMREMAP_WB);
> 
> { } for being multi-line

Yes. I will fix it.

> 
>> +	/*
>> +	 * According to the ACPI specification r6.4, sec 5.2.12.19, the
>> +	 * mailbox-based wakeup mechanism cannot be used more than once
>> +	 * for the same CPU, so skip sending wake commands to already
>> +	 * awake CPU.
>> +	 */
>> +	if (physid_isset(apicid, apic_id_wakemap)) {
>> +		pr_err("CPU already awake (APIC ID %x), skipping wakeup\n",
>> +		       apicid);
>> +		return -EINVAL;
>> +	}
>> +
>> +
>> +	/*
>> +	 * Mailbox memory is shared between firmware and OS. Firmware will
>> +	 * listen on mailbox command address, and once it receives the wakeup
>> +	 * command, CPU associated with the given apicid will be booted. So,
>> +	 * the value of apic_id and wakeup_vector has to be set before updating
>> +	 * the wakeup command. So use WRITE_ONCE to let the compiler know about
>> +	 * it and preserve the order of writes.
>> +	 */
>> +	WRITE_ONCE(acpi_mp_wake_mailbox->apic_id, apicid);
>> +	WRITE_ONCE(acpi_mp_wake_mailbox->wakeup_vector, start_ip);
>> +	WRITE_ONCE(acpi_mp_wake_mailbox->command, ACPI_MP_WAKE_COMMAND_WAKEUP);
> 
> Do those want to be smp_store_release(), in addition to being a volatile
> write, those also include compiler barriers to make sure the compiler
> doesn't lift stuff around.

I think we can use smp_store_release(). Let me test and add it in next
version.

> 
>> +
>> +	/*
>> +	 * After writing wakeup command, wait for maximum timeout of 0xFF
>> +	 * for firmware to reset the command address back zero to indicate
>> +	 * the successful reception of command.
>> +	 * NOTE: 255 as timeout value is decided based on our experiments.
>> +	 *
>> +	 * XXX: Change the timeout once ACPI specification comes up with
>> +	 *      standard maximum timeout value.
>> +	 */
>> +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
>> +		cpu_relax();
> 
> What's the unit of the timeout? The mailbox reads, the PAUSE
> instruction?

Read mailbox memory, timeout dec and then pause. Its more like busy wait loop.

And timeout count is decided based on our experiments. Once spec defines a
standard, we can modify it.

> 
>> +
>> +	if (timeout) {
>> +		/*
>> +		 * If the CPU wakeup process is successful, store the
>> +		 * status in apic_id_wakemap to prevent re-wakeup
>> +		 * requests.
>> +		 */
>> +		physid_set(apicid, apic_id_wakemap);
>> +		return 0;
>> +	}
>> +
>> +	/* If timed out (timeout == 0), return error */
>> +	return -EIO;
>> +}
>> +
>>   #endif				/*CONFIG_X86_LOCAL_APIC */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
