Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE82F32D9BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhCDS4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbhCDSz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:55:57 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB6FC061762
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 10:55:16 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id q25so24773117lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 10:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIedxvn2pUV8jHqx/T/j7o575rCzZwehOhBHC4/HPSs=;
        b=sKgu7jrXa097dlgasbFRTSNvGa+cG0zoU1AX9QjQ/L59fLPazlvieepuALAEZ1ivie
         75Aw4v2mpGas++khIzwT/ExFDtW6OU4rXhmdgpJj+ncUHWVqKvmXXpOMqSkMG6+gwhFx
         NJQjIbaOTqzf9MyrcZqPtmG6/t8vmaxJwFTUMn8SbQP/x9IBX/hkbhpHcTM44Mi4AFzD
         FZ13O1tvKQZnVq6gjvvsJNvnsHzkiGFd+bjL8ckhy5k66gJB6o4sj+CfO5Eth1Y+ThVg
         2YNe8hHfRPAyGFAVtU7/o7CuKYJnNLsaCLeRt2RWc7YwuytYgl04NIL3tKnMUovOz088
         HFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIedxvn2pUV8jHqx/T/j7o575rCzZwehOhBHC4/HPSs=;
        b=kS0jByh1JNDkt5MRjRhjOAid5AjUO9FecUO1eUO06rQuXTvytpXJa3viXWxdkhEr5O
         cK9fNBguiWNqV7gI2HtZyhPPI6hFWYN09WBIDTx+ACz2nuuoluOuU20hJarVfOW5qpB4
         6ctFIRVRO2DZfpdjHfF3teyA0/DK89FDRuucJXj+r1PU2XHGUhIMZZ0GzKE83WPIwu9P
         GOTcjDHEKM6IzIWE8cThtXbr0MPD1Wc8cI9Uvh98ECmsEi6X6y3Hzlb6/ylgAp/WHAid
         C8Sh5la2tizJIUEyHeIBBYmGy6oRdI9dU86irg37XWvB+I0tSlUrIB89iPUW6TwTozp2
         Bqog==
X-Gm-Message-State: AOAM531z3/wPWO1lJ4qmQMFlwZWp9l9GADmEl2SJeMrjiG9nsxnDBAVW
        vXNAJbYhp05JNOUMx04BgcBYhQVi1g+SAIibyAUVSw==
X-Google-Smtp-Source: ABdhPJwSUSBW0MkbaQYXDHv3jvqkvvYIRhVI5aH1FjZSipRDqhL8UKv4oFt+GYqnm4WkNCVLdKPlOOsilGpeRJb4inQ=
X-Received: by 2002:a19:ee19:: with SMTP id g25mr2991727lfb.83.1614884114960;
 Thu, 04 Mar 2021 10:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20210304074053.65527-1-zhouguanghui1@huawei.com> <20210304074053.65527-3-zhouguanghui1@huawei.com>
In-Reply-To: <20210304074053.65527-3-zhouguanghui1@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 4 Mar 2021 10:55:03 -0800
Message-ID: <CALvZod72R=o3WQdx+QzBrTftXQPm4rqLusOMsTaZxvDxGSTDUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
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

On Wed, Mar 3, 2021 at 11:57 PM Zhou Guanghui <zhouguanghui1@huawei.com> wrote:
>
> As described in the split_page function comment, for the non-compound
> high order page, the sub-pages must be freed individually. If the
> memcg of the fisrt page is valid, the tail pages cannot be uncharged
> when be freed.
>
> For example, when alloc_pages_exact is used to allocate 1MB continuous
> physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> set). When make_alloc_exact free the unused 1MB and free_pages_exact
> free the applied 1MB, actually, only 4KB(one page) is uncharged.
>
> Therefore, the memcg of the tail page needs to be set when split page.
>
> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
