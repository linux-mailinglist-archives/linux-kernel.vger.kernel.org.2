Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396C03FAA36
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhH2IwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 04:52:07 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:47036 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbhH2IwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 04:52:06 -0400
Received: by mail-il1-f198.google.com with SMTP id f20-20020a056e020c74b02902243d481d97so6933760ilj.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 01:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VRjZ55btMfZrqeGahP9upV/+bb8bMaX/8gs+6OMv40U=;
        b=sJqmDYdHu9VcYNW0QsVq+mXv8qXHG2X0mrf0+DOfLcp44Nf6CaUhwP7RdLxjnY48t/
         Id+MZ/LXfuGPLqbscJc82jhzn2+KU4aLUMRz6wmpDyordGxC420ElG+5cq07wDHEVJOs
         +wT/EcLkxsEc8ql36tztMRIsAHVEC156hZuYlwZkdMTojZ98gC/xh5VrSJmu+KheP3HW
         AP0KjFCZSEgxYGwzKFEglt/IiuLgAOw3kDcN/0PqlHZD41Dp/0x/rhKwxIsxXwXHTHbi
         oH2u4Cz8BiC6HIpDARXeYtN+zF1TZPRC4vM/mjIJyasepB+LHeA+x5BeuP13+Rwgixyo
         vojQ==
X-Gm-Message-State: AOAM533zSHWB7pNRyKFfxu+Cy/JXl38v1erA+AZgc84iEBtBWsQuLIaT
        L3ZPgc4tc4PED+BkCs3H10T5W0s5IV/7e12ceIoSLgVdUG/l
X-Google-Smtp-Source: ABdhPJyVvN8oXQt2MGRND3Pgy/bPaDyFUxLOI1Jcv0MmI3Hmw64p195vbuwVSUMPjj0r0mqcTW/w/loewrn56mynJQND8yznsIDX
MIME-Version: 1.0
X-Received: by 2002:a05:6602:340a:: with SMTP id n10mr12067086ioz.188.1630227074389;
 Sun, 29 Aug 2021 01:51:14 -0700 (PDT)
Date:   Sun, 29 Aug 2021 01:51:14 -0700
In-Reply-To: <20210829082929.2897-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac212205caaed18a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com>
To:     desmondcheongzx@gmail.com, hdanton@sina.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com

Tested on:

commit:         e3f30ab2 Merge branch 'pktgen-samples-next'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef482942966bf763
dashboard link: https://syzkaller.appspot.com/bug?extid=2bef95d3ab4daa10155b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108523fe300000

Note: testing is done by a robot and is best-effort only.
