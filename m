Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F227413591
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhIUOsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhIUOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:47:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6C0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:45:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v22so70456834edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UQshi3eC1CKDj9DpZic1/oFHuAGOMwFKYcnq7T63EM=;
        b=OG5vn4UI5RWsGMr1kSBoNDGRlRw2LXTlKq1DIf6AmZWN+iVXzm/Zsh6yK8A8TzdWlU
         eun6yrJyMN2FIzGmOwTJ+YDEc6+8+5mHRCYi0FRDW68A3fFoSCuausFEcdkOstSog478
         OciPCf84A316/tJS3mVuouFRQzqoWKtOtWpoGXwwkz/xJ6ZNkyDZvsB+XN8GkdE1tW+B
         dy1J/+uwBYgz0bvk/EkLDZkHaNOylom1ZzYHydImFgppnlFYiZTfgdsotWRKI4OwEs3/
         33WfNod4J1xK3YyTysiBNEIFuObRT0TfbkuGbREhsr1XR/lWIGap1X18RvqenhSOvevj
         xzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UQshi3eC1CKDj9DpZic1/oFHuAGOMwFKYcnq7T63EM=;
        b=xr4bRY+0E4IFX+JL+/NFjTtJfFUd6WapawakAIi6SsDFhS7//xoI0z7nHRlLMxeGG9
         gjdl+Qhlz7oUmI9IcX+pGqTo/AjCPyaYDAFfi8sRN3waL9kTQx1q0f/AnZtRzb8hr1qR
         FY4LlEkK5s0Kcxd8enofo0dVt12knkWUhM5oQcfK6105ijoCrRFhh7YotVi+LvoMaFtI
         GjE+oiw+bGCw+AoJQdTqHwJ4YNbwHxbOdhDTA4aWNm5HLM70tyfIwkWpympXUiz4xusE
         QqMijIONh46oufHKHn7v2BNKr9tk+7n/QMLIZ65wJWu5oKayqoE6VPaNDBmkL1CBopMi
         4sKg==
X-Gm-Message-State: AOAM531PQvi7yYo5moDN+B0se8zxY4PTmDZ/IFiIQ0LoQvdSXUPFm1Sa
        chFhduJRJfAKS3pue2cvOExqBVukwW++wQaQuGiDsy45IA==
X-Google-Smtp-Source: ABdhPJy9s3S5skeCDh7vuYtu4bb3p3FjHSjnXBc6dLAhH2npPXxat6uok6Ikcn1ihgxmvttcAijBDQf3pwZyJ4FMb3I=
X-Received: by 2002:a05:6402:3587:: with SMTP id y7mr35691132edc.362.1632235394068;
 Tue, 21 Sep 2021 07:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210921111750.6f7bd218@canb.auug.org.au>
In-Reply-To: <20210921111750.6f7bd218@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Sep 2021 10:43:04 -0400
Message-ID: <CAHC9VhTFp6uj+bBhiEhvd2v346qOLx-t0bs=mv==8rCY5Zq+jg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 9:17 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the selinux tree got a conflict in:
>
>   fs/io-wq.c
>
> between commit:
>
>   dd47c104533d ("io-wq: provide IO_WQ_* constants for IORING_REGISTER_IOWQ_MAX_WORKERS arg items")
>
> from Linus' tree and commit:
>
>   5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
>
> from the selinux tree.

Thanks Stephen.

I noticed the same thing while doing some additional testing yesterday
and applied a very similar patch to my testing kernel.  I'll be sure
to mention this to Linus when I send this up during the next merge
window.

-- 
paul moore
www.paul-moore.com
