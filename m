Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C4943703C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhJVC7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbhJVC7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:59:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCC6C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:57:06 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id br29so2200120lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQ7tR0Yp6rf1GJIW4s5NegDfNukJ5qAaGOcznVi/4fI=;
        b=h+Hl0emiqAK+B5ocs80eCdhcXRzi5YMDF968lXPzFxnEUEjZNCV6OZuT38DosVDCnX
         2kd2/6AfNusMc5xZkJ8N/9HOLbumhVHkRiVl+pTu0p8c76KiiCFvZP6csq8e5XzeKi6s
         NKzG9bxPFLEFUUM8MXoHHRBH58n0tfALyHZLNCEXPuZAdHp3IgWsrEtLaIcl/FQ/twrr
         hIQ2l5UiMMeYimNmh9FL25L+JI1EsizIDwRoXofARqjCqxBLfJa5U+iVP1afhGBSql/i
         LQLgTmVowuxTC7rnceq7K+q0QmfkhwHTbf/RdNNeDinD5gd8YVstgSuB3dBRn2olMQi3
         IFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQ7tR0Yp6rf1GJIW4s5NegDfNukJ5qAaGOcznVi/4fI=;
        b=c1R1AS//1UwvvSi6KAp82Qq8azLLD0p/GYz5QOftn3H3qaZdVpdA758SzqRub8hSta
         MvkacxyfzllB+F5eRzoDs4ODY4z944p7AT5RJCt8wjdaallg2xDI0lH6WhhOcic0pjYv
         LzyiFSRfztgeOslwsHUpw/rsxt4TI5OQKlyw2JcyvCyArw63b6wYs9RQNbozlwgmzes8
         0grZiUtkOuV2RHW6nGkAVb0WoJOxVqlRJNMApvY8bROH8+rCHdsW/cQ5fCT8R4PWDRXm
         NDOSXRllur4HQBmycUgwzBAIyLSYdg/vlZDeZG6ULb1Om1FDXW8cxMzcrbGLSMxwVQZs
         W1MQ==
X-Gm-Message-State: AOAM530TmHDzt9H6afp0CA6DppcI+Wv+DWPVCIR5VOGmnb1AmFacor29
        R4RzMk0yK/z6GJiRxmTsqwL8hEndfHUlz2VS/K8cmg==
X-Google-Smtp-Source: ABdhPJxJzM5FMhJLy7C24Ma1EhlhY+qm5a7Z6vGXJYXVhmcGsZqzKAOfVcJhFW3p0QRzG2qT+ZeBiOVY+pqKt+wQAQQ=
X-Received: by 2002:a05:6512:3191:: with SMTP id i17mr8670014lfe.485.1634871425112;
 Thu, 21 Oct 2021 19:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014850.22933-1-huangshuosheng@allwinnertech.com>
In-Reply-To: <20211022014850.22933-1-huangshuosheng@allwinnertech.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 21 Oct 2021 19:56:54 -0700
Message-ID: <CALAqxLXNMvaT3OU3Y-aYkH+KJA_g1QSOZNJHqvzt21WPy=6UJw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: heaps: init heaps in subsys_initcall
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 6:49 PM Shuosheng Huang
<huangshuosheng@allwinnertech.com> wrote:
>
> Some built-in modules will failed to use dma-buf heap to allocate
> memory if the heap drivers are too late to be initialized.
> To fix this issue, move initialization of dma-buf heap drivers in
> subsys_initcall() which is more earlier to be called.

Hey! Thanks so much for sending this out! I appreciate it!

So the change looks pretty straightforward to me, however, the
rationale for it is where we hit problems.

With the upstream kernel, there are not yet any modules that directly
allocate from dmabuf heaps. So in the context of the upstream kernel,
the reasoning doesn't make much sense.

Now, I know folks have their own drivers that want to allocate from
dmabuf heaps, but those haven't been submitted upstream yet.
So maybe can you submit those patches that need this along with this
change so it would make sense as part of a patch series? It would be
trivial to justify including this patch then.

thanks
-john
