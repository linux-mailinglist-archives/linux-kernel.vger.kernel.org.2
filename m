Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89193D0333
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhGTUDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 16:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbhGTTwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 15:52:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 13:32:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r11so27330891wro.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIWk5BKdHIXkOStxfUF7zNtVWR8PXbbd7J5me9z4RZE=;
        b=Vqe0E33hZAiq5rO4tkECZ2RNv4SKNV35O5vhgqgSxDZC2zxfsszv1ni6QOvhafBAhQ
         npz0nXmOzv9H6qCSMYJXeGZEaWGPxyVknU+Ny47YyxAYZRrIYYapnWghw5ZKdmU0hnPu
         b7JUrDsrufoQAj7OCdJj0NCdxT60hWuVXucLgrFpdeFYZAdbOflFD1AH5lG+ihDVZ85v
         Od9dE0Ad7ifBl7PAJR4qyidOPaixtVTZTw5d4zCBZUJcd/X8vj65605ytoN2zH9Dkth6
         YibwHVxdHRobRZrPKTNpK31Wr2qBW63WoJKhtQlgzcxHQDj1NfuDWADmODRDzqlIlHdc
         65wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIWk5BKdHIXkOStxfUF7zNtVWR8PXbbd7J5me9z4RZE=;
        b=iL1fW+lNRR35eCvFDjD28rxYANVjM7SuBtVD5O8RqWjNAvUYQkppUXx7i4NV479K4T
         pgDNMHOZuVLkB20fMgGHawF0f6XN6DnWsQvgWfkP6kJKh/WFiyRQjMQ5HPxx1OO7S076
         5CCjKltr0XXFuspTn50guDFXoO/7Vt5VxppGBXOD3YUlt13DTRysk8YHbcLbrJ3CXLAI
         e7XVmvpx5NUSzTo14zgZbcinkPQFLhXl4Zt0Iem/9gMEE7mGJnRTsPQs5m+1xK0BUojP
         /FIm6ej9Z6Jm5ASM67qcKGoofH8S4saF1X95aT9mxp336voe7qzn/spw0Pu8Y7M1SH0U
         sCog==
X-Gm-Message-State: AOAM5311akBoNFrUVjX4qbqwxJNKMKGWmNABTxdChLCkhFPIRUtwjXxq
        eSyCAnTV8RA9BpUsw8m8vX10wk3on/hWhNNyzEPv5g==
X-Google-Smtp-Source: ABdhPJzrhB5zVHMUs5Co+5EcZK8Y4nLQ9oRLi9EZKRUaMJmk/QBvPOmssls+DKWeTB4xv4TAXpAMHJQKtwP0WDQ9b4Y=
X-Received: by 2002:adf:ea8c:: with SMTP id s12mr39508206wrm.404.1626813166651;
 Tue, 20 Jul 2021 13:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <796cbb7-5a1c-1ba0-dde5-479aba8224f2@google.com> <20210720155150.497148-1-peterx@redhat.com>
In-Reply-To: <20210720155150.497148-1-peterx@redhat.com>
From:   Hugh Dickins <hughd@google.com>
Date:   Tue, 20 Jul 2021 13:32:19 -0700
Message-ID: <CANsGZ6aEW8pEncdoh_mGxKF-Se0_-O=E124EywULWvJ3qC0aVA@mail.gmail.com>
Subject: Re: [PATCH stable 5.13.y/5.12.y 0/2] mm/thp: Fix uffd-wp with fork();
 crash on pmd migration entry on fork
To:     Peter Xu <peterx@redhat.com>
Cc:     stable <stable@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>, Igor Raits <igor@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 8:52 AM Peter Xu <peterx@redhat.com> wrote:
>
> In summary: this series should be needed for 5.10/5.12/5.13. This is the
> 5.13.y/5.12.y backport of the series, and it should be able to be applied on
> both of the branches.  Patch 1 is a dependency of patch 2, while patch 2 should
> be the real fix.
>
> This series should be able to fix a rare race that mentioned in thread:
>
> https://lore.kernel.org/linux-mm/796cbb7-5a1c-1ba0-dde5-479aba8224f2@google.com/
>
> This fact wasn't discovered when the fix got proposed and merged, because the
> fix was originally about uffd-wp and its fork event.  However it turns out that
> the problematic commit b569a1760782f3d is also causing crashing on fork() of
> pmd migration entries which is even more severe than the original uffd-wp
> problem.
>
> Stable kernels at least on 5.12.y has the crash reproduced, and it's possible
> 5.13.y and 5.10.y could hit it due to having the problematic commit
> b569a1760782f3d but lacking of the uffd-wp fix patch (8f34f1eac382, which is
> also patch 2 of this series).
>
> The pmd entry crash problem was reported by Igor Raits <igor@gooddata.com> and
> debugged by Hugh Dickins <hughd@google.com>.
>
> Please review, thanks.

These two 5.13.y patches look just right to me, thank you Peter (and
5.12.19 announced EOL overnight, so nothing more wanted for that).

But these do just amount to asking stable@vger.kernel.org to
cherry-pick the two commits
5fc7a5f6fd04bc18f309d9f979b32ef7d1d0a997
8f34f1eac3820fc2722e5159acceb22545b30b0d

Hugh

(I'd usually reply with alpine rather than gmail, but I see extra
blank lines on these 0/2s that way; but the patches themselves are
good.)

>
> Peter Xu (2):
>   mm/thp: simplify copying of huge zero page pmd when fork
>   mm/userfaultfd: fix uffd-wp special cases for fork()
>
>  include/linux/huge_mm.h |  2 +-
>  include/linux/swapops.h |  2 ++
>  mm/huge_memory.c        | 36 +++++++++++++++++-------------------
>  mm/memory.c             | 25 +++++++++++++------------
>  4 files changed, 33 insertions(+), 32 deletions(-)
>
> --
> 2.31.1
>
>
