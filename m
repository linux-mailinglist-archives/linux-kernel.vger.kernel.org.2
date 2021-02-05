Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EFF31167E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhBEXCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhBEOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:37:37 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533B9C061225
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:15:34 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n10so4850611pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FTPh7oL8EmAIBxBRU2UBLoT6Jy/Icksa/rE3mlaA1mM=;
        b=cLrjPxBpGlaQNbmOEsfdJJzZMIp5F/CeTpQFaq97QruHEFUQ5yarW4BHlIsFKSf469
         QwxOtJtigpkm/z2uORLubYRRROLuy/Zi2Ue0q42XAWY/Dbi/PteR0YcsToI07JmBGV/Q
         eYHDpf+qwIS1PzsWiQVu0m+CdW6auQuQKrQzT+K7h6AZ0evOqL15+Hl9Ybc5UObkqN2r
         eYZqpjgUEMIlMtOyEQAkRzjmS6shAatT351egzzl+UHox5ifwQWdA59j13TLdgYmviMQ
         7QGW9P7ozeYAuiObNywhHFGc/UEFxlNpQx/huM65SK5Sp0znmy7DbdaH4BGiFoUys4/w
         gvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FTPh7oL8EmAIBxBRU2UBLoT6Jy/Icksa/rE3mlaA1mM=;
        b=G8f1lI2j/H8P4dSKjtiv15XfLNdkV5nbXlyHdQRaQCCMkrbrJFI+4p3HV90Lu+xQYU
         0w7O8lK3U44CLbx0v2/+A3kuaTOx5T76xldA025F0pz+80xDmg/Oynsjl340pq+NZJSE
         7JBln9wYepur3XyjyiyMkIIyKb9pu3mFdg1gOjV3/ZalRb6QZAC7j74sQ9B6lKrmLsc3
         zStSNwBgh0rklhz2ugTSmlZTnyEGOiOx0/L0LuGpwTn5tsmZBpq3Vx14dqDVy2MN1ZoO
         0hpHCshAOlhMyPBNUXXz35xqNJFGW8VthoIpomJ14CNtro3POfGQSS8dWaoeuwX45by5
         VIQQ==
X-Gm-Message-State: AOAM532k4tYr3wH4Rrq/lB4pWNC9nN6FOAp5Rnwsc9eg93I41ZGppb7r
        j0oyoEUaber3XEdMifg1oc8=
X-Google-Smtp-Source: ABdhPJycEKcf89NcaDzn9SbFfxdRzh67XFybri5aMzom9GFAxSRMGwzh+T7VgSdwl0REkw1U1otOag==
X-Received: by 2002:a65:4d4f:: with SMTP id j15mr5165087pgt.290.1612541733852;
        Fri, 05 Feb 2021 08:15:33 -0800 (PST)
Received: from google.com ([2620:15c:211:201:708b:34cf:3e70:176d])
        by smtp.gmail.com with ESMTPSA id r20sm10661949pgb.3.2021.02.05.08.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:15:32 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 5 Feb 2021 08:15:30 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <YB1vIrgI9S/5CDxL@google.com>
References: <YBxT9XFE6QAQ4T9N@google.com>
 <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
 <YByNU4Q7cc7gYwPh@google.com>
 <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com>
 <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com>
 <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
 <YBzkjh5nnuNiGb6Q@google.com>
 <f6e41e39-d60b-764d-0af4-8e6977663821@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6e41e39-d60b-764d-0af4-8e6977663821@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:41:14PM -0800, John Hubbard wrote:
> On 2/4/21 10:24 PM, Minchan Kim wrote:
> > On Thu, Feb 04, 2021 at 09:49:54PM -0800, John Hubbard wrote:
> > > On 2/4/21 9:17 PM, Minchan Kim wrote:
> ...
> > > # cat vmstat | grep -i cma
> > > nr_free_cma 261718
> > > 
> > > # cat meminfo | grep -i cma
> > > CmaTotal:        1048576 kB
> > > CmaFree:         1046872 kB
> > > 
> > > OK, given that CMA is already in those two locations, maybe we should put
> > > this information in one or both of those, yes?
> > 
> > Do you suggest something liks this, for example?
> > 
> > 
> > cat vmstat | grep -i cma
> > cma_a_success	125
> > cma_a_fail	25
> > cma_b_success	130
> > cma_b_fail	156
> > ..
> > cma_f_fail	xxx
> > 
> 
> Yes, approximately. I was wondering if this would suffice at least as a baseline:
> 
> cma_alloc_success   125
> cma_alloc_failure   25

IMO, regardless of the my patch, it would be good to have such statistics
in that CMA was born to replace carved out memory with dynamic allocation
ideally for memory efficiency ideally so failure should regard critical
so admin could notice it how the system is hurt.

Anyway, it's not enough for me and orthgonal with my goal.

> 
> ...and then, to see if more is needed, some questions:
> 
> a)  Do you know of an upper bound on how many cma areas there can be
> (I think Matthew also asked that)?

There is no upper bound since it's configurable.

> 
> b) Is tracking the cma area really as valuable as other possibilities? We can put
> "a few" to "several" items here, so really want to get your very favorite bits of
> information in. If, for example, there can be *lots* of cma areas, then maybe tracking

At this moment, allocation/failure for each CMA area since they have
particular own usecase, which makes me easy to keep which module will
be affected. I think it is very useful per-CMA statistics as minimum
code change so I want to enable it by default under CONFIG_CMA && CONFIG_SYSFS.

> by a range of allocation sizes is better...

I takes your suggestion something like this.

[alloc_range] could be order or range by interval

/sys/kernel/mm/cma/cma-A/[alloc_range]/success
/sys/kernel/mm/cma/cma-A/[alloc_range]/fail
..
..
/sys/kernel/mm/cma/cma-Z/[alloc_range]/success
/sys/kernel/mm/cma/cma-Z/[alloc_range]/fail

I agree it would be also useful but I'd like to enable it under
CONFIG_CMA_SYSFS_ALLOC_RANGE as separate patchset.
