Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285544541CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhKQH2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 02:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhKQH2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:28:21 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2363CC061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:25:23 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id s17so1080804vka.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0xmgwHrlv9ktwSdQ/JfjWjQenm8x9ltoihTIjxaBNQ=;
        b=JbyabcOFwg9RA8CfJQXEnNtK9YqVVxIwGdThHqLv6dHnkGsNYKDELnCxw9iNTyQQq1
         ND0s1vozfYnSAaFzlOjtmE45CCNh7SfCWUerukqPpadmxSr8L11WvEHCkf1hqI7AWD4o
         SHgdlnvP9G148VHCq2BYTYSJuFE8cd/T9YjIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0xmgwHrlv9ktwSdQ/JfjWjQenm8x9ltoihTIjxaBNQ=;
        b=ovQYjdatkNCQgCvPDu9HNXS4eJDOXWxK6Ndq7SWpsHaco19kdWgQg9wsesbSUPNPL5
         xkU0GR/JoJCG9hRNubtNuO7aNYy2EPehiHhHbzILQaWknoiQpHQYQW+KbOPc8ME5fBnG
         AAtMjNyL+sefenFz+YnLPZB8f8HILZKLDcMOKMASeaMRhUCOcYlh/e4/15XyJhvma674
         EBECBD2hkgCJsPV0zqPMMATQSnwDWMksMgSpNzXZ83xJm/rmQlyH5gpmqNMmWTQCo3MS
         ZkYJ6sC7xMuvwTlM/U3yyxsTjiO4XTo1i4e3/76lFUYHXfe/o9szgZu7It09OyUWkBXI
         Ui3g==
X-Gm-Message-State: AOAM530VP9JgiMcY5H2liCQJU0+8AVU4089D6xFoh9oFnVulN+hckezE
        AzSspMJ+T4HpWEXWzUEScZZ3jYv4qqi2yaeHaP5gRg==
X-Google-Smtp-Source: ABdhPJzBvilmkHXZGOjRkylsNfzWJ2cgYh6bVMxxcy/fEjHQEuzR5KbV/So04CzbtfXGK/uCfPDqT/fqDVC+3jwDADY=
X-Received: by 2002:a05:6122:1350:: with SMTP id f16mr41382809vkp.10.1637133922290;
 Tue, 16 Nov 2021 23:25:22 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c93bd505bf3646ed@google.com> <00000000000006b5b205d0f55d49@google.com>
In-Reply-To: <00000000000006b5b205d0f55d49@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Nov 2021 08:25:11 +0100
Message-ID: <CAJfpegtASmSmbNakuCYcgaF0Cy8kY=wu-w9_imiJnsCJngnR=A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in inc_nlink (2)
To:     syzbot <syzbot+1c8034b9f0e640f9ba45@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 at 06:32, syzbot
<syzbot+1c8034b9f0e640f9ba45@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 97f044f690bac2b094bfb7fb2d177ef946c85880
> Author: Miklos Szeredi <mszeredi@redhat.com>
> Date:   Fri Oct 22 15:03:02 2021 +0000
>
>     fuse: don't increment nlink in link()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10563ac9b00000
> start commit:   1da38549dd64 Merge tag 'nfsd-5.15-3' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e2ffb281e6323643
> dashboard link: https://syzkaller.appspot.com/bug?extid=1c8034b9f0e640f9ba45
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f16d57300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15758d57300000
>
> If the result looks correct, please mark the issue as fixed by replying with:

Highly unlikely: the original report was for sysvfs and the fix is for fuse.

Thanks,
Miklos
