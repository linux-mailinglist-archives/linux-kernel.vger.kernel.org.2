Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F0404340
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349542AbhIIBwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbhIIBwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:52:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C76C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 18:51:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k4so400073lfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/u0EQaKDQGGDkd+ule3FKZo2WhlafSzo8pbgpEMLBBM=;
        b=rdzoIDe5svCt+YT1ll+LbtbxJGCzHYSqt6n6QaYkXBU7FZYipT40dV2Or/f6ZQbY1e
         yUVKVCx//Ey2iZbDJ+qnlHLrJA4BJ1pm4npRiIEDvkJBAsQPNYma5U6GEps+6KZvUPi1
         DKiid8eHmgzPmos9cGFTHoJvfKFWcVBjCAtYSUGx1EY2vVh8WgLbhDa5XJ2ywIxoweRm
         mz1Zx7m1PYyfPchJQmg8KCDGhNNcb7cRCffc0ltc768ejnh5+b/EaGOwrsRDarzqXru7
         NVFPxQ7DydMZVBcVCoDvtikqZifsGPnHEdBTsG70iAds+6x5epLXSfzddH1rmw9Jaa3N
         7uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/u0EQaKDQGGDkd+ule3FKZo2WhlafSzo8pbgpEMLBBM=;
        b=1rIBioXvA7mC3FC4TGL+xzEWicFiEUP5bMBsUSVBKSmpohJ/zOOMYAWqezZPCf2fmX
         vORurshoUVUIm1AQQOdwn6WOAB7EUM9+/ivag60KM44o9oE+heCAEJqsNFWg3clG1OkC
         IT+PYZV5jlo5WZ/WqkFbSZDFQWwez9ufq+fv3XEgbZyoJVBMrCZfvAzV8kQBiTIkmRB7
         biq5EZI3J33HCGKVu+YeWXJx+Os96FDxpOmr5PmOKhvOQFLOlYThL/EdCfQ9nfwHwT3C
         OnwNYqXC+JuQoE9pYziIKBRfmPPaEbkskUb+qaGN3c2E6EG7p8pONJDzx1jEoOUgP0E8
         xjHg==
X-Gm-Message-State: AOAM533iBa3/guzDy80kIOldDNL9y4MHaKEsVMK9nCImIhHa9qnFZ9RQ
        t7mI0KLXBHXV8SOo5UHS2DVf7Asu1VH9WusCecvvP0v5xBE=
X-Google-Smtp-Source: ABdhPJwmqRE4rU/XiAoCjR+EetKlmt0IfeKMIuqN3wfOvpxU9Ufg6gggcs4airLhtYt89WyfRNE6KgtAFGDexKcts8U=
X-Received: by 2002:a05:6512:b20:: with SMTP id w32mr451697lfu.315.1631152271734;
 Wed, 08 Sep 2021 18:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com> <1631147036-13597-2-git-send-email-prakash.sangappa@oracle.com>
In-Reply-To: <1631147036-13597-2-git-send-email-prakash.sangappa@oracle.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 9 Sep 2021 03:50:45 +0200
Message-ID: <CAG48ez1isvC9c8aem1m6n2uPPHzG4H-otDW7yEUJXDktf=q0Ag@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 1/3] Introduce per thread user-kernel shared structure
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mingo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 2:16 AM Prakash Sangappa
<prakash.sangappa@oracle.com> wrote:
> A structure per thread is allocated from a page that is shared mapped
> between user space and kernel as means for faster communication. This will
> facilitate sharing information, Ex: per thread stats shared between kernel
> and user space, that can be read by applications without the need for
> making frequent system calls in latency sensitive code path.
[...]
> +               /* Try to map as high as possible, this is only a hint. */
> +               pg->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
> +                                       PAGE_SIZE, 0, 0);

I don't have an opinion on the rest of this patch, but from a security
perspective, please don't map things at fixed addresses; let the mmap
code pick some random address that it wants to use. If an attacker
manages to overwrite some userspace pointer with chosen data, we don't
want them to know an address where they can be sure something is
mapped.
