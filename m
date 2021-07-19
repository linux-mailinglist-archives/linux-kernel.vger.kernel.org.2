Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287B43CD3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhGSKxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236236AbhGSKxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626694437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZ/P5u++j9Qpns29fggdm0r9Q3FMuOlkVwzoX+ZoX4s=;
        b=LtrTGt9edGXQZPxzlTYhQLrm+RE9rxXG1X6YWULA+TSnZNqSHqZvBBnxu3Tp0cKUUPPcsF
        p7AH6StUY3q44aIuAeoGUl30mcr0xfI5/j+PrMhbIQLBJjc4G53QfwAEsgBblxthaUwnxU
        LMugnuwhmdHUOCbFgrJ8zlKKbZbFu4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-sH2EP5KoNgWIbfW8MCVQQg-1; Mon, 19 Jul 2021 07:33:56 -0400
X-MC-Unique: sH2EP5KoNgWIbfW8MCVQQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 678C3800FF0;
        Mon, 19 Jul 2021 11:33:54 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 905C119C44;
        Mon, 19 Jul 2021 11:33:49 +0000 (UTC)
Subject: Re: [PATCH v2 00/12] mm/debug_vm_pgtable: Enhancements
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210719054138.198373-1-gshan@redhat.com>
Message-ID: <3d0a3a3b-e0ce-bf13-c8ce-de93a6f21c2d@redhat.com>
Date:   Mon, 19 Jul 2021 21:34:05 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20210719054138.198373-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/19/21 3:41 PM, Gavin Shan wrote:
> There are couple of issues with current implementations and this series
> tries to resolve the issues:
> 
>    (a) All needed information are scattered in variables, passed to various
>        test functions. The code is organized in pretty much relaxed fashion.
> 
>    (b) The page isn't allocated from buddy during page table entry modifying
>        tests. The page can be invalid, conflicting to the implementations
>        of set_xxx_at() on ARM64. The target page is accessed so that the iCache
>        can be flushed when execution permission is given on ARM64. Besides,
>        the target page can be unmapped and access to it causes kernel crash.
> 
> "struct pgtable_debug_args" is introduced to address issue (a). For issue
> (b), the used page is allocated from buddy in page table entry modifying
> tests. The corresponding tets will be skipped if we fail to allocate the
> (huge) page. For other test cases, the original page around to kernel
> symbol (@start_kernel) is still used.
> 
> The patches are organized as below. PATCH[2-10] could be combined to one
> patch, but it will make the review harder:
> 
>    PATCH[1] introduces "struct pgtable_debug_args" as place holder of all
>             needed information. With it, the old and new implementation
>             can coexist.
>    PATCH[2-10] uses "struct pgtable_debug_args" in various test functions.
>    PATCH[11] removes the old implementation.
>    PATCH[12] fixes the issue of corrupted page flag for ARM64
> 
> Changelog
> =========
> v2:
>     * Rename struct vm_pgtable_debug to struct pgtable_debug_args.
>       The parameter name to various test functions are renamed
>       to "@args"                                                  (Anshuman)
>     * Code changes as suggested by Anshuman                       (Anshuman)
> 

Please ignore v2. I will post v3 to fix couple of issues in v2:

(1) The subjects of PATCH[5/12] and PATCH[9/12] should be fixed to
     start with "mm/debug_vm_pgtable".
(2) "WARN_ON(!pud_none(pud))" is missed in PATCH[9/12]. Otherwise,
     build warning for unused variable @pud is raised.
(3) Build warnings for unused variables in separate patches are
     raised, reported by 0-DAY CI Kernel Test Service.

Thanks,
Gavin

> Gavin Shan (12):
>    mm/debug_vm_pgtable: Introduce struct pgtable_debug_args
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in basic tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in leaf and
>      savewrite tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in protnone and
>      devmap tests
>    mm/vm_debug_pgtable: Use struct pgtable_debug_args in soft_dirty and
>      swap tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in migration and
>      thp tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in PTE modifying
>      tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in PMD
>    mm/vm_debug_pgtable: Use struct pgtable_debug_args in PUD modifying
>      tests
>    mm/debug_vm_pgtable: Use struct pgtable_debug_args in PGD and P4D
>      modifying tests
>    mm/debug_vm_pgtable: Remove unused code
>    mm/debug_vm_pgtable: Fix corrupted page flag
> 
>   mm/debug_vm_pgtable.c | 849 ++++++++++++++++++++++++------------------
>   1 file changed, 479 insertions(+), 370 deletions(-)
> 

