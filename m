Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5112531CB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 14:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBPNyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 08:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhBPNyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 08:54:19 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F747C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 05:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Mime-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kYUo66AoPkUWf5z7nwzQD189MD7HAT785a8XHdD9kAg=; b=vTzR6H3QPzvgKPVSjQ3YGjfGCq
        tKy6uNUudzrSUlgVtjda6aPQ2N/twQ/gXFxT5E1eeYAcEijWztfn3xBtPYBzv7c24qwZqdkEI8oGn
        4Wj9RaGw/l3/eZrutd+tEacos8pFvb0VrR0aaa/ykRAfUt6W1Z90u+dGDuQ1hNxj6TUniVA6TYPKy
        cmsVMqDQhGkeTQFcoGdj0ev0P2mJxsdTptVSjzQ5qlaXGmnL7ymYJdYK0Bain/Ilqq5VQwu81C1o6
        ogLfQg/2scWR6ikRNnrIhz0pby1IkDXz9UJ32ZgaKsIRKAANBiFEYMmaqUZZHCoSt3cmg015Pxwbc
        woBhO0Wg==;
Received: from 54-240-197-235.amazon.com ([54.240.197.235] helo=freeip.amazon.com)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lC0n9-0008BI-3d; Tue, 16 Feb 2021 13:53:27 +0000
Message-ID: <1d2a7bc911da2bbaa4c441d269287fbb5b1bc8d7.camel@infradead.org>
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
From:   David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "shenkai (D)" <shenkai8@huawei.com>,
        "Schander, Johanna 'Mimoja' Amelie" <mimoja@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian <hejingxian@huawei.com>
Date:   Tue, 16 Feb 2021 13:53:24 +0000
In-Reply-To: <87zh09tcqz.fsf@nanos.tec.linutronix.de>
References: <87ft22dxop.fsf@nanos.tec.linutronix.de>
         <27357c74bdc3b52bdf59e6f48cd8690495116d64.camel@infradead.org>
         <877dnedt7l.fsf@nanos.tec.linutronix.de>
         <87zh09tcqz.fsf@nanos.tec.linutronix.de>
Content-Type: multipart/signed; micalg="sha-256";
        protocol="application/x-pkcs7-signature";
        boundary="=-bqCwvlinyA9TBmWUfrIS"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bqCwvlinyA9TBmWUfrIS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-02-12 at 18:30 +0100, Thomas Gleixner wrote:
> On Fri, Feb 12 2021 at 01:29, Thomas Gleixner wrote:
> > On Thu, Feb 11 2021 at 22:58, David Woodhouse wrote:
> > I have no problem with making that jump based. It does not matter at
> > all. But you can't use the idle task stack before the CR3 switch in
> > secondary_startup_64 - unless I'm missing something.
> >=20
> > And there's more than 'call verify_cpu' on the way which uses stack. Le=
t
> > me stare more tomorrow with brain awake.
>=20
> The below boots on top of mainline. It probably breaks i386 and XEN and
> whatever :)

Nice. As discussed on IRC, you'll need more than 0xFFFF for APIC IDs
but I think you can probably get away with 0xFFFFF for physical APIC ID
since nothing more than that can fit in 32 bits of *logical* X2APIC ID.

> I didn't come around to play with your patches yet and won't be able to
> do so before next week.

I threw it into my tree at
https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/paralle=
l

It seems to work fairly nicely. The parallel SIPI seems to win be about
a third of the bringup time on my 28-thread Haswell box. This is at the
penultimate commit of the above branch:

[    0.307590] smp: Bringing up secondary CPUs ...
[    0.307826] x86: Booting SMP configuration:
[    0.307830] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  =
#9 #10 #11 #12 #13 #14
[    0.376677] MDS CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more de=
tails.
[    0.377177]  #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27
[    0.402323] Brought CPUs online in 246691584 cycles
[    0.402323] smp: Brought up 1 node, 28 CPUs

... and this is the tip of the branch:

[    0.308332] smp: Bringing up secondary CPUs ...<dwmw2_gone>=20
[    0.308569] x86: Booting SMP configuration:
[    0.308572] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  =
#9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27
[    0.321120] Brought 28 CPUs to x86/cpu:kick in 34828752 cycles
[    0.366663] MDS CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more de=
tails.
[    0.368749] Brought CPUs online in 124913032 cycles
[    0.368749] smp: Brought up 1 node, 28 CPUs
[    0.368749] smpboot: Max logical packages: 1
[    0.368749] smpboot: Total of 28 processors activated (145259.85 BogoMIP=
S)

