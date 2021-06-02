Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680AF397E9B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFBCPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhFBCPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:15:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF82C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 19:13:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso2569054pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tylmfxViZrbJw4R/4KjitwSP24dh3nFyN6PzzQ79jTg=;
        b=sgYSZAPMz9IqIjiiB3RP3qGplNq/yr8qhTK+3dLBRmqey2HlR4w4Lg8xuk2bfojtsd
         X3wQIwNoIwP/KCAfZhITag3gEVK87noKWRM1Ylp2oBpVM/2Ip8Wc55sVBVNddEKHWMez
         FmCi4dq8FHdmdUfkfSzmr8EUvC8DNAi6dE/l5gJewCf6OqnhKPti5XrjYHPEzqWFhWfO
         6HxE8cFn3jmZRxtO9ldbwe7AHYWP9OOierv2TXDAYj+9EBEo/ytAVfnrEzTwCoNbKu3q
         lDefk63pLoDrNNlg1sHD3r9CL3ZVXWWjubjeKMiFcvAB8HbgRjwOXaexzuEy1FYGo1BU
         HM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tylmfxViZrbJw4R/4KjitwSP24dh3nFyN6PzzQ79jTg=;
        b=UdLjey/9ampTgjM6BEwWL/3JU1/T3ESxs5bkOa36eo0q1KSZO5HkbndaSwWyxmmBgD
         Vgf9HuS8pgBsmaBcJGjslX0v2ysoPi/ws3FYQ13MfxLV7PTlQJ6UR7Xz9CBT4pqtWGz2
         gsPqN6yn7uhpWur5fuIh542UpaOXEfY/WClYweMQAXSCFeIU5GTivY1TvvV0wDw1DSEH
         9oE9OJkdvp/J3MgjtZUppzrOQNBH4MGX94cgsBzltlBQ5vVs2PEK06GWTvp5Bjjm5oS7
         HI14WgvokPj7YX8WRr0DfCs7/pmNXfloRfhEA6+BIwgkpQcnLgif9nIfmBRVERZPUevi
         +lRQ==
X-Gm-Message-State: AOAM532EqxMkBoebfKrEf0HGq1WTO+/pixPgIcV3G8QeZkQ8yFPe3dGy
        4PO87m3ptPDejTjZAE8UYd8ADw==
X-Google-Smtp-Source: ABdhPJwCHDApIipx3AzpCRD+1Hzhc6B29/zuXtHxVBQXRQXFA7F3teqXbRyId+xnD2tHXEXQELOlFQ==
X-Received: by 2002:a17:902:7684:b029:f4:b82b:b893 with SMTP id m4-20020a1709027684b02900f4b82bb893mr28203975pll.67.1622600030095;
        Tue, 01 Jun 2021 19:13:50 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a15sm14093213pfc.29.2021.06.01.19.13.48
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 19:13:49 -0700 (PDT)
Date:   Tue, 1 Jun 2021 19:13:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Ming Lin <mlin@kernel.org>, Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem
 read
In-Reply-To: <CAHk-=wip5urjbGkPsoATGRbFoXSf5bq1qMwNAWEz5OpeanE+DA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2106011911260.3353@eggly.anvils>
References: <1622589753-9206-1-git-send-email-mlin@kernel.org> <1622589753-9206-3-git-send-email-mlin@kernel.org> <CAHk-=wip5urjbGkPsoATGRbFoXSf5bq1qMwNAWEz5OpeanE+DA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021, Linus Torvalds wrote:

> This series passes my "looks fine, is simple and straightforward" test.

I'm sorry, but it also passes my "hack that we do not want in shmem.c"
test. I'll say more in response to the preceding mail.

Hugh

> 
> One nit:
> 
> On Tue, Jun 1, 2021 at 1:22 PM Ming Lin <mlin@kernel.org> wrote:
> >
> > +               error = vm_insert_page(vma, (unsigned long)vmf->address,
> > +                                       ZERO_PAGE(0));
> 
> On architectures where this matters - bad virtual caches - it would be
> better to use ZERO_PAGE(vmf->address).
> 
> It doesn't make a difference on any sane architecture, but it's the
> RightThing(tm) to do.
> 
>             Linus
> 
