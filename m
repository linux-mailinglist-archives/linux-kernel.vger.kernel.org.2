Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712AE3B0CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhFVSPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVSPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:15:06 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92470C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:12:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i1so10429344lfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZ8ZYzj6hHuJXsmZpwyIWIWw0nLJtjqqsF2RiG/A2YM=;
        b=kMmn25DaPZRRY3V65IMoK6joZt/2Rx0PQGhQ7nqJRDs7n/4KFlbx4nvlU6vYnDJoJ5
         FqN2m2BLT2LbAl24AWIhH15trb47pLTYpEYQab6qIbz/RGNfT4FyfxGWsPWQOqhDhCyy
         gUkP2NoWypK6UmXFHo9NNR14cgrc7797pp6DGXRw0QLpR3vmDsiTr21+/k7YUckC00D4
         WBlruau/FcBMV3DWRffttnXsZ88TxMH9gT1cw6XQbBZ3AQYVFwVqhogptbDcN2YZZzKh
         ZmEnLURq81Wlqyq69lvsaVJpGrrTp9yXsKZOzRX7ji5zmGd6D9aZyNlzGGmMa6OUrcw8
         KLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZ8ZYzj6hHuJXsmZpwyIWIWw0nLJtjqqsF2RiG/A2YM=;
        b=RUY1QscyJzjTCXpKTJfM463nQrMAvtfhyBhj9WS25qsJPbftuo6QPJwD+R3GnL5tBS
         vD0IITLMwuOxatgqXa8e8GtXKYKab+XaomXsNB2DwH57TcBnxDU+E3OthuLelDQOhXQE
         nMQLeBCVNmq63gsZdaVLZyI0IljXGPYfkten33pWW20QngIeQri1c0m+UUAUUBW495DQ
         Fpsa29T9W1B+SZlIwCBQdaZ0tSQmVCo506qMA5BwP48LGNxt78fqeKy+22nYzVIuDY7B
         fKPN08wFEFkJdEty6btjRCjuyj2YX5iWrRFbGMRy8O+JU7Lclm/SpkUC/l+SuFBEL9xE
         oarg==
X-Gm-Message-State: AOAM532jp6NKHO0AglxEN8OI+W9wYCGRMLbHtsFK6botlwBis1FR++hF
        Qp08p8/Qtpa5u0ehqAyZuZvSBxzQr8uRICA//FNuxg==
X-Google-Smtp-Source: ABdhPJxUlgpQBKy/3D4j5dmdUJ0JGTdKqWGeL13RGTa29Fy9JVnyl3fcIOuuJCIDbl+vREG69KynIfInYDadqBzOrz8=
X-Received: by 2002:a05:6512:1191:: with SMTP id g17mr1605160lfr.347.1624385567602;
 Tue, 22 Jun 2021 11:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210621083108.17589-1-sj38.park@gmail.com> <20210621083108.17589-8-sj38.park@gmail.com>
In-Reply-To: <20210621083108.17589-8-sj38.park@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 22 Jun 2021 11:12:36 -0700
Message-ID: <CALvZod61B66+Z4J1n6DG6UnvY9j8TE0diz=o1XXOBSZ5DaKSDQ@mail.gmail.com>
Subject: Re: [PATCH v31 07/13] mm/damon: Implement a debugfs-based user space interface
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
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

On Mon, Jun 21, 2021 at 1:31 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> DAMON is designed to be used by kernel space code such as the memory
> management subsystems, and therefore it provides only kernel space API.
> That said, letting the user space control DAMON could provide some
> benefits to them.  For example, it will allow user space to analyze
> their specific workloads and make their own special optimizations.
>
> For such cases, this commit implements a simple DAMON application kernel
> module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> exports those to the user space via the debugfs.
>
> 'damon-dbgfs' exports three files, ``attrs``, ``target_ids``, and
> ``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
>
> Attributes
> ----------
>
> Users can read and write the ``sampling interval``, ``aggregation
> interval``, ``regions update interval``, and min/max number of
> monitoring target regions by reading from and writing to the ``attrs``
> file.  For example, below commands set those values to 5 ms, 100 ms,
> 1,000 ms, 10, 1000 and check it again::
>
>     # cd <debugfs>/damon
>     # echo 5000 100000 1000000 10 1000 > attrs
>     # cat attrs
>     5000 100000 1000000 10 1000
>
> Target IDs
> ----------
>
> Some types of address spaces supports multiple monitoring target.  For
> example, the virtual memory address spaces monitoring can have multiple
> processes as the monitoring targets.  Users can set the targets by
> writing relevant id values of the targets to, and get the ids of the
> current targets by reading from the ``target_ids`` file.  In case of the
> virtual address spaces monitoring, the values should be pids of the
> monitoring target processes.  For example, below commands set processes
> having pids 42 and 4242 as the monitoring targets and check it again::
>
>     # cd <debugfs>/damon
>     # echo 42 4242 > target_ids
>     # cat target_ids
>     42 4242
>
> Note that setting the target ids doesn't start the monitoring.
>
> Turning On/Off
> --------------
>
> Setting the files as described above doesn't incur effect unless you
> explicitly start the monitoring.  You can start, stop, and check the
> current status of the monitoring by writing to and reading from the
> ``monitor_on`` file.  Writing ``on`` to the file starts the monitoring
> of the targets with the attributes.  Writing ``off`` to the file stops
> those.  DAMON also stops if every targets are invalidated (in case of
> the virtual memory monitoring, target processes are invalidated when
> terminated).  Below example commands turn on, off, and check the status
> of DAMON::
>
>     # cd <debugfs>/damon
>     # echo on > monitor_on
>     # echo off > monitor_on
>     # cat monitor_on
>     off
>
> Please note that you cannot write to the above-mentioned debugfs files
> while the monitoring is turned on.  If you write to the files while
> DAMON is running, an error code such as ``-EBUSY`` will be returned.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> Reviewed-by: Fernand Sieber <sieberf@amazon.com>


The high level comment I have for this patch is the layering of pid
reference counting. The dbgfs should treat the targets as abstract
objects and vaddr should handle the reference counting of pids. More
specifically move find_get_pid from dbgfs to vaddr and to add an
interface to the primitive for set_targets.

At the moment, the pid reference is taken in dbgfs and put in vaddr.
This will be the source of bugs in future.