There's more to be gained here if we can fix up the next stage. Right
now if I set every CPU's bit in cpu_initialized_mask to allow them to
proceed from wait_for_master_cpu() through to the end of cpu_init() and
onwards through start_secondary(), they all end up hitting
check_tsc_sync_target() in parallel and it goes horridly wrong.

A simple answer might be to have another synchronisation point right
before the TSC sync, to force them to do it one at a time but *without*
having to wait for the rest of the AP bringup in series.

Other answers include inventing a magical parallel TSC sync algorithm
that isn't 1-to-1 between the BSP and each AP. Or observing that we're
running in KVM or after kexec, and we *know* they're in sync anyway and
bypassing the whole bloody nonsense.

Recall, my initial debug patch timing the four stages of the bringup,
which I've left in my branch above for visibility, was showing this
kind of output with the original serial bringup...

> [    0.285312] CPU#10 up in     192950,    952898,  60014786,        28 (=
  61160662)
> [    0.288311] CPU#11 up in     181092,    962704,  60010432,        30 (=
  61154258)
> [    0.291312] CPU#12 up in     386080,    970416,  60013956,        28 (=
  61370480)
> [    0.294311] CPU#13 up in     372782,    964506,  60010564,        28 (=
  61347880)
> [    0.297312] CPU#14 up in     389602,    976280,  60013046,        28 (=
  61378956)
> [    0.300312] CPU#15 up in     213132,    968148,  60012138,        28 (=
  61193446)

So that's almost a million cycles per CPU of do_wait_cpu_callin()
before we get to the TSC sync (which is insanely expensive on KVM).
It's something like three times the time taken by the SIPI+wait in the
first phase, which is what we've parallelised so far (at a gain of
about 33%).



