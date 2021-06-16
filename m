Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5CF3A8DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhFPAoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFPAoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:44:14 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 17:42:09 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id g12so689948qvx.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 17:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MIZ4yfC4SJgSNnStHS2hV3bUSJEXPyXqzvDWBqSA7IE=;
        b=cWN9BUfrVnGFbKtIZ3DUiBrsX0OUV8SZhasHlYTeBCPpr+9HP+e1oLZNvWMtAC6mf1
         4kaEpIOLkAi6/aS52oOQPP4kOSQoqo0hJCMz+o7bSU8h2xRKXHhdtK4Zk2AxgMhq5c8K
         eWEdVeBmPJ8BM4s2GRBLWOufFUci7yk25ulljFjU1IZGfSsFyPBhC7Bsyhih+GSkT8f9
         7IpF1EisdHdnKvhp96F5VwcH4jVLVZU8gqwU7I9wGhymUikzXA0ZXRhwrZKcsFxEwc48
         AHDTzbf217WABi3UZZY6k8XHo2PdNQofBpiUSv0wy2sia396vWRsy15ft0KLorI4wB4x
         V5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MIZ4yfC4SJgSNnStHS2hV3bUSJEXPyXqzvDWBqSA7IE=;
        b=VyHUb7MVdZtiMnbe9ixTkIcIjdpNGBiR49w4FfGNJESo1nLVV/apj/seuHShhG34nE
         XU4d/XXilRyA5yzyj7yhMKVbTvQzzKhl9IERNGCDSPxlP9vxtfN/Eg2SJgiVslwPA4jG
         7T8BYx+zfJ4WrajbEMoDn115XbWIq7faL9YNuPRHUbQnNAGrXhiGsJQKIDwWeCkTtxdZ
         YErpeG6jW9Hd0AiSxb29Nec1QUlfqwlzBpXGTrbPwIg3ikIG/XGTKO277niVAt7IkP2v
         p1xG4mH8fhjQCdROVjMWL7Thr58m1omcxYo2oQMtqAa7Ezh+M1obHMiN/bGM2b6HzmxY
         sdig==
X-Gm-Message-State: AOAM532b7GfhJC/sef57viikt7GumL3Gb/cvY33+FFMscj5gibCbjbgF
        +rcFcH/PAtfaxxMpdHoeJ3Cwsg==
X-Google-Smtp-Source: ABdhPJzCCGXNtFKeBaAZBtslYwxAwLPkiq4om2TrlrIrdMkTrd8Mjvp7+4aeQphN8xrVeKEzLcOXGg==
X-Received: by 2002:a05:6214:7f1:: with SMTP id bp17mr8079423qvb.29.1623804128267;
        Tue, 15 Jun 2021 17:42:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id s23sm95645qtq.2.2021.06.15.17.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 17:42:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ltJd9-007I9Y-2M; Tue, 15 Jun 2021 21:42:07 -0300
Date:   Tue, 15 Jun 2021 21:42:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Will Deacon <will@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] mm: page_vma_mapped_walk(): use pmd_read_atomic()
Message-ID: <20210616004207.GU1096940@ziepe.ca>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <594c1f0-d396-5346-1f36-606872cddb18@google.com>
 <20210610090617.e6qutzzj3jxcseyi@box.shutemov.name>
 <20210610121542.GQ1096940@ziepe.ca>
 <aebb6b96-153e-7d7-59da-f6bad4337aa7@google.com>
 <20210611153613.GR1096940@ziepe.ca>
 <939a0fa-7d6c-f535-7c34-4c522903e6f@google.com>
 <20210611194249.GS1096940@ziepe.ca>
 <20210615094639.GC19878@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615094639.GC19878@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 10:46:39AM +0100, Will Deacon wrote:

> Then the compiler can allocate the same register for x and z, but will
> issue an additional load for y. If a concurrent update takes place to the
> pmd which transitions from Invalid -> Valid, then it will look as though
> things went back in time, because z will be stale. We actually hit this
> on arm64 in practice [1].

The fact you actually hit this in the real world just seem to confirm
my thinking that the mm's lax use of the memory model is something
that deserves addressing.

Honestly I'm not sure the fix to stick a READ_ONCE in the macros is
very robust. I prefer the gup_fast pattern of:

  pmd_t pmd = READ_ONCE(*pmdp);
  pte_offset_phys(&pmd, addr);

To correctly force the READ_ONCE under unlocked access and the
consistently use the single read of the unstable data.

It seems more maintainable 'hey look at me, I have no locks!' and has
fewer possibilities for obscure order related bugs to creep in.

Jason
