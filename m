Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1493B3175
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhFXOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhFXOhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:37:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC02C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:34:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u13so10708433lfk.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJrgmUk4MBeaLhPgL5J6HKmLfh86Hi7USjfP1jfq3Xg=;
        b=HkKrqNlJCRqVpsIJ0cu3IhrKJ2TsbGOb9M1uFceUtw6oX+ZSkuYkbbg4tyuKiUqINX
         FWkLJOsD3N/Wd0VK3P431vkL+OQ3kakrPNc8UCnvSL+cJYkadLEzexqZiJqn37a9Yvs/
         e295QEmuKGLZEHicPtisW9GeALJg0px/oJqTtl58TFFhrPxJTbFwhezbnfIig+GO0QbO
         wyNFQVAEzc3GbzAp3M/Oe+Py087BDI5VZBiZP6NJyItpoqQ0faP1RZWyPW43wEnNCHpa
         y5crsTxCeneBsRlbpXvfVTvRb02W5dLX242iJx2LReJimvMRz0c4DHNyAOYmMVqA7ls1
         xsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJrgmUk4MBeaLhPgL5J6HKmLfh86Hi7USjfP1jfq3Xg=;
        b=oRgPY1+FuL1EvpcUqogIEaTnPlHYqsrC9LReDdWDg+4namSMTFERx3lJUhNtqOO6FQ
         nVdKDrEQXUYqhNWSeMUQmJErh7OZUVAP/6hCyqmpOdgidh0JzS3s+jeZzwgDthGtyCfB
         OtLOXl7oIThtw3fB30b5/UJfzo4RdO7egC03jFnRrYDMXbPyacF3QN7SwlI7wnjQWt34
         KKCDtbjPfJjFfgqGaTX4klCfRyE3ulRiMn6aDcvtn/5CiNXdchh5QUWB0eznSA9aciNd
         YSFEkUzgZc5NgK2mnSVuK1MV2toFsKidAV+h80EqllSexQKtPHhgR8eC6OefBde/HLgY
         9Whg==
X-Gm-Message-State: AOAM530n2DQryWdLYukOQ5FYxFkrOkRBEWwZ7wWJRV+dHDt6rN6iAIqV
        0lL9l2CiV5/0Np60VSKUgzXfz0aWlepdmtrFFhBOZw==
X-Google-Smtp-Source: ABdhPJxBYv0UJTTLxHw1kaaaspf3Pmt0iwRN3IFZOKILLHVb0uLwmK4KT9JpC6yVOxPpLZDIvKuugOV8lPtmkTuH9DI=
X-Received: by 2002:a05:6512:1104:: with SMTP id l4mr349702lfg.549.1624545290734;
 Thu, 24 Jun 2021 07:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7byYA5jfzF3Vtr1czwWoiaHjkqn9M4e1Ajn1PP47k9=w@mail.gmail.com>
 <20210624102623.24563-1-sjpark@amazon.de>
In-Reply-To: <20210624102623.24563-1-sjpark@amazon.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 24 Jun 2021 07:34:39 -0700
Message-ID: <CALvZod4xDNSAHuoAyJHtAccELOeM0pAc30mJ_-ahkK2KPDJVPg@mail.gmail.com>
Subject: Re: [PATCH v31 01/13] mm: Introduce Data Access MONitor (DAMON)
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, greg@kroah.com,
        Greg Thelen <gthelen@google.com>, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, Mel Gorman <mgorman@suse.de>, mheyne@amazon.de,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        sieberf@amazon.com, snu@zelle79.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        zgf574564920@gmail.com, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 3:26 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
[...]
> > >         if time() % update_interval == 0:
> >
> > regions_update_interval?
>
> It used the name before.  But, I changed the name in this way to use it as a
> general periodic updates of monitoring primitives.  Of course we can use the
> specific name only in this specific example, but also want to make this as
> similar to the actual code as possible.
>
> If you strongly want to rename this, please feel free to let me know.
>

Nah, it is ok.

[...]

> >
> > Any reason to not use kthread_stop() here?
>
> Using 'kthread_stop()' here will make the code much simpler.  But, 'kdamond'
> also stops itself when all monitoring targets became invalid (e.g., all
> monitoring target processes terminated).  However, 'kthread_stop()' is not easy
> to be used for the use case (self stopping).  It's of course possible, but it
> would make the code longer.  That's why I use 'kdamond_stop' flag here.  So,
> I'd like leave this as is.  If you think 'kthread_stop()' should be used,
> please feel free to let me know.
>

Fine as it is.
