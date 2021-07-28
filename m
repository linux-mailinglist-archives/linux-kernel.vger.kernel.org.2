Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74233D89D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhG1Igs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhG1Igr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:36:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2498CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 01:36:45 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id jm13so1147050qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XNAi+Jf7+6jRfciI3PaXaiW4Vo78kl67VduGHwhdQLo=;
        b=L6ZpgCQwR+5Kz6mcl59kjajP8utJgKj1tyHJNuyGmlITPqFbM5OOA/ybSqWwqOG1+h
         PpV6YsEw5t2DebnEBp0/pHixqOQqBx+gTLJjtJr9XQY8UTNUUbbSSJhIi63oMRd3AvgG
         89Y4L1XReL768eBZMNDbaibrWZQ3Qvwf7XO8IncrUBdIm9toie8cGc63Uw97WNjE4sK3
         tYZXQmz4KiyRBTH9s4VSDBZgpCam3dO5yx8H1jn0Oo6w4b1hLdsk3KWiSGCZWb9o+OTt
         ZoTkTIziN7Btdt7oBZyeugGWZvOoP8AZu9ZN2GQLUZyAH36BrlgTgP5igHQLT2+HdbSQ
         GzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XNAi+Jf7+6jRfciI3PaXaiW4Vo78kl67VduGHwhdQLo=;
        b=URXkxjtfJs0wku6LtiqShtQkaK1iW89eFTUFf/5B96CQ9Lj0Rli4aDLWV0pLoygMbL
         K1WdMqL//H61WhtylKAfE4jgZj0twIjIKAi/kpD/QHxc/W3B5dUhhnr8Xpsk4Hwz8Hfe
         BIWJcN1W+xqEgTF5rvFAeTHOFaTS55SstHPNjauHi6JhIPi71AzhjIuFNccO1NBhMh0v
         rnmCOSW/4SWsCqjnBnBCC96icN/8Gv7KAED7/CwQALTsgYjbK4IEss275yxh3WcNqvpL
         cBU94wh8UXDXsCMMLSgf3ObNdz5CJ8KqfaanDQN/ouROdaGZaZJK3Bn6eEeD/KHU7coV
         KVHw==
X-Gm-Message-State: AOAM533ItVNmDbq90r1Qd+l4SafTgTNurSZKLzxf+VwBRvmKRe0x990a
        gUa72AUsnQwrT17sTyPB6B+hK7byQFWw7L47qqBv2w==
X-Google-Smtp-Source: ABdhPJwQbzLDFq+bkIInSBpwLCiyCzdd+0/KA9LQ2U7AIRQFoWQk3VDjlmDhfsfcSt67TeaFEIYdI9atIf5IP574Dk0=
X-Received: by 2002:a0c:aa42:: with SMTP id e2mr27389356qvb.23.1627461404074;
 Wed, 28 Jul 2021 01:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000055e16405b0fc1a90@google.com> <0000000000007cbbcd05c745a560@google.com>
 <20210721173744.GN19710@twin.jikos.cz>
In-Reply-To: <20210721173744.GN19710@twin.jikos.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Jul 2021 10:36:33 +0200
Message-ID: <CACT4Y+YQ1JCxR9Lj5ZFB0XxcgV8axzO=38ZY8xX+0ViHkQ26kQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in sta_info_alloc
To:     syzbot <syzbot+45d7c243c006f39dc55a@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 at 19:40, David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Jul 16, 2021 at 04:07:06PM -0700, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 282ab3ff16120ec670fe3330e85f8ebf13092f21
> > Author: David Sterba <dsterba@suse.com>
> > Date:   Mon Oct 14 12:38:33 2019 +0000
> >
> >     btrfs: reduce compressed_bio members' types
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d5f6f2300000
> > start commit:   7f75285ca572 Merge tag 'for-5.12/dm-fixes-3' of git://git...
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b5591c832f889fd9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=45d7c243c006f39dc55a
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164f385ad00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1427af9ad00000
> >
> > If the result looks correct, please mark the issue as fixed by replying with:
> >
> > #syz fix: btrfs: reduce compressed_bio members' types
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> That's completely unrelated and probably result of unreliable
> biscection. There's a different patch referenced in the dashboard
>
> https://groups.google.com/g/syzkaller-lts-bugs/c/ntHpclbYBMM/m/WG3hW1DvAgAJ
>
>   commit 25487a5ff100398cb214ae854358609e4bbd4e7d
>   Author: Johannes Berg <johann...@intel.com>
>   Date: Mon May 17 14:47:17 2021 +0000
>
>   mac80211: remove warning in ieee80211_get_sband()
>
> that looks more relevant but I don't know if it's the real fix.

Not having better candidates:

#syz fix: mac80211: remove warning in ieee80211_get_sband()