> ---
>  arch/x86/include/asm/realmode.h      |    3 +
>  arch/x86/include/asm/smp.h           |    9 +++-
>  arch/x86/kernel/acpi/sleep.c         |    1=20
>  arch/x86/kernel/apic/apic.c          |    2=20
>  arch/x86/kernel/head_64.S            |   71 ++++++++++++++++++++++++++++=
+++++++
>  arch/x86/kernel/smpboot.c            |   19 ++++++++-
>  arch/x86/realmode/init.c             |    3 +
>  arch/x86/realmode/rm/trampoline_64.S |   14 ++++++
>  kernel/smpboot.c                     |    2=20
>  9 files changed, 119 insertions(+), 5 deletions(-)
>=20
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -51,6 +51,7 @@ struct trampoline_header {
>  	u64 efer;
>  	u32 cr4;
>  	u32 flags;
> +	u32 lock;
>  #endif
>  };
> =20
> @@ -64,6 +65,8 @@ extern unsigned long initial_stack;
>  extern unsigned long initial_vc_handler;
>  #endif
> =20
> +extern u32 *trampoline_lock;
> +
>  extern unsigned char real_mode_blob[];
>  extern unsigned char real_mode_relocs[];
> =20
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -187,5 +187,12 @@ extern void nmi_selftest(void);
>  #define nmi_selftest() do { } while (0)
>  #endif
> =20
> -#endif /* __ASSEMBLY__ */
> +extern unsigned int smpboot_control;
> +
> +#endif /* !__ASSEMBLY__ */
> +
> +/* Control bits for startup_64 */
> +#define	STARTUP_USE_APICID	0x10000
> +#define	STARTUP_USE_CPUID_0B	0x20000
> +
>  #endif /* _ASM_X86_SMP_H */
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -114,6 +114,7 @@ int x86_acpi_suspend_lowlevel(void)
>  	early_gdt_descr.address =3D
>  			(unsigned long)get_cpu_gdt_rw(smp_processor_id());
>  	initial_gs =3D per_cpu_offset(smp_processor_id());
> +	smpboot_control =3D 0;
>  #endif
>  	initial_code =3D (unsigned long)wakeup_long64;
>         saved_magic =3D 0x123456789abcdef0L;
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2333,7 +2333,7 @@ static int nr_logical_cpuids =3D 1;
>  /*
>   * Used to store mapping between logical CPU IDs and APIC IDs.
>   */
> -static int cpuid_to_apicid[] =3D {
> +int cpuid_to_apicid[] =3D {
>  	[0 ... NR_CPUS - 1] =3D -1,
>  };
> =20
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -25,6 +25,7 @@
>  #include <asm/export.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/fixmap.h>
> +#include <asm/smp.h>
> =20
>  /*
>   * We are not able to switch in one step to the final KERNEL ADDRESS SPA=
CE
> @@ -177,6 +178,64 @@ SYM_INNER_LABEL(secondary_startup_64_no_
>  	UNWIND_HINT_EMPTY
> =20
>  	/*
> +	 * Is this the boot CPU coming up? If so everything is available
> +	 * in initial_gs, initial_stack and early_gdt_descr.
> +	 */
> +	movl	smpboot_control(%rip), %eax
> +	testl	%eax, %eax
> +	jz	.Lsetup_cpu
> +
> +	/*
> +	 * Secondary CPUs find out the offsets via the APIC ID. For parallel
> +	 * boot the APIC ID is retrieved from CPUID, otherwise it's encoded
> +	 * in smpboot_control:
> +	 * Bit 0-15	APICID if STARTUP_USE_CPUID_0B is not set
> +	 * Bit 16 	Secondary boot flag
> +	 * Bit 17	Parallel boot flag
> +	 */
> +	testl	$STARTUP_USE_CPUID_0B, %eax
> +	jz	.Lsetup_AP
> +
> +	mov	$0x0B, %eax
> +	xorl	%ecx, %ecx
> +	cpuid
> +	mov	%edx, %eax
> +
> +.Lsetup_AP:
> +	/* EAX contains the APICID of the current CPU */
> +	andl	$0xFFFF, %eax
> +	xorl	%ecx, %ecx
> +	leaq	cpuid_to_apicid(%rip), %rbx
> +
> +.Lfind_cpunr:
> +	cmpl	(%rbx), %eax
> +	jz	.Linit_cpu_data
> +	addq	$4, %rbx
> +	addq	$8, %rcx
> +	jmp	.Lfind_cpunr
> +
> +.Linit_cpu_data:
> +	/* Get the per cpu offset */
> +	leaq	__per_cpu_offset(%rip), %rbx
> +	addq	%rcx, %rbx
> +	movq	(%rbx), %rbx
> +	/* Save it for GS BASE setup */
> +	movq	%rbx, initial_gs(%rip)
> +
> +	/* Calculate the GDT address */
> +	movq	$gdt_page, %rcx
> +	addq	%rbx, %rcx
> +	movq	%rcx, early_gdt_descr_base(%rip)
> +
> +	/* Find the idle task stack */
> +	movq	$idle_threads, %rcx
> +	addq	%rbx, %rcx
> +	movq	(%rcx), %rcx
> +	movq	TASK_threadsp(%rcx), %rcx
> +	movq	%rcx, initial_stack(%rip)
> +
> +.Lsetup_cpu:
> +	/*
>  	 * We must switch to a new descriptor in kernel space for the GDT
>  	 * because soon the kernel won't have access anymore to the userspace
>  	 * addresses where we're currently running on. We have to do that here
> @@ -216,6 +275,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_
>  	 */
>  	movq initial_stack(%rip), %rsp
> =20
> +	/* Drop the realmode protection. For the boot CPU the pointer is NULL! =
*/
> +	movq	trampoline_lock(%rip), %rax
> +	testq	%rax, %rax
> +	jz	.Lsetup_idt
> +	lock
> +	btrl	$0, (%rax)
> +
> +.Lsetup_idt:
>  	/* Setup and Load IDT */
>  	pushq	%rsi
>  	call	early_setup_idt
> @@ -347,6 +414,7 @@ SYM_DATA(initial_vc_handler,	.quad handl
>   * reliably detect the end of the stack.
>   */
>  SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - SIZEOF_P=
TREGS)
> +SYM_DATA(trampoline_lock, .quad 0);
>  	__FINITDATA
> =20
>  	__INIT
> @@ -573,6 +641,9 @@ SYM_DATA(early_gdt_descr,		.word GDT_ENT
>  SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
> =20
>  	.align 16
> +SYM_DATA(smpboot_control,		.long 0)
> +
> +	.align 16
>  /* This must match the first entry in level2_kernel_pgt */
>  SYM_DATA(phys_base, .quad 0x0)
>  EXPORT_SYMBOL(phys_base)
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1021,6 +1021,16 @@ int common_cpu_up(unsigned int cpu, stru
>  	return 0;
>  }
> =20
> +static void setup_smpboot_control(unsigned int apicid)
> +{
> +#ifdef CONFIG_X86_64
> +	if (boot_cpu_data.cpuid_level < 0x0B)
> +		smpboot_control =3D apicid | STARTUP_USE_APICID;
> +	else
> +		smpboot_control =3D STARTUP_USE_CPUID_0B;
> +#endif
> +}
> +
>  /*
>   * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
>   * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
> @@ -1037,9 +1047,14 @@ static int do_boot_cpu(int apicid, int c
>  	unsigned long timeout;
> =20
>  	idle->thread.sp =3D (unsigned long)task_pt_regs(idle);
> -	early_gdt_descr.address =3D (unsigned long)get_cpu_gdt_rw(cpu);
>  	initial_code =3D (unsigned long)start_secondary;
> -	initial_stack  =3D idle->thread.sp;
> +
> +	if (IS_ENABLED(CONFIG_X86_32)) {
> +		early_gdt_descr.address =3D (unsigned long)get_cpu_gdt_rw(cpu);
> +		initial_stack  =3D idle->thread.sp;
> +	}
> +
> +	setup_smpboot_control(apicid);
> =20
>  	/* Enable the espfix hack for this CPU */
>  	init_espfix_ap(cpu);
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -125,6 +125,9 @@ static void __init setup_real_mode(void)
> =20
>  	trampoline_header->flags =3D 0;
> =20
> +	trampoline_lock =3D &trampoline_header->lock;
> +	*trampoline_lock =3D 0;
> +
>  	trampoline_pgd =3D (u64 *) __va(real_mode_header->trampoline_pgd);
>  	trampoline_pgd[0] =3D trampoline_pgd_entry.pgd;
>  	trampoline_pgd[511] =3D init_top_pgt[511].pgd;
> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -49,6 +49,19 @@ SYM_CODE_START(trampoline_start)
>  	mov	%ax, %es
>  	mov	%ax, %ss
> =20
> +	/*
> +	 * Make sure only one CPU fiddles with the realmode stack
> +	 */
> +.Llock_rm:
> +	btw	$0, tr_lock
> +	jnc	2f
> +	pause
> +	jmp	.Llock_rm
> +2:
> +	lock
> +	btsw	$0, tr_lock
> +	jc	.Llock_rm
> +
>  	# Setup stack
>  	movl	$rm_stack_end, %esp
> =20
> @@ -192,6 +205,7 @@ SYM_DATA_START(trampoline_header)
>  	SYM_DATA(tr_efer,		.space 8)
>  	SYM_DATA(tr_cr4,		.space 4)
>  	SYM_DATA(tr_flags,		.space 4)
> +	SYM_DATA(tr_lock,		.space 4)
>  SYM_DATA_END(trampoline_header)
> =20
>  #include "trampoline_common.S"
> --- a/kernel/smpboot.c
> +++ b/kernel/smpboot.c
> @@ -25,7 +25,7 @@
>   * For the hotplug case we keep the task structs around and reuse
>   * them.
>   */
> -static DEFINE_PER_CPU(struct task_struct *, idle_threads);
> +DEFINE_PER_CPU(struct task_struct *, idle_threads);
> =20
>  struct task_struct *idle_thread_get(unsigned int cpu)
>  {


--=-bqCwvlinyA9TBmWUfrIS
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCECow
ggUcMIIEBKADAgECAhEA4rtJSHkq7AnpxKUY8ZlYZjANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTkwMTAyMDAwMDAwWhcNMjIwMTAxMjM1
OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAsv3wObLTCbUA7GJqKj9vHGf+Fa+tpkO+ZRVve9EpNsMsfXhvFpb8
RgL8vD+L133wK6csYoDU7zKiAo92FMUWaY1Hy6HqvVr9oevfTV3xhB5rQO1RHJoAfkvhy+wpjo7Q
cXuzkOpibq2YurVStHAiGqAOMGMXhcVGqPuGhcVcVzVUjsvEzAV9Po9K2rpZ52FE4rDkpDK1pBK+
uOAyOkgIg/cD8Kugav5tyapydeWMZRJQH1vMQ6OVT24CyAn2yXm2NgTQMS1mpzStP2ioPtTnszIQ
Ih7ASVzhV6csHb8Yrkx8mgllOyrt9Y2kWRRJFm/FPRNEurOeNV6lnYAXOymVJwIDAQABo4IB0zCC
Ac8wHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFLfuNf820LvaT4AK
xrGK3EKx1DE7MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZy
YWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQALbSykFusvvVkSIWttcEeifOGGKs7Wx2f5f45b
nv2ghcxK5URjUvCnJhg+soxOMoQLG6+nbhzzb2rLTdRVGbvjZH0fOOzq0LShq0EXsqnJbbuwJhK+
PnBtqX5O23PMHutP1l88AtVN+Rb72oSvnD+dK6708JqqUx2MAFLMevrhJRXLjKb2Mm+/8XBpEw+B
7DisN4TMlLB/d55WnT9UPNHmQ+3KFL7QrTO8hYExkU849g58Dn3Nw3oCbMUgny81ocrLlB2Z5fFG
Qu1AdNiBA+kg/UxzyJZpFbKfCITd5yX49bOriL692aMVDyqUvh8fP+T99PqorH4cIJP6OxSTdxKM
MIIFHDCCBASgAwIBAgIRAOK7SUh5KuwJ6cSlGPGZWGYwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwMjAwMDAwMFoXDTIyMDEwMTIz
NTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALL98Dmy0wm1AOxiaio/bxxn/hWvraZDvmUVb3vRKTbDLH14bxaW
/EYC/Lw/i9d98CunLGKA1O8yogKPdhTFFmmNR8uh6r1a/aHr301d8YQea0DtURyaAH5L4cvsKY6O
0HF7s5DqYm6tmLq1UrRwIhqgDjBjF4XFRqj7hoXFXFc1VI7LxMwFfT6PStq6WedhROKw5KQytaQS
vrjgMjpICIP3A/CroGr+bcmqcnXljGUSUB9bzEOjlU9uAsgJ9sl5tjYE0DEtZqc0rT9oqD7U57My
ECIewElc4VenLB2/GK5MfJoJZTsq7fWNpFkUSRZvxT0TRLqznjVepZ2AFzsplScCAwEAAaOCAdMw
ggHPMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBS37jX/NtC72k+A
CsaxitxCsdQxOzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2Ny
bC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQG
CCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAC20spBbrL71ZEiFrbXBHonzhhirO1sdn+X+O
W579oIXMSuVEY1LwpyYYPrKMTjKECxuvp24c829qy03UVRm742R9Hzjs6tC0oatBF7KpyW27sCYS
vj5wbal+TttzzB7rT9ZfPALVTfkW+9qEr5w/nSuu9PCaqlMdjABSzHr64SUVy4ym9jJvv/FwaRMP
gew4rDeEzJSwf3eeVp0/VDzR5kPtyhS+0K0zvIWBMZFPOPYOfA59zcN6AmzFIJ8vNaHKy5QdmeXx
RkLtQHTYgQPpIP1Mc8iWaRWynwiE3ecl+PWzq4i+vdmjFQ8qlL4fHz/k/fT6qKx+HCCT+jsUk3cS
jDCCBeYwggPOoAMCAQICEGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYT
AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf
+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcf
WlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqza
aPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDK
CMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAU
u69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8E
RTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9u
QXV0aG9yaXR5LmNybDBxBggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2
SQgG1NgvNc3fQP7TcePo7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs
0j8CGpfb+SJA3GaBQ+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDM
KVmU/PUWNMKSTvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+
E2pvOUtY+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfH
M5tdhYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1t
yZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4o
gnzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAb
R9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA4rtJSHkq7AnpxKUY8ZlYZjANBglghkgB
ZQMEAgEFAKCCAe0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEw
MjE2MTM1MzI0WjAvBgkqhkiG9w0BCQQxIgQgukwRgmGmWzLgCDbLo3sYgbYwFqOV7UZLdTWAMmyX
M2swgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAKhnGP4lrZhndVzZxs7dvzbuEGoCMM63Kk51HT18eo3HLahGf9cg0lKX7ly+dFhM
rbD1Dc+RqkKSClFKACiN2SL5TzCmF9j9OZIVxjTuhC9u00E5wiu7J/jaef2LEDPiVTPVr3QDG2NW
jk2rIlMChjQutgCXO1KRvwO62vMKkqRT0ZXUCbxuxDpJqlUDP1nccWarcziTp8kFRnzTH8x4byV0
0Ug2YiMrspjrZXVm8qMULS7i2ibWk65D2g2PRA+ATmf3CwzQyZarM42oZ+Ve0WoTiWzNcWtyP/EG
eSmtr747Iry1fL3Yif65cFtYdC0pQmowNreErsQm6HFT42U04icAAAAAAAA=


--=-bqCwvlinyA9TBmWUfrIS--

