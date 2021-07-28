Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E653D89DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhG1Ig6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbhG1Igz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:36:55 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A9CC061757;
        Wed, 28 Jul 2021 01:36:54 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id k7so1426703qki.11;
        Wed, 28 Jul 2021 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=+MXRp7Tl85o2divJ+kH4TnnJffEbBDkHofQ2yxqw62M=;
        b=B6T+f5bonhkUi2WwwgNQic5dr3AUS2dc86icONvzoZ8rQFJPjh8UBJxcCTiDJ3tXsR
         /oILqchyrMhFyzpY+fum6UxD3CP1G+5iqmbGV4SWwr5Jqmkj+8+s2oDIHrHMEv8XTTFf
         I+LRM7OE5KHZ6WBtbJPVyv28eHpz0sdzeCnatIBGiLBpNv2XCtSp3gtEF8vsiAiSI1ch
         44+thJnpPXmVcVqrg1AKdPHVuimoBGSVVGfSv6yRYhDJ8+nauU2PwGM/DbDrXFk2fBdd
         SWHHyLWTnhZdVfculzXTqMZctWDqdrZ7KNsCdQ/4q+DBZs3DmJr0I28NwakHDuoQRvnm
         PWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=+MXRp7Tl85o2divJ+kH4TnnJffEbBDkHofQ2yxqw62M=;
        b=T6kWj3nGXVeNju4nPDXcbOXvnNZMtSuP52o/FWvkfF79jakVqYXff83xdTWlFMpTUc
         yR9+76JQHFY3eCXsFjqEsRUQEf+0mWa3OjglrVXi+kfBeld4hxRFZZyWNJwO/OR5XTNr
         WL9UgoQxf26inW5V7mJSkSM1aVeAzCnOL7zvrXSbSFj+6YdKjHlAn5xiSQUOtt9TF/K7
         CyuQgB0HA+D+BqUtL4BXuwbKh2w+D22upjKihDW+MOFuSd2WuvGpYIofVL9I4o77SZlH
         I+Wt9zQuyEWvdLnhbiWTMlxf0yTe7Gf3ETbrFmW6QIExvPMUiY4HcBTzOpVZ4teGRzov
         6bUg==
X-Gm-Message-State: AOAM533KmqZ8+5iCOdyDWW0EsjreCrRF8DOjy9Z1OH8ENjGmeCtk8kZm
        XIoV2OQP/Cc8cHXF0USRb2o=
X-Google-Smtp-Source: ABdhPJwUFZLnwvDqEPieQzxMu0fXCcTqYpPpcUeQ4lZGAXWc9D574kqUjuiRv0/ld2GguAUGbUubSA==
X-Received: by 2002:a37:9381:: with SMTP id v123mr26094014qkd.64.1627461413786;
        Wed, 28 Jul 2021 01:36:53 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id c2sm2592479qtw.30.2021.07.28.01.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 01:36:52 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Date:   Wed, 28 Jul 2021 08:36:43 +0000
Message-Id: <20210728083643.5873-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod53+KD_F+3z3ztdx6ELFWt+jAXY6Vq-S49bq6-Y2=Cneg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello,


On Tue, 27 Jul 2021 14:30:38 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> (reduced CC list)
> 
> Hi all,
> 
> I have been asked to comment if Google is interested in using this
> feature, its general usefulness and if it is sufficiently general and
> non-duplicative. I will try to answer these but first I will explain
> the use-cases we are particularly interested in and for which we want
> a general access monitoring mechanism.

Thank you for your great opinion below, Shakeel.

> 
> At the moment Google is particularly interested in four use-cases:
> 
> 1) Working set estimation: This is used for cluster level scheduling
> and controlling the knobs of memory overcommit.
> 
> 2) Proactive reclaim
> 
> 3) Balancing between memory tiers: Moving hot pages to fast tiers and
> cold pages to slow tiers
> 
> 4) Hugepage optimization: Hot memory backed by hugepages
> 
> In addition, these uses are not happening in isolation. We want a
> combination of these running concurrently on a system. So, it is clear
> that the first version or step of DAMON which only targets virtual
> address space monitoring is not sufficient for these use-cases.
> 
> I think the more important question is if DAMON can be extended to
> system level monitoring to fulfill these use-cases.

I also think this is the important point.  The main purpose of DAMON patchset
is providing a flexible monitoring framework which can easily extended for many
use cases.  Once we have the framework, I believe people will be able to extend
it for their usages, and others will be able to reuse those (a snowball can
start rolling).

