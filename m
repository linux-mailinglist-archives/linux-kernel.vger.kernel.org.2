Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E485F40239D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 08:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhIGGwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 02:52:14 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:34659 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhIGGwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:52:13 -0400
Received: by mail-il1-f199.google.com with SMTP id d17-20020a9287510000b0290223c9088c96so5469261ilm.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 23:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bQd9Yn1U78LI0fg5YUZ8e9dnmnC6+HnT8KD9nGnx8JU=;
        b=TYSrHQyRtafOee2TI9xo49qtxm3T9bhFxGqpekah0+PH8dBaPkO+UqN9WAVcUgl5Ki
         Dqqqy8HbXIvBNqLVZzG6HwZHpz1DoAvMrLtfRUpFf/9vraVl6k0jR1yBa2AkX/IGFPK0
         HH8ld+rV2EVAZTr1luGOt0HwoNDvS2ih+kn3+LotE9B4FEl4zsJ6vGHeDhfa6A31xmYV
         lmotUwT1CyBA3dGdz41CcC6kdXEkkmW8U3Xp+Ni7DNDZa4/AH0wDC9qPMpRH0qykI5kO
         KziKzEz3+sRiecai1vdfsu72bkNzOYUagtI+yxszOWHaWCno/OxBK8A3u9s30FfBx3/G
         KmOA==
X-Gm-Message-State: AOAM530Exe1eXTRzmB2XHcWNYK1PNUrlPEd7N2hAIE4MB+vzia9Vh/r1
        ymSoKMnblA8HYjEQbok45jb1AOL1c1U/C99MB/CmGw4Tu/lk
X-Google-Smtp-Source: ABdhPJyeUmZ77BzmFV6pTkT9Wvawnx2OaFZU5c3skKh+qRRWvRHB3C05eZo7fTlP2AYnx5kDHHj5zeGxsKLKjX/w3mvetoc6Vl5/
MIME-Version: 1.0
X-Received: by 2002:a6b:fb0b:: with SMTP id h11mr12845176iog.59.1630997467748;
 Mon, 06 Sep 2021 23:51:07 -0700 (PDT)
Date:   Mon, 06 Sep 2021 23:51:07 -0700
In-Reply-To: <000000000000bb5f8605c697fd87@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1e03005cb6230b5@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in get_ucounts
From:   syzbot <syzbot+8c3af233123df0578a5c@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 345daff2e994ee844d6a609c37f085695fbb4c4d
Author: Alexey Gladkov <legion@kernel.org>
Date:   Tue Jul 27 15:24:18 2021 +0000

    ucounts: Fix race condition between alloc_ucounts and put_ucounts

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1378d0ed300000
start commit:   d5ad8ec3cfb5 Merge tag 'media/v5.14-2' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=702bfdfbf389c324
dashboard link: https://syzkaller.appspot.com/bug?extid=8c3af233123df0578a5c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fedec6300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ucounts: Fix race condition between alloc_ucounts and put_ucounts

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
