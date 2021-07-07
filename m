Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCB3BF0B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhGGUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhGGUZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:25:22 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BBAC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:22:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f13so7447446lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hi3ITr6SouGSQjeuqThC33/t9lBaQSut2Lh+7accmC8=;
        b=WvflrsatifR0C1QAecIJeGdbr6flHM6sV2cF8SX6cRCr+xI0NrDl5WsaWCEb4VpLrZ
         38+7Vsmi6Pjyw0lxSXilNET19LVUzwO2/jVE62gY6Bbd0OW6EDyW1Lipy0R+9QMKGum3
         lsiDIvqM4gC9VIQlZx4s7xrzGk14kRIncraWnY7fnzY6Fel954Tnjy+7QNZkn2Nrrogw
         UiDvj3BeLLGBmjdshySJvN1FV6pUSiUJ/PEQKyPRR7vcdKDMstFoUfsdpMfaBIRj8uOk
         LGBW/q5bcK389MmrwxihaFmjbLNidJFRBssHJoYxAGwjdx/yg0cL8i0dYf3iklYIPgML
         eT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hi3ITr6SouGSQjeuqThC33/t9lBaQSut2Lh+7accmC8=;
        b=p6HDP7mRPAqu3KquDaBzRQgkKXIW6UF8VXEvDKRBV+QO8Ql1PPLoKEn81mgYiLLekD
         V3D4izsKxnTk7c+Jo7dqJuz0zY6JHfcn1FNDIjqxhR1RPHNWQ+fuGwyLvrnkWrAdg/Ke
         5YBddirXuJhxGFnj6F+Kj5jX80APxLgUw5V9oPnLNfMjU/BmjfqodvCNV5VG9gxQiWiK
         VIIGAs/aWTaEY4OTCjTPW8SQD1ff+g5w0+H16BhgFlfJ8i5VoYWQx5gQp307sZgvJi1v
         1eOBThVFd3SE0P/0tznRt66D9/k/FaDMpyFCzP3Yle/y7UQBLue9IZioYOaJaUz4PW7Y
         FXxw==
X-Gm-Message-State: AOAM533zI/6MjpeKeQpYFPaQ4qXshk8inskr9vb0eK1yjOKP7d0LpWwy
        RDpV8mK8PhMVG1ilTw9fdFGOuNOBQsBbDmFK/3p+uw==
X-Google-Smtp-Source: ABdhPJwF0fIfrpNN3MSAzhfkvbnU1hEac5p+VXT1iV3T/45FpdBLs0uMyCX5Yh8u2dv0LP2eGplEzO9btiLnEAMd7GE=
X-Received: by 2002:a19:7418:: with SMTP id v24mr20712677lfe.117.1625689358863;
 Wed, 07 Jul 2021 13:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com> <f71f8523-cba7-3342-40a7-114abc5d1f51@google.com>
In-Reply-To: <f71f8523-cba7-3342-40a7-114abc5d1f51@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 7 Jul 2021 13:22:27 -0700
Message-ID: <CALvZod4Tm_4mmNPW-5yfDPdOdukEmmZ1sqYpL9qUbiEXTms2dw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/rmap: fix new bug: premature return from page_mlock_one()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 1:11 PM Hugh Dickins <hughd@google.com> wrote:
>
> In the unlikely race case that page_mlock_one() finds VM_LOCKED has been
> cleared by the time it got page table lock, page_vma_mapped_walk_done()
> must be called before returning, either explicitly, or by a final call
> to page_vma_mapped_walk() - otherwise the page table remains locked.
>
> Fixes: cd62734ca60d ("mm/rmap: split try_to_munlock from try_to_unmap")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
