Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5C640F064
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbhIQD3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhIQD3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:29:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C346AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:27:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v19so5998754pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpSVsGqRAM7tzZJOFQLyq7I6t2DV/FxrnSYm6nDz6CQ=;
        b=g+L+wUBLF8LGmgoYaBDTY5RFRdjSErOSRCo+3+JDUkyXtefgHQkAKCGxM5Xo+/Rn42
         vuTlcskp560lWRNluRraf9fSLUckkfR9hCZFcnifzIpmj+ZnfsDaTdL+G8zrqYlHeqqE
         M4pY5ZjwvjTXTmKOAkEPyGiKKmAEZntX8deaA08OAg7eqDHYA+BHgA5vLoKnTvvEZxdG
         +4OwgjUnUuZM6PW9N6JOA6TEnYenboRGsJ5dWvRZV3fxxlamnovC/QSxcaEKnH15OFP2
         j2sBivpHTYbVMofI//CAzFmztQq4h/caZ3TEdrTMjzjKwGkSFniK+naxMSOxxCR2C0i5
         7X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpSVsGqRAM7tzZJOFQLyq7I6t2DV/FxrnSYm6nDz6CQ=;
        b=qD3KPglEkyagh2kNAA4VqRT4qSoKF5kv7WC5BZrVGJs1K3zr7PffowEemN5JukIN0p
         fiv0EJsCSHXzNBCLCR5c8DD/avuJqL9oqipOB5kvmHyRoiCBnJdiRfIAetXIWwThCsXQ
         JGI2Qfqa9Ezi1exj6NsNCDeTDEPRy8g6Jei0T0PDZMEiKfU7cSzL0oqqi3DaEnNh72CV
         js2e1vq2Nmwo8xPLyvJsarSjPkvj9J6vsC/k1XSJ2AJwVBofypeWvIppvzMo7cfDz4zv
         LQkc7bwGcK/WCTB0JAMBTbhpyRrva1/N4cLDUgXav2uKMScV+8+1INeEhLZVohD41gFy
         bKtg==
X-Gm-Message-State: AOAM530jeQT0wyjymMe0royYW1k521sDDcO4xOh3yWYZ5/82P8mR5tVo
        DqCbETZQ1MdcQB1vdsYhQ4azoBCNs9w9blpNomu2cw==
X-Google-Smtp-Source: ABdhPJwLShr73xUqn3fopcKpmsasJLKivAVs/wToecmamlHgSYUKv8wL4Y5iOrQU+w6u2wplmzLCc912kZD/kV2S1vU=
X-Received: by 2002:a17:90b:4f8a:: with SMTP id qe10mr8164668pjb.5.1631849267051;
 Thu, 16 Sep 2021 20:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210916212816.86838-1-peterx@redhat.com>
In-Reply-To: <20210916212816.86838-1-peterx@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 17 Sep 2021 11:27:08 +0800
Message-ID: <CAMZfGtXB45VAQeY6+X9=WA1vtHxXd5_sAGN_pHp7ouQMUFXd8g@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Drop __unmap_hugepage_range definition from hugetlb.h
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 5:28 AM Peter Xu <peterx@redhat.com> wrote:
>
> Drop it in the header since it's only used in hugetlb.c.
>
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
