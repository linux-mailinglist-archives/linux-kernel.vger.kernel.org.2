Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D799A3A2833
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhFJJYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhFJJYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623316935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A78UCyddoxVj3LRURmRZUmZxc6MPDgeQuh2wS7Aw9y0=;
        b=Pld09SMZa7GTX/1WpS3QlV3H7+yMVv8iM16wduaML63+aIzJxSs6RucAhXJqS/OwdwnDFi
        HDaHCylfPJ56TG5Tw718Ieji4XdNQtjA5Jh/UC/fqh6RIMK0gwcQhpqKwpW4b0Mk0JI79T
        H0+ENWPkpeffK+tUkfPjLdVEQ7msgGI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-L46q3701O7uuIagvccVFZw-1; Thu, 10 Jun 2021 05:22:11 -0400
X-MC-Unique: L46q3701O7uuIagvccVFZw-1
Received: by mail-wr1-f70.google.com with SMTP id n4-20020a5d42040000b0290119fef97609so586129wrq.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=A78UCyddoxVj3LRURmRZUmZxc6MPDgeQuh2wS7Aw9y0=;
        b=NtcKAx2MgFQwWgNtJP1WDZiM2fcOLvtHDV8gDVddtFjTPhh3qcGcbaTaxAR0a+dIqp
         v2jGcl61n4JoUUgNu9b1KC7W7lG2MtYNV+rvdV5MjEQaCgbL9e9mcspTgxykU0ryQBqQ
         ionkDf//MhWzh7nTuftAel4EVVVIa+f+McyhKpa6FXdzOU5GUuYAIcYG+8UIwXMCfYKc
         abPHh+lg5C+iBcVn/XcIygUYArclfrCtaFwP12msiOdOI0WM3aqMkow4Yofpj1Znz6DZ
         6co2Zr2S5PfYKXF6g6AS6leK4L1m4/Z0/i6jhP6k28z3hmWKrSe11sLZZWvPgIHxT9J0
         L+7g==
X-Gm-Message-State: AOAM530SJGpgUHKIDlO6yjKHgx+jY92sYiGySHp8fJ8JRMyq4EqG2ir0
        9zjnEkSR5r5P13rMFPZsJT5a6r0cICaUbIYZvT28xDEg/ItY0GLXmovJFjAmd9tx1E7+xpwjqbh
        ZIooOsSr4Dk/JrTnoTa0T02XE
X-Received: by 2002:a05:6000:1365:: with SMTP id q5mr4296008wrz.53.1623316930268;
        Thu, 10 Jun 2021 02:22:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo0K8dEKKmGBNIzZTAkSjYM+nE1iWqCoR4BRg6JLPFlpIk8f9MQqIUP671DqB+hCjLUJSbuA==
X-Received: by 2002:a05:6000:1365:: with SMTP id q5mr4295985wrz.53.1623316930022;
        Thu, 10 Jun 2021 02:22:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l13sm2939323wrz.34.2021.06.10.02.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:22:09 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, ligrassi@microsoft.com, kys@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 00/19] Microsoft Hypervisor root partition ioctl interface
In-Reply-To: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
Date:   Thu, 10 Jun 2021 11:22:08 +0200
Message-ID: <87bl8eyszj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:

> This patch series provides a userspace interface for creating and running guest
> virtual machines while running on the Microsoft Hypervisor [0].
>
> Since managing guest machines can only be done when Linux is the root partition,
> this series depends on Wei Liu's patch series merged in 5.12:
> https://lore.kernel.org/linux-hyperv/20210203150435.27941-1-wei.liu@kernel.org/
>
> The first two patches provide some helpers for converting hypervisor status
> codes to linux error codes, and printing hypervisor status codes to dmesg for
> debugging.
>
> Hyper-V related headers asm-generic/hyperv-tlfs.h and x86/asm/hyperv-tlfs.h are
> split into uapi and non-uapi. The uapi versions contain structures used in both
> the ioctl interface and the kernel.
>
> The mshv API is introduced in drivers/hv/mshv_main.c. As each interface is
> introduced, documentation is added in Documentation/virt/mshv/api.rst.
> The API is file-desciptor based, like KVM. The entry point is /dev/mshv.
>
> /dev/mshv ioctls:
> MSHV_CHECK_EXTENSION
> MSHV_CREATE_PARTITION
>
> Partition (vm) ioctls:
> MSHV_MAP_GUEST_MEMORY, MSHV_UNMAP_GUEST_MEMORY
> MSHV_INSTALL_INTERCEPT
> MSHV_ASSERT_INTERRUPT
> MSHV_GET_PARTITION_PROPERTY, MSHV_SET_PARTITION_PROPERTY
> MSHV_CREATE_VP
>
> Vp (vcpu) ioctls:
> MSHV_GET_VP_REGISTERS, MSHV_SET_VP_REGISTERS
> MSHV_RUN_VP
> MSHV_GET_VP_STATE, MSHV_SET_VP_STATE
> MSHV_TRANSLATE_GVA
> mmap() (register page)
>
> [0] Hyper-V is more well-known, but it really refers to the whole stack
>     including the hypervisor and other components that run in Windows kernel
>     and userspace.
>
> Changes since RFC:
> 1. Moved code from virt/mshv to drivers/hv
> 2. Split hypercall helper functions and synic code to hv_call.c and hv_synic.c
> 3. MSHV_REQUEST_VERSION ioctl replaced with MSHV_CHECK_EXTENSION
> 3. Numerous suggestions, fixes, style changes, etc from Michael Kelley, Vitaly
>    Kuznetsov, Wei Liu, and Vineeth Pillai
> 4. Added patch to enable hypervisor enlightenments on partition creation
> 5. Added Wei Liu's patch for GVA to GPA translation
>

