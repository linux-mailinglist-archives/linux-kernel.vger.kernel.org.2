Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0141684A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 01:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbhIWXCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 19:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbhIWXCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 19:02:13 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94791C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 16:00:41 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id s16so1728331ybe.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 16:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNi4Bos8lh7sJkc+jDcM0nJh0Q/L0O1bHURQWGbTkX4=;
        b=BSc1fqu6/Z/Rv3MnwMMeXb/jTCrjhoOWWYoqBAGDKtIkwZf5Ohw+67BmYf7iyGtKLw
         FGPyN7RfyoVb/tO3VZUYC67xDFTbdn2SvyUwiirIGqrO3ztPpmYSJ+QQoBVJAhPXsQzH
         JIgFfev54CDOz7nVU0ko5gEDaIniTuNVSzBdP3SUiz4wrhztbFrvVI617a+Qg7Q7GU2Y
         PxqWZ/Y4REdyQy8jB1fGjgCHPwZQe+RvBts8vdqPb14T84tyq1AgoglerVejtYa/hSrx
         TknyI/LcvKRi1Qa0viPfnd3bH164YUcPly4CFCQw61l9fehNp4BxbaO2AD8T1AQlkEkJ
         ygAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNi4Bos8lh7sJkc+jDcM0nJh0Q/L0O1bHURQWGbTkX4=;
        b=R455n0SnYrSNLmaaaI9qsADcqri5k/MBofBxwpBNweePgKd7873+RZfQWXuvYXGHe8
         /LwvV+uBqfbw9hjDtyeov6QSiIrgbOtaPyv1gfahXtwz4rdUEHK1pPsgICzxjIdvGQal
         z3nJqodcJ8KyLEyFyX4f8rCpccISWmGnBeIVjfUhPKHK/aTqjQVV7jaeU8Xl02Um02Jn
         6e4KlmxDq32kXocVTTupWppO3+C1egv5/+nQNipulLE+ylhPVL61cIeIbWPLZ3BunUQd
         Fosex47xoEaLAUi7dHcaYhO/9X8hZQTrSwx5bQTybGO8Hmb9Hhf+ZIyQtW4FbWOzHvgi
         /74Q==
X-Gm-Message-State: AOAM532QqUCIVtgIq3sCWekpJCf8MO3PDaOjL5BNTxKdtW5nWfGMpnJh
        PeiXGy1Eluqa7q7t78nezKfOg9bgOWu+Tas0OCO5V0xhvv0=
X-Google-Smtp-Source: ABdhPJzVucE3eg4ogr+EckrLlTAcmioko3LFLfBIUNJScv90rQfbKQAJbN/ec8tKzwtaa08Bv8HD0UYl2BesVajSqx8=
X-Received: by 2002:a25:bb52:: with SMTP id b18mr9308175ybk.506.1632438040561;
 Thu, 23 Sep 2021 16:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <23aeacb6-0cd9-d10f-76bc-3c9d33905daa@amd.com> <ca132183-e778-4a86-c81e-4d292e9d41a7@amd.com>
 <YUzl7qywbtVHipUT@casper.infradead.org>
In-Reply-To: <YUzl7qywbtVHipUT@casper.infradead.org>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Fri, 24 Sep 2021 00:00:29 +0100
Message-ID: <CAPj87rNqCuSvSZLuF=ULCXRpbDBQC+XAA+_Awa__4dvRkckamw@mail.gmail.com>
Subject: Re: BoF at LPC: Documenting the Heterogeneous Memory Model Architecture
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        Linux MM <linux-mm@kvack.org>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Phillips, Daniel" <Daniel.Phillips@amd.com>,
        "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 23 Sept 2021 at 21:40, Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Sep 23, 2021 at 04:25:08PM -0400, Felix Kuehling wrote:
> > Change of plan: Instead of a BoF, this is now a session in the "GPU/media/AI
> > buffer management and interop MC" micro conference. Thank you Daniel Stone
> > for making that happen.
> > https://linuxplumbersconf.org/event/11/contributions/1112/
> >
> > It is scheduled for tomorrow (Friday) 08:40-10:00 Pacific, 11:40-13:00
> > Eastern, 15:40-17:00 UTC.
>
> That's up against:
>
>  Direct map management
> Vlastimil Babka, Mike Rapoport, Rick Edgecombe  11:30-12:15.
>
> Seems like a lot of the same people would want to be in both sessions.
> Maybe one could be moved?

Good point, and thanks, but it's hard to keep the longer slot whilst
moving it later; I wonder if we could move direct map management to
the final slot?

Cheers,
Daniel
