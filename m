Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A369334086F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhCRPHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230269AbhCRPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616080046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1/LrD+I/pla5Li7HJQKY+fP7jpet1+5dxXs7b6R+8aw=;
        b=eB9E/IQV4WeRVa9kwga5kMezUPh7OxpN9i4c7leinV18hAGgVh0w8XFrV1FGcxEF+IoTgO
        Grz1+ecev7Xfap3C0X10qLCgLpy7gT54RLr9vflhsa78yCcTApH0p9glW8llGsDG9yPch+
        4vKzYcJWROjBztfdd+VkWqMRdHlmdpg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-lTxqlnoUN1upQr09LJTsDw-1; Thu, 18 Mar 2021 11:07:24 -0400
X-MC-Unique: lTxqlnoUN1upQr09LJTsDw-1
Received: by mail-qv1-f71.google.com with SMTP id s16so30089374qvw.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1/LrD+I/pla5Li7HJQKY+fP7jpet1+5dxXs7b6R+8aw=;
        b=bsZ6yaCJMUun3aEURSCj9v6qm1oBc6cE+4MVCrD21BZ3gPonNuTgbEmFTT2hXUy+mi
         NOptYsmBhaCJR/SEXv12OAYlN68qJUWt29jnrps94LCDjEJdUb92/inDXY6qwpfbrRYO
         yuPyv2P2Nrq+zIq9NrH6HYf5W0Os/n6F4LKXqdhX3fAxUJGW/kkaXyvpyLyP56TyhhAG
         UfaoH+MKx8lazF6XAQSBnk0gSL7EmAH2vGbikxxrSPgOnXeJIzgOo70F9fPqQfI4i3+8
         K4hvmxM4xdIfuZ4ZlAhhLRdz/IWA8sX6B11Wai/pMi8JV0hl5X5/jw5kHwjk4biFIYom
         Tn+A==
X-Gm-Message-State: AOAM530kYYx7x7K8wq7+Rv4G/mBEWCcxvc40WsjaKYu1nC2i3mZiTTYw
        /VURsSi29oO86PD1RCJJNjnnu09uM4SqkGiSTLnfmxhbo2qRbtQg3sa3+bxz0qARxWw/w7eqipK
        /CfTzbHjIQ4ZdifCgvUYn9nIZ
X-Received: by 2002:a05:620a:110a:: with SMTP id o10mr4887485qkk.281.1616080043399;
        Thu, 18 Mar 2021 08:07:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc2pygDzR+H4VqimhmOKQC0aDZ5rEfXPBH4NGN/DAGFsv6CKyGqkvVzT7bYv+X91M4O50KVQ==
X-Received: by 2002:a05:620a:110a:: with SMTP id o10mr4887446qkk.281.1616080043110;
        Thu, 18 Mar 2021 08:07:23 -0700 (PDT)
Received: from xz-x1 ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id j3sm1946715qki.84.2021.03.18.08.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:07:22 -0700 (PDT)
Date:   Thu, 18 Mar 2021 11:07:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, ziy@nvidia.com, willy@infradead.org,
        william.kucharski@oracle.com, vbabka@suse.cz,
        yulei.kernel@gmail.com, walken@google.com,
        aneesh.kumar@linux.ibm.com, rcampbell@nvidia.com,
        thomas_os@shipmail.org, yang.shi@linux.alibaba.com,
        richard.weiyang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 0/6] Some cleanups for huge_memory
Message-ID: <20210318150720.GP395976@xz-x1>
References: <20210318122722.13135-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318122722.13135-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 08:27:16AM -0400, Miaohe Lin wrote:
> Hi all,
> This series contains cleanups to rework some function logics to make it
> more readable, use helper function and so on. More details can be found
> in the respective changelogs. Thanks!
> 
> v2->v3:
> use ALIGN/ALIGN_DOWN too against HPAGE_PMD_SIZE per Peter.
> 
> v1->v2:
> rename try_to_split_huge_pmd_address and move up comments.
> 
> Miaohe Lin (6):
>   mm/huge_memory.c: rework the function vma_adjust_trans_huge()
>   mm/huge_memory.c: make get_huge_zero_page() return bool
>   mm/huge_memory.c: rework the function do_huge_pmd_numa_page() slightly
>   mm/huge_memory.c: remove redundant PageCompound() check
>   mm/huge_memory.c: remove unused macro
>     TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG
>   mm/huge_memory.c: use helper function migration_entry_to_page()

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

