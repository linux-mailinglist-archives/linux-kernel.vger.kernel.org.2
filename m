Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA7133FBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 00:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCQX3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 19:29:53 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:44163 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhCQX3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 19:29:31 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lMfbW-000Hdc-FQ; Thu, 18 Mar 2021 00:29:30 +0100
Received: from p5b13a966.dip0.t-ipconnect.de ([91.19.169.102] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lMfbW-000URv-8v; Thu, 18 Mar 2021 00:29:30 +0100
Subject: Re: [PATCH 0/1] sched/topology: NUMA distance deduplication
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        debian-ia64 <debian-ia64@lists.debian.org>
References: <255d6b5d-194e-eb0e-ecdd-97477a534441@physik.fu-berlin.de>
 <8735wtr2ro.mognet@arm.com>
 <cf4d7277-54a0-8bc7-60fb-9b2f6befb511@physik.fu-berlin.de>
 <87zgz1pmx4.mognet@arm.com> <20210317211424.33090a37@sf>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <f06aa8f4-9dba-109e-2033-020b3de60490@physik.fu-berlin.de>
Date:   Thu, 18 Mar 2021 00:29:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210317211424.33090a37@sf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.169.102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei!

On 3/17/21 10:14 PM, Sergei Trofimovich wrote:
> Or is it just an early bootstrap message assuming more are to come?
> 
> Could it be that we initialize too little of generic acpi boilerplace
> when there is no SRAT? Somewhere around:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/ia64/kernel/acpi.c#n446
> 
> arm64 and riscv calls `arch_numa_init()` and initializes numa node
> data in numa_init().
> While ia64 only calls acpi_numa_init() but not arch_acpi_numa_init()
> (which would do numa_init() for us).
> 
> x86 seems to vaguely resemble generic code by duplicating numa_init().
> 
> (UNTESTED) Could it be that we need something like:
> 
> --- a/arch/ia64/kernel/setup.c
> +++ b/arch/ia64/kernel/setup.c
> @@ -571,7 +571,7 @@ setup_arch (char **cmdline_p)
>         acpi_table_init();
>         early_acpi_boot_init();
>  #ifdef CONFIG_ACPI_NUMA
> -       acpi_numa_init();
> +       arch_numa_init();
>         acpi_numa_fixup();
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
>         prefill_possible_map();

That doesn't build:

  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  CHK     include/generated/compile.h
  CC      arch/ia64/kernel/setup.o
  CC      arch/ia64/kernel/acpi.o
arch/ia64/kernel/setup.c: In function 'setup_arch':
arch/ia64/kernel/setup.c:574:2: error: implicit declaration of function 'arch_numa_init'; did you mean 'acpi_numa_init'? [-Werror=implicit-function-declaration]
  574 |  arch_numa_init();
      |  ^~~~~~~~~~~~~~
      |  acpi_numa_init
cc1: some warnings being treated as errors
make[1]: *** [scripts/Makefile.build:271: arch/ia64/kernel/setup.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1851: arch/ia64/kernel] Error 2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

