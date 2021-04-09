Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC8D359B6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhDIKKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:10:43 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:26372 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhDIKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:03:03 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 139A2lhm021801
        for <linux-kernel@vger.kernel.org>; Fri, 9 Apr 2021 13:02:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1617962562; x=1620554562;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WXa9Zk1u14pWpGyUOTh6z8lc5xIgB/2jhhzZywlsrbM=;
        b=I/wJR2e5YPg1JE7lEuQQJ+/4z9fwYqjufaAljkovZx1oi064jQch+zU5hVsdLmCY
        z0t3Dh7MuyZOQSMeDdhHMn/IiG0GYTHRTGFz6VjX4PvaUcWlDbcEsg9ESNPkL5ny
        tQCVm+ppmctYFNdIMJbhJXrzo88oRG2mpXMuEUgZC5z5scur25/N34Up1tsjl04Y
        O3Aq/aToMsA6+2AD/5TJrG9Fi+F+LmW4axno2mAoedlMn8TwdzIh99LtBpiYTvqw
        reZzmhs4wyZbG8ao3pc1nxOqDiEyJWoEUD5ruHbUhVCHtNZWDhM6uZGyiLHlw4LA
        BnEuPxTNMAtDqorkLkF0SQ==;
X-AuditID: 8b5b014d-a4c337000000209f-8e-6070264291d6
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id F5.00.08351.24620706; Fri,  9 Apr 2021 13:02:42 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 09 Apr 2021 13:02:41 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Rob Herring <robh@kernel.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] RISC-V: Add kexec/kdump support
Organization: FORTH
In-Reply-To: <20210407162927.GA3836121@robh.at.kernel.org>
References: <20210405085712.1953848-1-mick@ics.forth.gr>
 <20210407162927.GA3836121@robh.at.kernel.org>
Message-ID: <77c532ea311ef731b3e6f9389b3d408c@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXSHT1dWddJrSDBoO8Fl8XlXXPYLLZ9bmGz
        aH53jt3i5eUeZou2WfwW//fsYHdg83jz8iWLx8NNl5g8Nq3qZPPYvKTe41LzdXaPz5vkAtii
        uGxSUnMyy1KL9O0SuDI+zXjNVvBXueLr/geMDYxPZboYOTkkBEwkFtx7wdLFyMUhJHCUUWLz
        uhWsEAlTidl7OxlBbF4BQYmTM5+wgNjMAhYSU6/sZ4Sw5SWat85m7mLk4GARUJU49qwSJMwm
        oCkx/9JBsHIRAUWJ323TWEHmMwssY5TYeHwFM0hCWMBa4uPaQ2BF/ALCEp/uXgTbyylgJbHj
        4E9WkJlCAhkS09vEIU5wkejtv80CcZqKxIffD9hBSkSB7M1zlSYwCs5CcugsJIfOQnLoAkbm
        VYwCiWXGepnJxXpp+UUlGXrpRZsYwaHO6LuD8fbmt3qHGJk4GA8xSnAwK4nwNjfnJwjxpiRW
        VqUW5ccXleakFh9ilOZgURLn5dWbEC8kkJ5YkpqdmlqQWgSTZeLglGpgiuFZ9ObILuPb+T3V
        m3yTDy7vOnrF2kzoI0PLSuMMz7MLOHflPdl50W2Zadqsl8l79QrLL83bde3UxUcrdb8lnnTI
        Oe389sSny+lGDDMkYq4wRB6skbmVd7j2+g7BgxN+8bx9tV3Q8reMQEHhqw9p2/6+0rrDP/vq
        xdX3LP4l/a2/vUPUxHvNr9CFyUqRF27umyPPft3EbK7/j7b2LvXe1RtX3GXSbj6jqpygJuvv
        prK0bEbQpeqQTQ2J/6485o2T50hwuWX+sqw91bm7o3HS9xrWm10eR+4m3NMxLfI/2K9h8f19
        /MaU5CI+n6l5///tPiNxWmZJDBNb5N30j13f+9/5b9OJ+7dw3sf0CJN9kkosxRmJhlrMRcWJ
        AHTvokHkAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-04-07 19:29, Rob Herring έγραψε:
