Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50593307C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhA1RRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhA1RPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:15:02 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96831C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:14:46 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id s18so7249987ljg.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jP5+AXxY87glZREeLAva697y16ZgEKsRQdrGKC7/24=;
        b=IzlIONI5ZD7sazxanJ7imKPu5j46GJZbzYiCdDH44cawOwKT7+MdIqBtfRSeHC0Fl7
         DJFru1FDRkDE+8ZsWTttKWAENGh8/+SsHsS0NvWQh4RJyEoPcVosX0NBSaWBdfe9HCUK
         eY+J5EOAv1KdST2NPvSmgzXDmoCaJiw45vbYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jP5+AXxY87glZREeLAva697y16ZgEKsRQdrGKC7/24=;
        b=LWqWS2XQmfHIX/Rr7H3yJuIsOMQ2EiikgZr1GJpGbSdQyEKossZMOf1AT/sz14S8f7
         RyPqMq9uwH2uxjY4/Ox5/7KRGhxRoYHzA/ovbCgZ68lZMdfNYNhv4F5Y+2Mx/69zpLq+
         LLvy4EcRK+HePftSO4hg7R7JA5Cke0EYJlPa6TebpgT7VdFQ4nViQxlj94eGgsXfTQ3B
         gJHH7dwPJdru6bwzGcUikG8pZfqC/gx2UmSv8tuCWX7FS3pTD9TW53WbcfrxOHwBzFyP
         WpRlsNho3twThrMJtot2dVbdQqi+HOhGkG3Gp8FMN+2k24GExM2lQwjwXBkLwVzR2gRt
         2SkA==
X-Gm-Message-State: AOAM532PeogbVlmHI6Bq60ZHAd0LNmueKkKnpc2U0/7/P9rHXITp/C2+
        jUAjMQOPAXZTAcCPv0BoTNL/d5q7HBJ6IQ==
X-Google-Smtp-Source: ABdhPJxbQlWNAi+QWTYUk71Qty21N+0zaLP12cljFk6h6LXHCwNF/pkkfSudR6PsmvZELn1GHrihyA==
X-Received: by 2002:a2e:b4c9:: with SMTP id r9mr162655ljm.100.1611854084661;
        Thu, 28 Jan 2021 09:14:44 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id e7sm2204378ljo.74.2021.01.28.09.14.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 09:14:43 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id u25so8596696lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:14:43 -0800 (PST)
X-Received: by 2002:a19:c14c:: with SMTP id r73mr34684lff.201.1611854082655;
 Thu, 28 Jan 2021 09:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20210127235347.1402-1-will@kernel.org>
In-Reply-To: <20210127235347.1402-1-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jan 2021 09:14:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibdV-nJxf77npZU8DadAMups90jAjPPAnV4Jnsemn7iQ@mail.gmail.com>
Message-ID: <CAHk-=wibdV-nJxf77npZU8DadAMups90jAjPPAnV4Jnsemn7iQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] tlb: Fix (soft-)dirty bit management & clean up API
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux-MM <linux-mm@kvack.org>, Yu Zhao <yuzhao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mohamed Alzayat <alzayat@mpi-sws.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 3:54 PM Will Deacon <will@kernel.org> wrote:
>
> The objective is to fix the lacklustre TLB invalidation on the clear_refs
> path and then augment the mmu_gather API to make it more difficult to
> abuse.

The series continues to look good to me.

I don't love our "tlb_flush_pending" hackery, but it is what it is,
and at least this series cleans up the proper flushing interfaces.

           Linus
