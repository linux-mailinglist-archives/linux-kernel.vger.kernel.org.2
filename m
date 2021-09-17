Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8870410056
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhIQUlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhIQUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:41:22 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A10C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:39:59 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id z12so7255622qvx.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tUDI15ViNGxSe7VU1t51m4wc6kYOj+/MYAHpzxNvJT0=;
        b=E/KErWIwnM+6MWgPyHorOC3+fhfdcfJG3NGaFBNUn7Lia1toRavuglV/tk5+7/7lp6
         Ydk/qsQec96jBMZeQ+jI03d5Ewvg/LUn5JW3eifM8SzY1XvKBANaO90rkBnaZBSGjz65
         oZl0DJhM/p6gKPuB7+wsRd7Qg3JiKFtciyZM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tUDI15ViNGxSe7VU1t51m4wc6kYOj+/MYAHpzxNvJT0=;
        b=CrPxKROd6aZN8wZ6pxHs7M/Vz3X2algL2R2z6l1PC66buNFyXUREzksrZ2NtiOtafW
         Ce5I1taEvgCEgn/cVtniEmRPu8itFBUn8YREM1K1KXBMSIaCZPRq7FCHKeHs2CnVammf
         QOOdKI+oW82hCxhVTNG61NIkrV7wtdRGEZ8MWf9K2VG7O7Xcd5fDjyQhiY11et1bzPbX
         21C5e8KqAlvM9UO4bJhZ4rx91c6RK+wDkRL1haESqSs4WQaMCUEmBnvGkVSdTBi+AuSL
         v8XUj46DTHqb7DXG2v4c+btt6PlvrMVXKr9/WQA9MAhXFMOf7pgGcBQW4Ka/ZTCFqet8
         qnJQ==
X-Gm-Message-State: AOAM533DRm+uZn6KzCsXLQIDYjfiS82IEt3hwEXL8uzaEV5+lqMMRr7i
        tsFbVhWIj7T+4MvoIsujulV5yJ8e6FxJfw==
X-Google-Smtp-Source: ABdhPJyWrZt9x43uNaFBEZURKZ0nDG0l1fdoFgtrNIZSPJbL7AY2NdlIGsPgcup6ElxTTotITObEiA==
X-Received: by 2002:a05:6214:1425:: with SMTP id o5mr13186732qvx.5.1631911198696;
        Fri, 17 Sep 2021 13:39:58 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id m6sm4731614qti.38.2021.09.17.13.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 13:39:58 -0700 (PDT)
Date:   Fri, 17 Sep 2021 16:39:57 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 30 years since the Linux 0.01 release
Message-ID: <20210917203957.kltk7n7qrvn4xrl6@meerkat.local>
References: <CAHk-=whOsdfVrXHRJir0gu4Y3-K+nDkk7jAAWg15xu0jfQ9hpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whOsdfVrXHRJir0gu4Y3-K+nDkk7jAAWg15xu0jfQ9hpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 01:02:58PM -0700, Linus Torvalds wrote:
> This is just a random note to let people know that today is actually
> one of the core 30-year anniversary dates: 0.01 was uploaded Sept 17,
> 1991.

Congratulations! Here's to 30 more years of Linux! :)

> Alas, the dates in that tar-file are for the last modification dates,
> not the actual creation of the tar-file, but it does seem to have
> happened around 7:30pm (Finnish time), so the exact anniversary was
> technically a couple of hours ago.

Those who want to see what 0.01 looked like can grab it from here:
https://mirrors.edge.kernel.org/pub/linux/kernel/Historic/linux-0.01.tar.gz

Congratulations again,
Konstantin
