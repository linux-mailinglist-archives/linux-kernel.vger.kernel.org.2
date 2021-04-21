Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171B336727E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244377AbhDUSZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:25:35 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:38722 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbhDUSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:25:34 -0400
Received: by mail-io1-f41.google.com with SMTP id q25so11641605iog.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 11:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mPgB8yCc8zamYWb0vi63329hsT/Sv+pV390azKvDE9o=;
        b=fobxI6dfdYW9iFYsk4luNw8phk2xsDaylgfegZmrV9yvZkRTrefe/3WcCtnTh4uInA
         rnayPqD5rEk07y6bhc/eDOpWn9GO3L4lAVZcZ0L7e3BGicvZyAgZX+Ue+0kyJGU1wANX
         W6tj4kW9wVbXO11ATdBeWP5CPcEsITm0ICHm0zm8SysprimnuD6dx9OwLOsNpNUmxOnI
         nDbSmOJSlV+UNr25TseMd+eXNS2AHXB2264Qs0m+RGKMwL5YkVs18AGRRit4TaM9X93L
         4d3oPklXX+78MRHKOcem7dmcKJGMqU2lN3gdntsrqZk68CAykqir9Ps70mtS9yzGBhDv
         Cdwg==
X-Gm-Message-State: AOAM532dBvWCHTtf0IHTdiexHeFjFoSksG4rTEQh+f2FWPqYVApKmEXs
        x2AJh0+cSsY6iIBTZ+3xFtBv1egPtKI=
X-Google-Smtp-Source: ABdhPJy8zrY3Zf7pmdbJqdN5CEQFL21g4VMTreumaKiwCar481749ycVklTaBVnkSeqNRN+nUx7EgQ==
X-Received: by 2002:a02:968f:: with SMTP id w15mr15747575jai.109.1619029500338;
        Wed, 21 Apr 2021 11:25:00 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id y19sm63666ili.51.2021.04.21.11.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 11:24:59 -0700 (PDT)
Date:   Wed, 21 Apr 2021 18:24:58 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] percpu: partial chunk depopulation
Message-ID: <YIBt+qaZ4teb+WfW@google.com>
References: <20210419225047.3415425-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419225047.3415425-1-dennis@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 10:50:43PM +0000, Dennis Zhou wrote:
> Hello,
> 
> This series is a continuation of Roman's series in [1]. It aims to solve
> chunks holding onto free pages by adding a reclaim process to the percpu
> balance work item.
> 
> The main difference is that the nr_empty_pop_pages is now managed at
> time of isolation instead of intermixed. This helps with deciding which
> chunks to free instead of having to interleave returning chunks to
> active duty.
> 
> The allocation priority is as follows:
>   1) appropriate chunk slot increasing until fit
>   2) sidelined chunks
>   3) full free chunks
> 
> The last slot for to_depopulate is never used for allocations.
> 
> A big thanks to Roman for initiating the work and being available for
> iterating on these ideas.
> 
> This patchset contains the following 4 patches:
>   0001-percpu-factor-out-pcpu_check_block_hint.patch
>   0002-percpu-use-pcpu_free_slot-instead-of-pcpu_nr_slots-1.patch
>   0003-percpu-implement-partial-chunk-depopulation.patch
>   0004-percpu-use-reclaim-threshold-instead-of-running-for-.patch
> 
> 0001 and 0002 are clean ups. 0003 implement partial chunk depopulation
> initially from Roman. 0004 adds a reclaim threshold so we do not need to
> schedule for every page freed.
> 
> This series is on top of percpu$for-5.14 67c2669d69fb.
> 
> diffstats below:
> 
> Dennis Zhou (2):
>   percpu: use pcpu_free_slot instead of pcpu_nr_slots - 1
>   percpu: use reclaim threshold instead of running for every page
> 
> Roman Gushchin (2):
>   percpu: factor out pcpu_check_block_hint()
>   percpu: implement partial chunk depopulation
> 
>  mm/percpu-internal.h |   5 +
>  mm/percpu-km.c       |   5 +
>  mm/percpu-stats.c    |  20 ++--
>  mm/percpu-vm.c       |  30 ++++++
>  mm/percpu.c          | 252 ++++++++++++++++++++++++++++++++++++++-----
>  5 files changed, 278 insertions(+), 34 deletions(-)
> 
> Thanks,
> Dennis

I've applied this to for-5.14 with 1 modification to the batching
threshold, 4 pages is quite little, so make it 16.

Thanks,
Dennis
