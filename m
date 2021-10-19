Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D04332D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhJSJu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:50:29 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:56116 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhJSJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:50:27 -0400
Received: by mail-il1-f198.google.com with SMTP id o8-20020a056e02068800b0025999dab84fso3582435ils.22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HkppKwxJSrwxL7dC9UV89aph7+9yntblLWJOhC1mcHE=;
        b=mCM9r2SShDjww+BaI0AulXGUB1yOPgHRVIamlTANLydT/bs3Vj+8sykWmL4Ciyh5JY
         2k52dXH+1XepjckNO7Ac3DsIwYrWfbrP3e08o3N+0YtX2IPNMbtHqVEwLgfFwLk+7T0w
         8EB2OJQvQlCLv5BALOKjFZlpRfpFwU6ypZctVwu5MSJu9EsDfKlXtFHh8iX5EdFVudHl
         1W2k/9KI7zGCPt88rfjjrWs4y/sKqKQusyt5W2dqpua+cgJljxKj1EtJ/JYYSGU5TdcR
         DnsAbZkfL1kmjmiJ/je9//+jBF2eRaUamlX/z8Vp7ZVdo2DWHHZeTqXDmUV05Eo8gHRJ
         bhog==
X-Gm-Message-State: AOAM531pFfZnmNVU3HGTMoRfjixX6q3QyCDulxZqAcBA/+TphUlN+5at
        ktFopFf8tRHk4KfvEiEFlPKGeeGwGc9nooiPUgFE4+qbhvRR
X-Google-Smtp-Source: ABdhPJyb8p3gPAxw/6FfoTBFhII+XiWGMzkh14vkr61G0rGK1ckzMLcK93Jd+koQdBXdoVfetU5dm6E+S+J/mN81JU2MLpgzl/ik
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0c:: with SMTP id g12mr17531265ila.260.1634636895325;
 Tue, 19 Oct 2021 02:48:15 -0700 (PDT)
Date:   Tue, 19 Oct 2021 02:48:15 -0700
In-Reply-To: <20211019091639.GE3255@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b948805ceb18f83@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __isofs_iget
From:   syzbot <syzbot+6fc7fb214625d82af7d1@syzkaller.appspotmail.com>
To:     bingjingc@synology.com, cccheng@synology.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, pali@kernel.org,
        robbieko@synology.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6fc7fb214625d82af7d1@syzkaller.appspotmail.com

Tested on:

commit:         519d8195 Linux 5.15-rc6
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd205ca848a57406
dashboard link: https://syzkaller.appspot.com/bug?extid=6fc7fb214625d82af7d1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101927c8b00000

Note: testing is done by a robot and is best-effort only.
