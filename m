Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1038EACE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhEXO6M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 May 2021 10:58:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53666 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhEXOxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:53:04 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 87eb3c669466d932; Mon, 24 May 2021 16:51:34 +0200
Received: from kreacher.localnet (89-64-80-49.dynamic.chello.pl [89.64.80.49])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 91A41669728;
        Mon, 24 May 2021 16:51:33 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] x86/acpi, x86/boot: Add multiprocessor wake-up support
Date:   Mon, 24 May 2021 16:51:33 +0200
Message-ID: <2592439.mvXUDI8C0e@kreacher>
In-Reply-To: <20210524060221.519093-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <e4dc31d5-d897-50fa-34e7-f5c033d5f5db@linux.intel.com> <20210524060221.519093-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.49
X-CLIENT-HOSTNAME: 89-64-80-49.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeijeekfeehgeejffefveffgeehheetueevudeutddtvdetueegudehieeiheefveenucfkphepkeelrdeigedrkedtrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrgeelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepshgrthhhhigrnhgrrhgrhigrnhgrnhdrkhhuphhpuhhsfigrmhihsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
 pehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhnshgrthhhhigrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvggrnhhjtgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghksehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, May 24, 2021 8:02:21 AM CEST Kuppuswamy Sathyanarayanan wrote:
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
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

It would help if you CCed this to linux-acpi@vger.kernel.org.

> ---
> 
> Changes since v4:
>  * Used smp_store_release() in place of WRITE_ONCE().
>  * Addressed some checkpatch warnings.
> 
> Changes since v3:
>  * Removed acpi_mp_wake_mailbox_init() and moved init code to
>    acpi_wakeup_cpu().
>  * Removed redundant NULL pointer check for acpi_mp_wake_mailbox.
>  * Added comments/debug prints as per Rafael's suggestion.
>  * Removed MADT/SVKL ACPI patches from this patchset. It will be
>    merged via ACPICA submission.
> 
>  arch/x86/include/asm/apic.h |  3 ++
>  arch/x86/kernel/acpi/boot.c | 96 +++++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/apic/apic.c |  8 ++++
>  3 files changed, 107 insertions(+)
> 
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 412b51e059c8..3e94e1f402ea 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -487,6 +487,9 @@ static inline unsigned int read_apic_id(void)
>  	return apic->get_apic_id(reg);
>  }
>  
> +typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
> +extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
> +
>  extern int default_apic_id_valid(u32 apicid);
>  extern int default_acpi_madt_oem_check(char *, char *);
>  extern void default_setup_apic_routing(void);
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 14cd3186dc77..c51134eb55d0 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -65,6 +65,10 @@ int acpi_fix_pin2_polarity __initdata;
>  static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
>  #endif
>  
> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> +static u64 acpi_mp_wake_mailbox_paddr;
> +static physid_mask_t apic_id_wakemap = PHYSID_MASK_NONE;
> +
>  #ifdef CONFIG_X86_IO_APIC
>  /*
>   * Locks related to IOAPIC hotplug
> @@ -329,6 +333,68 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
>  	return 0;
>  }
>  
> +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> +{
> +	u8 timeout = 0xFF;
> +
> +	/* Remap mailbox memory only for the first call to acpi_wakeup_cpu() */
> +	if (physids_empty(apic_id_wakemap)) {
> +		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> +						sizeof(*acpi_mp_wake_mailbox),
> +						MEMREMAP_WB);
> +	}
> +
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
> +	/*
> +	 * Mailbox memory is shared between firmware and OS. Firmware will
> +	 * listen on mailbox command address, and once it receives the wakeup
> +	 * command, CPU associated with the given apicid will be booted. So,
> +	 * the value of apic_id and wakeup_vector has to be set before updating
> +	 * the wakeup command. So use smp_store_release to let the compiler know
> +	 * about it and preserve the order of writes.
> +	 */
> +	smp_store_release(&acpi_mp_wake_mailbox->apic_id, apicid);
> +	smp_store_release(&acpi_mp_wake_mailbox->wakeup_vector, start_ip);
> +	smp_store_release(&acpi_mp_wake_mailbox->command,
> +			  ACPI_MP_WAKE_COMMAND_WAKEUP);
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
>  
>  #ifdef CONFIG_X86_IO_APIC
> @@ -1086,6 +1152,30 @@ static int __init acpi_parse_madt_lapic_entries(void)
>  	}
>  	return 0;
>  }
> +
> +static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> +				      const unsigned long end)
> +{
> +	struct acpi_madt_multiproc_wakeup *mp_wake;
> +
> +	if (acpi_mp_wake_mailbox)
> +		return -EINVAL;
> +
> +	if (!IS_ENABLED(CONFIG_SMP))
> +		return -ENODEV;
> +
> +	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> +	if (BAD_MADT_ENTRY(mp_wake, end))
> +		return -EINVAL;
> +
> +	acpi_table_print_madt_entry(&header->common);
> +
> +	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> +
> +	acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
> +
> +	return 0;
> +}
>  #endif				/* CONFIG_X86_LOCAL_APIC */
>  
>  #ifdef	CONFIG_X86_IO_APIC
> @@ -1284,6 +1374,12 @@ static void __init acpi_process_madt(void)
>  
>  				smp_found_config = 1;
>  			}
> +
> +			/*
> +			 * Parse MADT MP Wake entry.
> +			 */
> +			acpi_table_parse_madt(ACPI_MADT_TYPE_MULTIPROC_WAKEUP,
> +					      acpi_parse_mp_wake, 1);
>  		}
>  		if (error == -EINVAL) {
>  			/*
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 4f26700f314d..f1b90a4b89e8 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2554,6 +2554,14 @@ u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid)
>  }
>  EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
>  
> +void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
> +{
> +	struct apic **drv;
> +
> +	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
> +		(*drv)->wakeup_secondary_cpu = handler;
> +}
> +
>  /*
>   * Override the generic EOI implementation with an optimized version.
>   * Only called during early boot when only one CPU is active and with
> 




