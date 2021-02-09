Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BFB315B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhBJAq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbhBIVM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 16:12:58 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F102C0617AB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:12:32 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e18so23809453lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FXGsIN5T7fPPrN05ehbZdpVJVDuk872+BL495X4FDE=;
        b=YvBxOcvDEJCqlebLaBfz/mFH6WfvwNvw+jQhAqduaI6hWBxU9A7ZskYOCf8zcRNuUL
         LNbWWsUWHTLKYRhFQE7ZkmHbXyvJranSr8hnyxgHcM87KHuoJ9eUsuztqw3ewH1h8/DU
         9YcegKtpf6/jTxL35RfgKtx9Rd1OBpJeO/ouB0m3udBtiglWVl7Lp6l3JA8RS47w9/J0
         2dhI4ZOMi9bgsIRYK+d8DIvW4DTc2kMjCcTmIbo41C8RoVDL5ru3Dpa/g6a8Gvbc9xNu
         PW6i+H6yvplDmsMMShk7HQ2tWFn96BXZ/4i4IcP8Nqc4o2ryZiRU0xfEw8EQ6+VEYUY0
         L6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FXGsIN5T7fPPrN05ehbZdpVJVDuk872+BL495X4FDE=;
        b=WRvapFOcalpwNNTt9AsvDiMADC8P28luRPGb4jNpoii7C2ZQgFcOLvLSjUWQqCa75x
         wLTtYDxho3U3qpmezAgWo0ADyB73kWuGZD/08al1U6ohFeVq8LYw0//rpXp8svBle/vZ
         i9SyHAxjL9Nt/yPyc/eDC7WFxRSE1QE09aoNuUXzqqVAQnL45/ralHF7bvGK6M0r2Nd6
         FHDg9ASEMVePT8/+NvYSRFXQoZ5qsadbBVfwJScaMujLFtEVKVX+tV0PeMBOU/z3gXHT
         IY1IkRlZ6nMZfT1ZUhMcOeoqzmhonnLnUN4e8cpl7pb4eIm59ecl+6XJbs3RCYjCoKYN
         FTsw==
X-Gm-Message-State: AOAM5312Ow22xFIrqqVrPB3cLQIkAmdN7MoHjC7f83IaGB2cLiHYM8Yb
        HFdTgGfuLicpcIgRNDX4GOEHky2i8dPF7k1pBkUCsQ==
X-Google-Smtp-Source: ABdhPJwRFIwCydh144unLEXq/89Cii4bpddgSvF/jg/HdpgT2MwCFjxuenRx4CQBFhn3OdU+YiCwBnjOx79WfCp2jHY=
X-Received: by 2002:a2e:9801:: with SMTP id a1mr16081470ljj.122.1612897950233;
 Tue, 09 Feb 2021 11:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20210209190126.97842-1-hannes@cmpxchg.org>
In-Reply-To: <20210209190126.97842-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 Feb 2021 11:12:18 -0800
Message-ID: <CALvZod6jd5+H0jr8wyB_ivPcJzSYH-rCCQL64Hgg+D_wuAZZFg@mail.gmail.com>
Subject: Re: [PATCH] fs: buffer: use raw page_memcg() on locked page
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 11:01 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> alloc_page_buffers() currently uses get_mem_cgroup_from_page() for
> charging the buffers to the page owner, which does an rcu-protected
> page->memcg lookup and acquires a reference. But buffer allocation has
> the page lock held throughout, which pins the page to the memcg and
> thereby the memcg - neither rcu nor holding an extra reference during
> the allocation are necessary. Use a raw page_memcg() instead.
>
> This was the last user of get_mem_cgroup_from_page(), delete it.
>
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
