Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82933F8D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbhHZRaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhHZRaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:30:15 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6936C061757;
        Thu, 26 Aug 2021 10:29:27 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b64so4369600qkg.0;
        Thu, 26 Aug 2021 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=uF5IFoYHsR1lZIdnu6gTDDCluDFUW1Epl5M96Qr9kxs=;
        b=ArC8parQi12aPAfGoWzk0aeT0/zBlsU/OKeV0nbEI853NSXsshbHSO6/XC8zsGwuV0
         roG3jz8IxDyobLNm3JTIe/48VHLM/2nJ8AwHyiERUgW5xvhqgmrezuaEXUOnhU3eOK14
         7fEun9RzNj+I18Ikg2PMT4LDLoyX5b35oTF87KTq30kFIyfnJI7qmqP8Kvg1tmC2Zwg2
         5BYjeTRO4zVVfI0sB5Sq4q4oZnd+Wt0VZV/cA3jcRq2flp4ue+rzHlkIVb795VrzlllZ
         pT2rixtv9jQtb1sTXwh3H7qoo3bP8nDP/0PpasCNv4MK7vLVWmmfkFRal7i+yiF9dcSU
         rLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=uF5IFoYHsR1lZIdnu6gTDDCluDFUW1Epl5M96Qr9kxs=;
        b=hHwhmXK6Z+1+rh90lJyZN6vnK39SOc4tDIssdDAr1bh3jOhJ74Rn4XELLkitMVyQyz
         VpCsDdVWcqeRi+inDhoCwlsHflFlYWfDOD5vhwDNxEXUnDMqPP05a2CiiWmk5OjtEGW5
         OHJo3fkcbWw3fcF4oqt+4qIetptm/4p9P8wqTm08P4YtlNtFygnbKdDJHZrnggzoVfuZ
         24YlYfyq1p59y/3Qla/iTxw9XBUr7CSY67fGFFQCNWWhjF/3akJzHu65DRhndPXGG6QV
         k2wX9FVev5o608xMEW6JMWqNxcyF1YS7gS6MTxfqUnbkC10AXCqto4TiewIVaJI+E062
         baKA==
X-Gm-Message-State: AOAM532SHAYskrkCDdB6mnFzECqr4a/E4TYwS2s0PStpMGH7tK7empu7
        o9Rdbzr89e9qMG765K/BjEk=
X-Google-Smtp-Source: ABdhPJwwp98OJiE98pn+DKCzl2a89Oo78632vYbCnYS/SR5C3S62oww9ACKrOsiM726DTP58T16ayQ==
X-Received: by 2002:a05:620a:1aa7:: with SMTP id bl39mr5140925qkb.304.1629998966866;
        Thu, 26 Aug 2021 10:29:26 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id d78sm2728885qkg.92.2021.08.26.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 10:29:26 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org,
        markubo@amazon.com, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        corbet@lwn.net, dwmw@amazon.com, elver@google.com,
        fan.du@intel.com, foersleo@amazon.de, greg@kroah.com,
        gthelen@google.com, guoju.fgj@alibaba-inc.com, jgowans@amazon.com,
        joe@perches.com, mgorman@suse.de, mheyne@amazon.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sieberf@amazon.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v34 05/13] mm/damon: Implement primitives for the virtual memory address spaces
Date:   Thu, 26 Aug 2021 17:29:20 +0000
Message-Id: <20210826172920.4877-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <358fa060-7702-d523-5169-f25a3de0c22e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello David,


On Thu, 26 Aug 2021 16:09:23 +0200 David Hildenbrand <david@redhat.com> wrote:

> > +static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> > +{
> > +	pte_t *pte = NULL;
> > +	pmd_t *pmd = NULL;
> > +	spinlock_t *ptl;
> > +
> 
> I just stumbled over this, sorry for the dumb questions:

Appreciate for the great questions!

> 
> 
> a) What do we know about that region we are messing with?
> 
> AFAIU, just like follow_pte() and follow_pfn(), follow_invalidate_pte() 
> should only be called on VM_IO and raw VM_PFNMAP mappings in general 
> (see the doc of follow_pte()). Do you even know that it's within a 
> single VMA and that there are no concurrent modifications?

We have no idea about the region at this moment.  However, if we successfully
get the pte or pmd under the protection of the page table lock, we ensure the
page for the pte or pmd is a online LRU-page with damon_get_page(), before
updating the pte or pmd's PAGE_ACCESSED bit.  We release the page table lock
only after the update.

And concurrent VMA change doesn't matter here because we read and write only
the page table.  If the address is not mapped or not backed by LRU pages, we
simply treat it as not accessed.

> 
> b) Which locks are we holding?
> 
> I hope we're holding the mmap lock in read mode at least. Or how are you 
> making sure there are no concurrent modifications to page tables / VMA 
> layout ... ?
> 
> > +	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))

All the operations are protected by the page table lock of the pte or pmd, so
no concurrent page table modification would happen.  As previously mentioned,
because we read and update only page table, we don't care about VMAs and
therefore we don't need to hold mmap lock here.

Outside of this function, DAMON reads the VMAs to know which address ranges are
not mapped, and avoid inefficiently checking access to the area with the
information.  Nevertheless, it happens only occasionally (once per 60 seconds
by default), and it holds the mmap read lock in the case.

Nonetheless, I agree the usage of follow_invalidate_pte() here could make
readers very confusing.  It would be better to implement and use DAMON's own
page table walk logic.  Of course, I might missing something important.  If you
think so, please don't hesitate at yelling to me.


Thanks,
SJ

> 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
