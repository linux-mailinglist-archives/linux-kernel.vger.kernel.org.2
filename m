Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD4309025
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhA2WdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:33:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231246AbhA2WdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611959494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bkQ5Fz9RLzxxbo8DDzhzWAT6RjyUwzhlJneTB6y567o=;
        b=W+QCWlIslc3WFz8xBY5V0NDD88XMXMMYIaACXU1X6Lv/SY244nx4qCCpzxijnWRoLuA40o
        BNJMyfetiqAVTvQy09G2Cjr+JmYfdj6JAGWuAsoWTmZF9REefuFy++v1RJ/ERvrAtMzP16
        Ib373xKB/lLaWStCL3mPSVFKjpE3oa0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-keLhSUVCMxa3CCMw-39Tuw-1; Fri, 29 Jan 2021 17:31:33 -0500
X-MC-Unique: keLhSUVCMxa3CCMw-39Tuw-1
Received: by mail-qt1-f198.google.com with SMTP id d1so7085714qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 14:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bkQ5Fz9RLzxxbo8DDzhzWAT6RjyUwzhlJneTB6y567o=;
        b=U1GB/4lZICk0uq5fJ6F+XOYV9Q6Fuvc+sNwILI0A+AG33iClYG9jA2uUGWRxewpH7z
         P4+T3WLoeKpfjd0Kvi5w2NCDs4OU5DtFe+mZiBuziYVO8RBiB1usyQtTqcUTGVyE4lVH
         tdkDT898MpssmzxXyB9Z7RfiMkxMrE8AdzAuYj+dXKcjSUpbtimJC342XbtAGNqqBVXO
         WJb5rPTC+H74fXxWarHGwWAYRzvQnKvHj8pVpqOxshNWCjahU0D44sRqHDEKIfdlEH/l
         9Z8XrPdB5LiFUS+qWUU8yirUxa64fO+Lh4pPO3DGe/vr6GLcuGdWNuJoye9kSd25Kggq
         ojgA==
X-Gm-Message-State: AOAM533HXvVg1vrIzyUjV4Qbw2ecRkWEK559GeCQ42zgz/IEq/JE5Uuu
        5ayDiEeqo+UWN/SeX5yOa0BsW1X4R1hCl1nVQlzQ0EOof6AS8aWCauP1N0WVlqQaoALGugWZQUw
        6/4nixir2WhFAVe/8ciFn14dW
X-Received: by 2002:a05:622a:216:: with SMTP id b22mr6119531qtx.163.1611959492706;
        Fri, 29 Jan 2021 14:31:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyf27ceBG5a1vxnJjTDK9ymzfRnbILb6rGsC4KhbZQMdfq6pGYGr2v80zPM37vNL0V1Liyd8Q==
X-Received: by 2002:a05:622a:216:: with SMTP id b22mr6119516qtx.163.1611959492528;
        Fri, 29 Jan 2021 14:31:32 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id p188sm6231399qkf.40.2021.01.29.14.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:31:31 -0800 (PST)
Date:   Fri, 29 Jan 2021 17:31:29 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RFC 21/30] hugetlb: Pass vma into huge_pte_alloc()
Message-ID: <20210129223129.GB260413@xz-x1>
References: <20210115170907.24498-1-peterx@redhat.com>
 <20210115170907.24498-22-peterx@redhat.com>
 <CAJHvVcg4tjgRis=WF77phGC6Xm=DBo1W5pDa_d0ZP-Df1VXRxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcg4tjgRis=WF77phGC6Xm=DBo1W5pDa_d0ZP-Df1VXRxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 02:59:13PM -0800, Axel Rasmussen wrote:
> > +pte_t *huge_pte_alloc(struct mm_struct *mm, structt vm_area_struct *vma,
> 
> This was pointed out to me just after I sent v3 of my series today
> (which includes this patch):
> 
> Typo, s/structt/struct/.

Thanks Axel - fixed here too.  It's strange why it didn't complain.

Re the minor fault series, I thought it would be good to have some comment from
Andrea/Mike or others, but in all cases I'll read your v3 next week.

(A small heads-up: you'd better use v3.1 next time for that single patch, so
 that just in case there will be a complete v4 series then that patch won't
 collapse with it)

-- 
Peter Xu

