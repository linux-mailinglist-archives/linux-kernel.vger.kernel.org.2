Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8BE38221C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 01:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhEPXqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 19:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbhEPXqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 19:46:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840A9C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 16:45:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z13so6144876lft.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 16:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zg7hQi4e0dmMw67bNaK0NhSpXsVNqynwe8FbhANAgyE=;
        b=NTGxUEbWNI9aFZC1eBJ+m8ZlVUpibiJe9a9Ua7uK226aH5bpHAzZRAOPIWzmggYSfh
         DVkADuIZsb7wfUz8niQDEYRKrUvrb+MK6aWxofyuU2LGJ8ZaqsfRQK6saBBLpcDFI7Tc
         331Abnoo14KwylIrLCa0n7OOWdopS9VGZhyuLYuIcMxLkXphcJZ/adeJFyTmQZJ5M+gH
         1HsEYzkz59ha5Hwmlun30Gpdh7NTxQbIa6KYbCDpCBVFWq0m6SUQVQDn9aDD2qfiFyyR
         ogdeaTDW9oOTE0Raj/L+JPVIyfLC2VZ8oNIxU0bDzdAC85tupFUiTmxd0GqycVKY7nW3
         ztAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zg7hQi4e0dmMw67bNaK0NhSpXsVNqynwe8FbhANAgyE=;
        b=aYre3K5u8vT7FzZFGODardfO8pA70Ji31mTEEIyWSNqdRuSpzKddohGRGqIV5Iv3u+
         o525y3WEhXF5Igwx483hZP334jyRTMhBpijSiVZ//qJEdDtx8dWh6DdUXrjV+cTOz6oy
         JlmGGj75yfIFNarx+vbDjtERNS5Zxg1xpFHYgswhEqHpf3mZkmj2NuEJNHjZjX+0OB42
         9OimHbYFSMRm0sOqmSicx8m8Rowa1V6j1XLaXq+MM4v+sgBrPusztmkV9MAqytSG+Kzy
         ztLzvB+UmSE7TgI1bTOXK9kQBcxuxYfB/vXY2Vqf3yWjDm4ACBcjICSiT+Hfuw5/jkg5
         gihg==
X-Gm-Message-State: AOAM533U2L98ldhQahq2EoXznyHL4vZzhcx6MleOFoAgyODKc+1FJIi/
        /nhjuKBP/Z+hStCPVqcHf5u1SiFC+cSarvGsKTNYYbj2VEA=
X-Google-Smtp-Source: ABdhPJy44b/9XGxD5SVS9/3cqPNzdb1OHTk8jgqk239PYt2BFtdT6ZlU0xcpvsCF5wK9pEMlt7CoeSLoNczNdhQy/XY=
X-Received: by 2002:ac2:5a4f:: with SMTP id r15mr579079lfn.619.1621208718915;
 Sun, 16 May 2021 16:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210515180817.1751084-1-trix@redhat.com>
In-Reply-To: <20210515180817.1751084-1-trix@redhat.com>
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
Date:   Mon, 17 May 2021 08:45:09 +0900
Message-ID: <CAEcHRTr5TSEPX8Pigbx2O4n8rA8gO0JosDZvX9dhRh4fhi7-ig@mail.gmail.com>
Subject: Re: [PATCH] percpu: initialize best_upa variable
To:     trix@redhat.com
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 3:08 AM <trix@redhat.com> wrote:

> Static analysis reports this problem
> percpu.c:2945:6: warning: Assigned value is garbage or undefined
>         upa = best_upa;
>             ^ ~~~~~~~~
> best_upa may not be set, so initialize it.

Hi,

Actually, best_upa is always set in the for loop below. when upa is 1,
It will always satisfy all conditions.

> diff --git a/mm/percpu.c b/mm/percpu.c
> index a257c3efdf18b..6578b706fae81 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2916,6 +2916,7 @@ static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
>          * Related to atom_size, which could be much larger than the unit_size.
>          */
>         last_allocs = INT_MAX;
> +       best_upa = max_upa;
>         for (upa = max_upa; upa; upa--) {
>                 int allocs = 0, wasted = 0;

It doesn't seem to be a problem. But, how about this?

best_upa = 1;
for (upa = max_upa; upa>1; upa--)
