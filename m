Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3F53922FE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhEZXFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhEZXFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:05:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8E8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:03:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r5so5033895lfr.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZAwr+uWe1RDh6PrvXQCTvhQUq67NZKbIFSU2NmGCms=;
        b=DInztS5vf5H0IuXW0bNB2j/bEcRgqdeBKI3unl909a7pWSL4CZS3Tpy3WBmmUC0gQY
         f68bgDCxLBTVFTAeX0sz7iharrOIYJSyiL9a4g2if77wv6Kt4MMDG5PxQWPy2jEvRogq
         JHf9kdJz1NqntFyp92Ws2ydglgYZOR2wRU1uEqQqVja7yEfpbEKpjNq093b4E1xcZR/l
         3t8Ry09STINW1tp0ja6ia3P1FQ23E8rW2vntCvdsVevBk3LOb0+d26/1qDeV1Pfr9gQZ
         mFJZUPSR3GZpNKfvPFAoPmlR1k0qTLgF5nqRDSayzEjb4ePVni/0iGYbri7sNWNt+q8z
         e3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZAwr+uWe1RDh6PrvXQCTvhQUq67NZKbIFSU2NmGCms=;
        b=lWU+z1BJ++3XQ6MhO/k1iwZLEPttoC24p1jlAilY5tickwPGzPk/xuDF8MvaOh8rxS
         rgVUiFVmumqhTXzql87ka5rBI5y1Y5ZpKIvJ1UWGpUas7Wk7YwzhgxQWeVPoXOGPBOf/
         /3BIBj8hliv6kwMO5tqB+i7Lx4ZXOkASp5eYgRC+0CVXY4/Suw9KKXff6XWfIcbt/WF4
         2b6afiKxKpUda0GbHO3/qVfuXXpdAQ8F14e2MIO3CbhwK9r0Atu0jl7HVrx9hRl5FrfF
         TtCsTDLke8ql8OPZuegsAlb+VenYw5T/X/jOj8+gil0Z3PGpZtWCnBm7kzN6MYPQR5ns
         yVOg==
X-Gm-Message-State: AOAM530o3l4S+pcLLpN7KVjpr+iwJDu2oUHqfOStHBwd+15OHj7xQpWO
        kc5dGjpanYZBsZv4yGqmVMAuWtlhioJO+3mVzYtbEg==
X-Google-Smtp-Source: ABdhPJwVNK5U1mLQGbtiooe5DWoQS/py60QeZeqjo8+tyrjQRST7xi1Cw3dVr1w2aBB8MPL7N55L07DFRCvJvmC/z0Y=
X-Received: by 2002:a19:7012:: with SMTP id h18mr285616lfc.432.1622070215096;
 Wed, 26 May 2021 16:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210526201239.3351-1-shy828301@gmail.com> <20210526201239.3351-2-shy828301@gmail.com>
In-Reply-To: <20210526201239.3351-2-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 May 2021 16:03:23 -0700
Message-ID: <CALvZod7AXsky5ojvc_4E8=vK3eaBmto0XHcc41fBLFuWHUA4+g@mail.gmail.com>
Subject: Re: [v4 PATCH 2/2] mm: rmap: make try_to_unmap() void function
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>, naoya.horiguchi@nec.com,
        wangyugui@e16-tech.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 1:12 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Currently try_to_unmap() return bool value by checking page_mapcount(),
> however this may return false positive since page_mapcount() doesn't
> check all subpages of compound page.  The total_mapcount() could be used
> instead, but its cost is higher since it traverses all subpages.
>
> Actually the most callers of try_to_unmap() don't care about the
> return value at all.  So just need check if page is still mapped by
> page_mapped() when necessary.  And page_mapped() does bail out early
> when it finds mapped subpage.
>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
