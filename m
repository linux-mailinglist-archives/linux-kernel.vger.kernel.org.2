Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5732D9B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhCDSzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhCDSzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:55:18 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9984C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 10:54:37 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id m11so33810788lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 10:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ItS4fB2+vHharXBTqJG5Dm5+9xgs3TLgAY4Z0SXyWE=;
        b=Fy+ZWcTSiwFrD9Fg0RPINlU41uoPlkjcT7tN5KTrb1DvXXqFwPYBhyvKYUn9eqvguk
         XayP7jFz+dMKFzVd/BvAsClCM4K3FXdIGJ33eREf9ehawiKKvox+ALErWuYujHBc4PIH
         kphKC/qP2Ra/u509vgzb0TM6aMfnAWTkFvlHcAhVhE1WZOojb+fCqthinHzjtUATr7Xm
         vQMAxs7IrYtBmtiTKi+jK3jmyI16T3MlwELgRxULZo6bRFD3x52clXOabJ4i1MhSakTe
         kA+pVJ1w8fsBwFK8nDq0M+BKJ6LJQ+jWTpTKPHqX+3bBvEtZfRwa0yvl+9VIPXpwTKL6
         jAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ItS4fB2+vHharXBTqJG5Dm5+9xgs3TLgAY4Z0SXyWE=;
        b=cAnIhdqpHyOjNtChTmI9qmIPtYn4Doie+AT9fGEOnLJtGP0VfgUJqgKp/MSk3ffzYs
         TkWJq/xVeHwUR9SMexsQ7lJXRR81JUP0cJRXnLoBzZqxA+vfgQvlMteFucl2raln0ii7
         wHAV9B4E3hzJgqX5lr6WuO2m8WQzrnQd0CLg70jWG0BcXLjbR0HprvdTlo3IWQ57qQxh
         Y9r8mP+npbRmNnwSFeAsni5CpF44MdKp/GaEQ6Bxw6mQAMsd3x80ciYkOA1Ygi0A5SMD
         63bnkhtuErOPwquLH4Mapk2jYQ/CiVxAOMp78amWCA8XeEOWGGpIMjlvuk/Tt7B2dkXh
         A+JQ==
X-Gm-Message-State: AOAM53021w8ZWASdOEt9MKPskU/bT1xJmj0q2K4cqjrhyCv5mP20pgeQ
        rxiOSO1h7fgqofTep68jp0xzhjwgrt6Iwv6G7npVNLix8x0=
X-Google-Smtp-Source: ABdhPJxPKF/gtrjLNd5lVUk05QxoDjOpDsaL4m0OFqqzAKu3Cdk/FUticMgar/Q+zVBLTfMvhEBy6E2/GRNNofoSnfE=
X-Received: by 2002:a2e:9195:: with SMTP id f21mr2900326ljg.160.1614884075793;
 Thu, 04 Mar 2021 10:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20210304074053.65527-1-zhouguanghui1@huawei.com> <20210304074053.65527-2-zhouguanghui1@huawei.com>
In-Reply-To: <20210304074053.65527-2-zhouguanghui1@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 4 Mar 2021 10:54:24 -0800
Message-ID: <CALvZod67Pzzd4kfhoe1QRUXz4X=4imnymPhoRMLj51++4yL7VA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/memcg: rename mem_cgroup_split_huge_fixup to split_page_memcg
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 11:55 PM Zhou Guanghui <zhouguanghui1@huawei.com> wrote:
>
> Rename mem_cgroup_split_huge_fixup to split_page_memcg and explicitly
> pass in page number argument.
>
> In this way, the interface name is more common and can be used by
> potential users. In addition, the complete info(memcg and flag) of
> the memcg needs to be set to the tail pages.
>
> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
