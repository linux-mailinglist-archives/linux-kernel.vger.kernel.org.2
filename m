Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB240B508
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhINQjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbhINQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631637449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VemZzHEHtvtRUEB5jhPXKS5+fvR58IDWDZBKVTdj0Ds=;
        b=LfAEP5Dr2C14d7HF2oVILkhcdfmcCZ8kTowGCQ5mKXl3nF8DhXIPu7DJYyokUc1lDdZg5q
        73ukanMlSauNyun3ujmQzDylCMQFkFYuVd1AsD4zuzZWRNcSBFpaLm22aXZ4/BBgpHBSVX
        qaMZO8tq9D4xVY0N+YbunMjmwuUSJiw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-J20V3ryxO32JPyI3lWxLAQ-1; Tue, 14 Sep 2021 12:37:28 -0400
X-MC-Unique: J20V3ryxO32JPyI3lWxLAQ-1
Received: by mail-qv1-f70.google.com with SMTP id a15-20020a0ce34f000000b0037a944f655dso7849336qvm.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VemZzHEHtvtRUEB5jhPXKS5+fvR58IDWDZBKVTdj0Ds=;
        b=SepqhLn6IEUrG3C6JnVHaoSgaSg3vGLQ8FeBsq+NX6FcUo8SOC6E4NBZugLAIkMSn3
         NXkkNVoq9s2BYCqPXikPjz3PrFg6UG6UxDPzQKFlnmb4mTy0PJukrm2R7i0HpQDjdwDQ
         PQ2kFs+swAxveHkhgUEOtYyFLfsp2Aoy7ksHZUxcA1eHaijm+njEBiD+7zHNNQ/7/mE1
         J9cl9cElwWl1m/iTS9uifVXZPGpN1LoEMuhg16wV9fLhJ2Q/6v67oGrL3yFdHGwfMB7C
         +07/MMy+z6GCYlliZLt+zPJsDhgj3It9WMSjS3kFsJTuRYfhl0yAM8ywd93ugqEumhKE
         I9sA==
X-Gm-Message-State: AOAM532cXFBVlcNKO7QwAD0eRsWIH5i2tP+YB6ji237bL6h6JKGLA7QB
        isqjKe2Vt/uFLcEjWobzeIuSCmcMa2bo2Rx0xxtHwPReUP8/HweHLD3GuU9J2WYI4YrduB/GLzG
        yZyGv2dgvTL+vB2wBNrfOE9OWWD1gAh/JuFE6uGF0oFa4oUcE4zyIcpbs+/fQ6UqnX+wbkBUZJQ
        ==
X-Received: by 2002:ac8:6bd0:: with SMTP id b16mr5807464qtt.375.1631637447792;
        Tue, 14 Sep 2021 09:37:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxGn2r5G56Z4L4YfGFdhotY8WSkdSKL9b2c1wMMNiVWfrcMFfm6lfVhTbNjIhzVBNkBFCDVA==
X-Received: by 2002:ac8:6bd0:: with SMTP id b16mr5807420qtt.375.1631637447457;
        Tue, 14 Sep 2021 09:37:27 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id q10sm8128857qke.108.2021.09.14.09.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:37:26 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:37:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/5] mm: A few cleanup patches around zap, shmem and
 uffd
Message-ID: <YUDPxezHSd9BH955@t490s>
References: <20210908163516.214441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210908163516.214441-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 12:35:11PM -0400, Peter Xu wrote:
> [Based on linus/master, commit ac08b1c68d1b which should contain the recent -mm
>  pull, if not applicable, I can repost anytime]
> 
> v3:
> - Patch "mm: Add zap_skip_check_mapping() helper"
>   - In zap_skip_check_mapping() check zap_mapping first [Alistair]
> - Patch "mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags":
>   - Fix English errors in commit message [David]
>   - Drop paragraph mentioning commit 22061a1ffabd in commit msg
>   - Set ZAP_FLAG_SKIP_SWAP for unmap_mapping_page() too
> - Pick up r-bs

Ping - patches 1-4 have at least 1 ack already, the last patch is missing ack.

The change is quite straightforward as right now we apply SKIP_SWAP to all
"details" users of zapping process, so no functional change intended.  It'll be
important for uffd-wp in the future because uffd-wp will start to use "details"
without setting SKIP_SWAP.

It would be great if anyone could help have a look at the last patch, thanks.

-- 
Peter Xu

