Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE6C406DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhIJOf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 10:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhIJOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 10:35:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE03C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 07:34:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m4so3530499ljq.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 07:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ojA9ujletv5QxfO9Te+K34PRpc/+f6NKN+aRBBnpz4=;
        b=OvOsA4iL/y6czweDJab/Mb2HHqt31KkhfdQKe8vwqLrdrBAReJpvyiczPL56F6BHPB
         QJN7Kiz+VxVTm8YCssJwhTeY+ei1JZUD/bWzun9dYtRCw+no7fM8XndKBt0ORAK1808h
         dpB3hIcGcA9MObPc/nyj4EbbOBLCrC1cRy10tvTrH2llR+DQ/Hu8yHjBIUQjzV7F1lVP
         BSdi5kXf8fwxDvQsj1AczF/DmOktL0dDLuACIhs3bDEvOiQDezqpCrU48tiOAmce++WV
         hzo2f4Gs6PU61xXEAsJtCOKsaRss0/W27o25zQ9ZGxgDanG3Xq/T5U50WdvS70MfPXC4
         DT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ojA9ujletv5QxfO9Te+K34PRpc/+f6NKN+aRBBnpz4=;
        b=VUNag/haiRa2dwBGQ1mH9zp8s4HN9pRJyZcwP/3YCWiN1HYZHVY6JlyZ0+EP4NqxsF
         0wfJsgwtyyGHnahienf1/sP9aNJkZLBBXYXe291pXXAka1XOXDQsDwwEgEss/IcZ0/c/
         L2A3BfGX8yAJw33arQRRt4NAPRiT6HHB1WUb1T3j+UmnLj4O5KsAbhfSNf+EdVjMExau
         xZDx/a69KxIXXjVsnoYTL94osJ0rs6Abync08G55n8HK4IIfu9kySG023j5wRPXFuST9
         ia1/2po0uOn5Slpu37QaPmMNyuj7NZmok9zs/ZXgEi9hlj/liyjXg1OF3WD+o77C3IEh
         w4iw==
X-Gm-Message-State: AOAM532vlvOtZvzRbWEb+HPAu7Lpv70kdeWoK4faV8f3CGKLu32fyddR
        05R+l89Z5xovIfexrWxP4KpVX/bw8SkKpWBfVJ0=
X-Google-Smtp-Source: ABdhPJyPX865eWg+dzanuqZD4b0HhSTswfSGc6hpn1m/eZcvgvQXVSoJDJyHN3j9KK9oZe/seWfYRdAdhPzZwzf2Zbg=
X-Received: by 2002:a05:651c:88e:: with SMTP id d14mr4352030ljq.472.1631284485067;
 Fri, 10 Sep 2021 07:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210902172404.3517626-1-daeho43@gmail.com> <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
 <CACOAw_yovM592K3-2fQzA6M29XqWu8s_2f+zXawKo-QpNSXq0w@mail.gmail.com>
 <8f8e4695-4062-60c4-0f91-2a1f6a5b0a11@kernel.org> <CACOAw_yBYZzUVGV-A7K57zqrcAaZv7nFSk9mSj9AC6jTTeU7Vw@mail.gmail.com>
 <f64cb941-2bb7-eed2-732d-c9537f46f67c@kernel.org> <CACOAw_zxq=SX0OdXV77HyFytJc6aCMbYuS6KZAR_JoQeGZ26Sw@mail.gmail.com>
 <a59d23b9-961f-4129-7491-59f88923366a@kernel.org>
In-Reply-To: <a59d23b9-961f-4129-7491-59f88923366a@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 10 Sep 2021 07:34:34 -0700
Message-ID: <CACOAw_z+yfNN3p3U3Ji0vLe7xDP4vkVy11RdzwwcRwwnSTjsFg@mail.gmail.com>
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

On Thu, Sep 9, 2021 at 4:50 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/9/8 2:12, Daeho Jeong wrote:
> > On Fri, Sep 3, 2021 at 11:45 PM Chao Yu <chao@kernel.org> wrote:
> >>
> >> On 2021/9/4 12:40, Daeho Jeong wrote:
> >>>> As a per curseg field.
> >>>>
> >>>>> Maybe, we run into the same race condition issue you told before for
> >>>>> fragment_remained_chunk.
> >>>>> Could you clarify this more?
> >>>>
> >>>> e.g.
> >>>>
> >>>> F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_FIXED_BLK
> >>>> fragment_chunk_size = 384
> >>>> fragment_hole_size = 384
> >>>>
> >>>> When creating hole:
> >>>>
> >>>> - f2fs_allocate_data_block
> >>>>     - __refresh_next_blkoff
> >>>>       chunk locates in [0, 383] of current segment
> >>>>       seg->next_blkoff = 384
> >>>>       sbi->fragment_remained_chunk = 0
> >>>>       then we will reset sbi->fragment_remained_chunk to 384
> >>>>       and move seg->next_blkoff forward to 768 (384 + 384)
> >>>>     - __has_curseg_space() returns false
> >>>>     - allocate_segment() allocates new current segment
> >>>>
> >>>> So, for such case that hole may cross two segments, hole size may be truncated
> >>>> to left size of previous segment.
> >>>
> >>> First, sbi->fragment_remained_chunk should be seg->fragment_remained_chunk.
> >>
> >> Oh, correct.
> >>
> >>> I understand what you mean, so you mean we need to take the leftover
> >>> "hole" size over to the next segment?
> >>> In the example, the leftover hole size will be (384 - (512-384)). Do
> >>> you want to take this over to the next segment?
> >>
> >> Yes, the left 256 block-sized hole should be created before next chunk
> >> in next opened segment.
> >>
> >
> > Chao,
> >
> > Do you have any decent idea to pass the left hole size to the next
> > segment which will be allocated?
>
> Daeho,
>
> I guess we can record left hole size in seg->fragment_remained_hole.
>

I understand we need a new fragment_remained_hole variable in segment structure.
But, I mean.. How can we pass over the left hole size from the
previous segment to the next segment?

Thanks,

> Thanks,
>
> >
> > Thanks,
> >
> >> Thanks,
> >>
> >>>
