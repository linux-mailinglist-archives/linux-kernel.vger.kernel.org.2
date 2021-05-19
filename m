Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88791388FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347080AbhESOK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346630AbhESOK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621433377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uA5LBQUpQQcpe5I2oDgwRimXB7jI4me/eAnHY5LMMkc=;
        b=KFmiMj3s2us43/++cpPNGprz9FWDrJ3XOUFDYYYXGhqmakgiZ/af8CvyAPfS2kBeoNwt9l
        uPLmAoOb9RYF4gt6p5J4+UBUHQn+V6bSki4q/yB2cDS9v9MsxkV+4jW+9hH0GnZZ7GHvHC
        28jjjOWVpS4imP0Qszj0PUjZK5b7Kw4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-0CqxOzEvMBSj73SLeoa_Dw-1; Wed, 19 May 2021 10:09:35 -0400
X-MC-Unique: 0CqxOzEvMBSj73SLeoa_Dw-1
Received: by mail-qv1-f71.google.com with SMTP id e15-20020a0caa4f0000b02901eedbb09299so8845153qvb.15
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uA5LBQUpQQcpe5I2oDgwRimXB7jI4me/eAnHY5LMMkc=;
        b=h9CAzt5WPJfv3gzAz2TLT+jjaHtEie03d8Bj5/7id4+w9UBnbdIOHc1wxcsJe88N/U
         R8KmIoLfWc13wqihOGMMi1vf1QZdPBuiuJFKVEIdvf1dzgB/YSeca/pxAyBkmyOnpV6v
         +0gw7crUtVOxuSgIXUezr0wmzIxmv3g53vK93yQzk7QgqJyl7s0K/uWkdtof4Zn5DgQd
         syrAEH0KuZtP2Tu+43GylmzJKoRzAkkJTpZ52qXgHOM14sYJreq/IctRCG+L6db2zo6n
         hxNpXW3dVUQZH1oV2Xkwz0woeglTYs7aJCfe6lXZBHZ6NMfz/+Hr3b4Q8e0duFJoWkd8
         nhng==
X-Gm-Message-State: AOAM533sVpnR6yJqo1qRFKliSimjNwiPVUEK/3MAzjHqwbhm41ti9Ay+
        xa/bthAzthhKEaqgdPsDV3zpqUQjj0VoLHjAqoi6PlSu1hVNymrc/qNd3BhNEVJf1F8A1myJ5ec
        BJEsbCbeAYw0fLynw9IJ3wQ7U
X-Received: by 2002:a05:622a:413:: with SMTP id n19mr11309610qtx.238.1621433375268;
        Wed, 19 May 2021 07:09:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfgXghdceBt0pzuJuLcMWZrj1qSDnzHPuTLDIdA4muPS9QaO8qeOo+lEtQMgzjzxGPQ17Ppg==
X-Received: by 2002:a05:622a:413:: with SMTP id n19mr11309576qtx.238.1621433375015;
        Wed, 19 May 2021 07:09:35 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id c20sm15634299qtm.52.2021.05.19.07.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:09:34 -0700 (PDT)
Date:   Wed, 19 May 2021 10:09:33 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jhubbard@nvidia.com, rcampbell@nvidia.com, jglisse@redhat.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] mm: Device exclusive memory access
Message-ID: <YKUcHfhQMbDnjXC7@t490s>
References: <YKMhorngO2DVrxac@t490s>
 <47694715.suB6H4Uo8R@nvdebian>
 <YKP5Dj4Q/riGGc43@t490s>
 <20210518173334.GE1002214@nvidia.com>
 <YKQBACJCjsxeM3ro@t490s>
 <20210518194509.GF1002214@nvidia.com>
 <YKQjmtMo+YQGx/wZ@t490s>
 <20210518230327.GG1002214@nvidia.com>
 <YKRRgZmRMdk1vH7A@t490s>
 <20210519132842.GJ1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210519132842.GJ1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:28:42AM -0300, Jason Gunthorpe wrote:
> On Tue, May 18, 2021 at 07:45:05PM -0400, Peter Xu wrote:
> > On Tue, May 18, 2021 at 08:03:27PM -0300, Jason Gunthorpe wrote:
> > > Logically during fork all these device exclusive pages should be
> > > reverted back to their CPU pages, write protected and the CPU page PTE
> > > copied to the fork.
> > > 
> > > We should not copy the device exclusive page PTE to the fork. I think
> > > I pointed to this on an earlier rev..
> > 
> > Agreed.  Though please see the question I posted in the other thread: now I am
> > not very sure whether we'll be able to mark a page as device exclusive if that
> > page has mapcount>1.
> 
> IMHO it is similar to write protect done by filesystems on shared
> mappings - all VMAs with a copy of the CPU page have to get switched
> to the device exclusive PTE. This is why the rmap stuff is involved in
> the migration helpers

Right, I think Alistair corrected me there that I missed the early COW
happening in GUP.

Actually even without that GUP triggering early COW it won't be a problem,
because as long as one child mm restored the pte from exclusive to normal
(before any further COW happens) device exclusiveness is broken in the mmu
notifiers, and after that point all previous-exclusive ptes actually becomes
the same as a very normal PageAnon.  Then it's very sane to even not have the
original page in parent process, because we know each COWed page will contain
all the device atomic modifications (so we don't really have the requirement to
return the original page to parent).

Sorry for the noise.

-- 
Peter Xu

