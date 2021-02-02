Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8665930B613
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 04:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhBBDwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 22:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhBBDv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:51:59 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D959AC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 19:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ULgMFWwk3TvS5KArsELEwceUudzpxXJ2XabGwJIlDsw=; b=1KJd+oZWsqE3ryTB2rApTwsozI
        cCXW5V1d7iCAc2pVHteHzrSBZnLuDOfm3Ek4+eV6euwXjkaO1Taei1Dh9JBHf07JUHtRm0sav3Ye0
        r5RQQRUkPh8PN8mdwVY7htTUFhi19odDK0WUfg+opzYowC0d9U4+XxjEfPI03QFR7FdDZA8xsXutc
        YR8NheeSiBB9jD2UdZmRUHo83waguigTXs3T6TjUUlaSP/AEcZJNkhlfB4OrWdK16HLpJTx4N9pvc
        ICvuYh9EtT+9x5uhDowmxwYadNlS8Pb9ZZInrgPrCKVPhKVrnf4fYisiAK3XOhUMwvJCF32Zr4JVj
        w79OR71w==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6mie-0001Mo-1C; Tue, 02 Feb 2021 03:51:12 +0000
Subject: Re: [PATCH] arch_numa: fix common code printing of phys_addr_t
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com,
        Atish Patra <Atish.Patra@wdc.com>
References: <mhng-ea6bdfae-f473-448f-80df-5042b2a5cf83@palmerdabbelt-glaptop>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0d6fb1da-6b14-7f54-3f4c-4697c88a14f7@infradead.org>
Date:   Mon, 1 Feb 2021 19:51:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <mhng-ea6bdfae-f473-448f-80df-5042b2a5cf83@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 7:36 PM, Palmer Dabbelt wrote:
> On Wed, 27 Jan 2021 19:55:33 PST (-0800), rdunlap@infradead.org wrote:
>> Fix build warnings in the arch_numa common code:
>>
>> ../include/linux/kern_levels.h:5:18: warning: format '%Lx' expects argument of type 'long long unsigned int', but argument 3 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
>> ../drivers/base/arch_numa.c:360:56: note: format string is defined here
>>   360 |    pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
>> ../drivers/base/arch_numa.c:435:39: note: format string is defined here
>>   435 |  pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n", start, end - 1);
>>
>> Fixes: ae3c107cd8be ("numa: Move numa implementation to common code")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Atish Patra <atish.patra@wdc.com>
>> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
>> ---
>>  drivers/base/arch_numa.c |   13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> --- linux-next-20210125.orig/drivers/base/arch_numa.c
>> +++ linux-next-20210125/drivers/base/arch_numa.c
>> @@ -355,11 +355,12 @@ static int __init numa_register_nodes(vo
>>      /* Check that valid nid is set to memblks */
>>      for_each_mem_region(mblk) {
>>          int mblk_nid = memblock_get_region_node(mblk);
>> +        phys_addr_t start = mblk->base;
>> +        phys_addr_t end = mblk->base + mblk->size - 1;
>>
>>          if (mblk_nid == NUMA_NO_NODE || mblk_nid >= MAX_NUMNODES) {
>> -            pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
>> -                mblk_nid, mblk->base,
>> -                mblk->base + mblk->size - 1);
>> +            pr_warn("Warning: invalid memblk node %d [mem %pap-%pap]\n",
>> +                mblk_nid, &start, &end);
>>              return -EINVAL;
>>          }
>>      }
>> @@ -427,14 +428,14 @@ out_free_distance:
>>  static int __init dummy_numa_init(void)
>>  {
>>      phys_addr_t start = memblock_start_of_DRAM();
>> -    phys_addr_t end = memblock_end_of_DRAM();
>> +    phys_addr_t end = memblock_end_of_DRAM() - 1;
>>      int ret;
>>
>>      if (numa_off)
>>          pr_info("NUMA disabled\n"); /* Forced off on command line. */
>> -    pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n", start, end - 1);
>> +    pr_info("Faking a node at [mem %pap-%pap]\n", &start, &end);
>>
>> -    ret = numa_add_memblk(0, start, end);
>> +    ret = numa_add_memblk(0, start, end + 1);
>>      if (ret) {
>>          pr_err("NUMA init failed\n");
>>          return ret;
> 
> Thanks, this is on for-next.  Did you, by any chance, find %Lx documented
> anywhere?  It's not ISO C and the GCC source code says it's a GNU extension,
> but I couldn't find it in the documentation (or even where to add it, which I
> guess is how I forgot to send my version fo the patch).

'man sprintf' says this:

       As  a nonstandard extension, the GNU implementations treats ll and L as
       synonyms, so that one can, for example, write llg (as a synonym for the
       standards-compliant  Lg) and Ld (as a synonym for the standards compli-
       ant lld).  Such usage is nonportable.


and linux/lib/vsprintf.c has some handling for it:

	if (qualifier == 'L')
		spec->type = FORMAT_TYPE_LONG_LONG;

and

		case 'L':
			if (is_sign)
				*va_arg(args, long long *) = val.s;
			else
				*va_arg(args, unsigned long long *) = val.u;
			break;


Does that help?

-- 
~Randy

