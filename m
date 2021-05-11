Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044B437A9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhEKOxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231461AbhEKOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620744723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHftXcGxDoMDs0PAy4TpI3nYx8as+/F1eL0Owu3OX60=;
        b=XtV4tjGHKaPlEdiHAm3f9r2ECBNNb+tkr0bSLhPHnGqSrdw1du3hWkE1uIDplMaAXdnZuo
        2ujTWw4XH60gX2iuqIr2HgSswDadhvD78BrS8+izWi/OivIBLVAJk09uuyOeGa+P46D/zW
        Vq6fDKNltMf/do1LB/xwrApcYhdt9Ug=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-A6EfumgFNw2d6tVdiVAXVw-1; Tue, 11 May 2021 10:52:01 -0400
X-MC-Unique: A6EfumgFNw2d6tVdiVAXVw-1
Received: by mail-qk1-f200.google.com with SMTP id d15-20020a05620a136fb02902e9e93c69c8so14544461qkl.23
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sHftXcGxDoMDs0PAy4TpI3nYx8as+/F1eL0Owu3OX60=;
        b=o+eRHneTFdyP1Qxt6ac5JeUzo+uomMfehjPWWbUwp9OAinrtWymIWJ5WRL1zoxcGfM
         QSfe7z3tfrZIl6QszvQGYXvkPfbpXz0DBRvoMym6FyqHRydkeG5hB/Gd0dW1PlQDgL7X
         AeiVQ9/+ACH4TcOZ3fWtU9A+NMIjbzZwJ2ZAYp00F/L4Jo2MGIR8aRYTnUvrgQQzWdAW
         eqDBLyAaPDVZos/P6y7xiMs2x6VHpNXhIue8ASLAFBLN8WuOzeLZItd6pvtWnSUPUepM
         zWuxdV1exzzC4ClBAV8zSQhRWgKJ0R8mwBMD7xaY8XsSD6G2YTMY0j2YOI0FpbKmFq2G
         vLcw==
X-Gm-Message-State: AOAM531Wtq9XKvRfZ0Y5o4YYLph4QM2Z+JQdwQ7Gf55FOx5yaKVOoTWX
        natvoDNOngy7K2Po/iE/JyUQgfbIIygl2LWEXlck+nO9Qaew6n2UiXoSEgW2Cr/CMK4Zlwln9XX
        d6pvzloQ5JK+IJtnhHvs26ehI
X-Received: by 2002:a37:9a97:: with SMTP id c145mr12168081qke.47.1620744720212;
        Tue, 11 May 2021 07:52:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmph64tgTWkLHt+EmIR2ydfHRwt2RU0GH7V2n07ELog+qcaI8BvqVmh+g0pRHpHIzf5JIhhg==
X-Received: by 2002:a37:9a97:: with SMTP id c145mr12168061qke.47.1620744720034;
        Tue, 11 May 2021 07:52:00 -0700 (PDT)
Received: from horse (pool-173-76-174-238.bstnma.fios.verizon.net. [173.76.174.238])
        by smtp.gmail.com with ESMTPSA id b23sm7927757qtq.0.2021.05.11.07.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 07:51:59 -0700 (PDT)
Date:   Tue, 11 May 2021 10:51:57 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        lkml <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [kbuild] fs/fuse/dax.c:113 fuse_setup_one_mapping() warn: should
 'start_idx << 21' be a 64 bit type?
Message-ID: <20210511145157.GB238488@horse>
References: <202105032112.SJqOaXpO-lkp@intel.com>
 <CAOssrKcwq_wFc+B72Vvkaai-TgXoZPTJ9fvBu+BzUg4idnFoZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOssrKcwq_wFc+B72Vvkaai-TgXoZPTJ9fvBu+BzUg4idnFoZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 04:21:32PM +0200, Miklos Szeredi wrote:
> On Mon, May 3, 2021 at 3:27 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > head:   9ccce092fc64d19504fa54de4fd659e279cc92e7
> > commit: c2d0ad00d948de73c78f05d2b3e5bdfa605035cc virtiofs: implement dax read/write operations
> > config: i386-randconfig-m031-20210503 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > New smatch warnings:
> > fs/fuse/dax.c:113 fuse_setup_one_mapping() warn: should 'start_idx << 21' be a 64 bit type?
> 
> Yes.
> 
> But does it make any sense to enable virtiofs and/or dax on 32bit
> guest? We sure aren't testing it, as seen from this bug report.
> 
> Vivek, what do you think?

Hi Miklos,

We sure are not testing it but looks like it is possible to compile it
on 32 bit systems. 

I can't think of a good reason that why virtiofs DAX should be disabled on 
32 bit systems. So I sent a patch series to fix this warning here.

https://lore.kernel.org/linux-fsdevel/20210506184304.321645-1-vgoyal@redhat.com/

Thanks
Vivek

