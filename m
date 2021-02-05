Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FA3311AC8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhBFETp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhBFCbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:31:47 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F21C08ECB1
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:47:21 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g3so4318653plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 14:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9BnXZ/PFgv+PaZ+o1kNDJW5+yPYW/zbcZCYaFlhNaas=;
        b=ERByx7E+FwFwxJ3d0S7TCl5oQ+5IPBNEnlrbb59y9odPmtXRJ5Q4QgcXKTdkGKVfTU
         3tAeOOwZ9B1UfU9HaxaTgRCpwjPMYwA4Y8EcZLFmT5wpff8QwEoFXaUjPeGlMbnOTAXo
         nwhG+jb/1yr4VYh9P7Pl2BeR66JONsO5wIISNkNzPseaap0SHN7slbbHI3doSNGy8eD9
         Fq+m0j6Z0odGrK7u23Tl8sFRZA/dH5+aUIa3Cp5cP29FLOB7LCyR+Obrew3jD09kN1mq
         z5Mm9mXDcCzkDj4UPAKcdG2NzBKoAwQKrLI1rHHC8f+fRL08i8fz2lhsww12XNrdUokk
         BEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9BnXZ/PFgv+PaZ+o1kNDJW5+yPYW/zbcZCYaFlhNaas=;
        b=Zivp57FH2xOhJytVSaFWNHW3D3Y5un4gV3N/cdi8emUP1vsb3tztGv+mTBc/VZb0sZ
         xP3kLZO1n5BiM6ngAPeUgnxJ3t27lzFzgsCkzasZ5eTAuuZGDrQGZEf2FL2R0D4n6Kj9
         JxMdrUn6/D3DXLZfzKQOqvQnluPDrknvkGisc0HSFGMCKQDujRUFZiXD53CVT0Sge9LX
         dQEpi8Jy2T5/iBO+Lp1jXrxMWJ+vDh2HQdDBvAWV5jkbY7/NKac9dlbnaaxKxG3GA9Jr
         ou6iPs/f4ptf9xAByjtnvSz5fTViuOtnfw6FTyF+Wm2T6bzV334FObutq+IuN6Xi98GM
         /0IQ==
X-Gm-Message-State: AOAM532Sfc49Sc6qFVcx8YupOcxcSBwJ0+EkPrqOCo3sXzjtBvdltbZX
        se0NPEfEolRpzMFaiVKoqdM=
X-Google-Smtp-Source: ABdhPJxpG09XuDAWmTFw53mKpO8bI4+yGgzw50FAPRzNQTY84IrAGp32cWQW0MMK+PC+VXp7Hb1POg==
X-Received: by 2002:a17:902:102:b029:e1:2a4c:61ed with SMTP id 2-20020a1709020102b02900e12a4c61edmr6273328plb.61.1612565241129;
        Fri, 05 Feb 2021 14:47:21 -0800 (PST)
Received: from google.com ([2620:15c:211:201:708b:34cf:3e70:176d])
        by smtp.gmail.com with ESMTPSA id a24sm11567954pff.18.2021.02.05.14.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:47:20 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 5 Feb 2021 14:47:18 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <YB3K9rx7E9qMf6Is@google.com>
References: <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com>
 <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
 <YBzkjh5nnuNiGb6Q@google.com>
 <f6e41e39-d60b-764d-0af4-8e6977663821@nvidia.com>
 <YB1vIrgI9S/5CDxL@google.com>
 <269689b7-3b6d-55dc-9044-fbf2984089ab@nvidia.com>
 <YB24YXMJOjwokDb5@google.com>
 <CAJuCfpEaQqgsyGtzRvovpuLOELR0iRNvNF0rnih1bq0HQCTuww@mail.gmail.com>
 <cbd30192-6f9f-845c-6b1c-e21ed737781d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbd30192-6f9f-845c-6b1c-e21ed737781d@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 01:58:06PM -0800, John Hubbard wrote:
> On 2/5/21 1:52 PM, Suren Baghdasaryan wrote:
> > > > > I takes your suggestion something like this.
> > > > > 
> > > > > [alloc_range] could be order or range by interval
> > > > > 
> > > > > /sys/kernel/mm/cma/cma-A/[alloc_range]/success
> > > > > /sys/kernel/mm/cma/cma-A/[alloc_range]/fail
> > > > > ..
> > > > > ..
> > > > > /sys/kernel/mm/cma/cma-Z/[alloc_range]/success
> > > > > /sys/kernel/mm/cma/cma-Z/[alloc_range]/fail
> > 
> > The interface above seems to me the most useful actually, if by
> > [alloc_range] you mean the different allocation orders. This would
> > cover Minchan's per-CMA failure tracking and would also allow us to
> > understand what kind of allocations are failing and therefore if the
> > problem is caused by pinning/fragmentation or by over-utilization.
> > 
> 
> I agree. That seems about right, now that we've established that
> cma areas are a must-have.

Okay, now we agreed the dirction right now so let me do that in next
version. If you don't see it's reasonable, let me know.

* I will drop the number of CMA *page* allocation attemtps/failures to
make simple start
* I will keep CMA allocation attemtps/failures
* They will be under /sys/kernel/mm/cma/cma-XX/success,fail
* It will turn on CONFIG_CMA && CONFIG_SYSFS

Orthognal work(diffrent patchset)

* adding global CMA alloc/fail into vmstat
* adding alloc_range success/failure under CONFIG_CMA_ALLOC_TRACKING
  whatever configuration or just by default if everyone agree

Thanks.
