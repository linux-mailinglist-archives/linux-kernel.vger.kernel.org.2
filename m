Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D0738C971
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbhEUOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbhEUOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:47:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDAFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KE2XWIQJa7QyffRG2NB7ooMjea4/CmI8Kv+hx71I77k=; b=fbAP5/5ZhNwG63zBx/bbZ85ZOC
        B1Zu5XrHoYNkCCWMZ60dzNFpkwWP5wMGkTrxy116RMti0Wgob1GvOxfSnfJ9gzUb9P1GmoSLlL+z9
        QDBDUkGlSH4ebv1QvFTvO7UuGhPd9GnR15MqmWOtPBykdzyRhSyVFtdgDkjZd3Alh8VJYkhfji6PS
        fNzAorv6ZwLB1o3AebT3gkK5NBty1llFhZup7EjmHb9kgN3yUf3PjgM5l8WK7QI2KBqOFrUjc1RgU
        44t+bsgCPLS2h+MAkHs2s84azz5ObP0Jk0MpkrhaexEMASN5XC4Ss+If4U9LOj6wPIhFEp/IBkf32
        sGX7CS4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lk6P8-005o7P-5d; Fri, 21 May 2021 14:45:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 277703001D0;
        Fri, 21 May 2021 16:45:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D74D930D9D87B; Fri, 21 May 2021 16:45:30 +0200 (CEST)
Date:   Fri, 21 May 2021 16:45:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 1/1] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
Message-ID: <YKfHiu/a/V/0DS3V@hirez.programming.kicks-ass.net>
References: <CAJZ5v0hFfVCm25wUCetOm4YdZKwt5h2jknN9ad1nnpxuR16KkQ@mail.gmail.com>
 <20210513213732.418398-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513213732.418398-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 02:37:32PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> +{
> +	u8 timeout = 0xFF;
> +
> +	/* Remap mailbox memory only for the first call to acpi_wakeup_cpu() */
> +	if (physids_empty(apic_id_wakemap))
> +		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> +						sizeof(*acpi_mp_wake_mailbox),
> +						MEMREMAP_WB);

{ } for being multi-line

> +	/*
> +	 * According to the ACPI specification r6.4, sec 5.2.12.19, the
> +	 * mailbox-based wakeup mechanism cannot be used more than once
> +	 * for the same CPU, so skip sending wake commands to already
> +	 * awake CPU.
> +	 */
> +	if (physid_isset(apicid, apic_id_wakemap)) {
> +		pr_err("CPU already awake (APIC ID %x), skipping wakeup\n",
> +		       apicid);
> +		return -EINVAL;
> +	}
> +
> +
> +	/*
> +	 * Mailbox memory is shared between firmware and OS. Firmware will
> +	 * listen on mailbox command address, and once it receives the wakeup
> +	 * command, CPU associated with the given apicid will be booted. So,
> +	 * the value of apic_id and wakeup_vector has to be set before updating
> +	 * the wakeup command. So use WRITE_ONCE to let the compiler know about
> +	 * it and preserve the order of writes.
> +	 */
> +	WRITE_ONCE(acpi_mp_wake_mailbox->apic_id, apicid);
> +	WRITE_ONCE(acpi_mp_wake_mailbox->wakeup_vector, start_ip);
> +	WRITE_ONCE(acpi_mp_wake_mailbox->command, ACPI_MP_WAKE_COMMAND_WAKEUP);

Do those want to be smp_store_release(), in addition to being a volatile
write, those also include compiler barriers to make sure the compiler
doesn't lift stuff around.

> +
> +	/*
> +	 * After writing wakeup command, wait for maximum timeout of 0xFF
> +	 * for firmware to reset the command address back zero to indicate
> +	 * the successful reception of command.
> +	 * NOTE: 255 as timeout value is decided based on our experiments.
> +	 *
> +	 * XXX: Change the timeout once ACPI specification comes up with
> +	 *      standard maximum timeout value.
> +	 */
> +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
> +		cpu_relax();

What's the unit of the timeout? The mailbox reads, the PAUSE
instruction?

> +
> +	if (timeout) {
> +		/*
> +		 * If the CPU wakeup process is successful, store the
> +		 * status in apic_id_wakemap to prevent re-wakeup
> +		 * requests.
> +		 */
> +		physid_set(apicid, apic_id_wakemap);
> +		return 0;
> +	}
> +
> +	/* If timed out (timeout == 0), return error */
> +	return -EIO;
> +}
> +
>  #endif				/*CONFIG_X86_LOCAL_APIC */
