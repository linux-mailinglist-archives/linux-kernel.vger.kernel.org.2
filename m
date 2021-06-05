Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB81739C840
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 14:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFEMwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 08:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhFEMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 08:52:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50494C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 05:50:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so8951048pjp.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlZfc7pEeqreOo3MXeMdmrALgm1ljXYzN4kf8mOS59o=;
        b=yCRfCAR5vsxQG9DA6xdvi+LqB9/VQQ+4FWIH7wCHUEfknWrosW4+N9uGkNu0CiGTxo
         AXf7/RUX1ajcYDzPKnubtPrwezj5ATVM3s+jBMQAhsEl3bgTxkkSte4xN41q8JA73lJb
         37fq4CHkGKfOjMOhiQYarsoNBQtJrgekB9uAv+o2HtG+N5o5uZpp5pjTvVCETG43Nm+k
         ACBqTIYvsoss84XDeYatEG8kOS8Ljy+EhJjHR67kYW/rBfQRAFHOVMbnwcKYE9+RvCM0
         lTRmSbfpA4rDoFeSs49ftv9jlHCLMhQrkxjCjasaMYz4J7MOkiVGQZ3aZ0n9FpOMavMg
         SBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlZfc7pEeqreOo3MXeMdmrALgm1ljXYzN4kf8mOS59o=;
        b=MGBvo5I+0y2qJQh2mDmxfRY9yjSTBL/CXu8amxsaGLgVfApTB3pi+Tp0n84wUiC7js
         ztBgVfvFGdH8ZgA3nOPHbLLIjR13L2e628Ae4GnZWA6kdfinNmc208DhWpvzANy0QmMy
         /sPvOAEJM4uc+q55A8Xhi725819WiLMCbUxyovPYDWcdgzQldtrl+Gw4KUt55xXClAxf
         XyGTZhSYnsdU7IVSMFaH2hgPcuOXxXvW3mlyBhjfTvc9FSyAJnr7JYXIOsg2xyi+Ql/k
         C5XCjiFPY5URqyRWwyO59OlRYw9SlvCNGK+Q6OTQQb52XuKZ2o2Xwt5HaSl8MFndAvb/
         f4/A==
X-Gm-Message-State: AOAM530p4xCaEsCR8gc3da7B4C5SEkggDpnK39ZZBLExJFrukT3p+tgm
        ET4L476H7XdrSgqFnPDl0K0XpoLXCjd5bgN5yoAe3w==
X-Google-Smtp-Source: ABdhPJx849ceFnSkjnMEorauDXxs4AidxZAumfgXjsh+BeciFeCvOxH07RG/QxLx32ifGFn1lMzmJWl43Vweys84ICQ=
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr10423837pjb.13.1622897434869;
 Sat, 05 Jun 2021 05:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <1fd32aad-c99d-e89a-cdb1-05843f568f0c@oracle.com> <20210605010626.1459873-1-almasrymina@google.com>
In-Reply-To: <20210605010626.1459873-1-almasrymina@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 5 Jun 2021 20:49:58 +0800
Message-ID: <CAMZfGtWf3rx7MT88+t=H=5bVs_yNBFX5YTcWZs7in_+17i7+Fw@mail.gmail.com>
Subject: Re: [External] [PATCH] mm, hugetlb: fix allocation error check and
 copy func name
To:     Mina Almasry <almasrymina@google.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 9:07 AM Mina Almasry <almasrymina@google.com> wrote:
>
> The alloc_huge_page_vma() doesn't return error pointers, it returns
> NULL.
>
> There is an existing migrate_page_copy() which not only copies the page
> contents, but also page state/metadata.  People could get confused that
> 'migrate_page_copy' and 'migrate_copy_huge_page' do not have the same
> functionality.  Rename to 'copy_huge_page()' to make it less likely
> folks get confused.
>
> Fixes: 6a0badc266df ("mm, hugetlb: fix racy resv_huge_pages underflow on
> UFFDIO_COPY")

I think the commit id is not stable. So this really should squash
the commit of "mm, hugetlb: fix racy resv_huge_pages underflow
on UFFDIO_COPY". But anyway,

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Cc: linux-mm@kvack.org
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
