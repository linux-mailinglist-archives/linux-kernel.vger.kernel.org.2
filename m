Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5445365016
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 04:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhDTCDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 22:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhDTCDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 22:03:44 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE93DC06138A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 19:03:13 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id g24so542172uak.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 19:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SRW6B2l3evCXSdkMXhtncIWNHnatMPLHmgfTJZssxJE=;
        b=OcZYWiYjOx2mIwK5CtdpMAlAd4IaEvEDFU0TPQO94DzoR647nXkgfjfC/jlmL8SlnU
         zcwivITDXmDFDv1ihS38tlefhBShQliYmUoAdp791CurT2byJ1krHuikbGQFz/oNWFhM
         YrxCa/5rz6FsCekyrcW3ZbHLdBOiOyV/bm2/JcwE9N4EuXCPy0XjcYbQB/w7lyeJJCWZ
         DGIZFHYy2iorq/PohzqJv5eUufvUxytdXBpCjAwS8zVLoGa5o1dJElJXLdmznC1cVo0Q
         4EZNTqPheEnb/xbstGSnjdjpOtHCwT62hUNuZ24p+Z35W1tyQ3gJ3CsprI4dIY1iM96f
         xsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SRW6B2l3evCXSdkMXhtncIWNHnatMPLHmgfTJZssxJE=;
        b=XirYZ+6J88EZh9WCM/Vo7rbDWNOAVCcSWWx2xesMuLhQHi1zGyW2WEsa4XyVxjmjUC
         sCJmxh5TRBA5TBP/2Y9ZVeJkJF4XNzXZWbFbr4szzkd8pMwSQAUQjuI9dZud8qj/O71h
         /CPMfB1Uul93CWjHNjmwSx9mcqMGqNCPFmoqEPBS5aU8XSnQxY627kduUxwy3KyTXfCE
         TzieBeuyUzRg1Dro2zginTO+z7pAiZ/F3jEUVekuy8N3VFJEPpk7v6K57otpGioIk6DG
         io2lk6shvF+XFLe4/iDVZtJTeMfJqPCnVtYoD5yNZKn7QtHSXVgSL/6+Mr86z61Qzb1g
         ftqQ==
X-Gm-Message-State: AOAM531b1vZx4a2ebJ3fIXVvz9AP0e321cJauIE0Jdnga9Ua95zMOPmV
        jM4T4WTBsBv85MXymJM1VvICf0qDO4G1nBUjZ/PfnA==
X-Google-Smtp-Source: ABdhPJwuRmWnDH0KhG10/fSZj/4TzlbSYwhk8Pz+wH6szF4U95OMogzAqlSvjL+IHQAO8+XobgnxG3QIm/nFOhMPGGU=
X-Received: by 2002:ab0:7216:: with SMTP id u22mr404027uao.83.1618884192864;
 Mon, 19 Apr 2021 19:03:12 -0700 (PDT)
MIME-Version: 1.0
From:   Jue Wang <juew@google.com>
Date:   Mon, 19 Apr 2021 19:03:01 -0700
Message-ID: <CAPcxDJ5gH9XvZ1bMsRqqU8bTpGLsz75+pWMnj52b-nMZHKhdtQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
To:     nao.horiguchi@gmail.com, "Luck, Tony" <tony.luck@intel.com>
Cc:     akpm@linux-foundation.org, bp@alien8.de, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        naoya.horiguchi@nec.com, osalvador@suse.de, yaoaili@kingsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 07:43:20 +0900, Naoya Horiguchi wrote:

> This patch suggests to do page table walk to find the error virtual
> address.  If we find multiple virtual addresses in walking, we now can't
> determine which one is correct, so we fall back to sending SIGBUS in
> kill_me_maybe() without error info as we do now.  This corner case needs
> to be solved in the future.

Instead of walking the page tables, I wonder what about the following idea:

When failing to get vaddr, memory_failure just ensures the mapping is removed
and an hwpoisoned swap pte is put in place; or the original page is flagged with
PG_HWPOISONED and kept in the radix tree (e.g., for SHMEM THP).

NOTE: no SIGBUS is sent to user space.

Then do_machine_check just returns to user space to resume execution, the
re-execution will result in a #PF and should land to the exact page fault
handling code that generates a SIGBUS with the precise vaddr info:

https://github.com/torvalds/linux/blob/7af08140979a6e7e12b78c93b8625c8d25b084e2/mm/memory.c#L3290
https://github.com/torvalds/linux/blob/7af08140979a6e7e12b78c93b8625c8d25b084e2/mm/memory.c#L3647

Thanks,
-Jue
