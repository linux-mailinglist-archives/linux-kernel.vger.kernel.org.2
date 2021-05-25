Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB98638F6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhEYANR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhEYANP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:13:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A18C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:11:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5so15809425pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUlwWPEjEBC466iZ6g8hcxYhiN/KFRQWiFx0UlEipac=;
        b=U9fMhp00ZsfRAVyT9JVw0V+4wEIZ53dxOQhQr+RJ7edEyGoasKWtcqmMn1r50OcqIM
         4KrICxJ9rycntJ5xA4ASSTGWxLRdzz71HoK8E314h8xHF2nzZOkwDEbxmusYVgTCkVeE
         8q75THtH8pMEISNJMbyv0jQ8hCAKetfexGqsRdi/aIqkasHXxyuupBw6PmL2c6GmZeyB
         h8ZT6hre36tPaZeU4w33IIbf7c+bqWOQbKm5mK8QIOixAJwj9/03TDFYUm25Fj9c42Jx
         jNFfDFkrzIs/tR3sR0Zm9AvispJyP3dWquDcGJYL2/ig+VRcU4MyL2t2iD0r71T76i6P
         EW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUlwWPEjEBC466iZ6g8hcxYhiN/KFRQWiFx0UlEipac=;
        b=bgYeavvlFRCyop9LVKNHi99qcmvLPfABsURsPY+UTPaKFZ/zackpfJdR9iajt2kxXK
         srzzsgY712dwLhx/Led8T6RgjXJMk7193ZeWgCr7Ws/diQM47uqo6+1mTutNwmbZb7Mr
         U/ceIoYBmP0GEIWFi7p5CO/+BWcqsQNvai+SNNDxkqntraHdwcTEnd+0uTRUiT5dSWkE
         CxPwEPF0c+54LJgm88rrM7qzb3TmE/Mn2IarMwIBlwY9jpkxcnd0BjJjzhyA7lTfhlP6
         nZps8lF/yh1UVcT+rs2nVmRl4EDI4uRMLF5XCRlssAfAm41YFvdnYQEGWWp4s4IAABVP
         L7og==
X-Gm-Message-State: AOAM5315NHr+obYQtoGvV0EQ8mZtfoRChT1SCueNAGOChF9JStapL+m/
        +nNXxHf0c1jNGOKOhhqL3B+jKDi9jOPHJBOictH8Fg==
X-Google-Smtp-Source: ABdhPJzDpAY5Kl7EYrbTh60YtA/nIgzXVmikK11bIk7UFwcPG3S/kJ7+gTYXYzmM5m694eIhFp/UI1892g3EYd+miWE=
X-Received: by 2002:a17:902:ea0c:b029:f0:af3d:c5d6 with SMTP id
 s12-20020a170902ea0cb02900f0af3dc5d6mr27426462plg.45.1621901506390; Mon, 24
 May 2021 17:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210521074433.931380-1-almasrymina@google.com> <2a983662-ab90-0cdb-850c-eb50b0845b49@oracle.com>
In-Reply-To: <2a983662-ab90-0cdb-850c-eb50b0845b49@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 24 May 2021 17:11:34 -0700
Message-ID: <CAHS8izOB6OUsTwv2kvkW13+knrpXTmyA+igT3+jY+7SVwzt4PQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +                     if (!HPageRestoreReserve(page)) {
> > +                             if (unlikely(hugetlb_unreserve_pages(
> > +                                         mapping->host, idx, idx + 1, 1)))
> > +                                     hugetlb_fix_reserve_counts(
> > +                                             mapping->host);
> > +                     }
>
> I do not understand the need to call hugetlb_unreserve_pages().  The
> call to restore_reserve_on_error 'should' fix up the reserve map to
> align with restoring the reserve count in put_page/free_huge_page.
> Can you explain why that is there?
>

AFAICT here is what happens for a given index *without* the call to
hugetlb_unreserve_pages():

1. hugetlb_no_page() allocates a page consuming the reservation,
resv_huge_pages decrements.
2. remove_inode_hugepages() does remove_huge_page() and
hugetlb_unreserve_pages(). This removes the entry from the resv_map,
but does NOT increment back the resv_huge_pages. Because we removed
the entry, it looks like we have no reservation for this index.
free_huge_page() gets called on this page, and resv_huge_pages is not
incremented, I'm not sure why. This page should have come from the
reserves.
3. hugetlb_mcopy_pte_atomic() gets called for this index. Because of
the prior call to hugetlb_unreserve_page(), there is no entry in the
resv_map for this index, which means it looks like we don't have a
reservation for this index. We allocate a page outside the reserves
(deferred_reservation=1, HPageRestoreReserve=0), add an entry into
resv_map, and don't modify resv_huge_pages.
4. The copy fails and we deallocate the page, since
HPageRestoreReserve==0 for this page, restore_reserve_on_error() does
nothing.
5. hugetlb_mcopy_pte_atomic() gets recalled with the temporary page,
and we allocate another page. Now, since we added an entry in the
resv_map in the previous allocation, it looks like we have a
reservation for this allocation. We allocate a page with
deferred_reserve=0 && HPageRestoreReserve=1, we decrement
resv_huge_pages. Boom, we decremented resv_huge_pages twice for this
index, never incremented it.

To fix this, in step 4, when I deallocate a page, I check
HPageRestoreReserve(page). If HPageRestoreReserve=0, then this
reservation was consumed and deallocated before, and so I need to
remove the entry from the resv_map.
