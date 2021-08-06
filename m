Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362343E2A09
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245694AbhHFLs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245616AbhHFLsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:48:25 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D133C061798;
        Fri,  6 Aug 2021 04:48:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id k13so6211024qth.10;
        Fri, 06 Aug 2021 04:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=eGSjSqZSYbLxuQd8oI0XJgV6zBB7+cKt8LohYyTcZZs=;
        b=BezIgjl+gGQUTu7iVDcfOPvYqkFN+zCpKnY1WYtZ2qYRtRrSSFvtopgNpJSq6VvpjU
         DYXi60g8760AYS+P0KA+f0BEYyGvmEAiXmtncJQ7MNGiXxbif1z3dbvs6hgXGKmzvfjm
         AjB9TlgbN8/YUQ8pXsLB2lRPIgUG1RXA8iuMGRw2cmNOuFVqQ00A79tnU485W/C/JyuR
         2PQ2EYaAXzLNenIlToEISr+UYqfg2qUghKOHn6iCbU78+95HCRvWGf6KG+mluF+N1bDc
         yuu7o7/9N1a5s5UXswE3FNOtyzppvVPGIDlQWUYfoBmSK3x/bGI1OaqV+vZxxUNT2P7S
         sXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=eGSjSqZSYbLxuQd8oI0XJgV6zBB7+cKt8LohYyTcZZs=;
        b=h+Y7m+F65mx2Y+bj8VjOQC/uP/zKEU3WePQ/jBKHCUdc7gy2+bNEoNA6ilBtFYX/8P
         R2QWA95T8OwdVcYxwkmAaQ94nA15SFxxtrU6GVe79gj1O2MunIkIdEbRmrUhyCsYCTCC
         6NZCF3k4Vx2NgbJtnCgfbtIlocnPpALbuTPwiW3kR5GsNWslc9mcUnA5YYNvNPqkNwq9
         TX6HdRVDC7cFXlk0OgMvG5cTEsgzPAbZQiI8EisX3I7/f2VM2xmTlPtTsOMRVLEtyJQJ
         DBkzV7Z2nzO+HErCIcPW8YMwQ6eF6yCVseU8cpJvM6rllcB0EyudpqIW2vaHMZqp/Li0
         4Cdg==
X-Gm-Message-State: AOAM533ejJlq8j1yCsOkFl3+70KNzs+DeHNp3Fk3QkvP3veeKU+mOghL
        zDl+JFwV4poIf/iy6wsQOv8=
X-Google-Smtp-Source: ABdhPJzEJRoYEkGBXrvd5E849+FERj7uQF2zN7qzcOZdLpibeL+Tn2GWh/7otgjmTmgVEyjRBpWRPA==
X-Received: by 2002:ac8:6886:: with SMTP id m6mr8681334qtq.255.1628250487810;
        Fri, 06 Aug 2021 04:48:07 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id t64sm4470921qkd.71.2021.08.06.04.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:48:07 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
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
Date:   Fri,  6 Aug 2021 11:48:01 +0000
Message-Id: <20210806114801.6958-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805170344.afbf5f1ceb00eb212082ca7b@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Thu, 5 Aug 2021 17:03:44 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 28 Jul 2021 08:36:43 +0000 SeongJae Park <sj38.park@gmail.com> wrote:
> 
> > > DAMON does not expose stable APIs at the moment, so these can
> > > be changed later if needed. I think it is ok to merge DAMON for some
> > > exposure. However I do want to make this clear that the solution space
> > > is not complete. The solution of system level monitoring is still
> > > needed which can be a future extension to DAMON or more generalized
> > > Multigen LRU.
> > 
> > Agreed.  We have lots more works to do.  Some of those are already posted as
> > RFC patchsets[1,2,3,4].  I promise I will happily do the works.  But, how dare
> > could only I get all the fun?  I'd like to do that together with others in this
> > great community.  One major purpose of this patchset is thus providing a
> > flexible framework for such collaboration.  The virtual address space
> > monitoring, which this patchset provides in addition to the framework, is also
> > for real-world usages, though.
> > 
> > Now all the patches have at least one 'Reviewed-by:' or 'Acked-by:' tags.  We
> > didn't find serious problems since v26[5], which was posted about four months
> > ago. so I'm thinking this patchset has passed the minimum qualification.  If
> > you think there are more things to be done before this patchset is merged in
> > the -mm tree or mainline, please let me know.  If not, Andrew, I'd like you to
> > consider merging this patchset into '-mm' tree.
> 
> Shall take a look.  With some trepidation.
> 
> 1-2 years from now someone will pop up with a massive patchset
> implementing some monitoring scheme and we'll say "why didn't you use
> DAMON" and they'll say "it's unsuitable for <reasons>".

Agreed.  And I personally believe merging this in will help avoiding such
situation, because the someone will be able to easily find the developer who is
responsible to convince the person.  I will happily and definitely do my best
for that.

> 
> I would like to see more thought/design go into how DAMON could be
> modified to address Shakeel's other three requirements.  At least to
> the point where we can confidently say "yes, we will be able to do
> this".  Are you able to drive this discussion along please?

Sure.  I will describe my plan for convincing Shakeel's usages in detail as a
reply to this mail.


Thanks,
SeongJae Park
