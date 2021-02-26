Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FC6326574
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhBZQWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhBZQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:22:26 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAAFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 08:21:44 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 204so9556745qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 08:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wKhee+wwyY8wAQtAwhfFGxIYlymbanXy7c8d3WGe9uw=;
        b=UbX00wvuuvMEYhRJX3nCu4zXb85v13Cqv2r7hy9O+bowY1FaIbOHtDcePeLY0/B0Da
         SF2Rt/j2i5vqV+2nd6y/YV7vdWi7UcnYCo6GUDusZkQq2I/4QAMG5NnybLXlvhoAWc4E
         CB07JSKy/zS1mTJuVrl1tmyNn9/lGP5fKjyqtPqmEH+ZLIUFG0B2e4C+3p28fkRswuxC
         hFXweOu/200WMxTdg7r9jyhUcvqhegxsjllPJTsf9QRFCspOmTW4FmlmbibPyeQkxmm0
         eTduKaFz+s5eAm4qAnHn5719bNNg6/TZ7O3TMvWSTpqPFuHHbDX0UTpRpz8DWGQYjFaf
         L6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKhee+wwyY8wAQtAwhfFGxIYlymbanXy7c8d3WGe9uw=;
        b=okXGrPu9qr8VCwgBx/ik0qvMf39eP3NE/WqokYKVw5fROarkmouVDSZNW0dqDYMoYM
         7uPS2dTT5zNd8kKsd61cimtfuiiilI8OXCzcJgj5r7q07uLxPalZYbnBGZXdRcfxU/ZR
         A1UNtAEFidBr0h5T0wzPPpzrLqTa1kQhBFiITXVAl6HCqeUQxnfqU1CxbvhnKiMq+Ega
         X7Qnda/2/pMVnaEZFIivlZ4fMSuCWR4e6Vd7Au7LYprI6luJlbYAxWbZa1GtUwsKvCh2
         4/j8iplz5QMQ2ToExZ2p5CNYIZiunPLVF7EOVbs8lBC6d7jNav/aVYxmhd3hH2XPCUn3
         2xTg==
X-Gm-Message-State: AOAM530IEHFGdUqYbdJNqXA0eKG/pmQPGMZ2SJxLhvIranlhvgWFhINT
        NE2MX2Th8sWh0BDiHU7POVxk+Q==
X-Google-Smtp-Source: ABdhPJwJdZL4xF23yJV09qXQ0a4Ybxm3pNDa6pceKSCI9bofx7wUXwpD/kCLchRD1oPm3hWZue3Zhg==
X-Received: by 2002:a37:dc41:: with SMTP id v62mr3158437qki.457.1614356503934;
        Fri, 26 Feb 2021 08:21:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id x3sm6801311qkd.94.2021.02.26.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 08:21:43 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lFfs7-000yvy-1U; Fri, 26 Feb 2021 12:21:43 -0400
Date:   Fri, 26 Feb 2021 12:21:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Freeing page tables through RCU
Message-ID: <20210226162143.GW2643399@ziepe.ca>
References: <20210225205820.GC2858050@casper.infradead.org>
 <20210226144200.GV2643399@ziepe.ca>
 <20210226160354.GE2723601@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226160354.GE2723601@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 04:03:54PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 26, 2021 at 10:42:00AM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 25, 2021 at 08:58:20PM +0000, Matthew Wilcox wrote:
> > 
> > > I'd like to hear better ideas than this.
> > 
> > You didn't like my suggestion to put a sleepable lock around the
> > freeing of page tables during flushing?
> > 
> > I still don't see how you convert the sleepable page walkers to use
> > rcu??
> 
> I don't want to convert the sleepable ones to use RCU ... I want to
> convert the non-sleeping ones to use RCU.  

Why? Convert them to use the normal page table spinlocks?

It makes everything much more understandable if it is locked properly.

The lockless walks should be reserved for special places because they
are actually hard to do properly.

> A page_table_free_lock might work, but it might have its own
> problems later (eg a sleeping lock can't be acquired under RCU or
> spinlock, and it can't be a spinlock because it'd have to be held
> while we wait for IPIs).

The mmap_sem today is serving the function of the page_table_free_lock
idea, so I think a sleepable lock is already proven to work?

Jason
