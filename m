Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D081F3AA341
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhFPSiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhFPSiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:38:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F6DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:36:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k15so2902913pfp.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=68dUbqfE4SHuzDV/ITTjNzfPVwl+Y5E4YdaUjtV5+SM=;
        b=J+iBSCxVI9jYH68oWvPqs6SrIxZU+B/vsIhREijY8w3hbBXi0m+cMBoTbXebRF6s6x
         4UxTaREsNGYJa8ehBhFYFDN5idvzz93nPKAEvXMkrPIkJDV3Ju/C/WB6Lz1ii9QwuUMQ
         OXBorfuFc8hzPkZ9tLz+tSJHcedePwKKCRonrQLqmZLycOG1U6QhEfc+LRgVHVCL5HCX
         172NrBIiRlHwjuJQa9vHZBjQocLtduj64PkGZrCt1l9JazTF6trQy0l77j9i5+SJhBs0
         MH2gXxNW8017ZMuqXOHr8S5hLZU1/3/LQbEXmZT+q4sxzIisYpc1r+88qS+ObnSW6FBf
         JVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=68dUbqfE4SHuzDV/ITTjNzfPVwl+Y5E4YdaUjtV5+SM=;
        b=cl0xWyxSWH0jIkEv3xaZJ12GSgE8YYWDUXJDZKAPjRNsPPovZmQp9RI2VDCVmHCIPq
         ZaPbzTuRsKH6Jt3Cj5CTFMvn+eUcQ/lYXGtjpUvfLhbzjhdGkq2a9B37By/mSZYbzLNT
         RnNTkYsdhslx9PkVYb6NDbjyiinMbVI1pemJowpEkiSHQnJfEW0sl3D1EmiuXgU1LZVh
         KlC/BYf5zWxUT+jm9x8T6hAtjZqakRor9oZsTC1iH0EbWdtFfsJ1j8bm+G3XHA22IPbd
         lFKa40nWTylYsjU7OTVAkWYUgVktM+mnKMvRt5HVDFZWGf+QZYC/W8O8tAeCsKWQQ+bu
         XJrg==
X-Gm-Message-State: AOAM532ECveGmyXS+zojrpmw5+BbIkg3AU1fep+5jn00/cfPcDLCnxXv
        JU93fOEL+PNXugoIUC92edA=
X-Google-Smtp-Source: ABdhPJzlYRExpxBz/5ZI5xAqecq1F1uVwziv1Eqs8rATfkZT1HYyPVtArS2KZGFO5m5Np9AOdUb7GA==
X-Received: by 2002:a63:d40d:: with SMTP id a13mr972537pgh.382.1623868603888;
        Wed, 16 Jun 2021 11:36:43 -0700 (PDT)
Received: from nuc10 (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id b133sm2944503pfb.36.2021.06.16.11.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:36:43 -0700 (PDT)
Date:   Wed, 16 Jun 2021 11:36:39 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        gregkh@linuxfoundation.org
Subject: Re: kmemleak memory scanning
Message-ID: <YMpEtyUP0vuWo9HV@nuc10>
References: <YMe8ktUsdtwFKHuF@nuc10>
 <20210615101515.GC26027@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615101515.GC26027@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Catalin,

On Tue, Jun 15, 2021 at 11:15:15AM +0100, Catalin Marinas wrote:
> Hi Rustam,
> 
> On Mon, Jun 14, 2021 at 01:31:14PM -0700, Rustam Kovhaev wrote:
> > a) kmemleak scans struct page (kmemleak.c:1462), but it does not scan
> > the actual contents (page_address(page)) of the page.
> > if we allocate an object with kmalloc(), then allocate page with
> > alloc_page(), and if we put kmalloc pointer somewhere inside that page, 
> > kmemleak will report kmalloc pointer as a false positive.
> > should we improve kmemleak and make it scan page contents?
> > or will this bring too many false negatives?
> 
> This is indeed on purpose otherwise (1) we'd get a lot of false
> negatives and (2) the scanning would take significantly longer. There
> are a lot more pages allocated for user processes than used in the
> kernel, we don't need to scan them all.
> 
> We do have a few places where we explicitly call kmemleak_alloc():
> neigh_hash_alloc(), alloc_page_ext(), blk_mq_alloc_rqs(),
> early_amd_iommu_init().

makes sense, tyvm!

> > b) when kmemleak object gets created (kmemleak.c:598) it gets checksum
> > of 0, by the time user requests kmemleak "scan" via debugfs the pointer
> > will be most likely changed to some value by the kernel and during
> > first scan kmemleak won't report the object as orphan even if it did not
> > find any reference to it, because it will execute update_checksum() and
> > after that will proceed to updating object->count (kmemleak.c:1502).
> > and so the user will have to initiate a second "scan" via debugfs and
> > only then kmemleak will produce the report.
> > should we document this?
> 
> That's a mitigation against false positives. Lot's of objects that get
> allocated just prior to a memory scan have a tendency to be reported as
> leaks before they get referenced via e.g. a list (and the in-object
> list_head structure updated). So you'd need to get the checksum
> identical in two consecutive scans to report it as a leak.
> 
> We should probably document this.

thanks, i'll send a documentation patch for this

