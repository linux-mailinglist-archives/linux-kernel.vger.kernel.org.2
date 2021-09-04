Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ABF4009D1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 06:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhIDEl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 00:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhIDEl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 00:41:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAD4C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 21:40:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s10so2290730lfr.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 21:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dP+j4JXyDo34ICC3JmPP8rPqOyI1cAd3JzgpaFIRD4I=;
        b=jExnvpX8lFUG+gFgfft7gQUua/drCkukHXU314B7Yaw5h0DOnJPIyq1vOlCo4wHgWH
         IkTMCVnUwZUOsT1VCqfmOfzryoXk52iYIModjiklCYFwhO5PofuenJPYnTOO6RTAFz/p
         oRbH1lqc3K7JNqoAEaycoK9ux2QIgeeo9htBfCn12P2pJ4+wIMJyywsbnXpJbqAtJ2T0
         BO6SG9vsDTU9GxRpc9MkMFfZMCyR9WDtsoaiwqutAbGbF6jGXtwywDt/jNp6yOQjmRAt
         bBN1K3f6pL3RyqdEWZYIwBEyl7IOeJj+3J5PScHpsrjpPiIv6TSfUN/yfx9I+FmsFOAz
         wtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dP+j4JXyDo34ICC3JmPP8rPqOyI1cAd3JzgpaFIRD4I=;
        b=SO2804KpCwQMG1Umcaqd1uTBivPCsj2UU9STXviZgZ2c8D75mbZDJWPVVZzeYWZCFD
         DL5Sx2kXFRnnD6EkXQO6O0WXIGs1GZrMoMoP7O3czmdZtVj47olhl5Q9m09d9Pqx/oI3
         BLCUMcBqP+dH08tJV1RXT2Nx4yiHNSFjyxBcze9/JgDgKwTJiem2AKBxQf4EfJaj0W7X
         jZ05lykJ9RAsW7kHBBhmqH1mK85FJ5aSJY9iEF3pDr54c3tfR18vO20Fka5uzCL6ngOH
         Hq5lSRfPl2dYsH5WnCpeeFd9hF6VIPvEYw/fDkN6bUuemDrHgDylv0M3psK0vsMxyqTu
         aTCw==
X-Gm-Message-State: AOAM531LyqTjLBDzBHDkWhiR6Av3CB8o1tq2Ht2EGnMAp22EbTXDzR3e
        q7UoBEBjy08qrVp81baeKunK9As0u7MZL1gp2i5xMI+lDas=
X-Google-Smtp-Source: ABdhPJxtE7a+pXHA9vv/DbRTQSMp2yIwkyjcLIa/2qvDD7Gt6Tv7i3FVAXf9SprNaomxYhPXYcEsQuyORGLdeKpzOjo=
X-Received: by 2002:a05:6512:1189:: with SMTP id g9mr1825764lfr.26.1630730424284;
 Fri, 03 Sep 2021 21:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210902172404.3517626-1-daeho43@gmail.com> <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
 <CACOAw_yovM592K3-2fQzA6M29XqWu8s_2f+zXawKo-QpNSXq0w@mail.gmail.com> <8f8e4695-4062-60c4-0f91-2a1f6a5b0a11@kernel.org>
In-Reply-To: <8f8e4695-4062-60c4-0f91-2a1f6a5b0a11@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 3 Sep 2021 21:40:13 -0700
Message-ID: <CACOAw_yBYZzUVGV-A7K57zqrcAaZv7nFSk9mSj9AC6jTTeU7Vw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As a per curseg field.
>
> > Maybe, we run into the same race condition issue you told before for
> > fragment_remained_chunk.
> > Could you clarify this more?
>
> e.g.
>
> F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_FIXED_BLK
> fragment_chunk_size = 384
> fragment_hole_size = 384
>
> When creating hole:
>
> - f2fs_allocate_data_block
>   - __refresh_next_blkoff
>     chunk locates in [0, 383] of current segment
>     seg->next_blkoff = 384
>     sbi->fragment_remained_chunk = 0
>     then we will reset sbi->fragment_remained_chunk to 384
>     and move seg->next_blkoff forward to 768 (384 + 384)
>   - __has_curseg_space() returns false
>   - allocate_segment() allocates new current segment
>
> So, for such case that hole may cross two segments, hole size may be truncated
> to left size of previous segment.

First, sbi->fragment_remained_chunk should be seg->fragment_remained_chunk.
I understand what you mean, so you mean we need to take the leftover
"hole" size over to the next segment?
In the example, the leftover hole size will be (384 - (512-384)). Do
you want to take this over to the next segment?
