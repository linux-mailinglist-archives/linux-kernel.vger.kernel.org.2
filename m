Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE80145CEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 22:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343992AbhKXVXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 16:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243849AbhKXVW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 16:22:58 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E11C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:19:47 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k23so8250615lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xsrVI4JVeqO+9evyHHI7Dch8GDpLynkfJrUX3WfwWA=;
        b=ZQ3U+e6o580w9XuoqCcUmNSrIjZCNv56VNDhqZgcfSwtzSiVXi3xn+d7/YHBTUfCLU
         727ozilp1jt2Ag+wfwiN6FAp8gEHB54JvmEtelCYS20dg40MYLasm/HkZUbLYumkWRSn
         MQbIP9DWpKEEZIY5O5GNDobrAxBS9F/VX6UMBtbWi++GyjvCL/xoV+doRGtbDX6mlNPS
         Y4jZ32rNsDXK/YsSK7G3CArf+kxV6K15fV2tkCxmoQLLFiHWZJhd100uqRbma2nhw4Kd
         Auc6/n6EaQXC4Sn7s+zn/VUJtFuy1p9qXCNMWxeYuiQtarQ7cxholZRPMcH4SGicZhIh
         2H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xsrVI4JVeqO+9evyHHI7Dch8GDpLynkfJrUX3WfwWA=;
        b=0sZVAq9uKR8+eUBh8SjGafvvrhGFF2gpodxj8dI+tn3taJeEsh8TjBKMo/Ys1dsjaB
         cSmbq7kY2sJtoXVjiZe5V3KPOWQvpKRfHXSMpexOSVP5tFug8MGpJjzDExB7PnlGQYLY
         FY43++8zGA83U1MWiiOdf/CEUJoDunEtjpwUDM+R3qxp+W7mPXJ6D8hevPR1HBLA/gYP
         TCO9NNhbT1VkeY7nnAgrs+APfBns1qBxAdZj3FvvWbM9RbqIM5qdoGeMVmDhZqfCCoGW
         wL4LssZgF404f/jByghmv7zTN1M0A+rf3j8yiQx+tXoexuxfbHGjpur24UNH6AJGI7HD
         nmgQ==
X-Gm-Message-State: AOAM531J5Q7f+O9AA1Kwu+L6hkNZUd0K78I2KpxJJRPsolnO0yBvYL9+
        7vF+BIEmPzXGLHtmHQa5wsMo5hAeREh3+Ly+cRmYfA==
X-Google-Smtp-Source: ABdhPJyZLD14H2CRCtTVGIlBNE4A2k1CBfekEwunZAdta6YLqyKVm1Pu+KD6aAlAOqEYcYn1MPQspt0Q4DW/ovgW4zA=
X-Received: by 2002:a2e:9699:: with SMTP id q25mr19401273lji.6.1637788785831;
 Wed, 24 Nov 2021 13:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20211123190916.1738458-1-shakeelb@google.com> <20211124201238.3xzpy2b5zcv7j23s@box.shutemov.name>
 <CALvZod6zUsCajhYcQOod+Nf0Y34x_sS1nnc7zAXUwZX0w3jzTw@mail.gmail.com> <CAHbLzkqmTks5dGn=yCykKSwqtmsCKVqLx_bU9D1=fTvEgX06xw@mail.gmail.com>
In-Reply-To: <CAHbLzkqmTks5dGn=yCykKSwqtmsCKVqLx_bU9D1=fTvEgX06xw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 24 Nov 2021 13:19:34 -0800
Message-ID: <CALvZod6_goW2bCqRp83p2pUQFmq4i5gfBFCsAcVEKgQffHV4GA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: thp: update split_queue_len correctly
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 1:17 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Nov 24, 2021 at 12:44 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 12:12 PM Kirill A. Shutemov
> > <kirill@shutemov.name> wrote:
> > >
> > > On Tue, Nov 23, 2021 at 11:09:16AM -0800, Shakeel Butt wrote:
> > > > The deferred THPs are split on memory pressure through shrinker
> > > > callback and splitting of THP during reclaim can fail for several
> > > > reasons like unable to lock the THP, under writeback or unexpected
> > > > number of pins on the THP. Such pages are put back on the deferred split
> > > > list for consideration later. However kernel does not update the
> > > > deferred queue size on putting back the pages whose split was failed.
> > > > This patch fixes that.
> > >
> > > Hm. No. split_huge_page_to_list() updates the queue size on split success.
> > >
> >
> > Right. This is really convoluted. split_huge_page_to_list() is just
> > assuming that if the given page is on a deferred list then it must be
> > on the list returned by get_deferred_split_queue(page). The
> > interaction of move_charge and deferred split seems broken.
>
> Because memcg code doesn't move charge for PTE mapped THP at all. See
> the below comment from mem_cgroup_move_charge_pte_range():
>
> "We can have a part of the split pmd here. Moving it can be done but
> it would be too convoluted so simply ignore such a partial THP and
> keep it in original memcg. There should be somebody mapping the head."
>
> BTW, did you run into any problem related to this?
>

No, just reading code to see if I can share code for the sync splitting of THPs.
