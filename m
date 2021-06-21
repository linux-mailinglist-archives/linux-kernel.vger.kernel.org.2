Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7CF3AEAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFUOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFUOEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:04:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30F4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:02:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id n20so19108921edv.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpIxGlR3fPNuk0vQbtg5MYpb/zfRP+iuV/F0H7hG2gc=;
        b=IGiY8vpOnvIl++Bqc3unTTmqd/bvatfpNEL1UnPBI8/bjdsfSz1UO0j/Xg+qp/BAW5
         sD9sGWimiEqGGhHCTyFovCk/Rvgk8LD04fMRNc2U6iTCvOc0qLiot6A+g/W5vSchEbaS
         af93R8ur1IDvsTXDwd5u4Gjc/oTJSL0U0B1Es90m35+T6aICRIr44zKaognegA92e7K4
         0jXxWUyJqDQXTKF/h52CEd8ZIzPRdofW+bWHe9mLfqDeOhuNtXQvm0B953MFbe3sHEy0
         MqLHNHiXg/t/8UPxUkMszzFjt/7wjiyPfIpAeTslaTMaF2e9QJCkydBRv4V9S1vRF4P+
         H+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpIxGlR3fPNuk0vQbtg5MYpb/zfRP+iuV/F0H7hG2gc=;
        b=ITGtnViii0wUHi4Fm0DugIXXamM/2YdS64FwbqB7085nFkXbGVJnZkxlozs/8wQtV7
         uzsb331xQt3NdcZpId8zOlychIhaVkjBOlgT5k0xh0nmM/hPimljtOCJs4Vi7YHMsyqR
         5alYJ4RfnN6kHANJ110e+aThYzOAIf+I/V2X164Dwf3oKfnEteHYCGvxlsQh8s0YfG+x
         I76lDKqhoB9L2lF2waIz/rnwKSF+V+BLjEIDXoKKsOCPY5Y/7doDUPhJcu5f/QFWhpD6
         HakgEAzhsoYT0QFXx+lXoZRtCcSvNII6X/BZmog94kjOFecWfaTpraY1AaRqM+pji1Dk
         9vbQ==
X-Gm-Message-State: AOAM533dzbwKBEB4sX9ZhgF+O/no4YyWBA0ODJnxzODySCImBkzU73GD
        VmpOZFIsUwanOnC4hXcf6Vv+Z96wnQK9FIc7rpk=
X-Google-Smtp-Source: ABdhPJzTddfM+oN2NrOlwEmgJHcpqzRqYOSQYB76NSL/uIY5o8UUs/jc+Txgb3iekDv9INwyaASNg7S96cj67Kq9hE8=
X-Received: by 2002:aa7:c7c6:: with SMTP id o6mr5265257eds.228.1624284133308;
 Mon, 21 Jun 2021 07:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210621051152.305224-1-gshan@redhat.com>
In-Reply-To: <20210621051152.305224-1-gshan@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 21 Jun 2021 07:02:02 -0700
Message-ID: <CAKgT0Uf3UwhdFX93YrkiB8yk6v3syqUrdbu720ECqv1ak_H_FA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm/page_reporting: Make page reporting work on arm64
 with 64KB page size
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the question I would have is what is the use case for this? It
seems like you don't have to deal with the guest native page size
issues since you are willing to break up what would otherwise be THP
pages on the guest, and the fact that you are willing to go down to
2MB pages which happens to align with the host THP page size for x86
makes me wonder if that is actually the environment you are running
in.

Rather than having the guest control this it might make sense to look
at adding an interface so that the page_reporting_register function
and the page_reporting_dev_info struct could be used to report and
configure the minimum page size that the host can support for the page
reporting. With that the host could then guarantee that it isn't going
to hurt performance by splitting pages on the host and risk hurting
the virtualization performance.

Also you would benefit by looking into the callers of
page_reporting_register as there are more than just the virtio balloon
that are consuming it. Odds are HyperV won't care about an ARM64
architecture, but your change would essentially disable it outright
which is why I think this might be better to address via the consumers
of page reporting rather than trying to address it in page reporting
itself.

Thanks,

- Alex

On Sun, Jun 20, 2021 at 8:11 PM Gavin Shan <gshan@redhat.com> wrote:
>
> The page reporting threshold is currently equal to @pageblock_order, which
> is 13 and 512MB on arm64 with 64KB base page size selected. The page
> reporting won't be triggered if the freeing page can't come up with a free
> area like that huge. The condition is hard to be met, especially when the
> system memory becomes fragmented.
>
> This series intends to solve the issue by having page reporting threshold
> as 5 (2MB) on arm64 with 64KB base page size. The patches are organized as:
>
>    PATCH[1/3] introduces variable (@page_reporting_order) to replace original
>               macro (PAGE_REPORTING_MIN_ORDER). It's also exported so that it
>               can be adjusted at runtime.
>    PATCH[2/3] renames PAGE_REPORTING_MIN_ORDER with PAGE_REPORTING_ORDER and
>               allows architecture to specify its own version.
>    PATCH[3/3] defines PAGE_REPORTING_ORDER to 5, corresponding to 2MB in size,
>               on arm64 when 64KB base page size is selected. It's still same
>               as to @pageblock_order for other architectures and cases.
>
> Gavin Shan (3):
>   mm/page_reporting: Allow to set reporting order
>   mm/page_reporting: Allow architecture to select reporting order
>   arm64: mm: Specify smaller page reporting order
>
>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>  arch/arm64/include/asm/page.h                   | 13 +++++++++++++
>  mm/page_reporting.c                             |  8 ++++++--
>  mm/page_reporting.h                             | 10 +++++++---
>  4 files changed, 32 insertions(+), 5 deletions(-)
>
> --
> 2.23.0
>
