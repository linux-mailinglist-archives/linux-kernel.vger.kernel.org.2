Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67342311A6B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhBFDpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:45:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231774AbhBFCsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612579636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+wyoDc8XOR2cj3A6BtGWJ+SBoGGxhF/HLXZdPPz1zrI=;
        b=NfkxfGo2USee1vFlwiWtx8eX6/u+Mq7m+pJowFwztAjH3uZhBs584mJbhGgAMJsNWyeIl3
        zR++SutSs5Aa956RB3T1qSc9KtbnJlBF/OS3xK1bnIef2bIgdF10sQEKD7P4hlc8XKTIz5
        /XL5t343v6QhJxKa4oZEd7c0pXbmmrc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-9JKLlsftOGG9hKlw401GSw-1; Fri, 05 Feb 2021 21:47:14 -0500
X-MC-Unique: 9JKLlsftOGG9hKlw401GSw-1
Received: by mail-qt1-f198.google.com with SMTP id k90so6700009qte.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 18:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+wyoDc8XOR2cj3A6BtGWJ+SBoGGxhF/HLXZdPPz1zrI=;
        b=mZmQKmjuLZPAh+Kai2GejcRRwQ/EEFaMizcFiwf+GL1zsAl3sJZnecPCGKrhiUzOii
         UDqdqR4ekM0IrCfXKKrjAN3z/vM7IRxBrLNUj0PA0usWjhz3KfdIzzR2kiUtN7ISvg1l
         CTLBVVPzYmgmez59t3Wu3sEpjhbqI3mmt9+fZlaAJbSzP6G2TOVGC+2Av6ZOHjgz/z+Z
         T7bI2kjSu/nWx2JIXnM8nPPusx4FxyYFdch/Pb8FiOQ7rFYxMpJxfT6jZ4Qcg8L6IKOG
         NP4NJ6NZ4YidZyrywgagBFxNmZQf/v/Wjxni+JcgmE6+0j7omq2gU6Kyr82ytlW5DKHp
         jgsQ==
X-Gm-Message-State: AOAM531HF17uqSvtNt/hzw6moY2q2iRRL0caqsQ1heXv09m9zP08FpYw
        SCc8jD2X5zjRhoQoC1+EXvxZqnrBRIWizfszN0hU5EO+fifFnHfrM0WGIoxMIC0D3A+4gKLgKUF
        WsxodOAFRNX2w40g8fc+vsfA4
X-Received: by 2002:a37:9d53:: with SMTP id g80mr7350176qke.307.1612579634199;
        Fri, 05 Feb 2021 18:47:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeKIuLtR8y4v8gCIkyTs9rsJZfFFo+tzRDqiO6R5CA7Iai/cKcEqVyrzhf/2UEe5+FVdUrcw==
X-Received: by 2002:a37:9d53:: with SMTP id g80mr7350163qke.307.1612579633991;
        Fri, 05 Feb 2021 18:47:13 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 22sm11848068qke.123.2021.02.05.18.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 18:47:13 -0800 (PST)
Date:   Fri, 5 Feb 2021 21:47:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RFC 00/30] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <20210206024711.GE3195@xz-x1>
References: <20210115170907.24498-1-peterx@redhat.com>
 <20210129224938.GC260413@xz-x1>
 <alpine.LSU.2.11.2102051411200.5769@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2102051411200.5769@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 02:21:47PM -0800, Hugh Dickins wrote:
> On Fri, 29 Jan 2021, Peter Xu wrote:
> > 
> > Huge & Mike,
> > 
> > Would any of you have comment/concerns on the high-level design of this series?
> > 
> > It would be great to know it, especially major objection, before move on to an
> > non-rfc version.
> 
> Seeing Mike's update prompts me to speak up: I have been looking, and
> will continue to look through it - will report when done; but find I've
> been making very little forward progress from one day to the next.
> 
> It is very confusing, inevitably; but you have done an *outstanding*
> job on acknowledging the confusion, and commenting it in great detail.

I'm honored to receive such an evaluation, thanks Hugh!

As a quick summary - what I did in this series is mostly what you've suggested
on using swp_type==1 && swp_offset=0 as a special pte, so the swap code can
trap it.  The only difference is that "swp_type==1 && swp_offset=0" still uses
valid swp_entry address space, so I introduced the "swap special pte" idea
hoping to make it clearer, which is also based on Andrea's suggestion.  I hope
I didn't make it even worse. :)

It's just that I don't want to make this idea that "only works for uffd-wp".
What I'm thinking is whether we can provide such a common way to keep some
records in pgtable entries that point to file-backed memory.  Say, currently
for a file-backed memory we can only have either a valid pte (either RO or RW)
or a none pte.  So maybe we could provide a way to start using the rest pte
address space that we haven't yet used.

Please take your time on reviewing the series.  Any of your future comment
would be greatly welcomed.

Thanks,

-- 
Peter Xu

