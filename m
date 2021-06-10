Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5528D3A280C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFJJSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:18:51 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:43808 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhFJJSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:18:50 -0400
Received: by mail-lf1-f50.google.com with SMTP id n12so2077897lft.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wr6ozHJ9YAn6tkwbAWHJClxhdOSxSeF3/ANQDt15IBg=;
        b=Ao9890MUAJW99696YdIBhyJgMld3AjAdkz2sm77UQpWPt/xd6TroiC2wAeeEpkCN9c
         NRfDglQ27QpEecaeYFvFbtV7QKzpNSzcOKsWWh8pUnLHGDzc59U1VPYSFR95EURJHqb/
         +W+b7KfaRK5s7p386x7pkQiwgwVifh7cJ67EHY6QgzeCH2vzmoiLEs12HPfFICALeZU8
         8Tf3kaOZEoPpKRnQb965vGDtnmXfy0dDnqfVXNbXHyYbGh+JcqOSv3ZhzLsnRgGuAkkx
         PFVc53sdfb97LVU5AKdcF7DTrtEXpweTYjzV9nXr9TUxm4aKMquoIbo0VE/PuRDW0vp9
         FYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wr6ozHJ9YAn6tkwbAWHJClxhdOSxSeF3/ANQDt15IBg=;
        b=uiO2zjKw3B49MERKy0CXJhSapTe5i6tgIJKogSJ4gKoZcYdMGg/a/lv+Mme9DjKszW
         reCBnzov7L+tmWWxiGfkYdfidF3S0/C348UkEiNHjfcUpUvZK5V6QowleQP/YdOH0E9T
         Dh56tuEEqf1fBJOZVS2riuM+He7szX+DQ2IwvL7MVIi1DhFaq/OZNr1yvS7ry6MJE/b2
         dajUARuR0XRnF62bGICGoXXkFCgP3EElK6UIDwI81V3UteVtqqDJ8fXQxzY+y4+RXT8Q
         ZkOoqC1UnxAdnBgpO0qLFckPBuGB+KB1f3b1YAvcWPtc+tQNavZg48i6dHJfUTCrCS0q
         YoFA==
X-Gm-Message-State: AOAM532knxdDTtajMFI9uossX68tA6w4+XJEto/bTjqx52DyKI6ye+R0
        IIij7n9Fi5cTqm8NwFZe9FFXHw==
X-Google-Smtp-Source: ABdhPJzsehUhEYCARVTWGNQmP9i7wfjK8FXXFnxNeAKNeJMryusJRqsLqX0ucwKHroZDe4khiBzUaw==
X-Received: by 2002:a19:2d0f:: with SMTP id k15mr1365708lfj.237.1623316553716;
        Thu, 10 Jun 2021 02:15:53 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g15sm242114lfu.55.2021.06.10.02.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:15:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 11CC61027EE; Thu, 10 Jun 2021 12:16:09 +0300 (+03)
Date:   Thu, 10 Jun 2021 12:16:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] mm: page_vma_mapped_walk(): prettify
 PVMW_MIGRATION block
Message-ID: <20210610091609.64kddqad5dfm2qrs@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <378c8650-1488-2edf-9647-32a53cf2e21@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <378c8650-1488-2edf-9647-32a53cf2e21@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:42:12PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: rearrange the !pmd_present() block to
> follow the same "return not_found, return not_found, return true" pattern
> as the block above it (note: returning not_found there is never premature,
> since existence or prior existence of huge pmd guarantees good alignment).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
