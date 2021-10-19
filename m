Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC83433B52
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhJSP40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhJSP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:56:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF5CC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:54:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t9so8555088lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQ+A4NQkpvXDSEUSuSg9ZjNkNFu0PsTaZnbtgFfG3Q0=;
        b=A7Y67U9scji6kEWrogwR4V0Fjid80lnQNc1nyv8OO6sOAgMWUpGpqKF9/DNvA+7p+k
         bceomJ5SO5db0eZbkDCiLj/CfRE07YlzT2FT37zzBM9VhBlZMVcAb47xvx0Z7GYnb3Ox
         CMZpNXu+H4rba5Lymr4CRITFWHp9DArMOyhFXS7XvtWSOEV3wHbFoVB5jnvFfhlQnAMv
         N2Wat3/P3dDaficXJtS9q/zFFZD3IKpaFq8IsTLaeHrCneM6/JL/oBx9YqfZj+VB4ecH
         vbgHRlx9AvaEIXev7qn+ndXrh4H0ONb5LSurVqF7KCcKmWdnV72ZSWhvZG0jveo0pOf2
         RpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQ+A4NQkpvXDSEUSuSg9ZjNkNFu0PsTaZnbtgFfG3Q0=;
        b=2Oek9bGET1nrJs5s1Qq0IiPSTrvzMkJZRwXJVS52GhA8Uj1BSPxUiF6PJvo7lWde9B
         KvLrGg5/kg9sAffM/V9A7yPnWMlhi4jMQHRW23hKprR74MyD4iZdIWklBRmDHv6YW8Ux
         x/8jxwoLqVgNbJpdc16b/VPPES3CvmuERJeHdxx7H8WShw5H1bY7yg1ZjJNgrts+w3XY
         UW8JSseUcR9uww9drH2gKqkPjBbjGccHxGDfDEYaVkbkRxd9i/jlv53wigWSrwvk2WmO
         J8CrE3Jzk6zWvZ94y1c0t00hg/97+9OSr1rQXR4w4GJSJZj+JaovcqyyhLt9M9RDN8qI
         25cg==
X-Gm-Message-State: AOAM531O5n6kFWk7PZqfu7TRK9r1pvEuCXqtYx1x8FXwV3kBU99+yniq
        A0hw0sUHoQUZUs/TpA2mE6a7gI5hRxXgH+ysqg8xwQ==
X-Google-Smtp-Source: ABdhPJxGa+PAU2LW0zminwI8DAubYh8la4xjFe4g0Ha6k8+fDveL8bLcjfJ9VOKtHtG2wu2m3R7Kq+OMqGVtNepSjKc=
X-Received: by 2002:ac2:5e3c:: with SMTP id o28mr6653219lfg.184.1634658849968;
 Tue, 19 Oct 2021 08:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211018123710.1540996-1-chenwandun@huawei.com>
 <20211018123710.1540996-2-chenwandun@huawei.com> <YW1rEt0u2CSCYgnJ@casper.infradead.org>
In-Reply-To: <YW1rEt0u2CSCYgnJ@casper.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 Oct 2021 08:53:58 -0700
Message-ID: <CALvZod4BEu3sYuo3kZ9OS0SXHm_q7C8w7sYObJo9X_xeMUd8sQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/vmalloc: fix numa spreading for large hash tables
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chen Wandun <chenwandun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, guohanjun@huawei.com,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 5:41 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Oct 18, 2021 at 08:37:09PM +0800, Chen Wandun wrote:
> > Eric Dumazet reported a strange numa spreading info in [1], and found
> > commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
> > this issue [2].
>
> I think the root problem here is that we have two meanings for
> NUMA_NO_NODE.  I tend to read it as "The memory can be allocated from
> any node", but here it's used to mean "The memory should be spread over
> every node".  Should we split those out as -1 and -2?

I agree with Willy's suggestion to make it more explicit but as a
followup work. This patch needs a backport, so keep this simple.
