Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19233F345C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbhHTTMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237996AbhHTTMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629486726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2tZh7fIirAY20LFdym0XInFDFkFJinMnH6nV5ZYKg78=;
        b=TrIdeWt3kOnWX1LQcSFabW7Ed/UWazxPdKklreWgVuZ4KiPCIiiGjubbhicJXVRAHcrBA/
        FCtMUXv9WClw252jg2WVqAsqKNdwrp2fdswFQn51li0BX1LoumPnLwdvgpsym2gKQpg3LD
        v9lUFSzJ2+Zs7tIo+DwA9gVQvP0K5m8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-oONNkl_fNRWknan_v_DgOA-1; Fri, 20 Aug 2021 15:12:04 -0400
X-MC-Unique: oONNkl_fNRWknan_v_DgOA-1
Received: by mail-qk1-f198.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so7153413qkd.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 12:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2tZh7fIirAY20LFdym0XInFDFkFJinMnH6nV5ZYKg78=;
        b=FQjUH2eHMn5iBYnL1uCFDVlulpQhcYkHjyRO+vcukGKopVPTP7rAD7BgCHwvdarkk/
         t8prWM0Nxpggi1DgS7R05TGYPwB4g4+XXVbkp3jCAC8Kd0Met4ZHM5hpdoXBT2vw6ONW
         Iih0vPwfo9us16XHNkORJ0aS3DEnDTZUBWHP63zKJ1heqv8AXY1yBl66lL7MmuVaVWJF
         HAEpQIZfs/aOqakyUPTJ8Hgmvs8kPVxDhCqyVw94iIJ9d9Utj5q1ziDG1zkVMCggSGPD
         0C1A+S6gif3j0Uby/v2s51kFTKgUcwZyX0oZYA5LEjDmFikzjHnZrInlu1+APYM4KoM3
         4SYA==
X-Gm-Message-State: AOAM530ZUQSOpiGiUCr6apiuAcRDipkVHpb6ZEJ948qDAnhhwmXRMbo+
        ezSgOVsxwwSb+t1YpK+FNdw6c9OFK7yfBcxIs60B36Qjt/ic+d4KncSg1eOltbexpR0mNfznLKD
        ahZUsyAOy78x0OETEctN3NYZc
X-Received: by 2002:a37:9445:: with SMTP id w66mr10437795qkd.410.1629486724406;
        Fri, 20 Aug 2021 12:12:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpB0vcNQo/sTpBiY0C92p1/c61IvSfKnROX6eWTDOUGU4LY+9Jqi6/Q57UYo9u0BlstvcOUw==
X-Received: by 2002:a37:9445:: with SMTP id w66mr10437783qkd.410.1629486724176;
        Fri, 20 Aug 2021 12:12:04 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::d413])
        by smtp.gmail.com with ESMTPSA id 69sm3990176qke.55.2021.08.20.12.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:12:03 -0700 (PDT)
Date:   Fri, 20 Aug 2021 15:12:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>
Subject: Re: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Message-ID: <YR/+gfL8RCP8XoB1@t490s>
References: <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com>
 <YRvtPrPmAorX+KY5@t490s>
 <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com>
 <YRwa6+jx5PukCn53@t490s>
 <c29a9994-8fa3-d36d-d973-f99314c243cf@redhat.com>
 <7F645772-1212-4F0D-88AF-2569D5BBC2CD@nutanix.com>
 <6ab58270-c487-2a56-b522-ea5100edb13c@redhat.com>
 <0A4C4E37-88C9-4490-9D8B-6990D805F447@nutanix.com>
 <5766d353-6ff8-fdfa-f8f9-764e8de9b5aa@redhat.com>
 <B130B700-B3DB-4D07-A632-73030BCBC715@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B130B700-B3DB-4D07-A632-73030BCBC715@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Tiberiu,

On Fri, Aug 20, 2021 at 04:49:58PM +0000, Tiberiu Georgescu wrote:
> Firstly, I am worried lseek with the SEEK_HOLE flag would page in pages from
> swap, so using it would be a direct factor on its own output. If people are working
> on Live Migration, this would not be ideal. I am not 100% sure this is how lseek
> works, so please feel free to contradict me, but I think it would swap in some
> of the pages that it seeks through, if not all, to figure out when to stop. Unless it
> leverages the page cache somehow, or an internal bitmap.

It shouldn't.  Man page is clear on that:

       SEEK_DATA
              Adjust the file offset to the next location in the file greater
              than or equal to offset containing data.  If offset points to
              data, then the file offset is set to offset.

Again, I think your requirement is different from CRIU, so I think mincore() is
the right thing for you.

> 
> Secondly, mincore() could return some "false positives" for this particular use
> case. That is because it returns flag=1 for pages which are still in the swap
> cache, so the output becomes ambiguous.

I don't think so; mincore() should return flag=0 if it's either in swap cache
or even got dropped from it.  I think its name/doc also shows that in the fact
that "as long as it's not in RAM, the flag is cleared".  That's why I think
that should indeed be what you're looking for, if swp entry can be ignored.
More below on that.

Note that my series is as you mentioned missing the changes to support
mincore() (otherwise I'll know the existance of it!).  It'll be trivial to add
that, but let's see whether mincore() will satisfy your need.

[...]

> It is possible for the swap device to be network attached and shared, so multiple
> hosts would need to understand its content. Then it is no longer internal to one
> kernel only.
> 
> By being swap-aware, we can skip swapped-out pages during migration (to prevent IO and potential thrashing), and transfer those pages in another way that
> is zero-copy.

That sounds reasonable, but I'm not aware of any user-API that exposes swap
entries to userspace, or is there one?

I.e., how do you know which swap device is which?  How do you guarantee the
kernel swp entry information won't change along with time?

Thanks,

-- 
Peter Xu

