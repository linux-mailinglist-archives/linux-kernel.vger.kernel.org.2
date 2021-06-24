Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BBC3B2C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhFXK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhFXK3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:29:04 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7869C061574;
        Thu, 24 Jun 2021 03:26:45 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id g19so2978226qvx.12;
        Thu, 24 Jun 2021 03:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to;
        bh=GGBWy7KblmjWzOLjXRSnKxPbTK1pFfoPIQuuwojTTjw=;
        b=RziSWFb/goJ5Z5rJNF0zfNVbms3RjEdVvH+SscHcPl30lH8lr6wJk+dZBPUNeRl5zV
         Fnxo3V/fIMHLIIj2gInVCXXntpMYQF2lc59NE9LYOlIFLpJ6PNFOt/ZpG5OjdKzMX5JV
         jYvc6ApnimX5bwbDDT7o+2wxXvNrdl2A6Ifvlr8pGjP4VAFCUJpkUVjifd7QJCzX5KLA
         IKuivI3MUJgbQVRiDPpK2CSpMc5V90WnXgZHjJeIrd6EDUW2hohTbll7QiJL1/UAeOxR
         1K2MvqZYAlkBXiadjtQRubBq8yhu8Au3RjB/SBBv64gRPwbgXQ9N1bg1FYBKqjraV5rn
         s12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=GGBWy7KblmjWzOLjXRSnKxPbTK1pFfoPIQuuwojTTjw=;
        b=jVv/vLpmvrv/7n39b7+tEUbjJf9tyV01XAppdMRYwKVrOG2E3T11949tMtk43qMkQj
         vLAjaQjNk2pjYtRmRITXm0IcApEEPMCZ+Bhu7gfyoe3Qw2ggLpFKPYI6LW2M/08y2SvQ
         wj1H88rRChw8/FyWJM1T7AcXyoIv3LrA87H6CDbH+pr+FNFnEJ0eICCQyZHNIr0BYyNT
         zfRewN5cRINQLxfW2LShHdYOlyRYGUNuMmGJ/zXW2ZsJbTnOrYyA+Ic+bmOV7sk9QF81
         xod0xOcEWx8HyMlRCUisos66aOv+7FhNUupZxGShXjXvxfVmtQMprOwo03bpJM7bsNXo
         nk5w==
X-Gm-Message-State: AOAM531njG1cvvwOzq74rSbMBTrKY5qj8LJ9qJE/iQmy+NyMeIFwqzwK
        PmXS2nzSVQzOnC5AGSGZYQY=
X-Google-Smtp-Source: ABdhPJwx6VMUqBVs5D5s1urjNgPqOJuyGnFRMhDKaTTekxWQDCxg58Ygg1KAqEgbfYoCIzlCIlTg0g==
X-Received: by 2002:ad4:51cf:: with SMTP id p15mr4628222qvq.5.1624530405088;
        Thu, 24 Jun 2021 03:26:45 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id w195sm2132842qkb.127.2021.06.24.03.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:26:44 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Shakeel Butt <shakeelb@google.com>
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
Subject: Re: [PATCH v31 07/13] mm/damon: Implement a debugfs-based user space interface
Date:   Thu, 24 Jun 2021 10:26:22 +0000
Message-Id: <20210624102623.24563-4-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210624102623.24563-1-sjpark@amazon.de>
References: <20210624102623.24563-1-sjpark@amazon.de>
In-Reply-To: <CALvZod61B66+Z4J1n6DG6UnvY9j8TE0diz=o1XXOBSZ5DaKSDQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 22 Jun 2021 11:12:36 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Jun 21, 2021 at 1:31 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > DAMON is designed to be used by kernel space code such as the memory
> > management subsystems, and therefore it provides only kernel space API.
> > That said, letting the user space control DAMON could provide some
> > benefits to them.  For example, it will allow user space to analyze
> > their specific workloads and make their own special optimizations.
> >
> > For such cases, this commit implements a simple DAMON application kernel
> > module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> > exports those to the user space via the debugfs.
> >
> > 'damon-dbgfs' exports three files, ``attrs``, ``target_ids``, and
> > ``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
> >
> > Attributes
> > ----------
> >
> > Users can read and write the ``sampling interval``, ``aggregation
> > interval``, ``regions update interval``, and min/max number of
> > monitoring target regions by reading from and writing to the ``attrs``
> > file.  For example, below commands set those values to 5 ms, 100 ms,
> > 1,000 ms, 10, 1000 and check it again::
> >
> >     # cd <debugfs>/damon
> >     # echo 5000 100000 1000000 10 1000 > attrs
> >     # cat attrs
> >     5000 100000 1000000 10 1000
> >
> > Target IDs
> > ----------
> >
> > Some types of address spaces supports multiple monitoring target.  For
> > example, the virtual memory address spaces monitoring can have multiple
> > processes as the monitoring targets.  Users can set the targets by
> > writing relevant id values of the targets to, and get the ids of the
> > current targets by reading from the ``target_ids`` file.  In case of the
> > virtual address spaces monitoring, the values should be pids of the
> > monitoring target processes.  For example, below commands set processes
> > having pids 42 and 4242 as the monitoring targets and check it again::
> >
> >     # cd <debugfs>/damon
> >     # echo 42 4242 > target_ids
> >     # cat target_ids
> >     42 4242
> >
> > Note that setting the target ids doesn't start the monitoring.
> >
> > Turning On/Off
> > --------------
> >
> > Setting the files as described above doesn't incur effect unless you
> > explicitly start the monitoring.  You can start, stop, and check the
> > current status of the monitoring by writing to and reading from the
> > ``monitor_on`` file.  Writing ``on`` to the file starts the monitoring
> > of the targets with the attributes.  Writing ``off`` to the file stops
> > those.  DAMON also stops if every targets are invalidated (in case of
> > the virtual memory monitoring, target processes are invalidated when
> > terminated).  Below example commands turn on, off, and check the status
> > of DAMON::
> >
> >     # cd <debugfs>/damon
> >     # echo on > monitor_on
> >     # echo off > monitor_on
> >     # cat monitor_on
> >     off
> >
> > Please note that you cannot write to the above-mentioned debugfs files
> > while the monitoring is turned on.  If you write to the files while
> > DAMON is running, an error code such as ``-EBUSY`` will be returned.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > Reviewed-by: Fernand Sieber <sieberf@amazon.com>
> 
> 
> The high level comment I have for this patch is the layering of pid
> reference counting. The dbgfs should treat the targets as abstract
> objects and vaddr should handle the reference counting of pids. More
> specifically move find_get_pid from dbgfs to vaddr and to add an
> interface to the primitive for set_targets.
> 
> At the moment, the pid reference is taken in dbgfs and put in vaddr.
> This will be the source of bugs in future.

Good point, and agreed on the problem.  But, I'd like to move 'put_pid()' to
dbgfs, because I think that would let extending the dbgfs user interface to
pidfd a little bit simpler.  Also, I think that would be easier to use for
in-kernel programming interface usages.  If you disagree, please feel free to
let me know.


Thanks,
SeongJae Park
