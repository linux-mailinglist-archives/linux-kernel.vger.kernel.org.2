Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898D0380401
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhENHJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhENHJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:09:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FBCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:07:51 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id j12so17447786pgh.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uMgRMGg/r3gIQINvH+QzQw4VB9eKfNkU/NWagyALQy0=;
        b=PbVOBlIX5vaNdsa+smKUweNt1LFR3XYJHTQMw1vBkxnXZxn4mb0CHtm+PJwGXlspIi
         AVZuIhwVKu9c1KehnCjg7xYut3FJp6vO437EX+SJRPW74HPYsOzDElqTDOPvjs6t/x2Z
         Er6+pGXd74YtlJNXGZVXTTTIMKQFldIeB39fR6md//OrAqD15tctErLDh9FilL/LKgzP
         +NrGrlqa3hVMGB7xFRYRamHzDUigJHmc1x9cJ6th1wyZU+B9VCpL5XVnXrkduOCoQdYW
         Hob5oKcfVRtACnBf3/PC8dM6TLAF4J6t1efJblLyO6YM3XOhrAv93inv/Y0VAFD09T57
         OA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uMgRMGg/r3gIQINvH+QzQw4VB9eKfNkU/NWagyALQy0=;
        b=LsYbe2wBGvF2yllTzhP3vB49ffRNce719o2WQVJ/1nKsf4Eh9E8mkyjNIBY+SAvJUJ
         E/gWsvu/7qBbQR0GH41xklEHE1JX0szazDqSNi04H87l33kscNmMNg3o+Pyt5PPFuCNT
         v2i7hodeXmD2Jv4xm8YR1zP07xCRVZhkmqgLFEPTwv68ZI2ncqidhh4Wz+5o0pA6yGtL
         iBcspa4AVwsEJxPoSKAwpSJjP5DZoZmABXT3ke/QAsTc9Xp0Jaob2X5/jyfI8hQ8EQ4D
         DZpC1VTM2tWfL2Knwnzi7E6JnAWdsjeEC0KlVnG6Sr+bbTXydCe6B8ahr+xwTl1NAiQT
         COyA==
X-Gm-Message-State: AOAM530awFeRPLVB6OTov8hwpPrId4NpLOtdzQV3xfLn6FzOxZGdMjzb
        QnkHz1LKQ/mS6ZFCFeDrfpnXpQ==
X-Google-Smtp-Source: ABdhPJwAVGQcyFu8huddUFoRGDzEvr7xGXtt8NmG/sXBUnLfl67u8rYlL3910hnQ0PeqKG/ewx893w==
X-Received: by 2002:a63:1165:: with SMTP id 37mr45959674pgr.295.1620976070717;
        Fri, 14 May 2021 00:07:50 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n11sm3460701pfu.121.2021.05.14.00.07.49
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 14 May 2021 00:07:50 -0700 (PDT)
Date:   Fri, 14 May 2021 00:07:38 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 00/24] userfaultfd-wp: Support shmem and hugetlbfs
In-Reply-To: <YJwl1wNM18trv7px@t490s>
Message-ID: <alpine.LSU.2.11.2105132312350.3969@eggly.anvils>
References: <20210427161317.50682-1-peterx@redhat.com> <YJwl1wNM18trv7px@t490s>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021, Peter Xu wrote:
> On Tue, Apr 27, 2021 at 12:12:53PM -0400, Peter Xu wrote:
> > This is v2 of uffd-wp shmem & hugetlbfs support, which completes uffd-wp as a
> > kernel full feature, as it only supports anonymous before this series.
> 
> Ping..
> 
> Thinking about a repost, as this series shouldn't be able to apply after we've
> got more relevant patches into -mm.  E.g., the full minor fault, and also some
> small stuff like pagemap, as we need one more patch to support shmem/hugetlbfs
> too.
> 
> Hugh, haven't received any further comment from you on shmem side (or on the
> general idea).  It would be great to still have some of your input.
> 
> Let me know if you prefer to read a fresh new version otherwise.

I am very sorry to let you down, Peter, repeatedly; but it is now very
clear that I shall *never* have time to review your patchset - I am too
slow, have too much else to attend to, and take too long each time to
sink myself deep enough into userfaultfd.

I realize that you're being considerate, and expecting no more than
a few comments from me, rather than asking for formal review; but it's
still too much for me to get into.

The only reason I was involved at all, was when you were wondering how
to handle the pagetable entries for shmem.  I suggested one encoding,
Andrea suggested slightly differently: Andrea's was more elegant (no
"swap type" required), and it looked like you went with his - good.

I wonder whether you noticed
https://lore.kernel.org/linux-mm/20210407084238.20443-2-apopple@nvidia.com/
which might interfere.  I've had no more time to look at that than yours,
so no opinion on it (and I don't know what happened to it after that).

Please keep uppermost in mind when modifying mm/shmem.c for userfaultfd,
the difference between shared and private; and be on guard against the
ways in which CONFIG_USERFAULTFD=y might open a door to abuse.

Thanks,
Hugh
