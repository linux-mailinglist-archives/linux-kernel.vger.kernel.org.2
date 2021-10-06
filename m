Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACCF42438C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbhJFRAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbhJFRAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:00:07 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EF0C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 09:58:15 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id e16-20020a4ad250000000b002b5e1f1bc78so1032431oos.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5xDrgFACjOepC7RkZDvaYKNi9d553cufV3NPgiCK1R8=;
        b=tHbJVm08SRhZMU7ok0+pq1/SU6WE6mizmnoKgZa+GC24T7H1K/mfizbX7gpg/IYclC
         RqDZ4AbrsHSlrGmO2pT9YYOW4ln5IHeM7glE8aEc6eqd3OmXSkevlleItViBo6nV2TO5
         J2w0PNNhabDLbOtz1dx4fWDEm25x9vlWuLgY2b9OpOg7X6GJhbv96cxF2rfmQh97RwAq
         /+l/PgnfGCY8wZ1ik7QypY2BM7yf1LJsZfK0FrKPFtBN6+xeB5epK40YEIq1OXGYdKuj
         AcoS/XF1chB6FeZjBAwbW2HuJpRRNVGI2YC4D7j0I0IEig92+yvXiZoak4R4JQoOyd+l
         8xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5xDrgFACjOepC7RkZDvaYKNi9d553cufV3NPgiCK1R8=;
        b=L4WvKS2KSLxsh0QzqyKLTM2yNkSbs3xJmNrS6y2csLTG9Qch687ANLQCqklkqmFvS8
         vPj8IXI+Jb0BUsXBIVVCG1Gx5nuV+fHKDVxmDLBIFe74zKZu+XFJNhkaHtKiEDZw0w+p
         qzDT2pZEkGvlTFsK/WYyA/66b1y7yFXqP2MHwD391d7RZCgcaoNrF3FgcKi6/LsjfryH
         zeNfsWBEB+4DadQaGyWvPOLsMKvxUISIbnUlXfiYeCCP8f/hHwoEhsZEPmeGKz8wUcP0
         bG4YbVg3pygUNx83wsfvdawo87qHxTpBJAfjOP4dFfDanR0BMOpfz3opyvB3WqtuQbg9
         EXKA==
X-Gm-Message-State: AOAM533qRJ3MwpPoUyZAUllPE3l28QvqzRu6NJ9zW7zLWf2kdt/HKnYb
        g3LicdzSFI1t1YjF9YpxF1v0MkbkXmSD5x56VlKgjUCYUDZlNg==
X-Google-Smtp-Source: ABdhPJy7ZqBhajFc5YipXUfw+ZNGm2jm0zFKwnXqRd5WeyxZrUYZa2gIfDRwSbL/2mFIGhJoB4HBB7FoX/uMB6upnsQ=
X-Received: by 2002:a05:6820:16a5:: with SMTP id bc37mr7668796oob.5.1633539494259;
 Wed, 06 Oct 2021 09:58:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3f4a:0:0:0:0:0 with HTTP; Wed, 6 Oct 2021 09:58:13 -0700 (PDT)
X-Originating-IP: [98.45.152.168]
In-Reply-To: <CAGw6cBs8qf-GWYS-LtrCm+ye-=K_vu1WxDPOROnya_PVod=TGg@mail.gmail.com>
References: <20210509000103.11008-1-mforney@mforney.org> <CAGw6cBv2NBCDrZb7ZnmAhZOJ_EwgW6tR-8AfY2v=T9OkD=6O8g@mail.gmail.com>
 <YNmHRi+00RAAUmEt@hirez.programming.kicks-ass.net> <20210629171224.jhlqyyb3lus323o3@treble>
 <CAGw6cBs8qf-GWYS-LtrCm+ye-=K_vu1WxDPOROnya_PVod=TGg@mail.gmail.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Wed, 6 Oct 2021 09:58:13 -0700
Message-ID: <CAGw6cBtjGUzM+gDxGBgVuP1kwB=1qD7FOa7AMAUN3dp+yGZRhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] objtool: Check for gelf_update_rel[a] failures
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-28, Michael Forney <mforney@mforney.org> wrote:
> On 2021-06-29, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> Looks ok to me.  Let me run them through some testing.
>
> Just wanted to check: did the testing go well? I'd really like to see
> these patches in 5.15 if possible.

Ping again. Anything I can do to help this make 5.16?
