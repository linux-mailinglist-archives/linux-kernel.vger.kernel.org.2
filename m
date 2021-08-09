Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE33E4739
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhHIOJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhHIOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:09:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF26C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 07:08:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id c25so15319512ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 07:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zR6+b4jMQHu+xJ/A9TlI8gnwYind6t4cL5CmTg0J/sg=;
        b=laQXcY5+l2yqZ9bgjlwSlIh613HtIDArhrDi5bmvioCLPLweoajCRMFawJpgJDsC3C
         s8KladoRM2g6c7xOCe6VjpAuP5eh79bw0GdM8eWYtRACCZjEHjHMZqVCSTxmXDWJ+vUz
         FWv1LJdCNk4/TF0UFzvsNTzy4tDDAPsR53mstI20F0Ry+jyesy8fxEtCrzNpMTShAGfd
         tUGZKXwNFdaVPqoIaJ3/n90RHpL4C0jKEyuPFIyTMJTlFOazUZI9bfO7vusiM4JUi3ts
         cuWxU1vc0xSyqgSgXvFEUO6at1JDkZKFWdkJ6MnqUTdOvzf8GI+RcV5/OilNBicyUKk2
         OkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zR6+b4jMQHu+xJ/A9TlI8gnwYind6t4cL5CmTg0J/sg=;
        b=VDGBCgkcyunHxVndpHCB+yz3YenXWfs8q+j8rZhXM17Wv7s0qiqcJdUZJjV0vu4L9B
         TzeWokpMyCFmWL8VMWa87+6JgvCA0eEC2HczW4+VkmtaM91G0BOxwoe8KaYa9mz/BfZb
         acZ4EZOcHlVr9JvowqYKFKYAJs636oaBWQCcH1N+oEGB/gVKlbCF3rAdSW3Jwzv69f1G
         7m6XsSFq27IuVpdU45GL37ENN6ZQGzXGlxC52K48qRvtOfKaamthITAYVO2QBJdETzMk
         m+XLNnIPzZQAIFYZ07MzyXKDkNFtRexZu9g1s3PYcjLxw6DKpYJPs2DtZSemxeETrqiW
         okug==
X-Gm-Message-State: AOAM5316QNnDuQ/geofrSAr9vsf0EE/lq5xwkkpGndFEmhOGRgZwJpi2
        Q3Cxcf/+kwD6GUb73cEUvJW9qTTuRsjvB3QH5X9sa3R8
X-Google-Smtp-Source: ABdhPJwTh+xvPOetWpwQq87E8NuXpPo+Arodp6MN1X8piZv3IFZ/2VSBmQdMIXxfBXGnLDrhZ3HSqMJvjpRDf3vl7Ok=
X-Received: by 2002:a17:907:9851:: with SMTP id jj17mr5002781ejc.489.1628518117708;
 Mon, 09 Aug 2021 07:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210805190253.2795604-1-zi.yan@sent.com> <20210805190253.2795604-12-zi.yan@sent.com>
In-Reply-To: <20210805190253.2795604-12-zi.yan@sent.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 9 Aug 2021 07:08:26 -0700
Message-ID: <CAKgT0Uckb4_EOaCmfp4UsDCMi7jROThFUpDa_5f4s7jH0oxaNA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/15] mm/page_reporting: report pages at section size
 instead of MAX_ORDER.
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 12:04 PM Zi Yan <zi.yan@sent.com> wrote:
>
> From: Zi Yan <ziy@nvidia.com>
>
> page_reporting_order was set to MAX_ORDER, which is always smaller than
> a memory section size. An upcoming change will make MAX_ORDER larger
> than a memory section size. Set page_reporting_order to
> PFN_SECTION_SHIFT to match existing size assumption.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/page_reporting.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 382958eef8a9..dc4a2d699862 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -11,7 +11,8 @@
>  #include "page_reporting.h"
>  #include "internal.h"
>
> -unsigned int page_reporting_order = MAX_ORDER;
> +/* Set page_reporting_order at section size */
> +unsigned int page_reporting_order = PFN_SECTION_SHIFT;
>  module_param(page_reporting_order, uint, 0644);
>  MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");

The MAX_ORDER assumption is correct. The general idea with this being
set to MAX_ORDER is that the processing is from page_reporting_order
to MAX_ORDER. So with it set to MAX_ORDER then page reporting is
disabled.
