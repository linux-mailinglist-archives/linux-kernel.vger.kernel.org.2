Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AB4346326
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhCWPlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232810AbhCWPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616514058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ffzPyphtdhkRIijwb41EPoN1LYXu9B8LbqgVvLt0lI=;
        b=gdnTLSvf92t4GHvdz1JLWAt3/NrLuFhUOYT94qbH+2eYTCmqDoc9Pzg/JXtQXWIk7m+COU
        6IrjcrBHPWSHTWvNkDl1n+MNO+1w1pIb6YB/cAzpIVt/YuO0TtjaglzxCRIsQ2KAMDwdJO
        hBS23jPWltDb4DOfGcmjjnfQoXOUugA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-t2HczsYlOmGTPY6chzGb_w-1; Tue, 23 Mar 2021 11:40:56 -0400
X-MC-Unique: t2HczsYlOmGTPY6chzGb_w-1
Received: by mail-qk1-f197.google.com with SMTP id p133so2220594qka.17
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ffzPyphtdhkRIijwb41EPoN1LYXu9B8LbqgVvLt0lI=;
        b=SmFNvfZRrxHw1Qd3Hw2qa84ACYEXzPfHjM5Jz3M8RrUbUc1b3ELHT7XVbNOqfDAzM+
         IrHpOoEJ3O1lnLZ60K6lMoDN6p0MjYbs5yHfFO9MVKO92h1eVhs0tJctlEDPxebK8X+1
         uxcrcMvvDA9nldZZPXo3wogxilBfYeoihPuuWasn7y64RwFSXZs9gAEZdYoGetKr5E+e
         CkhFTu/0AUPsvFmRjLrhuVkrzdBoqpSEdMwKt81K/B4cw3eujVfJUc+Mg/O+Z6ELTfEU
         Gv6wdALEz5xoY6dxwPUjrk25ULoacAHdmFN4OWZYKLMdGMfDEhbjEDclwTGzZxhi2A+z
         FXtw==
X-Gm-Message-State: AOAM533q2BLrmAJs30wtt152xYG2WDdVlHouWSPWtoXZZDmGYuD0Ka3S
        A5DW+72SYVpxpqWWOlpUMmmp6g88bu4p3UH+kc1ITBJhjExJd4U5wLC5uGhNYmdnrJZq5d50yER
        JLN2DtOx3qOKgtdjiylc+ev1B
X-Received: by 2002:ac8:6606:: with SMTP id c6mr5092321qtp.76.1616514055653;
        Tue, 23 Mar 2021 08:40:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjndLoaGi+llXMkxdyWCe50dXelUQ5vwDuDl2tdSDWegEQ0bnTd2W+fvQiGSlv81JRBlACkQ==
X-Received: by 2002:ac8:6606:: with SMTP id c6mr5092296qtp.76.1616514055380;
        Tue, 23 Mar 2021 08:40:55 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id b17sm11042850qtp.73.2021.03.23.08.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:40:54 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:40:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/23] mm: Clear vmf->pte after pte_unmap_same() returns
Message-ID: <20210323154053.GF6486@xz-x1>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323004912.35132-3-peterx@redhat.com>
 <28c1dfdc-b72b-88a7-411c-effc078f774a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28c1dfdc-b72b-88a7-411c-effc078f774a@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 10:34:45AM +0800, Miaohe Lin wrote:
> Hi:
> On 2021/3/23 8:48, Peter Xu wrote:
> > pte_unmap_same() will always unmap the pte pointer.  After the unmap, vmf->pte
> > will not be valid any more.  We should clear it.
> > 
> > It was safe only because no one is accessing vmf->pte after pte_unmap_same()
> > returns, since the only caller of pte_unmap_same() (so far) is do_swap_page(),
> > where vmf->pte will in most cases be overwritten very soon.
> > 
> > pte_unmap_same() will be used in other places in follow up patches, so that
> > vmf->pte will not always be re-written.  This patch enables us to call
> > functions like finish_fault() because that'll conditionally unmap the pte by
> > checking vmf->pte first.  Or, alloc_set_pte() will make sure to allocate a new
> > pte even after calling pte_unmap_same().
> > 
> > Since we'll need to modify vmf->pte, directly pass in vmf into pte_unmap_same()
> > and then we can also avoid the long parameter list.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Good cleanup! Thanks.
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Just a note that this is not a pure cleanup - the latter patches may start to
depend on the clearing of vmf->pte in their logic.

Thanks for the quick review!

-- 
Peter Xu