Thank you for addressing these!

One nitpick though: could you please run your next submission through
'scripts/checkpatch.pl'? It reports a number of issues here, mostly
minor but still worth addressing, i.e.:

$ scripts/checkpatch.pl *.patch
...
---------------------------------------------------------------
0002-asm-generic-hyperv-convert-hyperv-statuses-to-string.patch
---------------------------------------------------------------
ERROR: Macros with complex values should be enclosed in parentheses
#95: FILE: include/asm-generic/hyperv-tlfs.h:192:
+#define __HV_STATUS_DEF(OP) \
+	OP(HV_STATUS_SUCCESS,				0x0) \
...

ERROR: Macros with complex values should be enclosed in parentheses
#119: FILE: include/asm-generic/hyperv-tlfs.h:216:
+#define __HV_MAKE_HV_STATUS_ENUM(NAME, VAL) NAME = (VAL),

ERROR: Macros with multiple statements should be enclosed in a do - while loop
#120: FILE: include/asm-generic/hyperv-tlfs.h:217:
+#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);

WARNING: Macros with flow control statements should be avoided
#120: FILE: include/asm-generic/hyperv-tlfs.h:217:
+#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);

WARNING: macros should not use a trailing semicolon
#120: FILE: include/asm-generic/hyperv-tlfs.h:217:
+#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);

total: 3 errors, 2 warnings, 108 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0002-asm-generic-hyperv-convert-hyperv-statuses-to-string.patch has
style problems, please review.
...
-------------------------------------------
0004-drivers-hv-check-extension-ioctl.patch
-------------------------------------------
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#36: 
new file mode 100644

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#131: FILE: drivers/hv/mshv_main.c:52:
+	return -ENOTSUPP;

total: 0 errors, 2 warnings, 137 lines checked

...

WARNING: Improper SPDX comment style for 'drivers/hv/hv_call.c', please use '//' instead
#94: FILE: drivers/hv/hv_call.c:1:
+/* SPDX-License-Identifier: GPL-2.0-only */

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#94: FILE: drivers/hv/hv_call.c:1:
+/* SPDX-License-Identifier: GPL-2.0-only */

ERROR: "(foo*)" should be "(foo *)"
#178: FILE: drivers/hv/hv_call.c:85:
+				*(u64*)&input);

ERROR: "(foo*)" should be "(foo *)"
#201: FILE: drivers/hv/hv_call.c:108:
+			*(u64*)&input);

ERROR: "(foo*)" should be "(foo *)"
#215: FILE: drivers/hv/hv_call.c:122:
+	status = hv_do_fast_hypercall8(HVCALL_DELETE_PARTITION, *(u64*)&input);

total: 3 errors, 3 warnings, 330 lines checked

...
------------------------------------------------
0008-drivers-hv-map-and-unmap-guest-memory.patch
------------------------------------------------
ERROR: code indent should use tabs where possible
#101: FILE: drivers/hv/hv_call.c:222:
+                                                    HV_MAP_GPA_DEPOSIT_PAGES);$

WARNING: please, no spaces at the start of a line
#101: FILE: drivers/hv/hv_call.c:222:
+                                                    HV_MAP_GPA_DEPOSIT_PAGES);$

ERROR: code indent should use tabs where possible
#469: FILE: include/asm-generic/hyperv-tlfs.h:895:
+        u32 padding;$

