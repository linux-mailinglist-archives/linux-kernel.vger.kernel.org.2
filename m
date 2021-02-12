Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E9731A762
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBLWPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:15:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229602AbhBLWPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613168050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NM6XT65mv4VcavdfmwjtH1q2UKP+BPnEnoXWk6zcyFs=;
        b=cjcgKWMn2ise+d+twbicpnbDafBFcJ9XHn1TkACZzh8FqiE8JcRj9Ypfdmf5vgipiuzzu7
        vciBU+nyBJcyRUNT4gKAnY6SPpQR9zUmejAaXbnLnzGT8Op5NPPvYelc7D6WoDSxwfw2tU
        Z2L+NKDadWFfy8xjT5KT+Uf7R+C0+74=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328--nt_fTXZPUa-0oy04bHq6g-1; Fri, 12 Feb 2021 17:14:08 -0500
X-MC-Unique: -nt_fTXZPUa-0oy04bHq6g-1
Received: by mail-qv1-f71.google.com with SMTP id h10so574127qvf.19
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 14:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NM6XT65mv4VcavdfmwjtH1q2UKP+BPnEnoXWk6zcyFs=;
        b=LImtIHYTy8hWfxuA+k6XfH+k+hWsO84CioN++ja1dXXIHl03G6tVVljJbAl3tQSDId
         /VAnCiKeKIsyvxIFo6UNoCUJNI4qLLpOgcoGa1Sb0pkBqlUl6ruZoc82aC+cu9JvgzIl
         +8QtJgyLtJQBKt7kzCTrJkhQSRU4I0xxkVfcraLj/25q+Kc4ucxOTREUECZpitREXi80
         RBt1Ozb7J3qIFROLuqDDdYUgGQ2IUe4zls/LjF9YQcFClu1A1oGA5prNNIuM7R4uUhrA
         suisUPLoNE2zB3UdLkJtnjWNPry/cfJQmFg8CaDy++gIQrstn6RatalA0FptGl2gyVkQ
         tlrg==
X-Gm-Message-State: AOAM533s99AuGCsIK2D2RbVkwo+97PVnF0uL1NDPswjLEtSnWhYWavPO
        wC03q8wtFamqWfucWhFXbxyTo+PS7G4YLqUTnsflbF9SKrOplTmehN+rCuqbCCP6qQ4/GB8iLpE
        W9kznJGA8B+Va9S5tUi7TZpca
X-Received: by 2002:a05:620a:6d0:: with SMTP id 16mr4645213qky.335.1613168047025;
        Fri, 12 Feb 2021 14:14:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybRSOjiYGjU1WMov5+xWuEznSoVTMv4b/Sz5l/l/d/2YmGS2gMcMRRnE4elHcSTnBXvTjm4A==
X-Received: by 2002:a05:620a:6d0:: with SMTP id 16mr4645162qky.335.1613168046774;
        Fri, 12 Feb 2021 14:14:06 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id p16sm6558793qtq.24.2021.02.12.14.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 14:14:06 -0800 (PST)
Date:   Fri, 12 Feb 2021 17:14:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 04/10] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
Message-ID: <20210212221404.GE3171@xz-x1>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-5-axelrasmussen@google.com>
 <517f3477-cb80-6dc9-bda0-b147dea68f95@oracle.com>
 <20210212211856.GD3171@xz-x1>
 <a32b5427-0560-fa24-450c-376c427dd166@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a32b5427-0560-fa24-450c-376c427dd166@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 01:34:03PM -0800, Mike Kravetz wrote:
> I'm good with the new MMU_NOTIFY_HUGETLB_UNSHARE and agree with your reasoning
> for adding it.  I really did not know enough about usage which caused me to
> question.

It actually is a good question..  Because after a 2nd thought I cannot think of
any mmu notifier usage to explicitly listen to huge pmd unshare event - it
could be just a too internal impl detail of hugetlbfs.  I think any new flag
should justify itself when introduced.  Before I could justify it, I think
MMU_NOTIFIER_CLEAR is indeed more suitable.

Thanks,

-- 
Peter Xu

