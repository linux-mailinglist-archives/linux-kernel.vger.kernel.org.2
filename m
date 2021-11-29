Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0369C460D05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 04:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbhK2DN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 22:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241563AbhK2DL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 22:11:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC42C06175A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=OVoXXnrDjTAaeBFRj8Gcc2JXynTRFEq41ESvrncKtQ0=; b=DoEjRIXzijeTMmgr+zrVjWGsYs
        vrsDED/QZLgaLfCCmMwqLIcVUYaNqPC28MEQVTpabukg7BeJkcLVHdqe5TBc8X3p7z7ERpPLhx1Yi
        vI+jIXW9NON7x/niua7foYi/HUcaoAxxtXJm21dVLFl259PL3v4zLZ38ak8pOsqV/kQEyyCpwjMHv
        x+gO4Ag9fCZ6bA4tJ+edejsLleK7pCGaGcJaUQGp5ih4CMBvK18aykqoe+wjsFtgIucSSIaQBze2R
        M+e1d2F3XX75pEKWkJN2u+AevFUOpjrl5gIQSAmx9GINLAavO7bVW4A4ZHdwNEdM89flKhRnNHNkl
        K+chkQiQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrX0Z-005U28-NS; Mon, 29 Nov 2021 03:07:12 +0000
Message-ID: <09df5c2a-8e03-8afd-ffe3-628dcd326497@infradead.org>
Date:   Sun, 28 Nov 2021 19:07:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Linux 5.16-rc3
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <CAHk-=wgtC_D-irsmyC89JPE1mnAAGJTc8qaNwaqcNUrt66TDMw@mail.gmail.com>
 <20211129015909.GA921717@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211129015909.GA921717@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/21 17:59, Guenter Roeck wrote:
> On Sun, Nov 28, 2021 at 02:21:20PM -0800, Linus Torvalds wrote:
>> So rc3 is usually a bit larger than rc2 just because people had some
>> time to start finding things.
>>
>> So too this time, although it's not like this is a particularly big
>> rc3. Possibly partly due to the past week having been Thanksgiving
>> week here in the US. But the size is well within the normal range, so
>> if that's a factor, it's not been a big one.
>>
>> The diff for rc3 is mostly drivers, although part of that is just
>> because of the removal of a left-over MIPS Netlogic driver which makes
>> the stats look a bit wonky, and is over a third of the whole diff just
>> in itself.
>>
>> If you ignore that part, the statistics look a bit more normal, but
>> drivers still dominate (network drivers, sound and gpu are the big
>> ones, but there is noise all over). Other than that there's once again
>> a fair amount of selftest (mostly networking), along with core
>> networking, some arch updates - the bulk of it from a single arm64
>> uaccess patch, although that's mostly because it's all pretty small -
>> and random other changes.
>>
>> Full shortlog below.
>>
>> Please test,
>>
> 
> Build results:
> 	total: 153 pass: 152 fail: 1
> Failed builds:
> 	mips:allmodconfig
> Qemu test results:
> 	total: 482 pass: 482 fail: 0
> 
> Building mips:allmodconfig ... failed
> --------------
> Error log:
> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> 
> There is still no fix for the mips:allmodconfig build problem as far
> as I can see. It is a bit odd, because the fix would be as simple as
> 
>   config PCIE_MT7621
> -	tristate "MediaTek MT7621 PCIe Controller"
> -	depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> +	bool "MediaTek MT7621 PCIe Controller"
> +	depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
>   	select PHY_MT7621_PCI
>   	default SOC_MT7621
>   	help
> 
> Context: tristate doesn't make sense here because both RALINK and
> SOC_MT7621 are bool. Also, RALINK is redundant because SOC_MT7621
> already depends on it. The compile failure is due to missing exported
> symbols, and it is only seen if PCIE_MT7621=m - which is only possible
> if COMPILE_TEST=y. In other words, the dependencies above are set such
> that test builds, and only test builds, fail.
> 
> The problem was introduced with commit 2bdd5238e756 ("PCI: mt7621:
> Add MediaTek MT7621 PCIe host controller driver"). Copying some of
> those responsible to see if we can expect a solution sometime soon.


I sent a patch for this a couple of weeks ago and Sergio replied to it
here:

https://lore.kernel.org/linux-pci/CAMhs-H8TA0S23FjSRKGKeKAWWdUxET6YnivLQoFuy_fSVJOPXw@mail.gmail.com/

saying that is a different patch out there but that it had not
been reviewed yet.

-- 
~Randy
