Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A439345445
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhCWAyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231234AbhCWAyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWCcOHs5KSbLWx+LxQrabDk0BHkHykJxEkocJ4OHPJM=;
        b=g5+lXRyz5YmPL62/0YhK3bVxmn5yoQWsHSXWniS7U9qg2Of/p3bwOLNoeK0GFO05mo6CPe
        Kvh/rk39sCYVn8YHWwXlMLzef7h9YXBQRxxMOnXq63JK3xrn2z4TA5G4iD3cVg5JnnkQZM
        P+dKpvgfbb+7lRqaspZ6Fc5aqRiwiS4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-YI5lkgHlNie4GsVmrDXSJQ-1; Mon, 22 Mar 2021 20:54:13 -0400
X-MC-Unique: YI5lkgHlNie4GsVmrDXSJQ-1
Received: by mail-qk1-f199.google.com with SMTP id v136so824173qkb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWCcOHs5KSbLWx+LxQrabDk0BHkHykJxEkocJ4OHPJM=;
        b=O6jdFcp0TlIIwloFBIAky/WORtyYSHzqlgkBG0EBPfPTRCub50Z118xASZwkfXSLdO
         1vmUjRx8fsCSsXhL5q/3OdLmr8GZqu3rSrrRZd4GFPSfkQOq7pIFeHTT1257icNtdXIe
         ClcciTnyTVGzgBkWOhXo5gx+G1H4XE44EsC+FgCOisbEMC8ftYICX9e2Qeh70F06Xa/I
         3dhQ8h+Rz4IEdtLD7kXHx9wkZfo/7Ki0yu2MsQWXnEXGrXaGtyy6yXYxd+lOtlFie49D
         uYka3r06W3iHpGt87b/tqYI2yABG63fhTW4QlyRrX09mUotxo4po3PpvPIJ1sS/53Y7p
         jcLw==
X-Gm-Message-State: AOAM531uZ9boza3q5E7TYN/3KDiBN3Lo2gurLFJZmYfLX15VoiXtl0sR
        GRRXpkQ9VEA5xoTIX+mzRvqbaVfQdQEQwKg3J/XB0kA0WmvmjB2+CpEA9EH1jYld49Cg01MsApY
        eERpVFrRKRFHyqxrdxQbJ29jHDreBb+2K+vIPivrjc58AAJjVJcXcf/SvNFR1ocehgD8arbMp2w
        ==
X-Received: by 2002:aed:2983:: with SMTP id o3mr2359507qtd.149.1616460852798;
        Mon, 22 Mar 2021 17:54:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqYBOZle0ClIrEr5bxHCoI74d6Dmul0VkpF+F22h7UvXTGzc/ja+FWdB4SAHPxnRQHGGNemw==
X-Received: by 2002:aed:2983:: with SMTP id o3mr2359485qtd.149.1616460852517;
        Mon, 22 Mar 2021 17:54:12 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id a14sm10084476qtw.80.2021.03.22.17.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:54:12 -0700 (PDT)
Date:   Mon, 22 Mar 2021 20:54:10 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <20210323005410.GA6486@xz-x1>
References: <20210323004912.35132-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 08:48:49PM -0400, Peter Xu wrote:
> This patchset is based on tag v5.12-rc3-mmots-2021-03-17-22-26.  To run the
> selftest, need to apply the two patches to fix minor mode page leak:
> 
> https://lore.kernel.org/lkml/20210322175132.36659-1-peterx@redhat.com/
> https://lore.kernel.org/lkml/20210322204836.1650221-1-axelrasmussen@google.com/
> 
> Since I didn't get any NACK in the previous RFC series for months, I decided to
> remove the RFC tag starting from this version, so this is v1 of uffd-wp support
> on shmem & hugetlb.

Attaching changelog, rfc->v1:
- fix up syzbot reported issue
- add a new feature bit UFFD_FEATURE_WP_SHMEM_HUGETLBFS exported in uapi, so
  that apps can detect the new kernel capability.
- check for all pte_to_swp_entry callers too (hmm, etc.) [JasonG]
- dropped the first few patches that are not directly related to this series; I
  will post them separately as standalone series

Add Cc too (I'll remember to send the series with full cc list next time..).

Thanks,

-- 
Peter Xu

