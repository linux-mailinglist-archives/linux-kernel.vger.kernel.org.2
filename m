Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5DB45A1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhKWLrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:47:04 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:59569 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhKWLrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:47:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hz2N8002hz4xbs;
        Tue, 23 Nov 2021 22:43:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1637667834;
        bh=qqAD2VWLEMQH+phv8NFveP7U5VFKxU4q6PVtjKnS8RM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o7yGcV4y24HPIbff4/mau/++TJPX2G5JyZzP24CzskPLwE6AfqH4X+r28t0zNNPer
         dAVnCmuEQDTgKNAoUbIc18WEmpf7OgSDLPgnAWRdcHrNTnCX6FE2vlB4ZKWqadINvn
         Y85q+X9KzllvXcCMNjTsV6C7TyxlzRxhCGPf90Jgzay6un4erkBIyIbKGhXFNgdEi7
         OrR7L58tK3q52DIBiYrJza+RQFSY8zvH02d8GCbbijgGQT3CrIpfF7/LOZhS0F0be6
         QtLst+/YHkcIENxkWMQRnkGn1AnFMFk4yP1I1IBCdkwfBdNFE1lVFUPbt8/de9M8U0
         3yVOy07r4y6Dw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] fs: ntfs: Disable NTFS_RW for PPC
In-Reply-To: <b63d1758-b434-93c3-164c-b536c7437bdf@roeck-us.net>
References: <20211122230653.1779162-1-linux@roeck-us.net>
 <CACPK8XfM1e7b6m_QBhJFgXCXhqOajMKGUkWqRGxa5sCKyLxRQg@mail.gmail.com>
 <b63d1758-b434-93c3-164c-b536c7437bdf@roeck-us.net>
Date:   Tue, 23 Nov 2021 22:43:48 +1100
Message-ID: <87a6hvqeq3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:
> On 11/22/21 5:15 PM, Joel Stanley wrote:
>> On Mon, 22 Nov 2021 at 23:58, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> NTFS_RW code allocates page size dependent arrays on the stack. This
>>> results in build failures if the page size is 64k, which is now the
>>> default for PPC.
>> 
>> It became the default for PPC_BOOK3S_64, which doesn't include all of
>> PPC, in f22969a66041 ("powerpc/64s: Default to 64K pages for 64 bit
>> book3s").
>> 
>> You might want to add a mention of this commit in your commit message.
>> 
>>>
>>> fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
>>> fs/ntfs/aops.c:1311:1: error:
>>>          the frame size of 2240 bytes is larger than 2048 bytes
>>>
>>> Increasing the maximum frame size for PPC just to silence this error does
>>> not really help. It would have to be set to a really large value for 256k
>>> pages. Such a large frame size could potentially result in stack overruns
>>> in this code and elsewhere and is therefore not desirable. Disable NTFS_RW
>>> for PPC instead.
>>>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> v2: Introduce new configuration flag DISABLE_NTFS_RW and use it to disable NTFS_RW
>>>      for PPC
>>>
>>>   fs/ntfs/Kconfig | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
>>> index 1667a7e590d8..324224febb6a 100644
>>> --- a/fs/ntfs/Kconfig
>>> +++ b/fs/ntfs/Kconfig
>>> @@ -49,8 +49,13 @@ config NTFS_DEBUG
>>>            When reporting bugs, please try to have available a full dump of
>>>            debugging messages while the misbehaviour was occurring.
>>>
>>> +config DISABLE_NTFS_RW
>>> +       bool
>>> +       default y if PPC
>> 
>> PPC_64K_PAGES would be more accurate.
>> 
>> I think arm64 was seeing a similar build error, so you could include
>> ARM64_64K_PAGES as well?
>> 
> Yes, you are correct.
>
> fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
> fs/ntfs/aops.c:1311:1: error: the frame size of 2608 bytes is larger than 2048 bytes
>
> Ok, I'll do that. And, digging for it, I see
>
> config VMXNET3
>          tristate "VMware VMXNET3 ethernet driver"
>          depends on PCI && INET
>          depends on !(PAGE_SIZE_64KB || ARM64_64K_PAGES || \
>                       IA64_PAGE_SIZE_64KB || PARISC_PAGE_SIZE_64KB || \
>                       PPC_64K_PAGES)
>
> That adds hexagon, ia64, mips, parisc, and sh to the list of affected architectures.
> Plus, of course, there is PAGE_SIZE_256KB and PPC_256K_PAGES.
>
> So we are looking for something like
>
> config DISABLE_NTFS_RW
> 	bool
> 	default y if PAGE_SIZE_256KB || PPC_256K_PAGES || \
> 		PAGE_SIZE_64KB || ARM64_64K_PAGES || IA64_PAGE_SIZE_64KB || \
> 		PARISC_PAGE_SIZE_64KB || PPC_64K_PAGES
>
> Anything else ?

Can we do something like this instead?

I'm pretty sure it does what we want for NTFS, and also for VMXNET3.

It is not pretty, but at least keeps the arch specifics out of driver
Kconfigs.

cheers


diff --git a/arch/Kconfig b/arch/Kconfig
index 26b8ed11639d..d3c4ab249e9c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -991,6 +991,16 @@ config HAVE_ARCH_COMPAT_MMAP_BASES
 	  and vice-versa 32-bit applications to call 64-bit mmap().
 	  Required for applications doing different bitness syscalls.
 
+config PAGE_SIZE_LESS_THAN_64KB
+	def_bool y
+	depends on !ARM64_64K_PAGES
+	depends on !IA64_PAGE_SIZE_64KB
+	depends on !PAGE_SIZE_64KB
+	depends on !PARISC_PAGE_SIZE_64KB
+	depends on !PPC_64K_PAGES
+	depends on !PPC_256K_PAGES
+	depends on !PAGE_SIZE_256KB
+
 # This allows to use a set of generic functions to determine mmap base
 # address by giving priority to top-down scheme only if the process
 # is not in legacy mode (compat task, unlimited stack size or
diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
index 1667a7e590d8..f93e69a61283 100644
--- a/fs/ntfs/Kconfig
+++ b/fs/ntfs/Kconfig
@@ -52,6 +52,7 @@ config NTFS_DEBUG
 config NTFS_RW
 	bool "NTFS write support"
 	depends on NTFS_FS
+	depends on PAGE_SIZE_LESS_THAN_64KB
 	help
 	  This enables the partial, but safe, write support in the NTFS driver.
 
