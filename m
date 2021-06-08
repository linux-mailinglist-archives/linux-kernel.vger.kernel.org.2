Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2E73A07CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhFHXep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhFHXeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:34:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 16:32:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h12so199578plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 16:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O72AWa9VkoAUETAw2NPPa7YXWB4emA9mrECefmej4pE=;
        b=RtGFDqUtfEi1Yb1mAgGHXrjH2pOvarlzlxA5OrxwBxzGBRt1YlUi6H9WTOfmBxl0OG
         JXd8Qfa/RgjeqLIl9JY63WviZ10IsYVBMi8+5OvDCri5fyiHvawybXpnrYNULv5SPjbo
         QCso5on6yXUD147PxFyr6F+cJnnBl3LDLMUMadI3EKDhOVe364kxcUGPyK/GDEjUCAXK
         RhFaeT38DHLzL+LWQp0es7h99vjvumMoO0nyIxcQXZAQ7z/dQCMq6ejX+CzTJo/JFk8z
         iRS7JZtVZyndDBe/7b69pF4ROPadq0jXjUxSBcKkrOa6K8W1wma7pCFrdjkcv45C9z9H
         ym4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O72AWa9VkoAUETAw2NPPa7YXWB4emA9mrECefmej4pE=;
        b=gjdIREouer9nhe7rDgW9LPaj8jfA1vBwFNe507KzJSUDyXyLl0z8ujBaSYAvKbcF2a
         fPhYkMTIlro4lDv9QyHj3G0U1SckYUtoQ0ztgDgUUklSQhvNgG+gDJxqK335pqUEi4hU
         wUix5jhTF7kcciq977liudAWlVpOllim4u0q1DVNjiKSn0RgMY+FeKKvdXU/R55SZ/Vm
         QfV25qTLZsXem3RQ5fVJmttWB11bsuoSKQQ7G2HhbrwnpppJd5Yjq+ogzBdQChl6dE/t
         AxBbxD/3L0y2Zpy1335AOOO78+mzTdsycKIdInV/+tyiM8oLFHn7d3EVoJjCN2GjD6G7
         X6hQ==
X-Gm-Message-State: AOAM533MdHVXA18nk48kg3VbgU0/n15CQLbZg9JELWaFSnyDd34LscF2
        2xRQjVxITpIoBHTR7DxxvTpghDBKsJ0Y5CqyvfQb8Q==
X-Google-Smtp-Source: ABdhPJwqsxPWhoYg0xX90PeesZ/6DyrhBNVBKeS+U70AKNCpyT7RXgCJiRkQTUmsGc8MLvhWUBFB9E7kzOUMLIYwnVg=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr7535870pjb.13.1623195170725;
 Tue, 08 Jun 2021 16:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
 <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 16:32:39 -0700
Message-ID: <CAPcyv4hoxc2+50EOFuq8NOa_CBFKX_A549Vw4U24V5SG25ftxQ@mail.gmail.com>
Subject: Re: [RFC v2-fix-v3 1/1] x86/tdx: Skip WBINVD instruction for TDX guest
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 2:35 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Current TDX spec does not have support to emulate the WBINVD
> instruction. So, add support to skip WBINVD instruction in
> drivers that are currently enabled in the TDX guest.
>
> Functionally only devices outside the CPU (such as DMA devices,
> or persistent memory for flushing) can notice the external side
> effects from WBINVD's cache flushing for write back mappings.
> One exception here is MKTME, but that is not visible outside
> the TDX module and not possible inside a TDX guest.
>
> Currently TDX does not support DMA, because DMA typically needs
> uncached access for MMIO, and the current TDX module always
> sets the IgnorePAT bit, which prevents that.
>
> Persistent memory is also currently not supported. Another code
> path that uses WBINVD is the MTRR driver, but EPT/virtualization
> always disables MTRRs so those are not needed. This all implies
> WBINVD is not needed with current TDX.

Let's drop the last three paragraphs and just say something like:
"This is one of a series of patches to usages of wbinvd for protected
guests. For now this just addresses the one known path that TDX
executes, ACPI reboot. Its usage can be elided because FOO reason and
all the other ACPI_FLUSH_CPU_CACHE usages can be elided because BAR
reason"

>
> So, most drivers/code-paths that use wbinvd instructions are
> already disabled for TDX guest platforms via config-option/BIOS.
> Following are the list of drivers that use wbinvd instruction
> and are still enabled for TDX guests.
>
> drivers/acpi/sleep.c
> drivers/acpi/acpica/hwsleep.c
>
> Since cache is always coherent in TDX guests, making wbinvd as
> noop should not cause any issues. This behavior is the same as
> KVM guest.
>
> Also, hwsleep shouldn't happen for TDX guest because the TDX
> BIOS won't enable it, but it's better to disable it anyways
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>
> Changes since RFC v2-fix-v2:
>  * Instead of handling WBINVD #VE exception as nop, we skip its
>    usage in currently enabled drivers.
>  * Adapted commit log for above change.
>
>  arch/x86/kernel/tdx.c           |  1 +
>  drivers/acpi/acpica/hwsleep.c   | 12 +++++++++---
>  drivers/acpi/sleep.c            | 26 +++++++++++++++++++++++---
>  include/linux/protected_guest.h |  2 ++
>  4 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 1caf9fa5bb30..e33928131e6a 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -100,6 +100,7 @@ bool tdx_protected_guest_has(unsigned long flag)
>         case PR_GUEST_MEM_ENCRYPT_ACTIVE:
>         case PR_GUEST_UNROLL_STRING_IO:
>         case PR_GUEST_SHARED_MAPPING_INIT:
> +       case PR_GUEST_DISABLE_WBINVD:
>                 return true;
>         }
>
> diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
> index 14baa13bf848..9d40df1b8a74 100644
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -9,6 +9,7 @@
>   *****************************************************************************/
>
>  #include <acpi/acpi.h>
> +#include <linux/protected_guest.h>
>  #include "accommon.h"
>
>  #define _COMPONENT          ACPI_HARDWARE
> @@ -108,9 +109,14 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
>         pm1a_control |= sleep_enable_reg_info->access_bit_mask;
>         pm1b_control |= sleep_enable_reg_info->access_bit_mask;
>
> -       /* Flush caches, as per ACPI specification */
> -
> -       ACPI_FLUSH_CPU_CACHE();
> +       /*
> +        * WBINVD instruction is not supported in TDX
> +        * guest. Since ACPI_FLUSH_CPU_CACHE() uses
> +        * WBINVD, skip cache flushes for TDX guests.
> +        */
> +       if (prot_guest_has(PR_GUEST_DISABLE_WBINVD))
> +               /* Flush caches, as per ACPI specification */
> +               ACPI_FLUSH_CPU_CACHE();

ACPICA uses OS abstractions like ACPI_FLUSH_CPU_CACHE and Linux
patches rarely (never?) change ACPICA directly. If you want to change
ACPICA it goes through the ACPICA project first and is then
"Linux-ized", but in this case I believe you do not need to go that
path. Instead, this wants to change the definition of
ACPI_FLUSH_CPU_CACHE() directly in arch/x86/include/asm/acenv.h and
explain why the other ACPI cache flushing paths / requirements do not
apply to TDX guests.
