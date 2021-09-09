Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD9404589
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352414AbhIIGSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhIIGSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:18:45 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A0FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 23:17:35 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s12so1299098ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 23:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6jMBpmkSePi8Q+tjzlzHAw91s1TP7X0CnXJ0KmdHirc=;
        b=YWfZixjdK1spTMoY+DKK2RVGNam+gDZa9XXZshjr8WkTud98VrUKcYg2mpsfUQhRUJ
         NeS8wAb4xR+CeiY7S7YWeJs1n2F1rmwgzA5H8uzLe/rJ3o/x9lonfs5N5cFQUypUI61r
         j8Pj1ul2MQB1PTPl7qW41rkgoGLsiS0Vt4TojJiytNUsfKgeHqXFkfZpBE9OdGDtbQjd
         rWbfESzJJXasSBa4Wu/WrYPFs95c/+L7s4Wb6JNtUNQQN2lPLYFCbXS2UPCZ6I2qUh4Y
         ijCZ9tj4njnbZ7a7URbk1p/lT604hsUiLgQfiPkE5eKyJo1q3wXUuy2ptWYvtuxFXsJ0
         1fRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6jMBpmkSePi8Q+tjzlzHAw91s1TP7X0CnXJ0KmdHirc=;
        b=sI3QhDmG4BXmUD5Dy+xWuatWUBIKpODlxZgcVeC0FKJ0K68lgue14aeIP4Ct4yIYnW
         Ob+qvY2kSEc0r+05FQ0S1vM4BhE++19J+UEmfmDgXgnSTQxWjgxeIgx7fTuRFU9xZ3gL
         WrcJIAm7fcLg6fBmd30mdyuQRaJjW5SwZKWrUsv39G/XT3cYnf+qHM/fGbPT8pPW4ZWG
         Vfh+Q4v6P3+qLaHtFtjUV/wDYrqjw4c7ktSGS5GPppE7c4xooOpdEMZIw3Axh6WvMku1
         g+6i6h+HQeyOX1VJHLsaCKfKiBoG/BIqnk5MmPMRRTohEBLE0o4GH74rII74A2Scpk3w
         Yqsw==
X-Gm-Message-State: AOAM531lt2sDzOKcnUHWdSBHN4NA1FvMyXwITTmiDQB+Bzgwk+sfcDgC
        wshWh2++XP/8gQRliDdgYbb0tA==
X-Google-Smtp-Source: ABdhPJzb79sYeiW67woAU2L4IduTt4NiWhx/bQpljHERdeUzxLeeTCJBcOMp98yo0hN7hHObtp3r6A==
X-Received: by 2002:a2e:824e:: with SMTP id j14mr954387ljh.65.1631168254321;
        Wed, 08 Sep 2021 23:17:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y9sm87502ljm.5.2021.09.08.23.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 23:17:33 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id AA213102F11; Thu,  9 Sep 2021 09:17:32 +0300 (+03)
Date:   Thu, 9 Sep 2021 09:17:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Liu Yuntao <liuyuntao10@huawei.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, liusirui@huawei.com, windspectator@gmail.com,
        wuxu.wu@huawei.com
Subject: Re: [PATCH v2] fix judgment error in shmem_is_huge()
Message-ID: <20210909061732.2zalspiyfoevd7ea@box.shutemov.name>
References: <20210909032007.18353-1-liuyuntao10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909032007.18353-1-liuyuntao10@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 11:20:07AM +0800, Liu Yuntao wrote:
> In the case of SHMEM_HUGE_WITHIN_SIZE, the page index is not rounded
> up correctly. When the page index points to the first page in a huge
> page, round_up() cannot bring it to the end of the huge page, but
> to the end of the previous one.
> 
> an example:
> HPAGE_PMD_NR on my machine is 512(2 MB huge page size).
> After allcoating a 3000 KB buffer, I access it at location 2050 KB.
> In shmem_is_huge(), the corresponding index happens to be 512.
> After rounded up by HPAGE_PMD_NR, it will still be 512 which is
> smaller than i_size, and shmem_is_huge() will return true.
> As a result, my buffer takes an additional huge page, and that
> shouldn't happen when shmem_enabled is set to within_size.
> 
> Fixes: f3f0e1d2150b2b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Signed-off-by: Liu Yuntao <liuyuntao10@huawei.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>


-- 
 Kirill A. Shutemov
