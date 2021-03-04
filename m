Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF1932CB60
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhCDE2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:28:24 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8387 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhCDE2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:28:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604061aa0002>; Wed, 03 Mar 2021 20:27:22 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 04:27:21 +0000
Received: from nvdebian.localnet (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar 2021
 04:27:18 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <bskeggs@redhat.com>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <jglisse@redhat.com>, <hch@infradead.org>,
        <daniel@ffwll.ch>
Subject: Re: [PATCH v3 3/8] mm/rmap: Split try_to_munlock from try_to_unmap
Date:   Thu, 4 Mar 2021 15:27:16 +1100
Message-ID: <29906974.JcgKRUyaEZ@nvdebian>
In-Reply-To: <20210301161049.GJ4247@nvidia.com>
References: <20210226071832.31547-1-apopple@nvidia.com> <20210226071832.31547-4-apopple@nvidia.com> <20210301161049.GJ4247@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614832042; bh=p4JDJbZednwqFrVYpTjMUfEe/DvW0PBtYvVi5ZHIeDg=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:Content-Type:
         X-Originating-IP:X-ClientProxiedBy;
        b=eK4xtp0Lie2rFKeCJiwu9nlyb3pg65al7AaYhe5pFEkjuZypZcZWqWwBhIJF/wcDp
         PeQNy6FGBUd0zDIOEMAmPED2HCpYTvechpwR+GhIoYVRZFKyk01aJKt7ARncP8p8JZ
         ybgZM6eVhq/ekdvvxoHYF4ZUo3i3wFiUVmzFby7JbEpdKu/9FUzqaXW8BGo+t+IT56
         wnlFRZhUlyDxyoFeYFzg2G/DH1DkrOlKSB4Gze98CVtRP0KXBvoV+25QwHqG+JoaMn
         aZRBeoYSfmsvpz2jOgPXwj+ksEe+zXuX4lMEPiIXdghUNttv0RhWvDU/1dJpobBdT8
         cwnG9pSLeDbSQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2 March 2021 3:10:49 AM AEDT Jason Gunthorpe wrote:
> > +       while (page_vma_mapped_walk(&pvmw)) {
> > +               /*
> > +                * If the page is mlock()d, we cannot swap it out.
> > +                * If it's recently referenced (perhaps page_referenced
> > +                * skipped over this mm) then we should reactivate it.
> > +                */
> > +               if (vma->vm_flags & VM_LOCKED) {
> 
> And since we write the data without holding the PTLs this looks
> pointless, unless there is some other VM_LOCKED manipulation
> 

Thanks. I couldn't find any other manipulation of VM_LOCKED whilst holding the 
PTL so I'll remove this redundant check.

 - Alistair



