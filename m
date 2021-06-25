Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992493B4298
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhFYLfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhFYLfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624620772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pozbymbWvFQuGp2tlGCuk4zDQGB354qvNygqlie95bg=;
        b=OkJh50NQSM+scrA32nE0U5q7YDEWpfStVkICUTQrZKIlqjUgGI2+Nhx7zo6Na/sfzLpp8U
        n5/EjHDqIoobXkc7FnrZwW/WIajhwd/HFqTBVVHLB1EcTq501YyWszOkxhj+4GFEnArUa3
        ev6f8w8RZQQ0nmgvvvZYdCbBMRSuQuQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-hCL1ZHu3NQCqeRsCktoSqA-1; Fri, 25 Jun 2021 07:32:50 -0400
X-MC-Unique: hCL1ZHu3NQCqeRsCktoSqA-1
Received: by mail-oo1-f72.google.com with SMTP id b1-20020a4ac2810000b029024bec618157so5632640ooq.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 04:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pozbymbWvFQuGp2tlGCuk4zDQGB354qvNygqlie95bg=;
        b=llTpzAFF8lEkD2KuCTHyt9h1DRdgQc3l7FjP8jLQJaSUqq4LwamKTffpzfUhvuYkCp
         3uenqzd8npIn+3AEkg+dLNNcNAnYE6WOP0/DerukiMFBGiWIMh1o4ObWiPFWjp58oc0w
         ECqNfnF2kPBro+NOv9iXb7PXNB4sp08RiqvrYyQWNJcCP3eXBaeNItBr/XWM5Zkekpnw
         2G9Ixgnhao5jY3cajZ3gnU4jLz+7uotqHosqYdTmKZw3mm7VgZdHyrepIgsmbJFby5s4
         2H2aTQvWqB6+TORU1N8dxmQ4O/QYa2m49QlRkAC1J0ygm1kXSWwwfLfJ8tjBVyjPmGff
         huJA==
X-Gm-Message-State: AOAM533F5aB0CCG/U28/cmBiCrIG9zggQ9Up/VkP79d8GVujYvGafkMS
        me+2WHwxd0WIey3Bi+EC66CeFMRQNisNe41K9OpkWXlzH7IhKYRl9SVsXQuUoxpAZ2mkN2nZpf6
        I6On2zZOGT9zGHt+kYL0AJ5J+XV1dRuseBqPBrni8
X-Received: by 2002:a05:6830:19c2:: with SMTP id p2mr9181288otp.234.1624620770241;
        Fri, 25 Jun 2021 04:32:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyv1FbCBHCGpmdqo1fUppwBHGWam/MkhlCGgMNVBccHnGUGe0DAJDDSLRic7kaHq1Ql9gP2fzTcW4/tMx+h2l0=
X-Received: by 2002:a05:6830:19c2:: with SMTP id p2mr9181273otp.234.1624620770015;
 Fri, 25 Jun 2021 04:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4pXLd9rGTh5o6BS+E0iA3H2ADArFM=N_yN1WWm_PngWnA@mail.gmail.com>
 <20210624122728.82625-1-odin@uged.al>
In-Reply-To: <20210624122728.82625-1-odin@uged.al>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Fri, 25 Jun 2021 13:32:39 +0200
Message-ID: <CA+QYu4qN80P9_uMeq4auTvKBGqrvE=c=2cp3j_W45-N=gJJhvg@mail.gmail.com>
Subject: Re: FAIL: Test report for kernel 5.13.0-rc6 (mainline.kernel.org, cba5e972)
To:     Odin Ugedal <odin@uged.al>
Cc:     bsegall@google.com, CKI Project <cki-project@redhat.com>,
        Erik Hamera <ehamera@redhat.com>, Fine Fan <ffan@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>,
        Juri Lelli <jlelli@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-kernel@vger.kernel.org, Memory Management <mm-qe@redhat.com>,
        nathan@kernel.org, skt-results-master@redhat.com,
        Xiong Zhou <xzhou@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 2:30 PM Odin Ugedal <odin@uged.al> wrote:
>
> Hello,
>
> > Since this commit (Commit: cba5e97280f5 - Merge tag
> > 'sched_urgent_for_v5.13_rc6') we started to see some problem when
> > running the LTP "cfs_bandwidth01" test case.
>
> We got a similar report here, together with some discussion:
> https://lore.kernel.org/lkml/9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com/
>
> It should be fixed by this patch, so feel free to test and report back:
> https://lore.kernel.org/lkml/20210621174330.11258-1-vincent.guittot@linaro.org/

Thank you for the reply, I've tested the patch and it works well.

Bruno

>
> It has already made its way into tip;
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=sched/urgent
>
> Thanks
> Odin
>

