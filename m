Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCE43C885F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhGNQMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhGNQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:12:14 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85146C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:09:22 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h9so4205210ljm.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTrRhh4ATToXnLaZIsX+KWYTOMzlq26jNnD0kci+iJY=;
        b=GYLdHac7wske5/rBo4t4qHRWybjUaM8ef4f8igg6gQi7kmUpr11sVwWTe/iK4CQG4d
         uLoXvj6sxB5Rwlb+L72002EMXKbU0APNfE4AVmI+eSwIaKbXSHaviSde/wbKwAmERYnM
         aLh+54+zwRUj5vLrs8R1RICeagYfRnOuGUjRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTrRhh4ATToXnLaZIsX+KWYTOMzlq26jNnD0kci+iJY=;
        b=g3D1SfinaYzmOBvoA9jPNGQ+tmrlEvymgJbj/gMYoyYS4mvXAjkxdy42HMQ8ZRDlXm
         nJu6OWL7aClXMuoDn2/h44j6xeZJheJtXHAKjy9GqpXz7aIwCkhy5uxpioJ1ORxeXijN
         hhE67X3E5z8PV/TlzfZQTpDm91mFW2DPu83koJyXnUjAiaj0zixb4xoW11CnErZGILJk
         Mc2CDF1gmX5l81YAf8a5Fp+BtxNUlFm3SG3Dnfczy4yaR+KbSVWaJnc1w/R+p/JmNAjj
         /KDKS+c79AhEku3t7RKs6yVQXTmoPxb/i/sfrJuJ3CggWqDsrbVtHaEBYMJgwm0k0iD3
         o3lg==
X-Gm-Message-State: AOAM5314gEQmdSGkxQje5NVkfGMYR0N38uZQPSBI0NuTR8XFtH/0skyA
        4C0PV1tTph3ek3Ck5gUMTzhj1o/qBV3Ut5Ul
X-Google-Smtp-Source: ABdhPJzzmk9jUqCO18x9kdzTuexa64+lGosGJuK5qKbSZ5yLEki9gPfmdMxe5lHZPcGdjTCr9Vc68Q==
X-Received: by 2002:a05:651c:547:: with SMTP id q7mr9813635ljp.509.1626278960728;
        Wed, 14 Jul 2021 09:09:20 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id c10sm209109lfv.10.2021.07.14.09.09.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 09:09:19 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id y42so4518881lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:09:18 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr8296706lfc.201.1626278958708;
 Wed, 14 Jul 2021 09:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210712153207.39302-1-willy@infradead.org> <20210713191244.553680171f9fab3bf6e0889b@linux-foundation.org>
 <YO5J/OSGQvHp1npk@casper.infradead.org>
In-Reply-To: <YO5J/OSGQvHp1npk@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Jul 2021 09:09:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjr9UNG86GG1KOTkDJD_ke4z17UVgQJHPQaF-E_DVU3EQ@mail.gmail.com>
Message-ID: <CAHk-=wjr9UNG86GG1KOTkDJD_ke4z17UVgQJHPQaF-E_DVU3EQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Make copy_huge_page() always available
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mina Almasry <almasrymina@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 7:21 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Well, the code was only merged this merge window, so as long as it goes
> in in the next few weeks, there's no need to trouble -stable with it.

It already went in on Monday as commit 79789db03fdd.

           Linus
