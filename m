Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A59D41D0A0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347367AbhI3Ai0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbhI3AiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:38:25 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDFAC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:36:43 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w19so9374712ybs.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2m4wTYkqfAEhAyNUuV6Q8DZUcckAKLYKf6ImK4uiq8=;
        b=ghVBCvPquoWEts3xJ7bN5dEsukBUk9jPfKIf8PHvNz7cc+rkkYrGhYcNzAF7AoYGTs
         bTHz4n5qKuy4EN0bMG/So4x30K8B/B8RhPi3xH1qpHxopuKczW/GQZdRMnqBow1NTD+2
         L2RBMh5hk+Hmu/n1wpMTM6KJrMJWZPp0Uyhuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2m4wTYkqfAEhAyNUuV6Q8DZUcckAKLYKf6ImK4uiq8=;
        b=kxlXeYv0I1dccuaSs7oJdVmWTa0fNZG3XRjCzu8Z42uEEFltmI7Jc1ihKmuuJ3CoKR
         WKbV8Y+LTZJTHSZvTlrsCBIZhpPq3CTIQ9FwI5rdxWOIkHmLqPCDgsrULXVtZiiW1FJu
         jvj823/CmRDyM5bR+SKc/XVI29VtWAX0hz/Yo7cfD2xwZ6NYksinpJbR0BDpF02JiLwZ
         fPUyd/ZLhGJgT9yEnVikVoZ6dNETVKlrUEflRVVr3imH4FqcgN+JBWRW3bvtD2gR/T4n
         6NF3IAz9YMONHFKMxtE+Us0ZgxbK1ot1/CGX37kVs1je10SNwBkftvJKS35X0GaK1Pl/
         BS9w==
X-Gm-Message-State: AOAM5337HkuGQbmVz9NqJKvUA51Nie+HKRW+3hQLnnaKzV56ETEbOJl7
        143epIyT51W63Eqv8YMzL3hrL0wKdOOoZNb0J0uGzQ==
X-Google-Smtp-Source: ABdhPJznCK1TcaJ2m1s/SvhUqd/Ojpr+AV8TBGoPuQSyyTXZr4Nts/uCljWIvIeL46o6a+EhgDfRxNdf1hd5krrVdk8=
X-Received: by 2002:a05:6902:1547:: with SMTP id r7mr3495128ybu.72.1632962202554;
 Wed, 29 Sep 2021 17:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210930083201.16636e24@canb.auug.org.au>
In-Reply-To: <20210930083201.16636e24@canb.auug.org.au>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 30 Sep 2021 09:36:32 +0900
Message-ID: <CAD=HUj5XF9eNj+1oZZq6CcHfe-ii+M3z97BNPkSY9qW2BHaJbQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tags need some work in the iommu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 7:32 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commits
>
>   06e620345d54 ("iommu/dma: Fix arch_sync_dma for map")
>   08ae5d4a1ae9 ("iommu/dma: Fix sync_sg with swiotlb")

It looks like the Fixes messages got rewritten along with the tags in
the subject lines.

-David

> Fixes tag
>
>   Fixes: 82612d66d51d ("iommu: Allow the iommu/dma api to use bounce buffers")
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'
>
> --
> Cheers,
> Stephen Rothwell
