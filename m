Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FE436CC77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 22:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhD0Unn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 16:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236993AbhD0Unl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619556177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RvrYyTMEiHtCZW0MwDUjdnqhLrqE4kTWBWaQVaWhX4=;
        b=R+8E57gn+B5pgn/NxvlCNBsLbYiPuVc5cch5zvyqtSod1/N6mzM5Z3rQFumyylhiY4OEfl
        oteEHckGYAV8w/VvHMRE2m96Fpox5QftSI+Fa5zohXmfwErXAkyMlKaeFluZ2IVBsm7+od
        BlUGHZBK51b/8ahGRkrEM0V+eAWhFF0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-NrHpABDHO2i9CoqGT-aphg-1; Tue, 27 Apr 2021 16:42:53 -0400
X-MC-Unique: NrHpABDHO2i9CoqGT-aphg-1
Received: by mail-qt1-f197.google.com with SMTP id z5-20020a05622a0285b02901b943be06b5so15992274qtw.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 13:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/RvrYyTMEiHtCZW0MwDUjdnqhLrqE4kTWBWaQVaWhX4=;
        b=mOZUCyJ6PXCi5d2ocKDAM+2JmJ8ui8skztJqCiiAbadQBx4uQnm9oYNR/uHFsfkIbX
         gIXzYQ6vWa9iZgGiB5ESL+qVcViF1xrV5ZdbIXr6+xjQBmuPC5xoQHYq0DR4VQX1bEs7
         CU7ZWnuNEknWdS4lsmUM4l9MeCwFDTBxebUO3YNwieQEav8fDFMEXKrPYhd3VJ4LYbNc
         rwHg8YmuogzUmHfTMBCYn5PemSLQHlsOpNYfgkiBaqlmIs3ebeRqNq68do9cHDJg6ELW
         dMewV8MNuykVw+ykT6pIOq9zk+x9MqPK1osLoQmL3D+GA+lsbev8EMD/eU2fAegFUPKN
         Avsw==
X-Gm-Message-State: AOAM533+bOn6D9O4PJe1ffUC+hOG9dCHu85tOecemdSe3XSnMdb7fCi0
        THXXhmYhRrhe/aeG11WNurYR43DCBm0zHHv5RySCFhgSffraX41diN7hPTv8NDLm4UKIMx82TJ7
        HH5ELQ20UwAiD8zOEvPKEPG0t
X-Received: by 2002:a05:622a:11d1:: with SMTP id n17mr10557594qtk.360.1619556172933;
        Tue, 27 Apr 2021 13:42:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXdbR54zw+S/1LpL+C8ZvobC9U+08rm/wphtfr+XZ5o9lHGt3slPtEst+FHJjmjSso+DRu0w==
X-Received: by 2002:a05:622a:11d1:: with SMTP id n17mr10557577qtk.360.1619556172652;
        Tue, 27 Apr 2021 13:42:52 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id u126sm3664993qkd.80.2021.04.27.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 13:42:51 -0700 (PDT)
Date:   Tue, 27 Apr 2021 16:42:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for
 shmem
Message-ID: <20210427204250.GG6820@xz-x1>
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-4-axelrasmussen@google.com>
 <alpine.LSU.2.11.2104261906390.2998@eggly.anvils>
 <20210427155414.GB6820@xz-x1>
 <CAJHvVciNrE_F0B0nu=Mib6LhcFhL8+qgO-yiKNsJuBjOMkn5+g@mail.gmail.com>
 <20210427180314.GD6820@xz-x1>
 <CAJHvVciMU=TDGxArtEQSq3n5DCLfYNWh7bVX_8dQL_dht4Q73w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVciMU=TDGxArtEQSq3n5DCLfYNWh7bVX_8dQL_dht4Q73w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:29:14PM -0700, Axel Rasmussen wrote:
> On Tue, Apr 27, 2021 at 11:03 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Apr 27, 2021 at 09:57:16AM -0700, Axel Rasmussen wrote:
> > > I'd prefer to keep them separate, as they are not tiny patches (they
> > > are roughly +200/-150 each). And, they really are quite independent -
> > > at least in the sense that I can reorder them via rebase with no
> > > conflicts, and the code builds at each commit in either orientation. I
> > > think this implies they're easier to review separately, rather than
> > > squashed.
> > >
> > > I don't have a strong feeling about the order. I slightly prefer
> > > swapping them compared to this v4 series: first introduce minor
> > > faults, then introduce CONTINUE.
> > >
> > > Since Peter also has no strong opinion, and Hugh it sounds like you
> > > prefer it the other way around, I'll swap them as we had in some
> > > previous version of this series: first introduce minor faults, then
> > > introduce CONTINUE.
> >
> > Yes I have no strong opinion, but that's probably the least I prefer. :-)
> >
> > Because you'll declare UFFD_FEATURE_MINOR_SHMEM and enable this feature without
> > the feature being completely implemented (without UFFDIO_CONTINUE, it's not
> > complete since no one will be able to resolve that minor fault).
> >
> > Not a big deal anyway, but since we're at it... Basically I think three things
> > to do for minor shmem support:
> >
> >   (1) UFFDIO_CONTINUE (resolving path)
> >   (2) Handle fault path for shmem minor fault (faulting path)
> >   (3) Enablement of UFFD_FEATURE_MINOR_SHMEM (from which point, user can detect
> >       and enable it)
> >
> > I have no preference on how you'd like to merge these steps (right now you did
> > 1 first, then 2+3 later; or as Hugh suggested do 1+2+3 together), but I'd still
> > hope item 3 should always be the last, if possible...
> 
> In that case, I'll split the patch which adds the faulting path in
> two: add the faulting path hook and registration mode, and then in a
> separate commit advertise the feature flag as available.
> 
> Then I'll order them like so, which I think is the order Hugh finds
> more natural:
> 1. MInor fault registration / faulting path
> 2. CONTINUE ioctl to resolve the faults
> 3. Advertise the feature as supported
> 
> Sound okay?

Good to me, thanks Axel.

-- 
Peter Xu

