Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AB641E942
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352827AbhJAI4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 04:56:53 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:48725 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352826AbhJAI4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 04:56:51 -0400
Received: by mail-il1-f199.google.com with SMTP id x17-20020a927c11000000b0024da94ff1a6so6977210ilc.15
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 01:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mYVNj7GUYQ3ONE/lwuTfVtZPuGTc99UdHlU4HzP4RMU=;
        b=JdkpSg0uZDlYC0PVk4+OCg3CqZNMTr8VbvDRjtEY7xk7mOyFHboGBEabnmkf/SRi9r
         5SwfjVePWqS0OSP4+BUOMTe+b1PoQjW1AZjwNPD6cy+e/7UrURAHkYXaEWJPM5wSv3mc
         M80S0B/BvgWcJW4pd0zaBnmfqQxSLHv4JNXqi4fvSrs2Cg3kLaGpbJZINWGjJ9oOvRV4
         ALjuPZCd0psuEZ/IDjXhrHBRAJQAqrwunHRL6hW4yOou17/mc320LO8s2sxSxx3dxKc8
         Lu9wdBoDFny40lfUaiqOj+caohxim0wj1Ekr4mXiRnWnxZMKhbIIk5UJodwbbT21pzqX
         QOGA==
X-Gm-Message-State: AOAM531tCEmn+1Q9bTENAEDZy0v+53bKCSRJEz/DI0MYI4G9G60Hvevg
        Fafk4xAUU9ur+w2+hSLo6jWK7A0Rb95VUWy6m8KgIsbzPV1F
X-Google-Smtp-Source: ABdhPJwHjqhjMTIzJ+KD7re2/BvRja309HrPWUEceEN/YAnuUvrfDViaJV3ThPI7N/1fki4yZUmQcFv8x/XyxaaJ2RGEnxfueAgd
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3713:: with SMTP id k19mr8744051jav.44.1633078507394;
 Fri, 01 Oct 2021 01:55:07 -0700 (PDT)
Date:   Fri, 01 Oct 2021 01:55:07 -0700
In-Reply-To: <000000000000d068cf05c716264c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052dbbf05cd46b81e@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in em28xx_close_extension
From:   syzbot <syzbot+005037419ebdf14e1d87@syzkaller.appspotmail.com>
To:     dan.carpenter@oracle.com, hdanton@sina.com,
        hverkuil-cisco@xs4all.nl, igormtorrente@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        mudongliangabcd@gmail.com, stephen.s.brennan@oracle.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 0766ec82e5fb26fc5dc6d592bc61865608bdc651
Author: Stephen Brennan <stephen.s.brennan@oracle.com>
Date:   Wed Sep 1 17:51:41 2021 +0000

    namei: Fix use after free in kern_path_locked

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bf2a03300000
start commit:   fa54d366a6e4 Merge tag 'acpi-5.14-rc7' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=96f0602203250753
dashboard link: https://syzkaller.appspot.com/bug?extid=005037419ebdf14e1d87
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c086c5300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12950bee300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: namei: Fix use after free in kern_path_locked

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
