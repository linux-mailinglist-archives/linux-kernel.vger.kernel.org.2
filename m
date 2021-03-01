Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54B13281CF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbhCAPHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbhCAPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:06:10 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F85C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:05:30 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id b130so5126118qkc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CnYSa5BpoNmsrlE5xuLACW1oc/Ie+y9KsDztjUsE9K0=;
        b=zSpdZQrxlPGJCI8Gx0TWuxstB6h0vdCjUxSTz6lWHlvuKkK1r1DJ4aHhUWwfkFZ2z5
         PJ2yuzB4Qw/1hpNMNEWeFohhU8LgsDzqCntVwMrbkAayFavrwT8fOe+CPgkQyu4kigLi
         8COIFFzucuUy9ltCCy8HeeEhAQPEhwN0V0g9VEh2I354dD2vhdn+fArtlamHkfq61fmP
         EhgY5WQ5eukza4LcEBZiZ9/ZGyBakP0cs+SKc1pUYuyXmbX0EeogigftbyLsMTCaQoXU
         4sQV5JQ+OwfEvJYJTUXx50RtuNBM7WmiOCojak6nUSKdHVEKfTiG0G0ibFwPgIVHGKky
         B1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CnYSa5BpoNmsrlE5xuLACW1oc/Ie+y9KsDztjUsE9K0=;
        b=J8N+apfSuGDbtEG3cA7Fg1ruW9fWu7hQNQ1oNs/6xUwHs6nVjAgQEi/gjBGSdyYJC+
         aM2spuo4z2t0XsepFpg1gwzG23y1mxM3yhNGrTko/ZX/Gz1Bi4Kq+F/Bf7jNXcqIsIMc
         TeMjspimfaytrvHw6dk7lSz5ViuwhhEJvd7H8Z0IPcppMRKni3Xyf0iDo9UDkeOmY5mk
         Zv4SGb2T8YzMkx2AmfdmuSfU6xXiI7wBl+Qpuir0Z6zeCYIgVa8vaAPLjk9GI5ZybJmo
         djIoKkUsdUlNl44KlTxUMERB37+mOQHRw6CdvqLvoo7FA8CmtV+zMiUTDkTdU+yQYHgo
         /+nw==
X-Gm-Message-State: AOAM533y2joqCvS60KQ9I2fTmsjWl6BLDK2zq4WAwKDfR4Py5cJKuYCC
        9RbkBp2uBxbKsKK+uijGsySxJA==
X-Google-Smtp-Source: ABdhPJxsJiupemUjQ9FRN0qgybbahgtfZjr5CfKUvA1bm5Lt4GrwygyIbbUsK1rVE8jEXbgH0HQBvw==
X-Received: by 2002:a37:c92:: with SMTP id 140mr15135839qkm.177.1614611129387;
        Mon, 01 Mar 2021 07:05:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:c0b0])
        by smtp.gmail.com with ESMTPSA id 38sm11246382qtb.21.2021.03.01.07.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 07:05:28 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:05:27 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v8 PATCH 00/13] Make shrinker's nr_deferred memcg aware
Message-ID: <YD0Ct/tP4TSok0BI@cmpxchg.org>
References: <20210217001322.2226796-1-shy828301@gmail.com>
 <CAHbLzkrEfeoofwJjncFDepcOxEKzqiAo8T7mowX2jJVCz5ikEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrEfeoofwJjncFDepcOxEKzqiAo8T7mowX2jJVCz5ikEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yang,

On Thu, Feb 25, 2021 at 09:00:16AM -0800, Yang Shi wrote:
> Hi Andrew,
> 
> Just checking in whether this series is on your radar. The patch 1/13
> ~ patch 12/13 have been reviewed and acked. Vlastimil had had some
> comments on patch 13/13, I'm not sure if he is going to continue
> reviewing that one. I hope the last patch could get into the -mm tree
> along with the others so that it can get a broader test. What do you
> think about it?

The merge window for 5.12 is/has been open, which is when maintainers
are busy getting everything from the previous development cycle ready
to send upstream. Usually, only fixes but no new features are picked
up during that time. If you don't hear back, try resending in a week.

That reminds me, I also have patches I need to resend :)
