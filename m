Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1935B431868
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhJRMEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229569AbhJRMEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:04:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BF9B61077
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634558560;
        bh=RhHPIX0Z+xg7kqXRMeJLbAlYk80ZUNDoBDg7wJ0kQjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f8VqssK/7jXB2fJFSq2cPgm8keSIjqUPo0NkNs5vpiK2gdt3mDuwWa4s2sgUJAhvB
         mocVvlSp00gGAwQuZ+PW6ycCZG55QICmZcKzmQZSKE+rnN959zLroEfrPxCgeUh7a1
         OxR1KiP/yRUhs0T2h9JwGlZ4YsA9GDy+Y4vtKZUQ9JFLz5LS7xES5iDU3JowdsnOcu
         TmhBPvcop9oE881oRT4cY25wE4gQMpiG9JQKoVZqSBIindc/U9FWwNi1lOc/ETzuQv
         ZEanG1N/ErHQaDxpig6aoSFxXWKSz7TbhPqIcrTZhRcyw2aGDx5lgofsvyqjixjfSg
         sqT8gK873UO7g==
Received: by mail-ed1-f43.google.com with SMTP id w14so69926680edv.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 05:02:40 -0700 (PDT)
X-Gm-Message-State: AOAM533VO7q9G84lqjEWOKeHjOEmlCv0DcvcpRAFEwC5vq4r2TTYDHsc
        g7vPPjI0jXxgblOoyv4XV3/nry5EFkEIVxgpRg==
X-Google-Smtp-Source: ABdhPJyTVojjZSVx1tOOZXPoaIiK+leRXXmuEIBk5SwNOhlQESxuVhdC/rOnY3qX4Uo9iSyYPs7eHRtNesysghWobOo=
X-Received: by 2002:a50:da06:: with SMTP id z6mr45094962edj.355.1634558546647;
 Mon, 18 Oct 2021 05:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-3-guoren@kernel.org>
In-Reply-To: <20211016032200.2869998-3-guoren@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 18 Oct 2021 07:02:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+NM=jvYfvyNVsJCrizHzqaDMPe05hkBhnOWHc+JwBNig@mail.gmail.com>
Message-ID: <CAL_Jsq+NM=jvYfvyNVsJCrizHzqaDMPe05hkBhnOWHc+JwBNig@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] dt-bindings: update riscv plic compatible string
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:22 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Add the compatible string "thead,c900-plic" to the riscv plic
> bindings to support allwinner d1 SOC which contains c906 core.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <atish.patra@wdc.com>

Please send to the DT list so that checks run and it's in my review
queue (IOW, use get_maintainers.pl). And run 'make dt_binding_check'
so reviewers don't have to find your typos and other errors for you.

Rob
