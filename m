Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2385B307839
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhA1Og3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhA1OgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:36:25 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA58C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:35:44 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id q8so7845745lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HZ6vN2eEe9xlgJg6Acm1pXtbaRzCfTxTjwFlP4TFpU=;
        b=Dh6TtiOQldz7ctr2Vjc++l9sPFfbz1uIReK71LDhdAY7CMAfgSiOEAqExkoDQ4raee
         yiBKxu4aZyluG12epsDcVxU1V39k8CXSIeMG/3bOPvOWIoLFk8h0swTVl/glwTbkpjmk
         y56Bs8b22Ho+WA8dKqByZ9YpfuqOno7Df/De+xGLZEw6jy4cAjXsHChNzqt//SrwbPv/
         MFHIA7jAk/+jRjq2aXWCXav5v0/3LTauDbWHHZq5QthKDu2DlkOk0hEKjvSEHG23GPwW
         gggykyjVJ2IFuEciGMa8k0nx5G7Ug4zbvGdN9ksTDPu6JgRXIwl+ERrbHJbY6IRIJlWM
         IF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HZ6vN2eEe9xlgJg6Acm1pXtbaRzCfTxTjwFlP4TFpU=;
        b=mVUJl+pj0pRK2udLSU9RAmNaY9/JrhG7KNP7GxBwjLw69W834cv5aF4qZ443pB+T89
         /cLi7ViFdmD0xlJ1oe9Gx8mI2zwUhKjK+xPyMIyy4GbpXO0SKUk5u6rOBJEqYYWGLK6B
         wr2fAh31+bHU/jVLCYdmnCbZjK3KXuPA68acLB5tO4zcbx01Ts0fmHXW1uY5mVq5yt7H
         hsi938q6CqlLC/iq7is/dgSZkR0XvhPW2u5rk1DsMErejeSev4jB1WBfUozSOHVZem4H
         7ayXUywW5PW4bO9n9cSvOln0Kxe31xeymDZh2s5taUDH/ualXZvcgt+uQwnjFDCA5Auo
         t9JQ==
X-Gm-Message-State: AOAM530/nOC7xC/3Pxbgn/QLRukUd3gs1iaWDHx8zYY7m8EO77HxUP8H
        hB/GJoepp1NguvGp7cbRFY7GBOy/0IhQjYdbqsxm2g==
X-Google-Smtp-Source: ABdhPJwqwI0JXhluBVDgebMB/GJcLtoIuHaluDFZq7+Xj1RNJkY2OfC2kWQ4Clsu3GEZqQhCkC1nm3F37DJn50NMaO8=
X-Received: by 2002:ac2:5d51:: with SMTP id w17mr5544918lfd.343.1611844543382;
 Thu, 28 Jan 2021 06:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20210126204240.418297-1-hridya@google.com> <YBFXPbePURupbe+y@kroah.com>
 <CAO_48GHrpi9XxPhP2evwH_ZJmbVSWqxCvsYg6S2Syh-mrWBHzA@mail.gmail.com>
 <c0684400-c1e2-0ebd-ad09-cb7b24db5764@gmail.com> <CAO_48GGsOTLdqAQMO9vrLtWAKG6spByMC-GXwDv_f3ENvpemfA@mail.gmail.com>
 <Fu3J-fHQvkd_umZraMnhxQhFJR_JCDmgUssMBA4GJgRwo4UpIPKvVSh51Os9FQkABkhSL6tmEAV4vwBZa7hFWFTgujmjaBmrgqJJ75KM8ZU=@emersion.fr>
In-Reply-To: <Fu3J-fHQvkd_umZraMnhxQhFJR_JCDmgUssMBA4GJgRwo4UpIPKvVSh51Os9FQkABkhSL6tmEAV4vwBZa7hFWFTgujmjaBmrgqJJ75KM8ZU=@emersion.fr>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 28 Jan 2021 20:05:32 +0530
Message-ID: <CAO_48GEzi2b5M8Gv2E2L1s76VcPksA812ZqY1ihbpxkDkwb5_A@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3] dmabuf: Add the capability to expose
 DMA-BUF stats in sysfs
To:     Simon Ser <contact@emersion.fr>
Cc:     Christian Koenig <christian.koenig@amd.com>,
        Android Kernel Team <kernel-team@android.com>,
        kernel test robot <lkp@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        hyesoo.yu@samsung.com, Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Thu, 28 Jan 2021 at 20:01, Simon Ser <contact@emersion.fr> wrote:
>
> On Thursday, January 28th, 2021 at 1:03 PM, Sumit Semwal <sumit.semwal@linaro.org> wrote:
>
> > Since he didn't comment over Hridya's last clarification about the
> > tracepoints to track total GPU memory allocations being orthogonal to
> > this series, I assumed he agreed with it.
>
> IIRC he's away this week. (I don't remember when he comes back.)
>
> > Daniel, do you still have objections around adding this patch in?
>
> (Adding him explicitly in CC)
Thanks for doing this!

Best,
Sumit.
