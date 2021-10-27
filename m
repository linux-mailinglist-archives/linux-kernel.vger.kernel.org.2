Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1468143C35F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbhJ0HAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhJ0HAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:00:03 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D70C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:57:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v7so3998103ybq.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URxl8t8iTYJfz1qegI+ZGga/wMgCd+ssj3joE4QRces=;
        b=0oqJUyZAYxOn7SkkO2Owy/OKG6jjgVwHfM5DImY2Uqg7NeRkOA1Jlm015B1yt6Lvrq
         cF23qnQ8XyXHd27bsFp6OjTqyKoeCKyNpgq+gIf76NbiBY4BM28h6Yzp7wg0+Ly4r4bi
         7w0hItzVroBLtPgKBfBFtzm8p2gZzJfWGJY3gFSlAbaCFfLp0Tmkos1Ynz+SfD334Pyx
         N6tULj3ehsU+EOD6SstWh2OtwKSRqShD0oH9DqqPFPY1diVa1yOgwc9l+YYClVUVPfbP
         X6CKZt9XOMSzoCcGlK1vlfhuTGM+lCe9f7fP5I6hPdmR09DTghvg3lWc0PqMKcAXfS2c
         SchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URxl8t8iTYJfz1qegI+ZGga/wMgCd+ssj3joE4QRces=;
        b=CbRRWq9BrNp/0MB2xTq0Cle1J6m7PEmJQAOsBAkDDuulCDeOeAol24Zqog7Aw5YgSy
         XCMGu8ogxHqYM9MpS77+5TwH6SseNCc0JQGqNWbVm5/qL+h/18EPOq8arBC0KrgYb9PI
         dpqYuGAhQEbS61yea0L3kaBEc+R62G7CgRZl1e8lZRM8jUnB8gjY325WdSEBdrO8v4+3
         Rk4RKhNXJj7biXKId+WS0Oit0hYZErGpTOIkjfV33bJ2YeyaN17SanYBodZKbx7n9URX
         YfmlnDwzcrciSDP0NntnSDI4zx2HmSENHqh9ElKI90SrpggmukTjmRlF+ZzkeSUGlL8n
         ngMg==
X-Gm-Message-State: AOAM533P4Ug4d3NrMR8LsBmpcydS8RykWzCk+QF4L5S6+l/YODI9epbj
        fK27htrs8NdRwwEZ+XQo1Pw8/AkzCkzPyDcHAcqaKErXSWu5Lg==
X-Google-Smtp-Source: ABdhPJyuUT26bSUSn9qQ/m4WhUOtF8+ZGACnApnN26Yj5Fyg9OMfR9Ge5DudmEflD3rkSm2YkqZkoxzk+bmDsOIe7aA=
X-Received: by 2002:a25:c5cb:: with SMTP id v194mr27182906ybe.419.1635317858126;
 Tue, 26 Oct 2021 23:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211026220635.35187-1-mike.kravetz@oracle.com>
In-Reply-To: <20211026220635.35187-1-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 27 Oct 2021 14:57:00 +0800
Message-ID: <CAMZfGtXGC1qWbJeVrKh1+xXmvXwm1Dw-V91i3XL5=r5kw_P7Cg@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: remove unnecessary set_page_count in prep_compound_gigantic_page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 6:06 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> In commit 7118fc2906e29 ("hugetlb: address ref count racing in
> prep_compound_gigantic_page"), page_ref_freeze is used to atomically
> zero the ref count of tail pages iff they are 1.  The unconditional
> call to set_page_count(0) was left in the code.  This call is after
> page_ref_freeze so it is really a noop.
>
> Remove redundant and unnecessary set_page_count call.
>
> Fixes: 7118fc2906e29 ("hugetlb: address ref count racing in prep_compound_gigantic_page")
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
