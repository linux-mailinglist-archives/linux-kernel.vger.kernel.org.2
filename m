Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF93746F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhEERdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbhEERbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:31:43 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ECEC04954A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 09:59:01 -0700 (PDT)
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.43/8.16.0.43) with SMTP id 145Gwdee009776;
        Wed, 5 May 2021 17:58:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=9CBW6Wth5Dp4Mxt53x/HFECIqMBZ1wpsufkMs+1r7FQ=;
 b=imynDeR4RPjwcr3ZT5pt3pQJekN1FElqNKQESE6IrAVBYsELFoFIhpnq0IPWa4wvKaKW
 dIGfPSZDUUI9fPnW+8Nj4hcehGitCmTB6KY0fNSfXG18/Qc4BsB/bwRYml0aIeksVOeh
 tmPOPQoCfpifS1297WuTWEOg2vZeos8Cng5d0xRJWUDVTKaaeRTCE11uJ2g1U/D719mb
 Qk/EvcCZVBYR3Fh1WGdUFL9nIhfW8av7GMIoak5xElqi3xPB9M/qg13oOT59sMhJtArB
 kCU6zlXesVGz0I1VnQqw8lAf6JjO5lWEh21GYT9J0ZlwxjBf6yxvIl6sqHsXO/aOkktO uA== 
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 38bebmnenq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 17:58:39 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 145Gmrfu018275;
        Wed, 5 May 2021 12:58:32 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
        by prod-mail-ppoint4.akamai.com with ESMTP id 38bebh0414-1;
        Wed, 05 May 2021 12:58:32 -0400
Received: from [0.0.0.0] (unknown [172.27.119.138])
        by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id D1D3657B;
        Wed,  5 May 2021 16:58:31 +0000 (GMT)
Subject: Re: [PATCH 2/2] x86/e820: Use pr_debug to avoid spamming dmesg log
 with debug messages
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
 <6d55670d-2f06-d768-699f-5a79cece6ce0@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <d181b674-66fb-1719-e3c6-e4217cf5519c@akamai.com>
Date:   Wed, 5 May 2021 12:58:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6d55670d-2f06-d768-699f-5a79cece6ce0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050116
X-Proofpoint-GUID: t2ZvBqs1wZuOjLMFPGeAJl_nE-Y-PXuP
X-Proofpoint-ORIG-GUID: t2ZvBqs1wZuOjLMFPGeAJl_nE-Y-PXuP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050117
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 72.247.45.32)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/21 3:40 PM, Heiner Kallweit wrote:
> e820 emits quite some debug messages to the dmesg log. Let's restrict
> this to cases where the debug output is actually requested. Switch to
> pr_debug() for this purpose and make sure by checking the return code
> that pr_cont() is only called if applicable.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  arch/x86/kernel/e820.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index bc0657f0d..67ad4d8f0 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -465,6 +465,7 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>  	u64 end;
>  	unsigned int i;
>  	u64 real_updated_size = 0;
> +	int printed;
>  
>  	BUG_ON(old_type == new_type);
>  
> @@ -472,11 +473,13 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
>  		size = ULLONG_MAX - start;
>  
>  	end = start + size;
> -	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
> -	e820_print_type(old_type);
> -	pr_cont(" ==> ");
> -	e820_print_type(new_type);
> -	pr_cont("\n");
> +	printed = pr_debug("e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
> +	if (printed > 0) {
> +		e820_print_type(old_type);
> +		pr_cont(" ==> ");
> +		e820_print_type(new_type);
> +		pr_cont("\n");
> +	}


Hi Heiner,

We've been doing these like:

DEFINE_DYNAMIC_DEBUG_METADATA(e820_dbg, "e820 verbose mode");

.
.
.

if (DYNAMIC_DEBUG_BRANCH(e820_debg)) {
    printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
    e820_print_type(old_type);
    pr_cont(" ==> ");
    e820_print_type(new_type);
    pr_cont("\n");
}


You could then have one DEFINE_DYNAMIC_DEBUG_METADATA statement - such that it enables
it all in one go, or do separate ones that enable it how you see fit.

Would that work here?

Thanks,

-Jason

>  
>  	for (i = 0; i < table->nr_entries; i++) {
>  		struct e820_entry *entry = &table->entries[i];
> @@ -540,7 +543,7 @@ static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type o
>  /* Remove a range of memory from the E820 table: */
>  u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
>  {
> -	int i;
> +	int printed, i;
>  	u64 end;
>  	u64 real_removed_size = 0;
>  
> @@ -548,10 +551,12 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
>  		size = ULLONG_MAX - start;
>  
>  	end = start + size;
> -	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
> -	if (check_type)
> -		e820_print_type(old_type);
> -	pr_cont("\n");
> +	printed = pr_debug("e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
> +	if (printed > 0) {
> +		if (check_type)
> +			e820_print_type(old_type);
> +		pr_cont("\n");
> +	}
>  
>  	for (i = 0; i < e820_table->nr_entries; i++) {
>  		struct e820_entry *entry = &e820_table->entries[i];
> @@ -1230,7 +1235,7 @@ void __init e820__reserve_resources_late(void)
>  		if (start >= end)
>  			continue;
>  
> -		printk(KERN_DEBUG "e820: reserve RAM buffer [mem %#010llx-%#010llx]\n", start, end);
> +		pr_debug("e820: reserve RAM buffer [mem %#010llx-%#010llx]\n", start, end);
>  		reserve_region_with_split(&iomem_resource, start, end, "RAM buffer");
>  	}
>  }
> 
