Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A976240BF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhIOF4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhIOF4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:56:42 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C7C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:55:24 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a15so1971460iot.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDVy5greG+8lJq19uaFSJH6Nx+KYNP3FKOVqZ9npFqs=;
        b=Y/V0rwFV+HU9UBCFwl9995ScbzjiT5skefdea+1qtSDSla/NnMfNdtET/4SQHsvQRd
         6Pt/cizw7X8K7R8B3o/SzTJl//+oIzAlwr3/5cypMr7HGLnZLJKixgYHsy6uuSUkr4iI
         qxku3/wP2K8x+QmSyh+BTPau675a6IawkRg0gOFsTXsjyaKqXdkB2lkqYnQV5Dt6NiB3
         2FRMMxFcYGeT2DXfwsz93uwNeUSX53tysbEJ8MscSvRUbd9jsv0kNzFhcnyX54BeEcYN
         BK7d070hL8dw6Hb8AXMGE6d5dFj8I03OU14CHABlvdJbm+vd4zQKZmkA1kaUNJB2hLZI
         Qb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDVy5greG+8lJq19uaFSJH6Nx+KYNP3FKOVqZ9npFqs=;
        b=YfxdKtzWdbuISCyJmuLS3o9FXiaUrMoKF0FszOWtzsW7mHP5pziLN/y1go/NecKl7a
         49s8D5QCmoVmAd7HCbwqHIHGYxFto5EqV/nIJrTOhit9kE1GEkuUZGsiqN8zsP1c7wuD
         JLOeVi4UVplnURUDTQWeRzBSjY5uXUBIRfp4eg/g6mmrBFxhCRsC/JT1HZKQF6AOxqdZ
         G8WHa0mXjYhko8F+hCgNjcvgEf4FRdA37zfdY8Wa+4KS127xRDfffMsCwsKJ6FepNMf2
         lFv8x4shNMlKkfL9uCxlhoPvMfAyoRHIf3eY+oCKEyk03yY/WwpYlF4og+qSLiZvSzrh
         XOeA==
X-Gm-Message-State: AOAM5317jY9oZt49tNLoVOWnoklKYZevQi2koa2sY1ShZQs2hlmacAna
        JdxXlfWhPcZN2TGGKRBMJrJt3ftUvcBeo6hJqAtjvg==
X-Google-Smtp-Source: ABdhPJzTGZCBHTGvTND0fcNWV9y4V55sjc4GJhVrHXs5tFS0Fc86JEtmENlTYGBRpJplFEdzW/uug903JYMzWYFpoOI=
X-Received: by 2002:a02:9282:: with SMTP id b2mr17621993jah.0.1631685323489;
 Tue, 14 Sep 2021 22:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com> <YTnL814pES+YWWnm@hirez.programming.kicks-ass.net>
In-Reply-To: <YTnL814pES+YWWnm@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 14 Sep 2021 22:55:12 -0700
Message-ID: <CABPqkBROKmSLLCwFjiqObDpQz4iBUeO-0OaziNy05kxs3-4JHQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 1:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 09, 2021 at 12:56:47AM -0700, Stephane Eranian wrote:
> > This patch series adds support for the AMD Fam19h 16-deep branch sampling
> > feature as described in the AMD PPR Fam19h Model 01h Revision B1 section 2.1.13.
>
> Yay..
>
> > BRS interacts with the NMI interrupt as well. Because enabling BRS is expensive,
> > it is only activated after P event occurrences, where P is the desired sampling period.
> > At P occurrences of the event, the counter overflows, the CPU catches the NMI interrupt,
> > activates BRS for 16 branches until it saturates, and then delivers the NMI to the kernel.
>
> WTF... ?!? Srsly? You're joking right?
>

As I said, this is because of the cost of running BRS usually for
millions of branches to keep only the last 16.
Running branch sampling in general on any arch is  never totally free.

>
> Also, can you please fix you MUA to wrap at 78 chars like normal people?

Ok, I fixed that now.