> Address space monitoring is a core concept in DAMON and it has implemented
> address space based optimizations (i.e. dividing address space into regions,
> assuming locality within regions, random sampling within regions instead of
> looking at each page and dynamically adjusting regions).  There is a followup
> proposal on monitoring physical address space in DAMON. However for systems
> running multiple workloads, the address space optimizations core to DAMON
> would be ineffective.

Right.  If the system is running a huge number of different workloads (e.g.,
systems running a huge number of virtual machines or kubernetes-managed
containers), DAMON's region-based monitoring's accuracy could be lowered.

However, I'd like to note that there are many people running only a small
number of major workloads on their systems.  Even in the above case of systems
running a huge number of virtual machines, each virtual machine would have only
a small number of major workloads.  People can use DAMON inside the guests.  We
also confirmed the region-based physical address space monitoring on such
production systems achieves high accuracy (we found 4KB hottest memory region
in 70GB memory).

Also, the region-based monitoring is not mandatory.  The followup proposal
which extends DAMON for physical address space monitoring[1] allows people opt
out it if they want.  In addition to that, it implements a page-granularity
monitoring.  I unsure if the implementation fits for Google's usage, but I sure
you can at least implement your own on the framework without the limitation of
the regions abstraction.

> 
> There are discussions/brainstorming on supporting abstract address
> space based on LRUs which is somewhat similar to Multigen LRU [1]
> proposal but not well articulated yet. BTW Multigen LRU [1] is another
> similar proposal but targets one specific use-case i.e. memory reclaim
> (proactive reclaim). Anyways I think we need more brainstorming for a
> generalized solution of system level access monitoring.

The idea is using the positional index of each page in its LRU list as its
address.  For example, a page at the head of a LRU list will have address 0.
On the address space, we can safely assume the pages adjacent in the address
scheme will have similar access frequency, and therefore DAMON's region-based
monitoring would work.  Further, we can proactively move the pages in the LRU
list so that pages near the head of the list have higher frequencies, based on
the monitoring results.

For example, if we see below monitoring results from the address space:

    <HEAD of a LRU list> HHHHHHHMMMMMMMCCCCHHCCCCC <TAIL of a LRU list>
    (H: Hot page, M: Mid-temperature page, C: Cold page)

We can move the hot pages near the tail to the head, as below:

    <HEAD of a LRU list> HHHHHHHHHMMMMMMMCCCCCCCCC <TAIL of a LRU list>
    (H: Hot page, M: Mid-temperature page, C: Cold page)

This will improve not only monitoring accuracy but also other mechanisms such
as reclamation, which are based on the assumption of LRU list.

As Shakeel also told, this is only in a brainstorming stage, though.

> 
> Regarding merging DAMON, I personally think there are users who might
> be interested in only their virtual address space and DAMON is
> providing a solution for such users. SeongJae can provide more details
> or knowledge if any big user other than Amazon is interested in the
> feature.

AFAIR, Huawei, Intel, and Alibaba shown some level of their interests publicly
and/or personally, so far.  They did code review and/or tests and bug reports.
Also a number of researchers and individuals have reached out to me.

> DAMON does not expose stable APIs at the moment, so these can
> be changed later if needed. I think it is ok to merge DAMON for some
> exposure. However I do want to make this clear that the solution space
> is not complete. The solution of system level monitoring is still
> needed which can be a future extension to DAMON or more generalized
> Multigen LRU.

Agreed.  We have lots more works to do.  Some of those are already posted as
RFC patchsets[1,2,3,4].  I promise I will happily do the works.  But, how dare
could only I get all the fun?  I'd like to do that together with others in this
great community.  One major purpose of this patchset is thus providing a
flexible framework for such collaboration.  The virtual address space
monitoring, which this patchset provides in addition to the framework, is also
for real-world usages, though.

Now all the patches have at least one 'Reviewed-by:' or 'Acked-by:' tags.  We
didn't find serious problems since v26[5], which was posted about four months
ago. so I'm thinking this patchset has passed the minimum qualification.  If
you think there are more things to be done before this patchset is merged in
the -mm tree or mainline, please let me know.  If not, Andrew, I'd like you to
consider merging this patchset into '-mm' tree.


Thanks,
SeongJae Park

> 
> thanks,
> Shakeel
> 
> [1] https://lore.kernel.org/lkml/20210520065355.2736558-1-yuzhao@google.com/

[1] https://lore.kernel.org/linux-mm/20201216094221.11898-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20201216084404.23183-1-sjpark@amazon.com/
[3] https://lore.kernel.org/linux-mm/20210107120729.22328-1-sjpark@amazon.com/
[4] https://lore.kernel.org/linux-mm/20210720131309.22073-1-sj38.park@gmail.com/
[5] https://lore.kernel.org/linux-mm/20210330090537.12143-1-sj38.park@gmail.com/
