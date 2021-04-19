Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8A364DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhDSWyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:54:47 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:33289 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhDSWyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:54:44 -0400
Received: by mail-io1-f50.google.com with SMTP id a11so34456609ioo.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xNe1AI+zAlQJlHonsRA7VbAthmGAmqlvMIkGNsV22k=;
        b=O09TIma8F+pRNckWT49pRMJZ6WRlJWw0aqUF6B9qDj6I0JyOEyZ4EYQKZ51vsbjzWL
         +ljejwelNhfWfLXmfgGq3MyalVPaMWExJkB6X+mXqBAOPdyiIVE7sLERuA7wj1yDy+Gd
         2UEZ/1Gi8Fobn8OEXLmIkHsluLzvCbjH/qtc7tQEA7lLivDF4a5padkAtvAC0tvJuI+I
         SkK1dR1mL0U2fVwyhVV1xOLjDbHYe5wZDJRAizWWQRpDcKzYgD9CoFEJ/kc+2s/FKxX6
         xEnkEaWTXERIC0aWebZk65/6KGo+nlvhi3tcOr7lWU7W4tdadNCJm9S4Yz2OvoLEVmGQ
         kUGA==
X-Gm-Message-State: AOAM530KvzHfzsZ/Cjet3MmgyvPofX8EXY7HAeq1H7N1hlDC51C2Zt2l
        l+OYotJyJhdrSDDoinRrXXMcxO/BFIc=
X-Google-Smtp-Source: ABdhPJxt5t6ZO16155uYGSei0G9muX0BqwWOt5nj2Dvznm46xkm1D5FXFelC0mcW7xv+XUHpwOdggA==
X-Received: by 2002:a05:6602:1689:: with SMTP id s9mr16042508iow.171.1618872854077;
        Mon, 19 Apr 2021 15:54:14 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id k1sm3841824ils.54.2021.04.19.15.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:54:13 -0700 (PDT)
Date:   Mon, 19 Apr 2021 22:54:12 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] percpu: partial chunk depopulation
Message-ID: <YH4KFOY/kP0vnPWZ@google.com>
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

And I forgot to link [1]...
[1] https://lore.kernel.org/lkml/20210408035736.883861-1-guro@fb.com/

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
