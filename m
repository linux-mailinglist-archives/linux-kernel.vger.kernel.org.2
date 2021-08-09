Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29A43E41D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhHIIuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234008AbhHIIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628499002;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igdJGS9Q0HZjFSDZhJ/yUBrXs2QalJMPtlJmQqZe3xk=;
        b=bFXjmPugLl2PSg1zVNOJGzIF/Da/Bo2VAVaIphHdrFTRoXeLTwgp/eOEkG/x3BqqGDPYi9
        7qo1Q+83WSeQt6AHPSfSi34hfWZP91ZqnrrxwK75qv/LNhOf38Y0kb2AdKMEuDxUN0asMc
        5IMzUxRUUWcLilyB5WikXWwUXCFB6UE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-kEsk062ZPhaprm013Y8gFA-1; Mon, 09 Aug 2021 04:50:01 -0400
X-MC-Unique: kEsk062ZPhaprm013Y8gFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A195100CEC9;
        Mon,  9 Aug 2021 08:49:59 +0000 (UTC)
Received: from [10.64.54.155] (vpn2-54-155.bne.redhat.com [10.64.54.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8A6269FAD;
        Mon,  9 Aug 2021 08:49:48 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [mm/debug_vm_pgtable] 08cb589cb3:
 BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Qian Cai <cai@lca.pw>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Chunyu Hu <chuhu@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
References: <20210808142553.GD27482@xsang-OptiPlex-9020>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <7a891ba4-dc7d-8fa3-5f0e-da99d34702d6@redhat.com>
Date:   Mon, 9 Aug 2021 18:49:53 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20210808142553.GD27482@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 12:25 AM, kernel test robot wrote:
>

[...]

> 
> [    9.433105][    T1] BUG: sleeping function called from invalid context at mm/page_alloc.c:5170
> [    9.434513][    T1] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
> [    9.436116][    T1] no locks held by swapper/0/1.
> [    9.436923][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc4-00161-g08cb589cb3d2 #1
> [    9.438398][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [    9.439880][    T1] Call Trace:
> [ 9.440404][ T1] ? dump_stack_lvl (lib/dump_stack.c:106)
> [ 9.441154][ T1] ? dump_stack (lib/dump_stack.c:113)
> [ 9.441827][ T1] ? ___might_sleep.cold (kernel/sched/core.c:9155)
> [ 9.442645][ T1] ? __might_sleep (kernel/sched/core.c:9109 (discriminator 14))
> [ 9.444795][ T1] ? __alloc_pages (include/linux/kernel.h:104 mm/page_alloc.c:5170 mm/page_alloc.c:5380)
> [ 9.445583][ T1] ? mem_encrypt_init+0x1/0x1
> [ 9.446389][ T1] ? destroy_args (mm/debug_vm_pgtable.c:1219)
> [ 9.447193][ T1] ? debug_vm_pgtable (mm/debug_vm_pgtable.c:1208 mm/debug_vm_pgtable.c:1237)
> [ 9.448076][ T1] ? destroy_args (mm/debug_vm_pgtable.c:1219)
> [ 9.448863][ T1] ? do_one_initcall (init/main.c:1282)
> [ 9.449676][ T1] ? parse_args (kernel/params.c:190)
> [ 9.450470][ T1] ? kernel_init_freeable (init/main.c:1354 init/main.c:1371 init/main.c:1390 init/main.c:1592)
> [ 9.451358][ T1] ? rest_init (init/main.c:1476)
> [ 9.452063][ T1] ? kernel_init (init/main.c:1486)
> [ 9.452759][ T1] ? ret_from_fork (arch/x86/entry/entry_32.S:775)
> [    9.453815][    T1] ------------[ cut here ]------------

[...]

Thanks for reporting the issue. The same issue was reported against v4 series before,
but this time, it's raised on v5 series. Fortunately, this report provides more useful
information so that I can reproduce the issue locally and I'm going to fix the issue
in v6 since I need to address Anshuman's last comment on v5.

As to the root cause, pte_alloc_map() is used in init_args(). The PTE entry is mapped
in atomic mode when CONFIG_HIGHPTE is enabled on i386. It means GFP_KERNEL isn't right
option to be used by alloc_pages() in init_args(). The fix is use pte_alloc() to replace
pte_alloc_map() and args->pte will be mapped when it's used in debug_vm_pgtable() for
PTE modifying tests. We need avoid atomic context lasting for too long.

Thanks,
Gavin

