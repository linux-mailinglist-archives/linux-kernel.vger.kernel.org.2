Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC573D81D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhG0Vax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhG0Vaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:30:52 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A48C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:30:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l4so503710ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1oEgvB9xwtjzMmFRjkCvx9OZZwaZHJCuRXqeK2qa/M=;
        b=f2FiTpac9qSFO843emkXD5RZfJPgc3/XxAk9HtVomdQNg3epUQrZV7lnvHbSulbDCf
         X9SoKJWCkxkDOhz4GTTgKSRbNUFYi0DRgdYgQhyBmdPGxH9lBJ3JnSvmt9s12j1BsRYW
         HTrdiwca25FgxzbzPMdK1zPF6/bq2WWj/8KqnqIZqwX5YZA7z6yCbrJnpZJk1955/FBq
         +0snDel9yryxzZbxY/2QciiGeq1TXN+UBmr1KVcmWGjaxycBgIZAnsEQCiUATA83ZapX
         x6Ck4OHsP0ZS6W3BlFKYi6bNbZTsgo6B6WVwuDQAvjEWvUMmCObd7tO0tFWWzleiYYfm
         dASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1oEgvB9xwtjzMmFRjkCvx9OZZwaZHJCuRXqeK2qa/M=;
        b=AnOjBdoMzai1RbF6zQshbiNfQcGlkKvRlU73Tcmt0vpfMxeK0Cyzw57hX4r3PSSFKY
         S0xTkS5qVwZBtith+Lgx7WBm51ps3nfMjB9mpCTB29J7QvB+rIUCd8pE4MNGBAkdyT+k
         0IpX2EoPPoMAFdFiXDLRMDlsshkMudfbVpaX5bVRG66dGXYXTt8zFR3juwqukfrFTa8U
         bYiSMwZ+u8cfw9PocI1FzPDz6IVyQ3kEhqPQKxH8yIRrQRywphzPN8NA90A5vmqkK/g9
         vLI6l7Wml4+DdrVUl7/mw4jjWxiETZJHji5BaL2pvUW6s4+F0oEn0mpDMYSZBspkBM5I
         4FeA==
X-Gm-Message-State: AOAM531NZTj8xb2A9ph0g5fsHggrI088YCF+fI1iLjE3pngQ1uCeuz8v
        uY6rt3tcKwMu8cjGKYJRXNdRe+CT9zUdZxHU4+NKQw==
X-Google-Smtp-Source: ABdhPJzABaVEdLMnfvrQQ6MCpyOmnx/JbktRxaRt/3TzVhGUD/2AMNAku6+0Q+i3GfGoQxvvXfJef5TVX4kp1yTFl1g=
X-Received: by 2002:a05:651c:1211:: with SMTP id i17mr17261522lja.122.1627421449749;
 Tue, 27 Jul 2021 14:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210716081449.22187-1-sj38.park@gmail.com>
In-Reply-To: <20210716081449.22187-1-sj38.park@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 14:30:38 -0700
Message-ID: <CALvZod53+KD_F+3z3ztdx6ELFWt+jAXY6Vq-S49bq6-Y2=Cneg@mail.gmail.com>
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        amit@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        jgowans@amazon.com, mheyne@amazon.de,
        David Rientjes <rientjes@google.com>, sieberf@amazon.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Wei Xu <weixugc@google.com>,
        Paul Turner <pjt@google.com>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(reduced CC list)

Hi all,

I have been asked to comment if Google is interested in using this
feature, its general usefulness and if it is sufficiently general and
non-duplicative. I will try to answer these but first I will explain
the use-cases we are particularly interested in and for which we want
a general access monitoring mechanism.

At the moment Google is particularly interested in four use-cases:

1) Working set estimation: This is used for cluster level scheduling
and controlling the knobs of memory overcommit.

2) Proactive reclaim

3) Balancing between memory tiers: Moving hot pages to fast tiers and
cold pages to slow tiers

4) Hugepage optimization: Hot memory backed by hugepages

In addition, these uses are not happening in isolation. We want a
combination of these running concurrently on a system. So, it is clear
that the first version or step of DAMON which only targets virtual
address space monitoring is not sufficient for these use-cases.

I think the more important question is if DAMON can be extended to
system level monitoring to fulfill these use-cases. Address space
monitoring is a core concept in DAMON and it has implemented address
space based optimizations (i.e. dividing address space into regions,
assuming locality within regions, random sampling within regions
instead of looking at each page and dynamically adjusting regions).
There is a followup proposal on monitoring physical address space in
DAMON. However for systems running multiple workloads, the address
space optimizations core to DAMON would be ineffective.

There are discussions/brainstorming on supporting abstract address
space based on LRUs which is somewhat similar to Multigen LRU [1]
proposal but not well articulated yet. BTW Multigen LRU [1] is another
similar proposal but targets one specific use-case i.e. memory reclaim
(proactive reclaim). Anyways I think we need more brainstorming for a
generalized solution of system level access monitoring.

Regarding merging DAMON, I personally think there are users who might
be interested in only their virtual address space and DAMON is
providing a solution for such users. SeongJae can provide more details
or knowledge if any big user other than Amazon is interested in the
feature. DAMON does not expose stable APIs at the moment, so these can
be changed later if needed. I think it is ok to merge DAMON for some
exposure. However I do want to make this clear that the solution space
is not complete. The solution of system level monitoring is still
needed which can be a future extension to DAMON or more generalized
Multigen LRU.

thanks,
Shakeel

[1] https://lore.kernel.org/lkml/20210520065355.2736558-1-yuzhao@google.com/
