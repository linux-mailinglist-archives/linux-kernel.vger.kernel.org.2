Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890863325F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCINBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCINAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:00:53 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF169C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:00:53 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id u20so13748685iot.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rm5lW1ENcl89omxJ8N+57DdgA2Z/G+rN4bPKq9l7yQQ=;
        b=Fll48E2oUhz0FUSH6bLGlApSjh82B8QHzwmdjDkZA7x3jakx4fPOYyRJaHZ+6SXD7S
         YZFxXMp/nsJhSX1tenc3K1yBZGHJdo0yCjlv9p7lEYwd/IJqY9GZCw7Ea8X+nL0RukQJ
         i9tPV0NZuKFgU0HMNhbJL8UbwuCkPzor31bOd1ItSGwoFf+7zalpM+XW+IYFp55fdUyb
         WxyQAmyJAhi/MgpWbBr9DNlUE+YhT/TikJWIp5siEYjryL+q9P7WaPPuSWb1ktnePKgF
         MXA7c888gYT7IbbrSLcE7+TRaSohEZ7E/+gO9Wj0G5r51mk1+BHZ0WnrMsUKe88DLUyL
         HdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rm5lW1ENcl89omxJ8N+57DdgA2Z/G+rN4bPKq9l7yQQ=;
        b=mnpAcsWIE7cDyw/byRUmQ9qONQ3PiR8Rv95iBYhp/+A55OTRBv9oWRj56obQvr6Yht
         1eGDLV5ZFDWX1NLylY7A2zlgFf9S5dPm5DtaEwTsVQ0T2yVet4YHT82c6E0jRWL1ByUq
         UQX1tfQ/NYjGyHYZVk8Fauhhg5QmEeD4xgg6P3U9QCNqMOZTnzwpXQSun2HZ5TfjcZX+
         6rfvzfAHKlceJsPhbyQbTie7NhCkowRtIgICcqwQ37iv6OW8NIsf8Ryriw+PDM/yvvIj
         EfoOENh82KwgKUTLsJQR5S30OUTkX5an0ekFnqspZFQCu+AXROA5eTLrwhIxocWk78fu
         RlHw==
X-Gm-Message-State: AOAM530C3MAlz9oHKUBJulL5fGpGsbpsAPSsXr2I9urW0rOt63nYQFGR
        IogdbXH8SnxPDL3amEP5jvw3uj7MiOjrGXVHH3E=
X-Google-Smtp-Source: ABdhPJwAPNA4NvHj1OiawwaamclqFEuNri6ZPN8VfYbDPO3QhsL+7kqp6rllhzwiby5c+ZvLosFmwzD/GLfG7vJh2tA=
X-Received: by 2002:a05:6638:1a6:: with SMTP id b6mr28397712jaq.116.1615294853126;
 Tue, 09 Mar 2021 05:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20210305022402.2721974-1-daeho43@gmail.com> <2f2abc41-24d5-6795-44fe-b770ed8514df@huawei.com>
In-Reply-To: <2f2abc41-24d5-6795-44fe-b770ed8514df@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 9 Mar 2021 22:00:40 +0900
Message-ID: <CACOAw_woQGgTy_hTfdcFufA7VG3cBVSN9vSD5bubvTeo+3wxsg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sysfs nodes to get accumulated
 compression info
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=EB=85=84 3=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:22, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2021/3/5 10:24, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added acc_compr_inodes to show accumulated compressed inode count and
> > acc_compr_blocks to show accumulated secured block count with
>
> I noticed that these stat numbers are recorded in extra reserved area in
> hot node curseg journal, the journal will be persisted only for umount
> or fastboot checkpoint, so the numbers are not so accurate... does this
> satisfy your requirement?
>

Yes, we are satisfied with just getting rough number of them. But, it
would be better if you suggest more accurate way. :)

> > compression in sysfs. These can be re-initialized to "0" by writing "0"
> > value in one of both.
>
> Why do we allow reset the stat numbers?
>

Actually, I want to have a way to clear any stale number of them, but
I agree we don't need this.

> Why not covering all code with macro CONFIG_F2FS_FS_COMPRESSION, since th=
ese
> numbers are only be updated when we enable compression.
>

I wanted to keep the info even in the kernel with doesn't support
per-file compression if those had been written once. What do you
think?

> Thanks,
