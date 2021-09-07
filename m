Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0F4402E36
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbhIGSNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245148AbhIGSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:13:41 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C8EC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 11:12:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s3so17951473ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPQ+nPkyctiSoFwjYHe+5+zlrPTqX7VHvSEjcWmKOqU=;
        b=IMcjfhvhnkuWBL6uN8LkHcuDiuYpvEWztGTZ/9xC+7AMWAesGHu+c4rL2RV3ZlrYsm
         8pqtiROpED/MITGIurNKLgLyJSxti0vQnUaIKth6teBZFx8R9hHmMjfEyYVNhocUDZOo
         Qi2CZ+mQqk6O+36YauxwGYF4LtBcgRaCk88okEgcqfRhq/20MFIaqvmnP45yNC00gzIx
         NIz00qc23/+N5Yq1vOs2dJVVgMPNSHJj4fjndKFupf+x4B8XQ7STaBvMgm+h1JPCtbeg
         mIHsxeQO0/MFLqLwuszsysjrICrvQEGY9ml1hMLErHJxGz003qjzopPanXCYAGioY4QT
         /rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPQ+nPkyctiSoFwjYHe+5+zlrPTqX7VHvSEjcWmKOqU=;
        b=gc6H2eR9EBfZ0z0wSOt86w4D8s12oKCVOyHEBLZEbambDwBmKOQYWRLz0HWfo152wa
         8cTTNZ8+CkLS6Bh3/3tS9oQ4SIy2aQ7t1acWwegBDCPhU+WSpbxVLNG+1uodXqM2A3M1
         ipKYin86ig0+o0WQjtrqJ+hKgvIU8KGijcPgHMA2Qcr4PjD8fbFNGsGrNtYYR7w9ut4r
         YbryQj6YNkT3+DNb1Dfm+PZ/ahdssI28bKPqJSQ70UhYpzXpr48mCMyTQ+Yhe2/+7e7v
         pwqy2t+CIUCE+hF25JiJdLaRP6P+YA9UnqzGM5L8IYBpQyihto9SDnUz+8mZEe+YBzAN
         FY7Q==
X-Gm-Message-State: AOAM531XJ4/syrxpBtVaSBiskj+1EqoBirvRavTV5fO8MbaPKrqD6eE3
        /RLoNXg3Ad4+JaFMGYxveMkRpnWNLI4S4e/dlbE=
X-Google-Smtp-Source: ABdhPJxj0iym9uah8XB56z0pqDOAWguqvVXa/WLkhjYxbkrLSWRCTbhBAHiUXNBIB67Z4s/bOmLnyAhAPafHUxvFYZA=
X-Received: by 2002:a2e:6c09:: with SMTP id h9mr15482853ljc.30.1631038352606;
 Tue, 07 Sep 2021 11:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210902172404.3517626-1-daeho43@gmail.com> <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
 <CACOAw_yovM592K3-2fQzA6M29XqWu8s_2f+zXawKo-QpNSXq0w@mail.gmail.com>
 <8f8e4695-4062-60c4-0f91-2a1f6a5b0a11@kernel.org> <CACOAw_yBYZzUVGV-A7K57zqrcAaZv7nFSk9mSj9AC6jTTeU7Vw@mail.gmail.com>
 <f64cb941-2bb7-eed2-732d-c9537f46f67c@kernel.org>
In-Reply-To: <f64cb941-2bb7-eed2-732d-c9537f46f67c@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 7 Sep 2021 11:12:21 -0700
Message-ID: <CACOAw_zxq=SX0OdXV77HyFytJc6aCMbYuS6KZAR_JoQeGZ26Sw@mail.gmail.com>
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

On Fri, Sep 3, 2021 at 11:45 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/9/4 12:40, Daeho Jeong wrote:
> >> As a per curseg field.
> >>
> >>> Maybe, we run into the same race condition issue you told before for
> >>> fragment_remained_chunk.
> >>> Could you clarify this more?
> >>
> >> e.g.
> >>
> >> F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_FIXED_BLK
> >> fragment_chunk_size = 384
> >> fragment_hole_size = 384
> >>
> >> When creating hole:
> >>
> >> - f2fs_allocate_data_block
> >>    - __refresh_next_blkoff
> >>      chunk locates in [0, 383] of current segment
> >>      seg->next_blkoff = 384
> >>      sbi->fragment_remained_chunk = 0
> >>      then we will reset sbi->fragment_remained_chunk to 384
> >>      and move seg->next_blkoff forward to 768 (384 + 384)
> >>    - __has_curseg_space() returns false
> >>    - allocate_segment() allocates new current segment
> >>
> >> So, for such case that hole may cross two segments, hole size may be truncated
> >> to left size of previous segment.
> >
> > First, sbi->fragment_remained_chunk should be seg->fragment_remained_chunk.
>
> Oh, correct.
>
> > I understand what you mean, so you mean we need to take the leftover
> > "hole" size over to the next segment?
> > In the example, the leftover hole size will be (384 - (512-384)). Do
> > you want to take this over to the next segment?
>
> Yes, the left 256 block-sized hole should be created before next chunk
> in next opened segment.
>

Chao,

Do you have any decent idea to pass the left hole size to the next
segment which will be allocated?

Thanks,

> Thanks,
>
> >
