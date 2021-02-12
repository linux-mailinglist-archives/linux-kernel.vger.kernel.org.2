Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BDB31A627
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBLUmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:42:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhBLUmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613162434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lhv01WUAUIt7cfh7FfrEWuxYc6udpak2O8cJ5MSKjhM=;
        b=ZPXGZ+HMh/N03OJ32IGC6/DHHlUrK/I8HYJ1INNAOwCEyVLudsMt1SZWEOevEHkMPnUOKW
        mFLknuYPGZz5/aXFQoKgvLL6iAE9JbkNsn5KbgNwkVRZpXzpJYMnR2Tj8AQqSTPsCvBIZE
        qD494odG3iUSceadH0yDw1Z2Fpt2040=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-nB-KtHtaM2GpX8ijKrebZA-1; Fri, 12 Feb 2021 15:40:32 -0500
X-MC-Unique: nB-KtHtaM2GpX8ijKrebZA-1
Received: by mail-qv1-f70.google.com with SMTP id h13so361962qvo.18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lhv01WUAUIt7cfh7FfrEWuxYc6udpak2O8cJ5MSKjhM=;
        b=sH0Z7+uZwJf2+PtzmNoR6Gs1cTQTY3Z3Eyegj0ZBxAGJbszOaIV2SWLHAhLhA9kpQh
         nGZXMrlNTQQGmwfbt0eFSV3vAiXhb9YuAO7poQ7PoMesA5mc7Ba6whBqrM1aUtHNoSHQ
         OVI3rUQVf8aWtONCr/6ACuX96Ne5xK/fE9k8aJ3sh2zRdCSX2PY5pNIVK2sCMh3dde6M
         p6+XEp3QvPKYKiIfBPoOPfRsc3pZsUoa1puEeB08sEluXqob8J1lFzZfYgYmW0QPEDgQ
         42IGdHV5DR9gHarufQElzVi7GITmTuY5zZssceTLnTWqdO8/wyMJjFsKivNcjVEcYTI1
         IZXA==
X-Gm-Message-State: AOAM530zmFiUQXEftyYgfqytslZhB+UNpqnSo7wR08fFvz6LrgDu/KvC
        ZtftI/dxvq4e+M4wsiFC5qdvM6xNpMhI/UhIgZv1QvmfwdvhhhxpeA4JO/ACEbMToblmvesDWTk
        k9fXuuaGxNUl2BcpD68570Sx/
X-Received: by 2002:a37:794:: with SMTP id 142mr4518168qkh.108.1613162432218;
        Fri, 12 Feb 2021 12:40:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUswzGCW3ELL2qJurJb7kKjeX2jYZXKw9W8lc+8Y9xOJdWIoFNQJ7ew2FPIeSB2eswM62WHQ==
X-Received: by 2002:a37:794:: with SMTP id 142mr4518131qkh.108.1613162431919;
        Fri, 12 Feb 2021 12:40:31 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id s129sm7083362qkh.37.2021.02.12.12.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 12:40:30 -0800 (PST)
Date:   Fri, 12 Feb 2021 15:40:28 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>
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
Subject: Re: [PATCH v5 02/10] hugetlb/userfaultfd: Forbid huge pmd sharing
 when uffd enabled
Message-ID: <20210212204028.GC3171@xz-x1>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-3-axelrasmussen@google.com>
 <0a991b83-18f8-cd76-46c0-4e0dcd5c87a7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a991b83-18f8-cd76-46c0-4e0dcd5c87a7@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 04:19:55PM -0800, Mike Kravetz wrote:
> want_pmd_share() is currently just a check for CONFIG_ARCH_WANT_HUGE_PMD_SHARE.
> How about leaving that mostly as is, and adding the new vma checks to
> vma_shareable().  vma_shareable() would then be something like:
> 
> 	if (!(vma->vm_flags & VM_MAYSHARE))
> 		return false;
> #ifdef CONFIG_USERFAULTFD
> 	if (uffd_disable_huge_pmd_share(vma)
> 		return false;
> #endif
> #ifdef /* XXX */
> 	/* add other checks for things like uffd wp and soft dirty here */
> #endif /* XXX */
> 
> 	if (range_in_vma(vma, base, end)
> 		return true;
> 	return false;
> 
> Of course, this would require we leave the call to vma_shareable() at the
> beginning of huge_pmd_share.  It also means that we are always making a
> function call into huge_pmd_share to determine if sharing is possible.
> That is not any different than today.  If we do not want to make that extra
> function call, then I would suggest putting all that code in want_pmd_share.
> It just seems that all the vma checks for sharing should be in one place
> if possible.

I don't worry a lot on that since we've already got huge_pte_alloc() which
takes care of huge pmd sharing case, so I don't expect e.g. even most hugetlb
developers to use want_pmd_share() at all, because huge_pte_alloc() will be the
one that frequently got called.

But yeah we can definitely put the check logic into huge_pmd_share() too.
Looking at above code it looks still worth a helper like want_pmd_share() or
with some other name.  Then... instead of making this complicated, how about I
mostly keep this patch but move want_pmd_share() call into huge_pmd_share()
instead?

Btw, Axel, it seems there will still be some respins on the pmd sharing
patches.  Since it turns out it'll be shared by multiple tasks now, do you mind
I pick those out and send them separately?  Then we can consolidate this part
to move on with either the rest of the tasks we've got on hand.

Thanks,

-- 
Peter Xu