WARNING: please, no spaces at the start of a line
#469: FILE: include/asm-generic/hyperv-tlfs.h:895:
+        u32 padding;$

ERROR: code indent should use tabs where possible
#477: FILE: include/asm-generic/hyperv-tlfs.h:903:
+        u32 padding;$

WARNING: please, no spaces at the start of a line
#477: FILE: include/asm-generic/hyperv-tlfs.h:903:
+        u32 padding;$

total: 3 errors, 3 warnings, 487 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

0008-drivers-hv-map-and-unmap-guest-memory.patch has style problems, please review.
---------------------------------------
0009-drivers-hv-create-vcpu-ioctl.patch
---------------------------------------
WARNING: Missing a blank line after declarations
#76: FILE: drivers/hv/mshv_main.c:75:
+	struct mshv_vp *vp = filp->private_data;
+	mshv_partition_put(vp->partition);

ERROR: trailing whitespace
#180: FILE: drivers/hv/mshv_main.c:376:
+^I$

total: 1 errors, 1 warnings, 210 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

0009-drivers-hv-create-vcpu-ioctl.patch has style problems, please review.
-------------------------------------------------------
0010-drivers-hv-get-and-set-vcpu-registers-ioctls.patch
-------------------------------------------------------
WARNING: braces {} are not necessary for single statement blocks
#690: FILE: drivers/hv/hv_call.c:326:
+		for (i = 0; i < rep_count; ++i) {
+			input_page->names[i] = registers[i].name;
+		}

WARNING: braces {} are not necessary for single statement blocks
#704: FILE: drivers/hv/hv_call.c:340:
+		for (i = 0; i < completed; ++i) {
+			registers[i].value = output_page[i];
+		}

WARNING: braces {} are not necessary for single statement blocks
#859: FILE: drivers/hv/mshv_main.c:121:
+	if (!registers) {
+		return -ENOMEM;
+	}

total: 0 errors, 3 warnings, 965 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0010-drivers-hv-get-and-set-vcpu-registers-ioctls.patch has style problems, please review.
---------------------------------------------------------------
0011-drivers-hv-set-up-synic-pages-for-intercept-messages.patch
---------------------------------------------------------------
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#274: 
new file mode 100644

ERROR: code indent should use tabs where possible
#310: FILE: drivers/hv/hv_synic.c:32:
+                             MEMREMAP_WB);$

WARNING: please, no spaces at the start of a line
#310: FILE: drivers/hv/hv_synic.c:32:
+                             MEMREMAP_WB);$

total: 1 errors, 2 warnings, 574 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

0011-drivers-hv-set-up-synic-pages-for-intercept-messages.patch has style problems, please review.
------------------------------------------
0012-drivers-hv-run-vp-ioctl-and-isr.patch
------------------------------------------
WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#86: FILE: arch/x86/kernel/cpu/mshyperv.c:77:
+EXPORT_SYMBOL_GPL(hv_remove_mshv_irq);

WARNING: consider using a completion
#410: FILE: drivers/hv/mshv_main.c:344:
+	sema_init(&vp->run.sem, 0);

total: 0 errors, 2 warnings, 435 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0012-drivers-hv-run-vp-ioctl-and-isr.patch has style problems, please review.
---------------------------------------------
...
-------------------------------------------
0016-drivers-hv-mmap-vp-register-page.patch
-------------------------------------------
WARNING: Missing a blank line after declarations
#222: FILE: drivers/hv/mshv_main.c:441:
+	struct mshv_vp *vp = vmf->vma->vm_file->private_data;
+	vmf->page = vp->register_page;

total: 0 errors, 1 warnings, 257 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0016-drivers-hv-mmap-vp-register-page.patch has style problems, please review.
-----------------------------------------------------------
0017-drivers-hv-get-and-set-partition-property-ioctls.patch
-----------------------------------------------------------
ERROR: code indent should use tabs where possible
#205: FILE: include/asm-generic/hyperv-tlfs.h:890:
+        u32 padding;$

WARNING: please, no spaces at the start of a line
#205: FILE: include/asm-generic/hyperv-tlfs.h:890:
+        u32 padding;$

ERROR: code indent should use tabs where possible
#215: FILE: include/asm-generic/hyperv-tlfs.h:900:
+        u32 padding;$

WARNING: please, no spaces at the start of a line
#215: FILE: include/asm-generic/hyperv-tlfs.h:900:
+        u32 padding;$

total: 2 errors, 2 warnings, 258 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile


-- 
Vitaly

