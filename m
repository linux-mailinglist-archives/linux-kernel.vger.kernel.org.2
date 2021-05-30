Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098D5394EE5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 03:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhE3BXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 21:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhE3BXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 21:23:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F53C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 18:21:54 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v13so3423051ple.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 18:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xEi6BXoNnqtihXfBBcx4dPYE6EijHD5pKsgqYkE4P1o=;
        b=njwqfZE8koNsvOck2/ofN7d+VeB9/E7agwkbIWPFN8S37AyMerjqqKz0V8hWHejz/W
         KKgX7L/+HAb4y3usDPcNGrcSU/QAX0Iagyogl0FZzt3oFCPljEk/heMiCdJ1LIg9ymCQ
         v+xeboWgbaWpQug7Dk/UsI1nW3gstZ0zL80egM1CBOvR94CAw9zv4DnjaDBiYA7A+4Xr
         AvWuyjzo1QfuqIWC3ChrCOJetq+8z2s4gTbq3flNl0ifg6Bwypds4FmRaajKGM4hNPiW
         4Pe3h9UKu7COlOyWOdD/Dn1Ro+iIOIFFzVIl0rFNIWkMlPXjEX6lAk5l8AS03Jk5kaW7
         cZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xEi6BXoNnqtihXfBBcx4dPYE6EijHD5pKsgqYkE4P1o=;
        b=WVrlYGFT1Q4ODsFyB7fEX9ThAVMNPmGbxMjm/jIXofgKKg+7JMNlLedylMjl9LBEh0
         BPng/X7V+f6jL35971orI/Dk5iYTCW49JtmtLyG1GbDkBA00TNTPV58sSczfdiOIq4cM
         jVQIXlaNEMMtSzpre2rTaxdO+6M/Ou50/kh0RQNj9poQCU8yW91RkcRflFYcG4IZJVUG
         pbXxN1ZLewmKkPj7/jL2cLEfVLaVKiczKaGkhagVUN5QrHOOa7LH42YFyj6G3nxZkhz8
         OBo5d8ZacSMTv70HQkg7rSjKluQoaC6ZTDzmZP9PkdY49eRYzFyPKv9yCeSLFUXrrkNu
         3oZA==
X-Gm-Message-State: AOAM533OQ0W2B4x9ABqylB+jtglkbNkG/wOUChzEtDe9qJyyrxzkDQoT
        rggIKE+qLpilBL4aCeqalwA8EA==
X-Google-Smtp-Source: ABdhPJwXmSyqUABdXDz0ldneJ5UzS6/oEHX7G+UGEOWDVAMNntp8O5RLzJ4SG1+zJ7w5qYdkAwo2Bw==
X-Received: by 2002:a17:90a:de09:: with SMTP id m9mr11649295pjv.41.1622337713693;
        Sat, 29 May 2021 18:21:53 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e17sm7340341pfi.131.2021.05.29.18.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 18:21:53 -0700 (PDT)
Date:   Sat, 29 May 2021 18:21:53 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 18:21:51 PDT (-0700)
Subject:     Re: [PATCH -next] riscv: mm: fix build errors caused by mk_pmd()
In-Reply-To: <mhng-4fb5ea1f-084a-4010-b4a6-d19423511720@palmerdabbelt-glaptop>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunnanyong@huawei.com
Message-ID: <mhng-5dc6487a-bafb-471f-ac5c-f6ec93cd311c@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2021 15:45:04 PDT (-0700), Palmer Dabbelt wrote:
> On Mon, 24 May 2021 00:02:20 PDT (-0700), sunnanyong@huawei.com wrote:
>> With "riscv: mm: add THP support on 64-bit", mk_pmd() function
>> introduce build errors,
>> 1.build with CONFIG_ARCH_RV32I=y:
>> arch/riscv/include/asm/pgtable.h: In function 'mk_pmd':
>> arch/riscv/include/asm/pgtable.h:513:9: error: implicit declaration of function 'pfn_pmd';
>>  did you mean 'pfn_pgd'? [-Werror=implicit-function-declaration]
>>
>> 2.build with CONFIG_SPARSEMEM=y && CONFIG_SPARSEMEM_VMEMMAP=n
>> arch/riscv/include/asm/pgtable.h: In function 'mk_pmd':
>> include/asm-generic/memory_model.h:64:14: error: implicit declaration of function 'page_to_section';
>>  did you mean 'present_section'? [-Werror=implicit-function-declaration]
>>
>> Use macro definition instead of inline function for mk_pmd
>> to fix the above problems.It is similar to the mk_pte macro.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>> ---
>>  arch/riscv/include/asm/pgtable.h | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 4b708ae08910..f35d9c90d4cb 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -508,10 +508,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
>>  	return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
>>  }
>>
>> -static inline pmd_t mk_pmd(struct page *page, pgprot_t prot)
>> -{
>> -	return pfn_pmd(page_to_pfn(page), prot);
>> -}
>> +#define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
>>
>>  static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>  {
>
> Thanks, this is on for-next.

Sorry, I wasn't looking closely enough.  I think the actual problem here 
is that mk_pmd() should be in pgtable-64.h.
