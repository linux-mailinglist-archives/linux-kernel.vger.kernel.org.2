Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6492731A80A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhBLWtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:49:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232464AbhBLWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613169850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nUItIC8AvpxN/ifxyQrgm5PhbIt2D7FId215syGUsUA=;
        b=cuwMLVZ2FzMEVhBupYdFUzTcYJCJAsBrbaSVaW1DJGuErC4uMy5X3491zJvWBIhKYCKpGO
        eRXMcbZ7/AaeWBahdokZuJcRVj2epfuM3EWg55obuqaXy4UU9agY7qdIfH0YXG4KbxfmjB
        7OQRgfBkaViXwUbdT5qFjdsgre27QqU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-p80Ry_zDPfSYDk2eHeclsQ-1; Fri, 12 Feb 2021 17:44:08 -0500
X-MC-Unique: p80Ry_zDPfSYDk2eHeclsQ-1
Received: by mail-qt1-f198.google.com with SMTP id d11so1169459qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 14:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nUItIC8AvpxN/ifxyQrgm5PhbIt2D7FId215syGUsUA=;
        b=pjgqWtiFrmFrn4Pvzokn86O/p3Pxm4XniiZ31L/hGPWe8CGNOjuIwINxVTmCgAtXBT
         b94NSvCQBnjpJlUqt1FoUm75uxDqleg4iYfiPJEnGKYc0YcYrBlMqt8MtIYjqikOunnr
         bkENcA6hloQySslMYnC0YqmZZo5Cy9DNFaiu3jhVhZ7n824BBaRkvrxYmXqENIZs7GlR
         J7+/wWMQr3GtU52PYSCbp4UgMU/PISIo8hF/9bgwDS4lGGTe5BJ3tT8MG5W35G/4ENcL
         TWmEKSK3KbXyctq+JNj/n2qsn+LFcNE3RXmXkKS+KL4QUvqaSsd3OublIsy8Br+OpJFM
         r5Lw==
X-Gm-Message-State: AOAM530FhnWaJQ+Iz1hTuFdWPjpIyXou99cVIURcTTTpQCdO45cTntUb
        vQ/VxlKHVM8lq0D/P7E7DxXjQXSXoGWNYgLymxknMmGPZPKTITNiNGxNLLlfSnqd73tF1sIiGhm
        e5R1ZSRvKF16mpNOaSTiqka8k
X-Received: by 2002:aed:2705:: with SMTP id n5mr4756513qtd.36.1613169848289;
        Fri, 12 Feb 2021 14:44:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybkH7EUY1ijGZtLtkL/3zdNnvQq/skhUoxC9qRmqlhCz+jadj7lnP17oSpV43oxXUFKfZbcw==
X-Received: by 2002:aed:2705:: with SMTP id n5mr4756479qtd.36.1613169848101;
        Fri, 12 Feb 2021 14:44:08 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id f188sm7216631qkj.110.2021.02.12.14.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 14:44:07 -0800 (PST)
Date:   Fri, 12 Feb 2021 17:44:05 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20210212224405.GF3171@xz-x1>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-6-axelrasmussen@google.com>
 <CAJHvVch8jmqu=Hi9=1CHzPHJfZCRvSb6g7xngSBDQ_nDfSj-gA@mail.gmail.com>
 <20210212222145.GB2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210212222145.GB2858050@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 10:21:45PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 11, 2021 at 11:28:09AM -0800, Axel Rasmussen wrote:
> > Ah, I had added this just after VM_UFFD_WP, without noticing that this
> > would be sharing a bit with VM_LOCKED. That seems like not such a
> > great idea.
> > 
> > I don't see another unused bit, and I don't see some other obvious
> > candidate to share with. So, the solution that comes to mind is
> 
> it'd be even better if you didn't use the last unused bit for UFFD_WP.
> not sure how feasible that is, but you can see we're really short on
> bits here.

UFFD_WP is used now for anonymouse already.. And the support for hugetlbfs and
shmem is in rfc stage on the list.

Is it possible to use CONFIG_ARCH_USES_HIGH_VMA_FLAGS here?  So far uffd-wp is
only working for 64 bit x86 too due to enlarged pte space.  Maybe we can also
let minor mode to only support 64 bit hosts.

Thanks,

-- 
Peter Xu

