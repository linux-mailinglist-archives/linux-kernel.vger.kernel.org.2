Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFFF3104EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 07:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhBEGZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 01:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBEGY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 01:24:58 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64834C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 22:24:18 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y10so3044519plk.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 22:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zSywmM2EpZ/Js/r/BYfFddDUaG1lx3gl3/zxV2qqNwo=;
        b=Vq/mL4ZsJ9A5DAOPn5VcUuTkCyUo+Z28wbu4s89OyvGU9Nn0IuWdgS0DQGflblnS/L
         81LwbztUQ2TUPVs+mGhEDcRWou694qJDEiiNjMT6ktQQxGgQC7PHI7+vlvbWz+adyn2z
         0M3HjQhxHSsDEe2D5FhP0EFkW2eVLEeuFhUPg2jktPoCk0s4TceaZvAe6eNpM+1p3iRz
         21tnqumPbemMet5HvuMVkCaFqFgIh11qEIyBJ2rgszgDxO2DDbiW0QqH7ldakBjh9op1
         DhIvHY44FYayHdUFRgHOQgM0vALvlhR6Jg7WKQpywE34V+p1PsBk9pWuXvFZqA7gtxd/
         0XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zSywmM2EpZ/Js/r/BYfFddDUaG1lx3gl3/zxV2qqNwo=;
        b=iJdlr2mC/QHlG1irHHpCrNKJC65fTZunvLz9F9mQAUiJ8cvfVO+X4iidABF2A0iyQs
         x/5AfInjKqIZgBMXIzBPpNYSMHiyALP1z64fqpzhVKfak707K15qPBXWmhQT4UHccAe/
         vaf3eDUcKaUm74KEEMR9rKrYLgFwWTou13YdYN9WLpF9YSFJA99X42v+wbWLniviNQxK
         K7Fe2V9f2IZiqK0Xt6EbSx5AtYsRZI6LDdWGB1Qz0IgrTc/J9rzCB2wR6v36nRup9vMZ
         sDZpE3PDQCWVXiHJtXWYPW3SbmlVogLMlw7vkYyglfysD/UQxl77wgVgrZ2ZllulWbQ9
         VPgg==
X-Gm-Message-State: AOAM533ptUEpeU/CajlSZIubN1Eva4tP4Jm6egOlOBlWAN/QWWlcKTOJ
        xgHsV5/g3mNxfcjHxZktZyIXzogjW7o=
X-Google-Smtp-Source: ABdhPJxiY5W5y7b2+v0yZLdqW1xZ4+/QfhHGMDUS8go/1xRrZT7q1lhyfy+xCeMkyJ1Otfq/4zBrog==
X-Received: by 2002:a17:90b:1217:: with SMTP id gl23mr2701570pjb.163.1612506257993;
        Thu, 04 Feb 2021 22:24:17 -0800 (PST)
Received: from google.com ([2620:15c:211:201:598:57c0:5d30:3614])
        by smtp.gmail.com with ESMTPSA id r194sm7748905pfr.168.2021.02.04.22.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 22:24:16 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Feb 2021 22:24:14 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <YBzkjh5nnuNiGb6Q@google.com>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
 <YBxT9XFE6QAQ4T9N@google.com>
 <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
 <YByNU4Q7cc7gYwPh@google.com>
 <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com>
 <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com>
 <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:49:54PM -0800, John Hubbard wrote:
> On 2/4/21 9:17 PM, Minchan Kim wrote:
> ...
> > > > > Presumably, having the source code, you can easily deduce that a bluetooth
> > > > > allocation failure goes directly to a CMA allocation failure, right?
> > > 
> > > Still wondering about this...
> > 
> > It would work if we have full source code and stack are not complicated for
> > every usecases. Having said, having a good central place automatically
> > popped up is also beneficial for not to add similar statistics for each
> > call sites.
> > 
> > Why do we have too many item in slab sysfs instead of creating each call
> > site inventing on each own?
> > 
> 
> I'm not sure I understand that question fully, but I don't think we need to
> invent anything unique here. So far we've discussed debugfs, sysfs, and /proc,
> none of which are new mechanisms.

I thought you asked why we couldn't add those stat in their call site
driver syfs instead of central place. Please clarify if I misunderstood
your question.

> 
> ...
> 
> > > It's actually easier to monitor one or two simpler items than it is to monitor
> > > a larger number of complicated items. And I get the impression that this is
> > > sort of a top-level, production software indicator.
> > 
> > Let me clarify one more time.
> > 
> > What I'd like to get ultimately is per-CMA statistics instead of
> > global vmstat for the usecase at this moment. Global vmstat
> > could help the decision whether I should go deeper but it ends up
> > needing per-CMA statistics. And I'd like to keep them in sysfs,
> > not debugfs since it should be stable as a telemetric.
> > 
> > What points do you disagree in this view?
> 
> 
> No huge disagreements, I just want to get us down to the true essential elements
> of what is required--and find a good home for the data. Initial debugging always
> has excesses, and those should not end up in the more carefully vetted production
> code.
> 
> If I were doing this, I'd probably consider HugeTLB pages as an example to follow,
> because they have a lot in common with CMA: it's another memory allocation pool, and
> people also want to monitor it.
> 
> HugeTLB pages and THP pages are monitored in /proc:
> 	/proc/meminfo and /proc/vmstat:
> 
> # cat meminfo |grep -i huge
> AnonHugePages:     88064 kB
> ShmemHugePages:        0 kB
> FileHugePages:         0 kB
> HugePages_Total:     500
> HugePages_Free:      500
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> Hugetlb:         1024000 kB
> 
> # cat vmstat | grep -i huge
> nr_shmem_hugepages 0
> nr_file_hugepages 0
> nr_anon_transparent_hugepages 43
> numa_huge_pte_updates 0
> 
> ...aha, so is CMA:
> 
> # cat vmstat | grep -i cma
> nr_free_cma 261718
> 
> # cat meminfo | grep -i cma
> CmaTotal:        1048576 kB
> CmaFree:         1046872 kB
> 
> OK, given that CMA is already in those two locations, maybe we should put
> this information in one or both of those, yes?

Do you suggest something liks this, for example?


cat vmstat | grep -i cma
cma_a_success	125
cma_a_fail	25
cma_b_success	130
cma_b_fail	156
..
cma_f_fail	xxx



