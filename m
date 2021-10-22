Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768AB437150
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 07:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhJVFZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 01:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhJVFZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 01:25:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6438DC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 22:23:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id b9so4348137ybc.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 22:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/K7g7u2ztiiMpfLD3ufFGiu7hRc5OC0Hi+SvzjKN4Uk=;
        b=ly0FbEE9Cx2o0m+sLygjae/WePo6aZBdJEycwr+AxFGMCElMOUSKMnm3dNn6yydnFD
         IeCJVcOc0fhI8EOODak6bDjP5jmdEdrwK9klZmCv393MLULV2izorxk+R2zF2uUMOSTI
         6YHAOGEZWpBJ9UmRlHOot/gSWeRJezJYsWzq/3+5475yi8MeNEd4eKZgk1u2VnuCmxT+
         bR7iVcEuthyMWB1WNLejEWG+ylqhYCQUMq61fWB6+Tjz9iTbNOzbcTRjjMaGHPnqRnZY
         TEbIS3zdaAYvypoQ0D+jKp9Fgb6/OrurOSihIUF7xWw5s/3kX+Ywf9jM36iNmm+c8zxg
         JJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/K7g7u2ztiiMpfLD3ufFGiu7hRc5OC0Hi+SvzjKN4Uk=;
        b=3+vRY/bU5WQ9uiI91oujZBL5bu2fBJMzSglD+d6JlwPU7dCp6QZvTTrxPExscvmOmV
         /1WwYwb8VG+xUP/9FNe+HTxam9dbnuK+TYkvy2Yu2W82kYZ9vIEQPKikS8n554SXUaTe
         q4ql8Hs95CJeIQ3e4xn/faI/PlDPiZajqET+jtOjyct5Ia8NRlO3SbGLabx15ali9XS/
         TqGITLPjVMt4yvY/75cj/ZMB/T1qZ/UoYLF4hgP+aWLPzVVzQ0UD+KnOV49eKNvbv5vB
         SDqra6CZsiKb63HR2kn4yb2y4DbxYp+cC5oJgNMi2dmFQuPyxQHHk/qjwWohUWISzN+i
         pnMQ==
X-Gm-Message-State: AOAM5315wWVXXSP5XFp08brAUrjlbKllDGW3pKApokXpLrSIeL0/072q
        F6LM8GPNatIT190al4VqwJZQE7Gz/59EMqurHeEiFA==
X-Google-Smtp-Source: ABdhPJyxZCUyr4sMHK+JfeiRtzhmYvXjKxyFRS/5VnhxOej5AiUTE/+OV68+Q8FkKKW+Dxu+8ENslNiFqTzqpBJ17+w=
X-Received: by 2002:a25:d1d3:: with SMTP id i202mr11392808ybg.487.1634880200329;
 Thu, 21 Oct 2021 22:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014658.263508-1-surenb@google.com> <20211021192454.72ada9b3d59460cc3c037d2c@linux-foundation.org>
In-Reply-To: <20211021192454.72ada9b3d59460cc3c037d2c@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 21 Oct 2021 22:23:09 -0700
Message-ID: <CAJuCfpEcvuYu5OhXMVz5g4OK+-a_jnF9MNtu17VP5V23r2oWtw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and exit_mmap
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 7:25 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 21 Oct 2021 18:46:58 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > Race between process_mrelease and exit_mmap, where free_pgtables is
> > called while __oom_reap_task_mm is in progress, leads to kernel crash
> > during pte_offset_map_lock call. oom-reaper avoids this race by setting
> > MMF_OOM_VICTIM flag and causing exit_mmap to take and release
> > mmap_write_lock, blocking it until oom-reaper releases mmap_read_lock.
> > Reusing MMF_OOM_VICTIM for process_mrelease would be the simplest way to
> > fix this race, however that would be considered a hack. Fix this race
> > by elevating mm->mm_users and preventing exit_mmap from executing until
> > process_mrelease is finished. Patch slightly refactors the code to adapt
> > for a possible mmget_not_zero failure.
> > This fix has considerable negative impact on process_mrelease performance
> > and will likely need later optimization.
>
> Has the impact been quantified?

A ball-park figure for a large process (6GB) it takes 4x times longer
for process_mrelease to exit.

>
> And where's the added cost happening?  The changes all look quite
> lightweight?

I think it's caused by the fact that exit_mmap and all other cleanup
routines happening on the last mmput are postponed until
process_mrelease finishes __oom_reap_task_mm and drops mm->mm_users. I
suspect all that cleanup is happening at the end of process_mrelease
now and that might be contributing to the regression. I didn't have
time yet to fully understand all the reasons for that regression but
wanted to fix the crash first. Will proceed with more investigation
and hopefully with a quick fix for the lost performance.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
