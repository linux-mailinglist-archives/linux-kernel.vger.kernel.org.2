Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90D43CF409
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 07:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhGTE53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 00:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhGTE5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 00:57:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D0AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 22:37:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bt15so13049889pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 22:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EX/d3F27UugquyAjfTnPTBtVfKy8vmZpCCq0lcY7Gp0=;
        b=P+ARNeROIU5w7F6upM0uMOhnGdKVUfmQhlCpsS+1vEmfU3ZNE4lrRdSnNh9QqZj6/I
         sXH2ULhpNCH6GiGVKn02EwfoGv7kMogMIb064wzJd+KD366WFdbYebagk++I3tbejUcw
         gJmDLKK7MvjwUz8WYnmALHRJ1kCKrea3IisDZr3zOYdiQGK7gRK8HqX0Q1SIUyAwH7nW
         OlcmkF71YUGshKwj+/2JDHrNZX8Mbh4HN1zPUA446yP7pOkJGG368UO215wnZfl5bZ7P
         L1UPztE+l0ypE9iKXJHpYdH8dhhMdCnPwASBPQR+IS3TQ8rpD/3r4pxnsI/BZ88es4y8
         +jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=EX/d3F27UugquyAjfTnPTBtVfKy8vmZpCCq0lcY7Gp0=;
        b=ogu/PYrAcbQiH7cQnFDmOtImYl6juxPad2ya2byC5ZtwqWzFgbkmuNkvfPZq2r+xuV
         mzIsGOHDvbCeFWbGH+Hg1mH30B6OkszeHgRhnU8Jxg+Dd/pIs38d2WQQyIdSJo6Jejc5
         yN6Ce62FN72NLBAXd66YDzNnR9dZOejDUTOIlzs3Wk7Uh7wNPv/7aXg2wbbSA4C/Z+5M
         tBlo/eSRz4SYYCeIzWbXm7qKWyK1sBo7jXVuz2ER48fiodk6Jtw5+vBQuSA3iPE5oS7h
         O9klHroAo13/KTwASr3HJNFNZhMB2W+UG++29RPtncy41kSFAQNTHmqC8E5WTlHwkfbL
         fWkA==
X-Gm-Message-State: AOAM530yiNtfIpAqo2uJA2LPixGtTbN6VT8k7X/TaWSp3xTl8uTFqve3
        aEvxc7Lf2JE9vLWKXeNtw63RW5iQAe8=
X-Google-Smtp-Source: ABdhPJyQlHqS3FXu1Dr0bp/psH4zvJsFkI4lU09QGbSL0shBJV5Je3poGArd22+729MmoA7pBwdNSg==
X-Received: by 2002:a17:90a:a6a:: with SMTP id o97mr34881140pjo.179.1626759479263;
        Mon, 19 Jul 2021 22:37:59 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:92eb:ffdf:6b35:b94d:258? ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id j21sm18004462pjz.26.2021.07.19.22.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 22:37:58 -0700 (PDT)
Message-ID: <283e44591010dcb0690769afaef147add3b36978.camel@gmail.com>
Subject: Re: [PATCH v5 02/11] powerpc/kernel/iommu: Add new
 iommu_table_in_use() helper
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Jul 2021 02:38:16 -0300
In-Reply-To: <29c199f3-63a8-3edb-b29e-de157431d89f@linux.ibm.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
         <20210716082755.428187-3-leobras.c@gmail.com>
         <29c199f3-63a8-3edb-b29e-de157431d89f@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fred, thanks for this feedback!

Sorry if I miss anything, this snippet was written for v1 over an year
ago, and I have not taken a look at it ever since.

On Mon, 2021-07-19 at 15:53 +0200, Frederic Barrat wrote:
> 
> 
> On 16/07/2021 10:27, Leonardo Bras wrote:
> > @@ -1099,18 +1105,13 @@ int iommu_take_ownership(struct iommu_table
> > *tbl)
> >         for (i = 0; i < tbl->nr_pools; i++)
> >                 spin_lock_nest_lock(&tbl->pools[i].lock, &tbl-
> > >large_pool.lock);
> >   
> > -       iommu_table_release_pages(tbl);
> > -
> > -       if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
> > +       if (iommu_table_in_use(tbl)) {
> >                 pr_err("iommu_tce: it_map is not empty");
> >                 ret = -EBUSY;
> > -               /* Undo iommu_table_release_pages, i.e. restore
> > bit#0, etc */
> > -               iommu_table_reserve_pages(tbl, tbl-
> > >it_reserved_start,
> > -                               tbl->it_reserved_end);
> > -       } else {
> > -               memset(tbl->it_map, 0xff, sz);
> >         }
> >   
> > +       memset(tbl->it_map, 0xff, sz);
> > +
> 
> 
> So if the table is not empty, we fail (EBUSY) but we now also
> completely 
> overwrite the bitmap. It was in an unexpected state, but we're making
> it 
> worse. Or am I missing something?

IIRC there was a reason to do that at the time, but TBH I don't really
remember it, and by looking at the code right now you seem to be
correct about this causing trouble.

I will send a v6 fixing it soon.
Please review the remaining patches for some issue I may be missing.

Alexey, any comments on that?

> 
>    Fred
> 

Again, thank you for reviewing Fred! 
Best regards,
Leonardo Bras





