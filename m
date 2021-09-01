Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924DC3FDD15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhIANNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242470AbhIANNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630501930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5zc5pVy5AQE8f2hIOP2bxIi4X/stfjf8ftLgm/AZ+k=;
        b=Dyb+BDr29aTtfrmAIpOBtKovr8Gqvny4IABySeV4OFDzgXiVZGNSnmWeabkqzVLo5DYe3N
        mnjCnQder2QR6tiylwdh3WlRhrfTofGXkOos+b1CkjdDKZqdllra8y4IigsU973iBAhpP5
        AtEYuHGRMdBaxAtj4XU3GzruYKziKG4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-s_CHxEmsMci2FufmXCSbnQ-1; Wed, 01 Sep 2021 09:12:09 -0400
X-MC-Unique: s_CHxEmsMci2FufmXCSbnQ-1
Received: by mail-lj1-f200.google.com with SMTP id m9-20020a2e5809000000b001dccccc2bf6so759179ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 06:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5zc5pVy5AQE8f2hIOP2bxIi4X/stfjf8ftLgm/AZ+k=;
        b=tOjsSSkdTy3MFiY1iWIjztTqt4lrj6najlqRzbcy9MAgOU3rdZe/Ea6tVxU7DRmlaw
         jDDq6h/vvSNb0YST7a2LpSTDncpcibnKFepUjnv8NnWb2Rmm1qWOCGd9PLdBXHYvw+5n
         oLPd7Q9IDIKuWXFabskugPfSg6BYYQ8vVoySCo2c/GK8kk1R5rb8kSP/QMWf+g0D9+Kz
         2Ce0p0PP3jsUIRR6kWYzVuA6HiJ8xOu/frjH4xFxx6l4nLsAEKVXCcNvrAXEY6TwfrfH
         Evwv2uTfrSay6Iz7FT6ubI6VC0ZvgxWn009npmobIXoyBOKR9u6JVXNYNQkL/BMMNJaC
         wlGA==
X-Gm-Message-State: AOAM533TaNzIseBiYuTTL5sDE7bFcrUBh/J8S05Tyn/g5HbaCtbPP3Il
        XLB1MDmXSZYkcg1wVUiBV7ka4iwfg9ATLJixXzZZHfZ2jKrnKTfPO0GjBLOhSTQOn5xT8tznfPP
        a89JvwnVFyf1NfDRZWs9OYxjTz4oDyewvyVkqM61M
X-Received: by 2002:a05:6512:2009:: with SMTP id a9mr6375333lfb.647.1630501927782;
        Wed, 01 Sep 2021 06:12:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB0QOBH84GtxMizOBl72HtxuAM5apgtrZH9DoyD/yNZzxzbNyEUI/v+eXareIkLTvGLn4Coob6TWtCox0EZJc=
X-Received: by 2002:a05:6512:2009:: with SMTP id a9mr6375307lfb.647.1630501927523;
 Wed, 01 Sep 2021 06:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210824152423.300346181@fuller.cnet> <20210824152646.706875395@fuller.cnet>
In-Reply-To: <20210824152646.706875395@fuller.cnet>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Wed, 1 Sep 2021 09:11:56 -0400
Message-ID: <CAFki+Lnso5j+cbDsd74+YM+-sT-zTYuymyJLY2Sw1ho3SHW74Q@mail.gmail.com>
Subject: Re: [patch V3 2/8] add prctl task isolation prctl docs and samples
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:42 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> Add documentation and userspace sample code for prctl
> task isolation interface.
>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>
> ---
>  Documentation/userspace-api/task_isolation.rst |  211 +++++++++++++++++++++++++
>  samples/Kconfig                                |    7
>  samples/Makefile                               |    1
>  samples/task_isolation/Makefile                |    9 +
>  samples/task_isolation/task_isol.c             |   83 +++++++++
>  samples/task_isolation/task_isol.h             |    9 +
>  samples/task_isolation/task_isol_userloop.c    |   56 ++++++
>  7 files changed, 376 insertions(+)

[...]

> +       if (ret) {
> +               perror("mlock");
> +               return EXIT_FAILURE;
> +       }
> +
> +       ret = task_isol_setup();
> +       if (ret)
> +               return EXIT_FAILURE;

The above check condition should be 'ret == -1', isn't it?

-- 
Thanks
Nitesh

