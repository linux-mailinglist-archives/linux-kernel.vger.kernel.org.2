Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9C13F6D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 03:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhHYBda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 21:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbhHYBd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 21:33:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E66EC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 18:32:44 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q70so28541222ybg.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 18:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DooZUfswKHzF8AU/S6qWSrN/bFFsgcna1SIFXjsJJEg=;
        b=uxyyEw0fUbMCkvNC3wec542H+lvX3swlTIQLLENJRbUpRjJqitEJBG/KFXQ9/xNbwu
         7Nn2gE9Lgnz6p3FP7gPSv0tIOOXuStwN3sTyC4sUXs34Fuq8Pc0QIddlAb5H8xzZ0aaa
         /OLm4zo9uBkJPHP54bECeCT2cfGR+RYsTTVveEY/3148FI1Tf+CiSPnjI+Q5ERYvbhs+
         N5BDekNpuE5pgoOXZK9e4D0WW90OBnphi/9G6kazl5MhAWnlGABC3YC95313DfjW8utP
         Bv3BsiBSjw4TzPxqD8PUGXmeq25Ya0sjR4j6+39w1SXQNsc0HbStDyfhc6UB5GkUkJsn
         /NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DooZUfswKHzF8AU/S6qWSrN/bFFsgcna1SIFXjsJJEg=;
        b=bFRw6HXSuLrrm71YVDm8i/gL+6ODAau91cfo9vmwQOQX2rS0T0qErvT2+cGgDbhzvL
         UQG4cDlSmRfZV8nKcnZLGYXlpNBEL8TX4sTBTjeJ7/Qe4zo8W+O8vJfNMY3VJpFAE1vp
         dpGprvyN4pwVSu4F0XDfnPdMhADIPZXG4Ne4cwHnoxkhT9k5Q+VwyAMtvUo3vt/YW2nF
         s9lx0jkf5ssqhoymODdHHr21xFX6DCl4DBLoZQJczaM3OWNpQTGdWx10lReYkEjpJveg
         X6o0IqdgIsE91CbaiUsW/gi4m1uVtA09QqXlFeyH3UMnEP33FyQYMFufKjxyYep7GWEb
         qdAw==
X-Gm-Message-State: AOAM531+mgVwUwlRHCc7J3IRqQIraGafv9yq57JwqhIoyjL0kQxRYPc5
        fRnFuw30EFJP02zuE2CXlgZFMGgJccLfTmX/ZYXBDg==
X-Google-Smtp-Source: ABdhPJw722xmr0qeMiaTP8R7yUGL7dZJ8a2XkTfEXvtNFzqy3/yP084uoAmTuR2Fmtarb48DK50uipQoUFJh1ZI5J5k=
X-Received: by 2002:a25:2286:: with SMTP id i128mr17939984ybi.172.1629855163549;
 Tue, 24 Aug 2021 18:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210823030143.29937-1-po-hsu.lin@canonical.com>
In-Reply-To: <20210823030143.29937-1-po-hsu.lin@canonical.com>
From:   Dylan Hatch <dylanbhatch@google.com>
Date:   Tue, 24 Aug 2021 18:32:32 -0700
Message-ID: <CADBMgpxckMvMfOSLwcReeNCpmWmk7EETdK_AMUBY37yhA+u5CA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Use kselftest skip code for skipped tests
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        hawk@kernel.org, kuba@kernel.org, davem@davemloft.net,
        kpsingh@kernel.org, john.fastabend@gmail.com, yhs@fb.com,
        songliubraving@fb.com, kafai@fb.com, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 8:12 PM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> There are several test cases in the bpf directory are still using
> exit 0 when they need to be skipped. Use kselftest framework skip
> code instead so it can help us to distinguish the return status.
>
> Criterion to filter out what should be fixed in bpf directory:
>   grep -r "exit 0" -B1 | grep -i skip
>
> This change might cause some false-positives if people are running
> these test scripts directly and only checking their return codes,
> which will change from 0 to 4. However I think the impact should be
> small as most of our scripts here are already using this skip code.
> And there will be no such issue if running them with the kselftest
> framework.
>
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Reviewed-By: Dylan Hatch <dylanbhatch@google.com>
