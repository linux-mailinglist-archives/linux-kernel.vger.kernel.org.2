Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CE834E9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhC3NuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhC3Ntz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:49:55 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7FDC061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 06:49:55 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q3so15822520qkq.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cVXpnZxXv6yHCnSM/DTKVxaY2Rfy2IhtzC0a2VwgjAs=;
        b=eapJqowaFe1+eVMDwPsIM+bpEjESgis+Hktp7GkYkYkpyggfW6NMPTv3Eb+tMgP+Ae
         J0FIOrJh8qsknFlubqnacIGvF2ioh/AXDEyzqqBlwYzn18Y6w46ePgkZOfXD1Mdm2FCK
         wiZBNq7rAidyeNsKL5sxlSNMr1CU3eG90OULZITNelx2novLIyK7TRT64c1GYaIDZuYI
         vNJWsjdbGRz7G9+bIHvgwAg2XdnBM4XFpXXKXtOTSh6+U2PK0TEH13WosSfSSxK+wZzK
         buOZ18Nvu9A27hnaEMLBbLUMlm20AhQFktK3LJHubyYa3FR65ILAjorLgioKzQDp/4rx
         rAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cVXpnZxXv6yHCnSM/DTKVxaY2Rfy2IhtzC0a2VwgjAs=;
        b=Y1QXoxZoliGTCBnX2p+YZc27vpiwZ4EbgIUNI+Wk2wDijGJWraRM5tjFkK4JDD0v+2
         YoVpdi4Vk8RTpxS0+vgnlOUqdf6yzP12sV08XVuSq+A8aV7XCKGArejvqYGtGExvvNgU
         KWKInBnjbnA2LLvc8AVcwLBnS/oVp75MS/ewV1eaRMv8kBIxu2rCsSrKOYsFrAXjxIca
         M+y38c7icgyMPpbIKgWwxb8v5eTM9/Hd90RqiYGQ8385onm1LaJh0KyOGUKwYQLjZpj6
         OWDlpmL+LRB9jc26uIKf9lcdrs5VkRk+Ngdbv90U+Rt2vsxaWzB6J2Y4k99f5AU11rea
         BrYg==
X-Gm-Message-State: AOAM530m9Q6qinj56Y51cKRz/z0b1Xkoamn81MOPEmwYVow5Iqr1krvX
        pfnfcbHbe7AKs9syZq26VvRdZw==
X-Google-Smtp-Source: ABdhPJzLvsFKN8J/s1Zqd4IjZyotN4j338+vin2Qg/BPBs3kJ7s1XDuVFJPUQwJECfg35Nm3TA/FjA==
X-Received: by 2002:a37:638f:: with SMTP id x137mr29805289qkb.199.1617112194440;
        Tue, 30 Mar 2021 06:49:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id z8sm13142809qtn.12.2021.03.30.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:49:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lREkj-005tlO-3a; Tue, 30 Mar 2021 10:49:53 -0300
Date:   Tue, 30 Mar 2021 10:49:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
Message-ID: <20210330134953.GT2710221@ziepe.ca>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
 <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
 <CAPcyv4g8=kGoQiY14CDEZryb-7T1_tePnC_-21w-wTfA7fQcDg@mail.gmail.com>
 <20210325143419.GK2710221@ziepe.ca>
 <CAPcyv4hHHFD4cvdRmajWgYbXU5-o-jF-o6D5ud-rg4dWNqt5Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hHHFD4cvdRmajWgYbXU5-o-jF-o6D5ud-rg4dWNqt5Ag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 04:24:19PM -0700, Dan Williams wrote:
> On Thu, Mar 25, 2021 at 7:34 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Mar 18, 2021 at 10:03:06AM -0700, Dan Williams wrote:
> > > Yes. I still need to answer the question of whether mapping
> > > invalidation triggers longterm pin holders to relinquish their hold,
> > > but that's a problem regardless of whether gup-fast is supported or
> > > not.
> >
> > It does not, GUP users do not interact with addres_space or mmu
> > notifiers
> 
> Ok, but the SIGKILL from the memory_failure() will drop the pin?

In the general case I doubt it..

I think this is fine, we shouldn't expect unplugging a driver to not
block if there are open users.

Demading DMA users to be able to shoot down access to system memory is
a really big kernel change.

Jason
