Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBB63112FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhBETTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 14:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhBETR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 14:17:28 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443DFC061788
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 12:57:52 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id f19so9390447ljn.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 12:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UUDqQnCKLG8KlWlCervJ1Pe6jRg7p+GmbjcM8bmlEX4=;
        b=hTuP4Xe0dt/q3oqh3WxdK8WGoQT5bwOWppy5lDWL0FJ79OTi34QaAq8VYfekwNprHi
         EDjGv5SLiNbttTG655zTOIlrIIHFuaJSq9aH08B5xUiltpXV8YGSBlyoE46ETKttc7CU
         NsDx4vC4wV2WJ3/kUgTEuUHNC7jKOvtRUgyuTeA1OotbHdC2YE2xg/2X9A1hhKDya3nc
         ByKBhpokGuNoQKZ6EhdpW9y+mODbabMBJ0VYWswu1rVFb+wDlJFxApcm7nH6lLmA+bwE
         EOLx0jc0appDILj7MhFkuYQPHEBqKMJuKlR5Ii6rQA+pK8PEyTmH+0Vg3n7BT/uVVuqg
         rg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UUDqQnCKLG8KlWlCervJ1Pe6jRg7p+GmbjcM8bmlEX4=;
        b=VKGqwzChtxMRIAYYXmx2tbfP/mdxAK4y6Tu9OCz0BE/GwDiluco8C1t2za+HQu2pA1
         yY9Em3Nv4gpIt4q6fQaESUCrF1sw2CF+2/38VFZq0oWldio1EYMNxZAMaJfTjP50nWCW
         FiMRssI7dDLEwn7hkXuKC4UlPs0DanEF6LJvjshMga/+6jlMDUvT49688gR5Hy00d+I9
         uAMrOcCbp7ibQy4psqLvyzRJ87+XVniYSUS+DZZT4pvNPK4xAhvhw1Tj4lddXqMFf3WB
         U46veTYnm+0xrcZf4wwpykizdZmdKp3oGqGTbUPlDlMZaqqatH59xXQaGKr+ZU/k+q+c
         E54g==
X-Gm-Message-State: AOAM530176WfIXVd1qFc6RAukBCK2h8JzFbU5puh9HJ81VBK/bIHUZCI
        Kvar4+g0x/M697r0Bf610mMeLih6AmbvWfoGbJdwdw==
X-Google-Smtp-Source: ABdhPJxLRfs8FH8bDIRywnbs42yMG9zKgx3Ds5nJMGF16QcPzaNxGXYCaRQqdYXCd6YTt9yxw5HXYLW3omFCA4RPLzI=
X-Received: by 2002:a2e:3018:: with SMTP id w24mr3858868ljw.333.1612558670803;
 Fri, 05 Feb 2021 12:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20210205080621.3102035-1-john.stultz@linaro.org> <0864e2a8-3a44-e7db-828f-abdac7c64471@amd.com>
In-Reply-To: <0864e2a8-3a44-e7db-828f-abdac7c64471@amd.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 5 Feb 2021 12:57:38 -0800
Message-ID: <CALAqxLXfK0eYGXDqsyfvMUzu6dxOb56WOe07ZsTayi3j1bT51g@mail.gmail.com>
Subject: Re: [RFC][PATCH v6 0/7] Generic page pool & deferred freeing for
 system dmabuf heap
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 2:36 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
> Am 05.02.21 um 09:06 schrieb John Stultz:
> > Input would be greatly appreciated. Testing as well, as I don't
> > have any development hardware that utilizes the ttm pool.
>
> We can easily do the testing and the general idea sounds solid to me.
>

Thanks so much again for the feedback!

> I see three major things we need to clean up here.
> 1. The licensing, you are moving from BSD/MIT to GPL2.

Yea, this may be sticky, as it's not just code re-used from one dual
licensed file, but combination of GPL2 work, so advice here would be
appreciated.

> 2. Don't add any new overhead to the TTM pool, especially allocating a
> private object per page is a no-go.

This will need some more series rework to solve. I've got some ideas,
but we'll see if they work.

> 3. What are you doing with the reclaim stuff and why?

As I mentioned, it's a holdover from earlier code, and I'm happy to
drop it and defer to other accounting/stats discussions that are
ongoing.

> 4. Keeping the documentation would be nice to have.

True. I didn't spend much time with documentation, as I worried folks
may have disagreed with the whole approach. I'll work to improve it
for the next go around.

Thanks so much again for the review and feedback! I really appreciate
your time here.
-john
