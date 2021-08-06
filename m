Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B5D3E23E4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbhHFHVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243599AbhHFHU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:20:58 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C614C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 00:20:41 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x144so4658606vsx.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcY+NhjZCxDCc6fzI/JMYTvUJ3ohCx1BhlM5JB9bQ6c=;
        b=J3lNdliQzbk3pJH/RUiwJjKq9xf2/J7wLsjKTtnHdvLrVFVazpThcttNeuAXG5WWoh
         vAJmmVBxfe+N0fq50fwFVgkfN3aXdVmvcVwgdu1spbWh1sVx1t4Sw5FGC1Y6YmH95Vp+
         ASQe6IPEvrs/ZAlP1cyHlROienYUHOCoXc8GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcY+NhjZCxDCc6fzI/JMYTvUJ3ohCx1BhlM5JB9bQ6c=;
        b=lKnVX2QASAuSKNzWtQTmuSN71pEZNNQJYznVK6b6MKcON4cm3rEnZSwTZssW7Dea1z
         1BPIFkYMbakh0CQQuYGEteKoxVG3t4Kf061vjuH7K2Dn2aMtK2RBuS0ZesrOF0hHpM9G
         oIDtsXASvEEL5k30sssM2a4MUDS6bYJE9q9DDRbjSgpKucjVGu1/a1hBunBurDkkpiAA
         gMcw/OOE/NDntbcZCjJ4VolVaGd3z1I5m+xk/6NqgehB2WpyNHPyaICpUX3tkLTV/fce
         fCAPW56VKiEeufeWYrrGs0IxaaWv2RFcMA/pURi6xyHXn8kFnaPmIDZPUWmNgUrTvZy4
         MbjA==
X-Gm-Message-State: AOAM533cVc+6kwig+kjjTU2gVp0/MkAD79mU6db6E5jZ5i90kvEzgacP
        uK367jzBMqEfA6QHsjt0cCz+XgVHfdqUostWC16qCw==
X-Google-Smtp-Source: ABdhPJzTE3mmzftvUeFfpXLtrsr52EidXjI+2jHkP2Wx8+U1MSmy0ZqLrEZ6em36Vyk5Qei/P5cOrqb9hi8jpV9vS1s=
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr7990025vst.0.1628234440687;
 Fri, 06 Aug 2021 00:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000001b19a05c85fdb77@google.com>
In-Reply-To: <00000000000001b19a05c85fdb77@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Aug 2021 09:20:30 +0200
Message-ID: <CAJfpegs=bJZ+ekx7=LJ9nZEivyhu7PctnH22HxPAVJCNZErn9A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in fuse_get_tree
To:     syzbot <syzbot+afacc3ce1215afa24615@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2021 at 01:48, syzbot
<syzbot+afacc3ce1215afa24615@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2265c5286967 Add linux-next specific files for 20210726
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=102c92b6300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=531dbd796dcea4b4
> dashboard link: https://syzkaller.appspot.com/bug?extid=afacc3ce1215afa24615
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d97fca300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174a53f8300000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+afacc3ce1215afa24615@syzkaller.appspotmail.com

Fix folded into fuse.git#for-next

#syz fix: fuse: allow sharing existing sb

Thanks,
Miklos