> On Mon, Apr 05, 2021 at 11:57:07AM +0300, Nick Kossifidis wrote:
>> This patch series adds kexec/kdump and crash kernel
>> support on RISC-V. For testing the patches a patched
>> version of kexec-tools is needed (still a work in
>> progress) which can be found at:
>> 
>> https://riscv.ics.forth.gr/kexec-tools-patched.tar.xz
>> 
>> v3:
>>  * Rebase on newer kernel tree
>>  * Minor cleanups
>>  * Split UAPI changes to a separate patch
>>  * Improve / cleanup init_resources
>>  * Resolve Palmer's comments
>> 
>> v2:
>>  * Rebase on newer kernel tree
>>  * Minor cleanups
>>  * Properly populate the ioresources tre, so that it
>>    can be used later on for implementing strict /dev/mem
>>  * Use linux,usable-memory on /memory instead of a new binding
> 
> Where? In any case, that's not going to work well with EFI support
> assuming like arm64, 'memory' is passed in UEFI structures instead of
> DT. That's why there's now a /chosen linux,usable-memory-ranges
> property.
> 

Here:
https://elixir.bootlin.com/linux/v5.12-rc5/source/drivers/of/fdt.c#L1001

The "linux,usable-memory" binding is already defined and is part of
early_init_dt_scan_memory() which we call on mm/init.c to determine
system's memory layout. It's simple, clean and I don't see a reason
to use another binding on /chosen and add extra code for this, when
we already handle it on early_init_dt_scan_memory() anyway. As for
EFI, even when enabled, we still use DT to determine system memory
layout, not EFI structures, plus I don't see how EFI is relevant
here, the bootloader in kexec's case is Linux, not EFI. BTW the /memory
node is mandatory in any case, it should exist on DT regardless of EFI,
/chosen node on the other hand is -in general- optional, and we can 
still
boot a riscv system without /chosen node present (we only require it for
the built-in cmdline to work).

Also a simple grep for "linux,usable-memory-ranges" on the latest kernel
sources didn't return anything, there is also nothing on chosen.txt, 
where
is that binding documented/implemented ?

> Isn't the preferred kexec interface the file based interface? I'd
> expect a new arch to only support that. And there's common kexec DT
> handling for that pending for 5.13.
> 

Both approaches have their pros an cons, that's why both are available, 
in no
way CONFIG_KEXEC is deprecated in favor of CONFIG_KEXEC_FILE, at least 
not as
far as I know. The main point for the file-based syscall is to support 
secure
boot, since the image is loaded by the kernel directly without any 
processing
by the userspace tools, so it can be pre-signed by the kernel's 
"vendor". On
the other hand, the kernel part is more complicated and you can't pass a 
new
device tree, the kernel needs to re-use the existing one (or modify it
in-kernel), you can only override the cmdline.

This doesn't work for our use cases in FORTH, where we use kexec not 
only to
re-boot our systems, but also to boot to a system with different hw 
layout
(e.g. FPGA prototypes or systems with FPGAs on the side), device tree 
overlays
also don't cover our use cases. To give you an idea we can 
add/remove/modify
devices, move them to another region etc and still use kexec to avoid 
going
through the full boot cycle. We just unload their drivers, perform a 
full or
partial re-programming of the FPGA from within Linux, and kexec to the 
new
system with the new device tree. The file-based syscall can't cover this
scenario, in general it's less flexible and it's only there for secure 
boot,
not for using custom-built kernels, nor custom device tree images.

Security-wise the file load syscall provides guarantees for integrity 
and
authenticity, but depending on the kernel "vendor"'s infrastructure and
signing process this may allow e.g. to load an older/vulnerable kernel 
through
kexec and get away with it, there is no check as far as I know  to make 
sure
the loaded kernel is at least as old as the running kernel, the 
assumption is
that the "vendor" will use a different signing key/cert for each kernel 
and
that you'll kexec to a kernel/crash kernel that's the same version as 
the
running one. Until we have clear guidelines on how this is meant to be 
used
and have a discussion on secure boot within RISC-V (we have something on
the TEE TG but we'll probably switch to a SIG committee for this), I 
don't
see how this feature is a priority compared to the more generic 
CONFIG_KEXEC.

Regards,
Nick
