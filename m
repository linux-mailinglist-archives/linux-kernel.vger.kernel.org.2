Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249113455B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCWCs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCWCsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:48:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC64C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:48:09 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f10so3176695pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UVzK1Lu9V581sbflxnU+woWz13QCeLb0leH55CLeWYw=;
        b=nGanR4KeudMZ0LjbytrBwDCLDpehXrSeYAESc7Ja+c3IlC7g4ol+nch9rdL6+hxCJa
         Wj0iZToOYKddaDtQYMFd49RpVgQdqZz7imVrKPzuuhjXM5elMdokCJpKM1KPOjV1rlCp
         N6lRnKoD2mlfRRtUy2xIdR1cP/x/wzqg/b1vOAWNtBDqlAXDKZ2+6MYz5CfeZrjZrWzI
         G0V1vs498BbCNp2kiApaCQbCd5P2ORez+/vzze+uRxb+W7nsn9+TEZ1sDl90xPlTh+8b
         Vn1FKHJm5/up7lcBdhBvW6xmwvL2Wzbb3me1lLX34aNiJ3+lOK0oDTfDWeJnknqpWxOL
         ZsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UVzK1Lu9V581sbflxnU+woWz13QCeLb0leH55CLeWYw=;
        b=eO70o04X74pu8Ldsj+9WQZGAW66JWb9UHw4XuQ7VJxN1z+WmJYPd6EcEVNtfPJdonW
         QRRWKT5Py8epTDS3qalWytHxa9GVHlfFcxVs9Qq2R+7dNlPKgFde2SvhZVwWj3sijtYG
         AH/d4+4ZhjUdodev9bahlqIfZnhkpCovVSygY7CXii0ohhExQRj2QBLy/EjylrpttkD4
         uW1x/cunchGwuaBrrthqFl29Oqzv+vvQF1SxhjtZvGHgd0D9/pzIrMtvc/ElKdMLVnDe
         v4RdigyYVMpFd0sU41J3mKMWVzfKjOdZ4VZ5mC33tIUbBRcY4syxOyoBPBbhdjjYGZQ9
         Bt4Q==
X-Gm-Message-State: AOAM531YiDjYP5rJB9TEW74sHXsKKWOB96K/hMLd1cIZR3t+LqUsNoMs
        41dZI/HVNDVMx1dSoiMN+0c=
X-Google-Smtp-Source: ABdhPJwVR1tBgyGmBdToVxYt/amDpbqwAFNDUF7uS1vL51UTFuWe010hqQXSrBYVIrkEyGhIKg0vmw==
X-Received: by 2002:a63:4b5e:: with SMTP id k30mr2045826pgl.130.1616467688614;
        Mon, 22 Mar 2021 19:48:08 -0700 (PDT)
Received: from local ([113.172.241.1])
        by smtp.gmail.com with ESMTPSA id b186sm15425399pfb.170.2021.03.22.19.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 19:48:08 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:48:03 +0700
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] userfaultfd: Write protect when virtual memory range has
 no page table entry
Message-ID: <20210323024803.GA3365@local>
References: <20210319152428.52683-1-minhquangbui99@gmail.com>
 <YFhuDf6L7nkUoT7q@dhcp22.suse.cz>
 <YFiU9YWbYpLnlnde@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFiU9YWbYpLnlnde@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:00:37PM +0200, Mike Rapoport wrote:
> On Mon, Mar 22, 2021 at 11:14:37AM +0100, Michal Hocko wrote:
> > Le'ts Andrea and Mike
> > 
> > On Fri 19-03-21 22:24:28, Bui Quang Minh wrote:
> > > userfaultfd_writeprotect() use change_protection() to clear write bit in
> > > page table entries (pte/pmd). So, later write to this virtual address
> > > range causes a page fault, which is then handled by userspace program.
> > > However, change_protection() has no effect when there is no page table
> > > entries associated with that virtual memory range (a newly mapped memory
> > > range). As a result, later access to that memory range causes allocating a
> > > page table entry with write bit still set (due to VM_WRITE flag in
> > > vma->vm_flags).
> > > 
> > > Add checks for VM_UFFD_WP in vma->vm_flags when allocating new page table
> > > entry in missing page table entry page fault path.
> > 
> > From the above it is not really clear whether this is a usability
> > problem or a bug of the interface.
> 
> I'd say it's usability/documentation clarity issue. 
> Userspace can register an area with
> 
> 	UFFDIO_REGISTER_MODE_MISSING | UFFDIO_REGISTER_MODE_WP
> 
> and then it will be notified either when page table has no entry for a
> virtual address or when there is a write to a write protected address.

Yes, you are right. I saw a patch from Peter to linux-man and saw that

	"When there is only UFFDIO_REGISTER_MODE_WP registered, the userspace
	will not receive any message when a missing page is written"

It's my mistake that I didn't look at the documentation carefully when playing
around.

Thanks,
Quang Minh.
