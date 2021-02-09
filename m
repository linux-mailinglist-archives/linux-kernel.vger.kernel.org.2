Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A328C314FDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhBINMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhBINLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:11:42 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8CFC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 05:11:02 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id r23so20325911ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 05:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4a4UM2l4+ZyyoGENZxN5GEKK/mJFIsgmA6Mdizwpl4=;
        b=gfIefI6fxLri8kmAeBcEjNbCvy9wmOOoXZfUHLVeRNm6oXMOl+P+faz/qFL8KdzZiB
         eWnvX9tXA27zNnNMmBJ0MWzk2PcxC6/Q0jp4rohaq4INlQfrK3JnoF8XXZ9cBxkImzDa
         R/a8R1iW72qC06GNwyvFhkHx4fsB+8MHQCDIovc6XL+bc98fdglW05yUcxGudD1htHv9
         0KWgI0HEzq22MHJqPBB74nsHEIo/4RunumetXfOFXMQ+1Gps/z9BQh9oFecqWxuKeNEX
         AmDQj0eu3cftC44iEsWQZ7SnW8asiM9gDSDmQ1trsswnYZIQZXZphCqtjSzy4Xl5nAov
         k6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4a4UM2l4+ZyyoGENZxN5GEKK/mJFIsgmA6Mdizwpl4=;
        b=WDwNyRqvzgslKOTYw3PEjBR/pK/55KiN67IlN4LJLNOnl+7ynUH/7ie96d7qnYVwSE
         R1t+d0d1DthJ+2eHtB7skhNCtYGGyl8pWqsnUHJAqgljAnkV0NgbZfQ61V3wbXTCyS4q
         8wv7f/zXNIzGI4kCA4t+NxuQZrSvwj4KEMSMWLE6nvEq3NYtToYlt4SrkaMTXdhoAp7p
         twZyTXhi+2D2jjwltulbKv9u7i5BVymKzhjlxQj71L+aiL28TLoglx0SJ9wL+EzM/nG+
         HNXeO+2kb/yRGM0BES6Jnpr99VjLER0SxDj5fJOoBOBhA8r++G7MAKjm0rWETN2ESYq5
         BQgw==
X-Gm-Message-State: AOAM531cn4G5HVbDm2l6b0wm+AnFsT5khF2PL++NU5IO912opfjuFzzr
        lYg+QvY8GhdDnuOuAeMk9LCuCYalh/285d9OvggFnQ==
X-Google-Smtp-Source: ABdhPJy3nopNeZYwAZEwhv45NZ1dB1UhEyc1+24g4P5+BPLv4FUJiirEwTEbYUbbNScSCim5g26UJnCdTVq2DOlDZ3A=
X-Received: by 2002:a2e:7007:: with SMTP id l7mr6792295ljc.176.1612876260899;
 Tue, 09 Feb 2021 05:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20210209082125.22176-1-song.bao.hua@hisilicon.com>
 <CAKfTPtCuJoS=Z2nOmeH6y_KTSjw9=hwrZ2N78VgC-ZQwz1d8FQ@mail.gmail.com> <jhjzh0dtqf9.mognet@arm.com>
In-Reply-To: <jhjzh0dtqf9.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Feb 2021 14:10:49 +0100
Message-ID: <CAKfTPtC=_KHRszX=ALiVh84YD0tUoCbXEr9Ru1-CyY50-JMtVQ@mail.gmail.com>
Subject: Re: [PATCH v3] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxarm@openeuler.org, "xuwei (O)" <xuwei5@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        tiantao6@hisilicon.com, wanghuiqiang@huawei.com,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Meelis Roos <mroos@linux.ee>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 at 12:46, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 09/02/21 10:46, Vincent Guittot wrote:
> > On Tue, 9 Feb 2021 at 09:27, Barry Song <song.bao.hua@hisilicon.com> wrote:
> >> Real servers which suffer from this problem include Kunpeng920 and 8-node
> >> Sun Fire X4600-M2, at least.
> >>
> >> Here we move to use the *child* domain of the *child* domain of node2's
> >> domain2 as the new added sched_group. At the same, we re-use the lower
> >> level sgc directly.
> >
> > Have you evaluated the impact on the imbalance and next_update fields ?
> >
>
> sgc->next_update is safe since it's only touched by CPUs that have the
> group span as local group (which is never the case for CPUs where we do
> this "grandchildren" trick).

It would be good to explain this in the commit message

>
> I'm a bit less clear about sgc->imbalance. I think it can be set by remote
> CPUs, but it should only be cleared when running load_balance() by CPUs
> that have that group span as local group, as per:
>
>   int *group_imbalance = &sd_parent->groups->sgc->imbalance;

We are also safe because sd_parent remains the same as the beg of
load_balance and LB only tries other CPUs from the local group
