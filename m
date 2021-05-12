Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2014D37ED24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378724AbhELUNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358100AbhELTB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 15:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620846048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d53AbpPViI4JdynXerclhzEEmPydKOif4FE1CyxwmVU=;
        b=YspWzzhPSNCw+X8NtTkUW6MGyfYB96FFhc0tSNmdcht1d5beQrGaW9k66301INeeX8zjSy
        ZaKoTm5tpnBdD1hGVZu+cTvv642g1eG7p2ehJ4QmFbXi7BVt8M1ahsu9L51L/10KCMdGBS
        t3KOXkG6lG8SoURVhrljmOnUEii0NbU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-cmE8Cfw0PxKFVicWz81XIg-1; Wed, 12 May 2021 15:00:46 -0400
X-MC-Unique: cmE8Cfw0PxKFVicWz81XIg-1
Received: by mail-qt1-f198.google.com with SMTP id 1-20020aed31010000b029019d1c685840so16436334qtg.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d53AbpPViI4JdynXerclhzEEmPydKOif4FE1CyxwmVU=;
        b=MsQxVVXpj207EH0+olC3IF4r5iM6jlcLkOb0l/1mD8rWTcrnZc0f8inwpGPytkTRhg
         0815pTzmPsXchlu7Lki8JcRnpHYLOhJFBqWiXNaMaLsoCZoWLQsv7TuiDtSFx5rayKHF
         lUBt1wr85soWt8374AwU1tAytIs2TIhpaBGXsHxAwH13eF4XPnOWaNbPnS65iQW8Lz7q
         tMbpGy8uXUgH8YXgFNQdJfDKEoCd9LGU67mUix8TsJpUN+ZqRga/XsaHghHGoKLvWZs3
         cHrzpWZhK0DQxVOCpoAQ3fCRS+uF9OqzkqZwnR/eOMPQOtKuRM6ilglaHAbn5w8L2ZD+
         00SA==
X-Gm-Message-State: AOAM530vsptYC9zMYDtlowP6Yhmhu3zpRNK8NH54m67FKO31NYuUPNs2
        jkUVTfhhRhyAVFMqJxAQeeE4w8jABwR1X76dRe4SWhMXLCNrirD3upgszOcjIRhDfqkYnQ9hvjt
        6o2z5Y3aBzKsvRu3poOzzVRCR
X-Received: by 2002:aed:2042:: with SMTP id 60mr34700051qta.340.1620846046370;
        Wed, 12 May 2021 12:00:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmcJlBZya5mSUMViEWt5ZmzkALpWvP+VOIznXl35RkE9MfVT3YMtKtz/5oOIWhLL9CObR9gQ==
X-Received: by 2002:aed:2042:: with SMTP id 60mr34700005qta.340.1620846046057;
        Wed, 12 May 2021 12:00:46 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id t203sm693005qke.83.2021.05.12.12.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 12:00:41 -0700 (PDT)
Date:   Wed, 12 May 2021 15:00:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 00/24] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <YJwl1wNM18trv7px@t490s>
References: <20210427161317.50682-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:12:53PM -0400, Peter Xu wrote:
> This is v2 of uffd-wp shmem & hugetlbfs support, which completes uffd-wp as a
> kernel full feature, as it only supports anonymous before this series.

Ping..

Thinking about a repost, as this series shouldn't be able to apply after we've
got more relevant patches into -mm.  E.g., the full minor fault, and also some
small stuff like pagemap, as we need one more patch to support shmem/hugetlbfs
too.

Hugh, haven't received any further comment from you on shmem side (or on the
general idea).  It would be great to still have some of your input.

Let me know if you prefer to read a fresh new version otherwise.

Thanks!

-- 
Peter Xu

