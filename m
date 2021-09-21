Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F714135D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhIUPGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233840AbhIUPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632236687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2x5rqD0I1Z8EQgTGoic1TcC/yhS9DgiwB+H8dUYgCd0=;
        b=cPqFba7/wfvnjR5vzWmBDdfUK7iJo9owoPcoS47kI2WElTUJiJbtQaPtJ74pB3qsFAhVqS
        mgMPHtrLcKc+NdUI2elOJxa5iImmIoZancVlS2tVevG3DiKe4TRS3iZR9VT1JhffBEBn18
        r7ssDXD/0gdaQRdTqWkxNqUzu0kglrY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-o-c4mm9rPzGphyDF8ADzMA-1; Tue, 21 Sep 2021 11:04:46 -0400
X-MC-Unique: o-c4mm9rPzGphyDF8ADzMA-1
Received: by mail-qt1-f200.google.com with SMTP id c22-20020ac80096000000b0029f6809300eso216575626qtg.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2x5rqD0I1Z8EQgTGoic1TcC/yhS9DgiwB+H8dUYgCd0=;
        b=KvYTkAZXFR8idI8xFYpC0mFErX453I3ARJuPpxybKBLQ9w8AhQaue54wJORxuf51x+
         rCW+UAGWnBgmI5PutEprLJdBYVlFYuAAfoobscrwRxRBRn4QhQ4ef4jnUarMftklvzte
         EyZqGtwLmCrOI31kF4kiBzqIgQJ2w7Y7wVlibjJsF/b51mc40djIqaEH6CvnkZnUOAfV
         yKc+Zw1ddSCMU9fq/NrCbjvMiADO+WlaQbZaNByUoEUzEymRuH+KuYoIs/EzGYDlwqyS
         cLdVs++2xMfC1A9cFACyRTo9T7mOEjmagDZZxtq3rWIN06eZ9qitrpFltjPGohO1m65P
         CoHw==
X-Gm-Message-State: AOAM530MYjyPgp6ReVdk1BGlxUA+K3vgJHiaJw9d+Dw15yV0VlDxhyRr
        Dzj1Pple4OMiUT4NlgbbnVGZiOWT5Vb4SA1ebM49ArmwLRR/upmzsiTJqQIP++rJqyprF/EUnls
        gv9+b2lWIKz6NxLwW/OOW5Jrg
X-Received: by 2002:a37:bfc6:: with SMTP id p189mr30693095qkf.33.1632236684763;
        Tue, 21 Sep 2021 08:04:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8U6vZ7gnxEMCR81lmgXlrbyrYpmkZLoTOiSc+Z8PManocp5D4HOKaV68dPRX4Kc12+vjS/g==
X-Received: by 2002:a37:bfc6:: with SMTP id p189mr30693063qkf.33.1632236684470;
        Tue, 21 Sep 2021 08:04:44 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id g17sm379283qkm.60.2021.09.21.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 08:04:43 -0700 (PDT)
Date:   Tue, 21 Sep 2021 11:04:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "david@redhat.com" <david@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>
Subject: Re: [PATCH v2 1/1] Documentation: update pagemap with shmem
 exceptions
Message-ID: <YUn0ikP4Gip3Yc6L@t490s>
References: <20210920164931.175411-1-tiberiu.georgescu@nutanix.com>
 <20210920164931.175411-2-tiberiu.georgescu@nutanix.com>
 <YUjb91tWhd/YAgQW@t490s>
 <F6A49621-C7A4-4643-95C2-F47B02F132D2@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F6A49621-C7A4-4643-95C2-F47B02F132D2@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiberiu,

On Tue, Sep 21, 2021 at 08:52:32AM +0000, Tiberiu Georgescu wrote:
> I tested it some more, and it still looks like the mincore() syscall considers pages
> in the swap cache as "in memory". This is how I tested:
> 
> 1. Create a cgroup with 1M limit_in_bytes, and allow swapping
> 2. mmap 1024 pages (both shared and private present the same behaviour)
> 3. write to all pages in order
> 4. compare mincore output with pagemap output
> 
> This is an example of a usual mincore output in this scenario, shortened for
> coherency (4x8 instead of 16x64):
> 00000000
> 00000000
> 00001110   <- this bugs me
> 01111111
> 
> The last 7 bits are definitely marking pages present in memory, but there are
> some other bits set a little earlier. When comparing this output with the pagemap,
> indeed, there are 7 consecutive pages present, and the rest of them are
> swapped, including those 3 which are marked as present by mincore.
> At this point, I can only assume the bits in between are on the swap cache.
> 
> If you have another explanation, please share it with me. In the meanwhile,
> I will rework the doc patch, and see if there is any other way to differentiate
> clearly between the three types of pages. If not, I guess we'll stick to
> mincore() and a best-effort 5th step.

IIUC it could be because of that the pages are still in swap cache, so
mincore() will return 1 for them too.

What swap device are you using?  I'm wildly guessing you're not using frontswap
like zram.  If that's the case, would you try zram?  That should flush the page
synchronously iiuc, then all the "suspecious 1s" will go away above.

To do that, you may need to firstly turn off your current swap:

        # swapoff -a

Then to configure zram you need:

        # modprobe zram
        # echo 4G > /sys/block/zram0/disksize
        # mkswap --label zram0 /dev/zram0
        # swapon --priority 100 /dev/zram0

Quotting from here:

        https://wiki.archlinux.org/title/Improving_performance#zram_or_zswap

Then you can try run the same test program again.

Thanks,

-- 
Peter Xu

