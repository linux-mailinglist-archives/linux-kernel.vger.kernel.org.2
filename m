Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA89232A6DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578971AbhCBPyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447357AbhCBN3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:29:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44656C061A2B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 05:28:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b7so11631178edz.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 05:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7L0BOqRe+13aQ5nTzLZo2I22iHREvV6oqm1AT8L/cvg=;
        b=u2zl81Aqw9FwWu6GkxsEZfGirRBF1s1UixG5XuA9aLQM7dKs01Fn/NkJe/eIid1VtP
         1V9c8DODkxMj5etjID8h0ONvUJeIaGemxIs10flIOS8pLlNLBojoaVz/EOmQhKSt5iUf
         sNCQvsv2h9AKyUO+DRPWzlG+29xnjgnu0nIuoMPjeHEib4VC0Ad4OWHPQAYgGd+YhwMW
         55uY9p9aJtSDw3y9mDmEkyuNl3PPJrX6TaB8zn/Z+Oco8un1umnRVGtVJ8bx1kqVAjed
         uGgDKKbJwOYeE57C0d9kOpKGFQ4WSTsbJISeOqU2wMZXyqsJc3IggB+xTzVzaIhWV4pN
         EZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7L0BOqRe+13aQ5nTzLZo2I22iHREvV6oqm1AT8L/cvg=;
        b=GWZwZWy9qmRRgjh+rzW9v6OqGakvCIXHjg0FskRdTYhz2OwySLJI72fhqmqWJsKn2u
         pyAmO7uTNJ6Y7pySygY6ivIQhkwKsPsHZrMlMYhGf9Y5Iu5mBBqp9NJxSBT3DDqKJQiz
         igNV6x12IWOGTALoz8qGhLyA9+RbsckLcxP/cPb9HY79VbQDjgTUUWhNygFYWU8rgrK5
         3gplMfOrA9rWNFuAFLT+DwZ+LUQf+umBA0lc0Zj9QneB9lcUPqp9vQYx7qvc/yA+jvsI
         0/FHckvBKpPjSlxv16pV0K0eHmWrCZwFd6LoQnSBnlbc+xgA5ydFOP5oPDTE/QXkYTIo
         AQdg==
X-Gm-Message-State: AOAM532t0kfwicwKCO8ifg5UBSPYjY5nivxESNUMb/zUnb7xxQc6s3U9
        jOZZCDZVTmiO3LfQuOKsLaTUeg==
X-Google-Smtp-Source: ABdhPJw9eHJTMelotSSOg71hzAPw3YXVnWisOTEJGBTWh28xPJGipgxc/LN7msOz1Qbj1qGcodyeVw==
X-Received: by 2002:aa7:cf02:: with SMTP id a2mr18762312edy.59.1614691721960;
        Tue, 02 Mar 2021 05:28:41 -0800 (PST)
Received: from ?IPv6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id y16sm16268059ejk.43.2021.03.02.05.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 05:28:41 -0800 (PST)
Subject: Re: [PATCH v1] microblaze: tag highmem_setup() with __meminit
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ira Weiny <ira.weiny@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210301114749.47914-1-david@redhat.com>
 <20210301221846.GA4744@localhost.localdomain>
 <b38b353b-7138-373b-057a-a4fa4b4ab30e@redhat.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <2db45dcc-87a5-fe1c-c0e6-702edeedc246@monstr.eu>
Date:   Tue, 2 Mar 2021 14:28:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b38b353b-7138-373b-057a-a4fa4b4ab30e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/21 10:04 AM, David Hildenbrand wrote:
> On 01.03.21 23:18, Oscar Salvador wrote:
>> On Mon, Mar 01, 2021 at 12:47:49PM +0100, David Hildenbrand wrote:
>>> With commit a0cd7a7c4bc0 ("mm: simplify free_highmem_page() and
>>> free_reserved_page()") the kernel test robot complains about a warning:
>>>
>>> WARNING: modpost: vmlinux.o(.text.unlikely+0x23ac): Section mismatch in
>>>    reference from the function highmem_setup() to the function
>>>    .meminit.text:memblock_is_reserved()
>>>
>>> This has been broken ever since microblaze added highmem support,
>>> because memblock_is_reserved() was already tagged with "__init" back
>>> then -
>>> most probably the function always got inlined, so we never stumbled over
>>> it.
>>
>> It might be good to point out that we need __meminit instead of __init
>> because microblaze platform does not define CONFIG_ARCH_KEEP_MEMBLOCK,
>> and __init_memblock fallsback to that.
>>
>> (I had to go and look as I was puzzled :-) )
>>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> Thanks!
> 
> Whoever feels like picking this up (@Andrew?) can you add
> 
> "We need __meminit because __init_memblock defaults to that without
> CONFIG_ARCH_KEEP_MEMBLOCK" and __init_memblock is not used outside
> memblock code.
> 

Applied with this line added.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

