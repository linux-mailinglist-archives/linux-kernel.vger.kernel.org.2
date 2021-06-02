Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA783995FF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 00:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhFBWhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 18:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229604AbhFBWhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 18:37:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F22D9613D6;
        Wed,  2 Jun 2021 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622673367;
        bh=GxpUd87XU+MpRXZ2PlmVvtGMToV2jbK/XAXadLJc3Ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B0f90I0IPVDpINHUZhHINCCb4mVM7ylkWMMqbnJwDr0CcXwdyF3mCb8FmTmSk0Vdi
         VJQ+4HxM7CeXzFsx6Iqo8q1vVe2P78XqCP5xqESVQVT4DoBp9g9/ftL6Pve6SSYeUD
         iJzFOQbHveg39VR7xkrDaa63fDGZIHAtrOscrlWk=
Date:   Wed, 2 Jun 2021 15:36:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 00/27] userfaultfd-wp: Support shmem and hugetlbfs
Message-Id: <20210602153606.93cfe1dfdaa2e11a2d863df2@linux-foundation.org>
In-Reply-To: <YLeYREkg/RrNjQ7v@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
        <YLeYREkg/RrNjQ7v@t490s>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 10:40:04 -0400 Peter Xu <peterx@redhat.com> wrote:

> On Thu, May 27, 2021 at 04:19:00PM -0400, Peter Xu wrote:
> > This is v3 of uffd-wp shmem & hugetlbfs support, which completes uffd-wp as a
> > kernel full feature, as it only supports anonymous before this series.  It's
> > based on latest v5.13-rc3-mmots-2021-05-25-20-12.
> 
> Andrew,
> 
> Any suggestion on how I should move on with this series?
> 

It is large, and thinly reviewed.  I haven't seriously looked at it
yet.  If nothing much else happens I might toss it in there for some
additional exposure but I do think more input from other developers is
needed before we go further.

