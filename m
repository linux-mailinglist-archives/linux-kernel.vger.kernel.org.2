Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4DF346873
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhCWTFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhCWTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:04:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ED4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:04:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so11414300wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RbFpbq45kpggLm6Psx0owbwRXsYpSfJN7JgeqcP2Mu4=;
        b=UZKiqbd5+BBdc0NgTu+GUe/wC4bea0GtvB29FWI7Spj3k/dxu8QOO3dVhiIyeJMucF
         vQC8feWgvEa9X3J7SMPxAwT6My2YOBhRcWaJ0yiBDG71JxnDD8Hh53nv/GPFX/N/VLv7
         jORi2aeofPCaEkYJT5x4PdkHS3eG0kBUdwfk5RqPLfGQpfiCQiZa2Uq12ZERjfBBu3Ty
         vThjutiV4MKI4efT85EHcLjz4bik64raZ063NTEN9k6h+7RnPiZukFM19+mXRKd7jNeL
         /ouBOF8Jqyovbt2ep53M/NOUW90gwGnJSod16lrWiQl16cT319HWHdSPDoCueq4hLT5P
         hb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RbFpbq45kpggLm6Psx0owbwRXsYpSfJN7JgeqcP2Mu4=;
        b=oyU+uhuRWsBb5GTIkUYEDaQIqSG125YDmTVR4q0r2ulAesBwe+WrtnB/2SdluGhbTh
         BGV0QiTdtLZEJgLKeYdRAN04BJlrcsb/KwIkjxvTDVlrOsUVXT5Z3/pFpJWF9v2ahpwU
         2TJ/Sdz1uz5uoQsKcWz84Qi/p09o7+d9GegLwjT3GTDDTICqYtMq4bQ0Scqj5YUyR0zs
         OFLC3oiFBMes28OPjeSJK56NbcTcB1hTvrNggJUzKv/QnsA7yHZODoXQyoI2FGYaC9Rh
         ApZlX6ZEedw3empu6C9ZU+l74+WwvNB4z++QmPh0+wf5sHaKwvCUaE0US+t6csqD/q4C
         Tjlw==
X-Gm-Message-State: AOAM530RO08pKpXuegHdFSoDeAoj4oyawqZFlzP2Is0IaQHWEL16zirf
        8boUbfPaI34pISu8BxZKt4w=
X-Google-Smtp-Source: ABdhPJxwi/mZg8TzTxJs26AM44HgpG1L47R7B6VUOtQ3vitadRNoKha3GN9uDw+lEk5ZSiOX+t9e+w==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr4663665wmj.54.1616526276276;
        Tue, 23 Mar 2021 12:04:36 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l9sm3194098wmq.2.2021.03.23.12.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 12:04:35 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] mm: Extend MREMAP_DONTUNMAP to non-anonymous
 mappings
To:     Brian Geffon <bgeffon@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
References: <20210303175235.3308220-1-bgeffon@google.com>
 <20210323182520.2712101-1-bgeffon@google.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <fef17cb0-ae0a-db3f-e847-3febd318a81a@gmail.com>
Date:   Tue, 23 Mar 2021 19:04:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323182520.2712101-1-bgeffon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 6:25 PM, Brian Geffon wrote:
> Currently MREMAP_DONTUNMAP only accepts private anonymous mappings.
> This restriction was placed initially for simplicity and not because
> there exists a technical reason to do so.
> 
> This change will widen the support to include any mappings which are not
> VM_DONTEXPAND or VM_PFNMAP. The primary use case is to support
> MREMAP_DONTUNMAP on mappings which may have been created from a memfd.
> This change will result in mremap(MREMAP_DONTUNMAP) returning -EINVAL
> if VM_DONTEXPAND or VM_PFNMAP mappings are specified.
> 
> Lokesh Gidra who works on the Android JVM, provided an explanation of how
> such a feature will improve Android JVM garbage collection:
> "Android is developing a new garbage collector (GC), based on userfaultfd.
> The garbage collector will use userfaultfd (uffd) on the java heap during
> compaction. On accessing any uncompacted page, the application threads will
> find it missing, at which point the thread will create the compacted page
> and then use UFFDIO_COPY ioctl to get it mapped and then resume execution.
> Before starting this compaction, in a stop-the-world pause the heap will be
> mremap(MREMAP_DONTUNMAP) so that the java heap is ready to receive
> UFFD_EVENT_PAGEFAULT events after resuming execution.

Pretty interesting idea :-)

> 
> To speedup mremap operations, pagetable movement was optimized by moving
> PUD entries instead of PTE entries [1]. It was necessary as mremap of even
> modest sized memory ranges also took several milliseconds, and stopping the
> application for that long isn't acceptable in response-time sensitive
> cases.
> 
> With UFFDIO_CONTINUE feature [2], it will be even more efficient to
> implement this GC, particularly the 'non-moveable' portions of the heap.
> It will also help in reducing the need to copy (UFFDIO_COPY) the pages.
> However, for this to work, the java heap has to be on a 'shared' vma.
> Currently MREMAP_DONTUNMAP only supports private anonymous mappings, this
> patch will enable using UFFDIO_CONTINUE for the new userfaultfd-based heap
> compaction."
> 
> [1] https://lore.kernel.org/linux-mm/20201215030730.NC3CU98e4%25akpm@linux-foundation.org/
> [2] https://lore.kernel.org/linux-mm/20210302000133.272579-1-axelrasmussen@google.com/
> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Tested-by: Lokesh Gidra <lokeshgidra@google.com>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks,
Dmitry
