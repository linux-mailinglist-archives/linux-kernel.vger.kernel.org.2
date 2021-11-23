Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22CF45AAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhKWSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKWSCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:02:33 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E352BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:59:24 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id v15so12916521ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZIuag7FlfW637npwI/iZ5O3Is51C1h2XYEt7gwhu2A=;
        b=Sj1jQbkuoPxjn7gutd7F17cEeO+GxHRH8PDVDtE09n/twk8V89GygKODfC7P0FVJdh
         xbPalhUApa7osyimYXaI2yRlmxrMiebFWJC0yqadJN1xLQ6tL/31IFJTT3006p7yO2be
         SYfoboBHLQKecVe9Xw8Goxe1PtPHMdw2C+RsbV7ajWbvb7QW1qxtTKqfLD1k3C7V6O6H
         gqZpsOcWyywSjtoYksuLA37bOioU5b7WY0m/ZBXg+SMB5NlBYohU02kUoBD2+jtsGDPv
         P4GFy9NxLI6PRlNDHuMIXLXDNEOCvju2Msqff7Od5i7ncneddLYjadA+ZUFUUs9ajPPB
         dAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZIuag7FlfW637npwI/iZ5O3Is51C1h2XYEt7gwhu2A=;
        b=aU7jcBjOJNyfv4U70jwetMS/GucKKxDYiNIJfaXarcT3TOYDagAzMvSJn4WxTqsQBS
         FSkRDkQIKd+ATeZ05SgTEMZmgrej+yVYUpi4aw+chKEUz1EDsjg/qw1qOpXDxamAiRKo
         eJI1fHk/zVdlGcYdq+R81JNH1O32VFq3szqtYJJQwkWtW3cQksRnG9oAMrbk2sn3YJcU
         zUiAGg2hWu+XHgA72f0hjQL+dEvtsxzam0fIhrKt6Z6pnQNhG+sL0CBeQixh++Srn4Kk
         z2x8EHJBnsbATSqv14yiopn6nejadBh3XNXC7HRc2j7ug66t7497rfGudnxp23GjxpC0
         8qWA==
X-Gm-Message-State: AOAM530XPOWrq1rhZd90Tr7LReK0JmyGkLdaUb8TMzteFzWmndFZCWe9
        kRGy/iVeBTMQLr7P5aoCT2UiM3a7vlIJvgljJMH7aA==
X-Google-Smtp-Source: ABdhPJxFAaFB+oZdm/wfRdcVzSUxvKp9cPNqY1LD8fy90cgI+qVrlWoNl9q1CthNkuAKDNHKcULvvUTUyOwCf6jMfgs=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr7162702ljp.202.1637690363016;
 Tue, 23 Nov 2021 09:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20211123174658.1728753-1-shakeelb@google.com>
In-Reply-To: <20211123174658.1728753-1-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Nov 2021 09:59:11 -0800
Message-ID: <CALvZod7NzOjQU+h4d39rebRVsR2kco_VTAxyHhZ=fEv6OqAbXw@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: update split_queue_len correctly
To:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 9:47 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> The deferred THPs are split on memory pressure through shrinker
> callback and splitting of THP during reclaim can fail for several
> reasons like unable to lock the THP, under writeback or unexpected
> number of pins on the THP. Such pages are put back on the deferred split
> list for consideration later. However kernel does not update the
> deferred queue size on putting back the pages whose split was failed.
> This patch fixes that.

I forgot to add the user visible impact.

"Without this patch the split_queue_len can underflow. Shrinker will
always get that there are some THPs to split even if there are not and
waste some cpu to scan the empty list."
