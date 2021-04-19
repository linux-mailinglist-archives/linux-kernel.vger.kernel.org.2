Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B99F364E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhDSW54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:57:56 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:39884 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhDSW5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:57:51 -0400
Received: by mail-il1-f169.google.com with SMTP id b17so30529268ilh.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jrWwcCLWSyD+ImzZIaLb1cLmYM5uMBiR0FllZtNDzxM=;
        b=e90TRNpnNCyCEZnaIC9cmGR1vnecCq4xuhbgx1tPpXznJX0ROgWo4gacodU0gwyCVl
         m4Ldk/0Joe0hQX+J9xAOWHjOoR08RCXKmcO4YKOZZO0+slyTpAKyf1OGO5hUUAKdQX4I
         RwOlRwVJVV1KSb/uqA08aoAuFYnCsGO67xfsMoLhKKRRf4nYYMyV49dzK2Om4Rc4cQEo
         JWG1XO3xxNzNtBA+PABLDhDSsAOFymAU2S110MaSo5ULu+r3Hi4Hh2nk874YAR/7+R30
         qrh/acKm8pdsEfCXJpfWBy4C/YNsILlE/qNktxK2TtEP4Hnyeq5dbvgoZXZR5VOH4fEG
         84BQ==
X-Gm-Message-State: AOAM530rScyLoCstFkFDzisHKa4InsvFWtGA42xpgkG8ATztlXifRq1p
        ZYSJFP8IXUdEUuUHPtJEu7U=
X-Google-Smtp-Source: ABdhPJzYfwGn+0dXodaH6TI4sxioXh8kIS9bLA2EMu6Pk6tLlZ/nnrT8KM/Tsj1uAAh0u04EQ7zR2A==
X-Received: by 2002:a05:6e02:20ef:: with SMTP id q15mr20482776ilv.167.1618873040559;
        Mon, 19 Apr 2021 15:57:20 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id r11sm6249069ilq.29.2021.04.19.15.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:57:20 -0700 (PDT)
Date:   Mon, 19 Apr 2021 22:57:18 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Pratik Sampat <psampat@linux.ibm.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] percpu: partial chunk depopulation
Message-ID: <YH4KzmddTHWx9Gih@google.com>
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

Hello Pratik,

Do you mind testing this series again on POWER9? The base is available
here:
https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git/log/?h=for-5.14

Thanks,
Dennis
