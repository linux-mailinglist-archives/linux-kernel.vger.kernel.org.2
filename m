Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB963C59A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350845AbhGLJHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359805AbhGLI11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 04:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626078278;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDK3ySbMS0SPjg0Ubws18Afu1lnic0msgKS6DH4MdFE=;
        b=ANccBNwy/WQZiOH5yT/xyejitAlIDoTjYtmjXkFbeXTIcaW5aziM/Ip2ZAic7FPnmglPL7
        ZRDM4VzLRe3XHX48yxBHsyTo8LheJgxth2753ggrPARM+ORqF0Id9UQyS3NcBzFgca6IM4
        s7Ao/JMPHgmqa/8jnRNQo5ZcdDOiol8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-JAkLXTFRNnGryeeNn1qMjw-1; Mon, 12 Jul 2021 04:24:35 -0400
X-MC-Unique: JAkLXTFRNnGryeeNn1qMjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3AB710C1ADC;
        Mon, 12 Jul 2021 08:24:33 +0000 (UTC)
Received: from [10.64.54.119] (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A730160BD8;
        Mon, 12 Jul 2021 08:24:28 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] mm/debug_vm_pgtable: Fix corrupted PG_arch_1 by
 set_pmd_at()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        kernel test robot <lkp@intel.com>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com
References: <20210702103225.51448-1-gshan@redhat.com>
 <202107080820.IwV1NKBI-lkp@intel.com>
 <0a232c69-ae9f-8431-22c7-74513f87c018@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <4da06097-6f27-34b2-38b5-834b267ed62d@redhat.com>
Date:   Mon, 12 Jul 2021 18:24:25 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <0a232c69-ae9f-8431-22c7-74513f87c018@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/21 1:21 PM, Anshuman Khandual wrote:
> 
> 
> On 7/8/21 6:05 AM, kernel test robot wrote:
>> Hi Gavin,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [cannot apply to hnaz-linux-mm/master linux/master v5.13 next-20210707]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Gavin-Shan/mm-debug_vm_pgtable-Fix-corrupted-PG_arch_1-by-set_pmd_at/20210702-183310
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3dbdb38e286903ec220aaf1fb29a8d94297da246
>> config: x86_64-allyesconfig (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce (this is a W=1 build):
>>          # https://github.com/0day-ci/linux/commit/414db1c0feb54b545b3df56bc19ffff27580deb5
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Gavin-Shan/mm-debug_vm_pgtable-Fix-corrupted-PG_arch_1-by-set_pmd_at/20210702-183310
>>          git checkout 414db1c0feb54b545b3df56bc19ffff27580deb5
>>          # save the attached .config to linux build tree
>>          make W=1 ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from arch/x86/include/asm/page.h:76,
>>                      from arch/x86/include/asm/thread_info.h:12,
>>                      from include/linux/thread_info.h:59,
>>                      from arch/x86/include/asm/preempt.h:7,
>>                      from include/linux/preempt.h:78,
>>                      from include/linux/spinlock.h:51,
>>                      from include/linux/mmzone.h:8,
>>                      from include/linux/gfp.h:6,
>>                      from mm/debug_vm_pgtable.c:13:
>>     mm/debug_vm_pgtable.c: In function 'pud_advanced_tests':
>>>> include/asm-generic/memory_model.h:25:37: error: invalid operands to binary + (have 'struct page *' and 'struct page *')
> 
> 
> So this problem has been fixed in the other series (which now
> includes this patch) you have posted ?
> 

Yes, Anshuman. Please ignore this one. The fix has been included into
the following series. The last patch [12/12] of that series fixes the
issue.

[PATCH 00/12] mm/debug_vm_pgtable: Enhancements

Thanks,
Gavin



