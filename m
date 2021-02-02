Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229DF30CCD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbhBBULH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240447AbhBBUHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:07:22 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9610C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 12:06:41 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y142so7106226pfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 12:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=3hz19TF2JROt6xvTiAYHx8FU5yLbxQH428pKwbOX3Ig=;
        b=voIIhR8+FopW32VevxJctVUrftIUn1iEu53Ov6JhrKhnxBC+usWT5fPD3K8rS5fslG
         cNpGKnZyl7Lv2JOe1m3J70I2MDA5E/354+yxtkzPt27SAsxW3kQZr+qg9CjydbNQ4STb
         ISUUhxKwJWKwtAYMkcm3/No3Te06fHBO9CJ5nFSO/c314+F8Z06vpTUVvW0/Y4VmQGsV
         MVdp43xJfjusjEThxvEjbjipcxBXOFbUVA1FVoO8sdjqmgzxVHK3LH4PuVXZobn5mr3b
         ZswtsEWv1jF4eJ0hOHsHpbzrqBbELbYNiUsttWbsWS5Kkv+inkOq85MzP9/fjqdh7Ef4
         Zriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=3hz19TF2JROt6xvTiAYHx8FU5yLbxQH428pKwbOX3Ig=;
        b=GA+VQKvJqqozNMFcl3JEA2sz/EB35b87rrgM2V+AEY+5vaFP8/lYxSXDDT7nyojgVY
         B045hr5VlO/l94MN5xByYYuIpB7jn4gAqrbaNjzFhdiMISRw+LdfhLqvDojrFrTU8NE/
         v2zh8jh7ZqGr/0PosXpXjO/WLSWgfZul1gfR1GHuQsU5fxZ3YOYlMim1XiFbwNeFkUPT
         cXbq31s6wIsYavjP6d06l2jqRi79P51G36MPVtBQLAT0Fex1+yv+/8nBDzd9r1DjhgdY
         A8uQn8MyW53JJ9SbkvxZXVrcoD5SgdfLGc1bPYD72HwT/e/GqsmjEAu9sRV3pK488WRY
         dPoQ==
X-Gm-Message-State: AOAM532jyk1ksAHbHNufIRCw/91M6Zqt5raaLcg6wzued3yQpm4aJXj0
        IIKhvG05E+Bc0qlqAvNn2T/XlpKfBB2Sog==
X-Google-Smtp-Source: ABdhPJwnNDMfcziICRutXluz6aeeLmpIl9Uar0z9zzAlWe6XeteKUMzoHFBb4l0lI+MX0P7t8sN8bA==
X-Received: by 2002:a63:357:: with SMTP id 84mr24020307pgd.13.1612296401148;
        Tue, 02 Feb 2021 12:06:41 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 11sm22747061pgz.22.2021.02.02.12.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 12:06:40 -0800 (PST)
Date:   Tue, 02 Feb 2021 12:06:40 -0800 (PST)
X-Google-Original-Date: Tue, 02 Feb 2021 12:06:38 PST (-0800)
Subject:     Re: [PATCH] arch_numa: fix common code printing of phys_addr_t
In-Reply-To: <0d6fb1da-6b14-7f54-3f4c-4697c88a14f7@infradead.org>
CC:     linux-kernel@vger.kernel.org, lkp@intel.com,
        Atish Patra <Atish.Patra@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-59dd686b-42bf-4880-8749-8b0426d55629@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 19:51:07 PST (-0800), rdunlap@infradead.org wrote:
> On 2/1/21 7:36 PM, Palmer Dabbelt wrote:
>> On Wed, 27 Jan 2021 19:55:33 PST (-0800), rdunlap@infradead.org wrote:
>>> Fix build warnings in the arch_numa common code:
>>>
>>> ../include/linux/kern_levels.h:5:18: warning: format '%Lx' expects argument of type 'long long unsigned int', but argument 3 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
>>> ../drivers/base/arch_numa.c:360:56: note: format string is defined here
>>>   360 |    pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
>>> ../drivers/base/arch_numa.c:435:39: note: format string is defined here
>>>   435 |  pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n", start, end - 1);
>>>
>>> Fixes: ae3c107cd8be ("numa: Move numa implementation to common code")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Cc: Atish Patra <atish.patra@wdc.com>
>>> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
>>> ---
>>>  drivers/base/arch_numa.c |   13 +++++++------
>>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> --- linux-next-20210125.orig/drivers/base/arch_numa.c
>>> +++ linux-next-20210125/drivers/base/arch_numa.c
>>> @@ -355,11 +355,12 @@ static int __init numa_register_nodes(vo
>>>      /* Check that valid nid is set to memblks */
>>>      for_each_mem_region(mblk) {
>>>          int mblk_nid = memblock_get_region_node(mblk);
>>> +        phys_addr_t start = mblk->base;
>>> +        phys_addr_t end = mblk->base + mblk->size - 1;
>>>
>>>          if (mblk_nid == NUMA_NO_NODE || mblk_nid >= MAX_NUMNODES) {
>>> -            pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
>>> -                mblk_nid, mblk->base,
>>> -                mblk->base + mblk->size - 1);
>>> +            pr_warn("Warning: invalid memblk node %d [mem %pap-%pap]\n",
>>> +                mblk_nid, &start, &end);
>>>              return -EINVAL;
>>>          }
>>>      }
>>> @@ -427,14 +428,14 @@ out_free_distance:
>>>  static int __init dummy_numa_init(void)
>>>  {
>>>      phys_addr_t start = memblock_start_of_DRAM();
>>> -    phys_addr_t end = memblock_end_of_DRAM();
>>> +    phys_addr_t end = memblock_end_of_DRAM() - 1;
>>>      int ret;
>>>
>>>      if (numa_off)
>>>          pr_info("NUMA disabled\n"); /* Forced off on command line. */
>>> -    pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n", start, end - 1);
>>> +    pr_info("Faking a node at [mem %pap-%pap]\n", &start, &end);
>>>
>>> -    ret = numa_add_memblk(0, start, end);
>>> +    ret = numa_add_memblk(0, start, end + 1);
>>>      if (ret) {
>>>          pr_err("NUMA init failed\n");
>>>          return ret;
>>
>> Thanks, this is on for-next.  Did you, by any chance, find %Lx documented
>> anywhere?  It's not ISO C and the GCC source code says it's a GNU extension,
>> but I couldn't find it in the documentation (or even where to add it, which I
>> guess is how I forgot to send my version fo the patch).
>
> 'man sprintf' says this:
>
>        As  a nonstandard extension, the GNU implementations treats ll and L as
>        synonyms, so that one can, for example, write llg (as a synonym for the
>        standards-compliant  Lg) and Ld (as a synonym for the standards compli-
>        ant lld).  Such usage is nonportable.
>
>
> and linux/lib/vsprintf.c has some handling for it:
>
> 	if (qualifier == 'L')
> 		spec->type = FORMAT_TYPE_LONG_LONG;
>
> and
>
> 		case 'L':
> 			if (is_sign)
> 				*va_arg(args, long long *) = val.s;
> 			else
> 				*va_arg(args, unsigned long long *) = val.u;
> 			break;
>
>
> Does that help?

The manpage does it, I guess I just wasn't reading closely enough. Thanks!
