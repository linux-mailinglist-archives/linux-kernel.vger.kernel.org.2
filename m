Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052FC38BCA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhEUCyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhEUCyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:54:38 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B40C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:53:15 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a4so7416197ljd.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPsBeMePr6vNdl72dFl2jE/e5Ses/6iw4P/zMQwFaso=;
        b=AxonyiUB4cI7lnYP4SAkb8Vsvx8mWYBMqHGhHg42AGxs+j0IwBEFYBeK5q+8EJUeky
         +BSqrp8QwZ3CSd+L3OPwpzea30xyBnCiPm57229g/kfmKreEFXr8Qrob5TMgUaIHLUII
         A6LmlyR50kCeiG0gBAfJoG7BNHrZ8Q7g0ohaVbdoLSACZ+2EbQtHdbGCGpcnNcSp2a+O
         CyBBT1WLPiiTJ0QJoI/xTEnFJNwf4Km8rJ4e1I8W9oTKjugrbIDCPOfSxvFuHfI0KJG+
         gHb5G7Z84ZFcu7KJGarPvHvxf5IFf0SSATRg1cvBa4X2KumCgkSpJUXo/fMyPi6yyrv+
         bVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPsBeMePr6vNdl72dFl2jE/e5Ses/6iw4P/zMQwFaso=;
        b=WuEX2gvmOWUsWxDAbWi9aPqVxtveAhFM+eSW3UEZoj3g8CS0d+sJ15sSZ0wthkPs0p
         eK47+3Lzjvhf0jkbmRyyWGwSuYSlAO432sCKhlOaiI8XOGlaR9T1gv/gtcUDKd8q8qhb
         1ZD5LT1U4trihJ546Fji2Lc+OQkMCbcWmLGfSGUqmymBhN17MeCK9yD60YxJE6UX3hkh
         2wBF+i4thfbHW5EK7u5eTrA1fIHWzgATKPT+HMeju3DXUhXc9WpPaI7XDKEFuxtK7Xad
         y5++2iGZaBmIR/Hs0uOa+FbTyyvju00l6uQKb1KfOb9dmrL/dZbYdtZxGNGVG84UAcE6
         6Abg==
X-Gm-Message-State: AOAM531rWQdWx7AOkfmXuYdAh7MVCSBqwB4BX9cBz7aIAsEq3qIzir/x
        LhngGtNwsSG5wNLIFRMIuSUrgjvSnOAnPBWRUH5m1g==
X-Google-Smtp-Source: ABdhPJwmTj06ZQyTfrxk0pdEXL5KraZDbrSM5Z7Pn1woEo07LA+UBY5tagvIYBA4Vn2kFt6dmcK2nwRYdXDbJ8Sjk2I=
X-Received: by 2002:a2e:9e87:: with SMTP id f7mr5070278ljk.81.1621565593987;
 Thu, 20 May 2021 19:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210520075629.4332-1-sj38.park@gmail.com> <20210520153426.34bfe5ab64ca1f06cca6f231@linux-foundation.org>
In-Reply-To: <20210520153426.34bfe5ab64ca1f06cca6f231@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 May 2021 19:53:02 -0700
Message-ID: <CALvZod6Q1kMaEN+PTEJ39D4hYfjtLcPQhKND8m2p7KYui5pKTA@mail.gmail.com>
Subject: Re: [PATCH v29 00/13] Introduce Data Access MONitor (DAMON)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, greg@kroah.com,
        Greg Thelen <gthelen@google.com>, guoju.fgj@alibaba-inc.com,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        zgf574564920@gmail.com, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 3:34 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 20 May 2021 07:56:16 +0000 SeongJae Park <sj38.park@gmail.com> wrote:
>
> > Changes from Previous Version (v28)
>
> Thanks for persisting with this.
>
> I'd be interested in people's overall take on this work, please.
> Mainly a high-level "should we merge this" view.  Detailed review of
> implementation and interface details can follow on in the usual fashion.

I am planning to go over the whole series but first let me give my
high-level view on the patch series.

In my personal opinion, this patch series is in the state where we can
merge this or at least add to the mm tree for further exposure.

I have pushed SeongJae to keep the functionality to bare minimum in
the first version and focus more on making the design extensible, so
as more use-cases arise, the core can be extended accordingly.

I am actually more interested in the followup of this work which would
be extended to monitor cgroups for use-cases like hugepages, balancing
hot/cold memory in memory tiers and hints for malloc implementations.
