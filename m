Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D24A31A82C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 00:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhBLXDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 18:03:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231532AbhBLXDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613170901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KrxNhkpJSkLcCNjs8YiuV+FXOAKe3IRMAr5lF3Khj2o=;
        b=Glh/4JYfzTWlZrJrHlO1UjDMlkTr2c35HppcdUgWQjYBqyg1Yeg1R37tzQxoXF1/JnZl0B
        OdAie1SLcZCe3VRJI9SPwDUCsgcgSGCFdaXaM0OL1oidcujg/POz0/774kdGZRYyrfzH++
        lLkTuW/SBE/jehlTbOgXKWDWPuqOxas=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-gqldho7UOqea_7vgpJRXCA-1; Fri, 12 Feb 2021 18:01:40 -0500
X-MC-Unique: gqldho7UOqea_7vgpJRXCA-1
Received: by mail-qk1-f200.google.com with SMTP id f140so585156qke.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 15:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KrxNhkpJSkLcCNjs8YiuV+FXOAKe3IRMAr5lF3Khj2o=;
        b=qm/DhZjAs16Q/V/JKBPfD4GhJMa4fytHZiZqL8c8hb7ORfsiIrKU37WykXpQUmz/Ik
         7mLsVSMkfz8JJw4aKxtpOKPu9MVVhrY9CVG6OvC1+174f05q6jtxR4qG/aQ23ak+k6id
         uW5SUDHrHeRn8hih5JrBABayXt+aVO9pV2hLUPRlh9lnFDXUwrj/FVbChAeOSfLq6sip
         YFaZIB9SNOIO/bfNeijHAls3zp+Re+OCpUkuKMVQT4/EAZO0a0QqqKkJN0ZPUEaTmU98
         VNLls2FS/BFpXn8yR+LW7XG4kTVBAAXkfEVs0ePHPcKBFqkI5IMVPa3IKLMKulBjwqL3
         07og==
X-Gm-Message-State: AOAM532WU4E4gbj/OeYSykUStY1bZiKQaMAuy1kyxqywUWHF/YDpY8Gd
        N2SE70FasrnAdy+ffXpQ+ZUFrJY9YUldTjMb0T1VsWP4QOOCSzGUFj+phA/1/VZz20ZjCUuoLfD
        KiQCygYJkJ5EvqlU0K8qOdIrY
X-Received: by 2002:a37:b2c4:: with SMTP id b187mr4905957qkf.153.1613170899918;
        Fri, 12 Feb 2021 15:01:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdr8KiYQo4/t+/dJmGbq34GKsvGbDSKjWg6u+rkPUHgRLm4huopjrCOovHivyHFM/is1qJtg==
X-Received: by 2002:a37:b2c4:: with SMTP id b187mr4905922qkf.153.1613170899689;
        Fri, 12 Feb 2021 15:01:39 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id f188sm7242711qkj.110.2021.02.12.15.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 15:01:39 -0800 (PST)
Date:   Fri, 12 Feb 2021 18:01:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 05/10] userfaultfd: add minor fault registration mode
Message-ID: <20210212230136.GG3171@xz-x1>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-6-axelrasmussen@google.com>
 <CAJHvVch8jmqu=Hi9=1CHzPHJfZCRvSb6g7xngSBDQ_nDfSj-gA@mail.gmail.com>
 <20210212222145.GB2858050@casper.infradead.org>
 <20210212224405.GF3171@xz-x1>
 <CAJHvVcgiD5OwFVK0Mgy-XDxM2PGCLkOJSCLLSF2Z8bYrf5BTJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcgiD5OwFVK0Mgy-XDxM2PGCLkOJSCLLSF2Z8bYrf5BTJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:51:17PM -0800, Axel Rasmussen wrote:
> On Fri, Feb 12, 2021 at 2:44 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Feb 12, 2021 at 10:21:45PM +0000, Matthew Wilcox wrote:
> > > On Thu, Feb 11, 2021 at 11:28:09AM -0800, Axel Rasmussen wrote:
> > > > Ah, I had added this just after VM_UFFD_WP, without noticing that this
> > > > would be sharing a bit with VM_LOCKED. That seems like not such a
> > > > great idea.
> > > >
> > > > I don't see another unused bit, and I don't see some other obvious
> > > > candidate to share with. So, the solution that comes to mind is
> > >
> > > it'd be even better if you didn't use the last unused bit for UFFD_WP.
> > > not sure how feasible that is, but you can see we're really short on
> > > bits here.
> >
> > UFFD_WP is used now for anonymouse already.. And the support for hugetlbfs and
> > shmem is in rfc stage on the list.
> >
> > Is it possible to use CONFIG_ARCH_USES_HIGH_VMA_FLAGS here?  So far uffd-wp is
> > only working for 64 bit x86 too due to enlarged pte space.  Maybe we can also
> > let minor mode to only support 64 bit hosts.
> 
> At least for my / Google's purposes, I don't care about 32-bit support
> for this feature. I do care about both x86_64 and arm64, though. So
> it's a possibility.
> 
> Alternatively, the "it's an API feature not a registration mode"
> approach I sent in my v6 also works for me, although it has some
> drawbacks.

Per-vma has finer granularity and logically more flexible.  If it's low hanging
fruit, let's think about it more before giving up so quickly.

Sorry I commented late for this - I got diverged a bit in the past days.  While
you worked on it so fast (which in many cases still a good thing :).

> 
> Another option is, would it be terrible to add an extra u16 or u32 for
> UFFD flags to vm_area_struct (say within vm_userfaultfd_ctx)?
> Historically we've already added a pointer, so maybe an extra say 16
> bits isn't so bad? This would avoid using *any* VM_* flags for UFFD,
> even VM_UFFD_MISSING could be in this new flag field.

For 64bit hosts there're still places for vm_flags.  It's just 32bit, while
there's option to make it 64bit-only.  Even if we'd add a new field, those bits
were still unused on 64bit hosts.  IMHO we should try to use them before adding
new field which will actually impact all hosts.

Thanks,

-- 
Peter Xu

