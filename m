Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EA5398D4A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFBOl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbhFBOlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622644808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sm2SeoWRQxSEs2JLkDQxNMnAg+44pme3giDMnFaXq3w=;
        b=MsMs+uTkeydnakUAQpIHPcdJBW2/nYFuoWsNUoPluTktGJpM0h9IiNxnyVB1W/it5/l/3E
        KWOPqy7/XmDaV4my8Pioe8UujMuxGmCX4w/LuEL1JcVSB60HRRkYpV9gt56y+14LMJ9sfH
        nNe3NctPJ0INdiff2nW05qs+oz9lRt8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-0FDIH0vPPUytb2QlTi_TgQ-1; Wed, 02 Jun 2021 10:40:07 -0400
X-MC-Unique: 0FDIH0vPPUytb2QlTi_TgQ-1
Received: by mail-qv1-f71.google.com with SMTP id v19-20020a0ce1d30000b02902187ed4452eso1847993qvl.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sm2SeoWRQxSEs2JLkDQxNMnAg+44pme3giDMnFaXq3w=;
        b=P6v1dJApw+UvOBeVw/yhIJiRab40gnZr+lpo1elVUu3gtORyF+h36LouTFd88Cf8uD
         8NDZN4m/y9L+4Oxytye7rsiHHnDhZImViFTvr2xgUd4v/kcm9rd9fzLN/UhURhxoxD9A
         6akZl1+Ua5FlR/+uXoGnoYfdv6ok3oxg8uMBMIs1GzxOaCdxW+fkVU42rFwH9Famk3h6
         vR6hRSakAk7RqHxTQkCTSCVg9IoGTO0vC6/k989RbKpWYtxnekIZQdL7dByY6JpNlaaC
         hybvHF0LSO8QVozeqxcq4EeZ2Lo/isWK6+MsoyUSUcnAsJTeSCKCYSP+C5U5ULQP1v2I
         vxYw==
X-Gm-Message-State: AOAM533CRQ/cvauE/3HpFX84mxFlFSdqHc+MuxQeKjLyzTFR99mkuiIg
        prUjqFiHK8ukDR0mUiWPtSdTO2ehCr2i9uT5l+BC+sgEFFnXDJOrMMh11MM7/px2fnCUaSjgQSF
        dPFWZrNlKcYIn2fAhGrYizie73HZBg/IPtTD65jYAmeGLKRCxXkSv0D96bgFWLHlO44EgiEJwXQ
        ==
X-Received: by 2002:ac8:6e8f:: with SMTP id c15mr24629815qtv.122.1622644806870;
        Wed, 02 Jun 2021 07:40:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3toWTpmf5oNFkXYwNCIpHzdNHB3Vws+8IsJL6FriYvztbnKED6ShmoTTuLQOSSC998TXcig==
X-Received: by 2002:ac8:6e8f:: with SMTP id c15mr24629784qtv.122.1622644806606;
        Wed, 02 Jun 2021 07:40:06 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-61-184-147-118-108.dsl.bell.ca. [184.147.118.108])
        by smtp.gmail.com with ESMTPSA id h21sm8093264qth.10.2021.06.02.07.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:40:06 -0700 (PDT)
Date:   Wed, 2 Jun 2021 10:40:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 00/27] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <YLeYREkg/RrNjQ7v@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 04:19:00PM -0400, Peter Xu wrote:
> This is v3 of uffd-wp shmem & hugetlbfs support, which completes uffd-wp as a
> kernel full feature, as it only supports anonymous before this series.  It's
> based on latest v5.13-rc3-mmots-2021-05-25-20-12.

Andrew,

Any suggestion on how I should move on with this series?

Thanks,

-- 
Peter Xu

