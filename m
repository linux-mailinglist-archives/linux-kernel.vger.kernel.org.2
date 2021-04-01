Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1293517F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhDARnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbhDARhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:37:13 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA02C0611A3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 05:28:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id y5so1919738qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S2lOqshgmzLNhO0Nubkd7SMctWNe6/PwkffE1ihM8go=;
        b=kIlF+XJbynAyetha4A1edQvJgEusSzGIDoeh8rqyepY4GP/NGsMBFAuQkd8VVtOccr
         9mo47pjAa25TPr402EsVDpi1+/4D65p1tc4UcbrGVBwdr/l6gE6ZtXONfvsafPzpvSAZ
         nJQTKO61IIQdRefBwpBYnWiZcVVTc71it2QBYbVaFL40/vRw78ls4Tlg4DcKvrYuQfbA
         vKwinW4j+oblL8MQH2CcEo0LFLL8CQIUCZ+bNwsJvsuMLvpfrMKJHEQp8TKx2dch/zbT
         CpHMQoWokFTfDRvkrInFNGfiZC8MTWXB0RCpNtoheILZAKL4j6KicOin4+M9aN663vU7
         nPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S2lOqshgmzLNhO0Nubkd7SMctWNe6/PwkffE1ihM8go=;
        b=J8CQEJySknC1eIxKh8exQem7dEB2yUjyoHvECSXGt+gjro1yyuAXT06M+hHE4nzqhK
         E5lDR/hDo0fUA6yuTodO1s+FRSERRI9LU3NKdWF2pHeYUbObKbcvkf8ohhmoFICeslpX
         XlRDy+q7eij3NvFk7nHwOGsozGWnifEMR734if8xpP07Zp5JSk3FroLsDLlegOb2vXFR
         q8NsoUBBdJ3J00Gt13nz5xpnCqRaqfQ4/XyvUvgbHw7l42V3Q6McS6w4H6exRSfOCD+t
         L/47LIqpfBiuwsFeaSEYNeYuU6yWW6zdkVkLEpsQQEcod76E0kxEkp6YUyP3upInyj96
         TApw==
X-Gm-Message-State: AOAM533duv0LkQbN6zRznRF+2cgndfygFQyAauGfo5BZSDfSpxRuDsDh
        9ISvXGhSw3JeCiKI22gWU+p6dA==
X-Google-Smtp-Source: ABdhPJx0uj4bLqv9+WIZDVq4iNjdBcpawuNSS1qIonBNVvkFxbwfdgcwwyy4CiyIWV1Llh5w+umxiQ==
X-Received: by 2002:a05:620a:16d3:: with SMTP id a19mr7877674qkn.88.1617280085277;
        Thu, 01 Apr 2021 05:28:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id d2sm3218920qte.84.2021.04.01.05.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 05:28:04 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lRwQd-006jmF-Tc; Thu, 01 Apr 2021 09:28:03 -0300
Date:   Thu, 1 Apr 2021 09:28:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 00/27] Memory Folios
Message-ID: <20210401122803.GB2710221@ziepe.ca>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210401070537.GB1363493@infradead.org>
 <20210401112656.GA351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401112656.GA351017@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:26:56PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 01, 2021 at 08:05:37AM +0100, Christoph Hellwig wrote:
> > On Wed, Mar 31, 2021 at 07:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
> > >  - Mirror members of struct page (for pagecache / anon) into struct folio,
> > >    so (eg) you can use folio->mapping instead of folio->page.mapping
> > 
> > Eww, why?
> 
> So that eventually we can rename page->mapping to page->_mapping and
> prevent the bugs from people doing page->mapping on a tail page.  eg
> https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2103102214170.7159@eggly.anvils/

Is that gcc structure layout randomization stuff going to be a problem
here?

Add some 
  static_assert(offsetof(struct folio,..) == offsetof(struct page,..))

tests to force it?

Jason
