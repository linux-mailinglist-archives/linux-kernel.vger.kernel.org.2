Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FE33D4324
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 00:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhGWWKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 18:10:38 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40746 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbhGWWKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 18:10:37 -0400
Received: by mail-il1-f199.google.com with SMTP id y6-20020a92d0c60000b029020757e7bf9fso1803027ila.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 15:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DaaaaLaBW1jmlP7RMEUt9dIMXSCUGy/U8gtZX+ytnqM=;
        b=edSq9oWgNTiCKd0NTPtfL61v76jVNgRtSa+o7S34laxfUnFVXbwf67b0CY3unwymJD
         AXAKZLX+nx8Omhy4CZFsNZOPygwZJOM7hcqOo1kzbr5eB6BaLJIzx95c4sCLfLw0VIR5
         RxQ74/iCyRLH7aYF4H0iuZFV6qXvEzadwiocHsmEDZhN38aizjkpBwXpdK4CYeBMQHG4
         2k75oaZVgoM29t/OG/MVj/lFR/P3gfNyQFMEYS+bFCzqLoVgPP4cGlGvGBqWXlGZwMTd
         G9OmNcEcPfzfGQGMcz5oVRtcy5WYR5jORD6/sj/F5IuFaP/9lr9fBQEI+EuMyqzW63Zm
         Skng==
X-Gm-Message-State: AOAM531NmSm8a49ImM3G5OnAjWQ5mSaj4EuIIFJoEhms8erYfflf5YF4
        xcxdmbroJpqc8BjMG1qXkoEkCT4FB6lmzkOdOisB3+wFXNO6
X-Google-Smtp-Source: ABdhPJweXdk5LKw1isr4SDbMvL1cbkMhpSNQqGu3T3XT9SozL7genpVeOdqLMsTdl2BTZ1gxnhs5pMIqV2dyyp0c0dqI1H+ZhY0P
MIME-Version: 1.0
X-Received: by 2002:a02:ad08:: with SMTP id s8mr6092490jan.40.1627080670155;
 Fri, 23 Jul 2021 15:51:10 -0700 (PDT)
Date:   Fri, 23 Jul 2021 15:51:10 -0700
In-Reply-To: <20210723193611.746e7071@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d9aa505c7d23d2a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in tipc_recvmsg
From:   syzbot <syzbot+e6741b97d5552f97c24d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, devicetree@vger.kernel.org,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, paskripkin@gmail.com, rafael@kernel.org,
        robh@kernel.org, syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/tipc/socket.c
Hunk #1 succeeded at 1885 (offset -1 lines).
Hunk #2 FAILED at 1974.
1 out of 2 hunks FAILED



Tested on:

commit:         704f4cba Merge tag 'ceph-for-5.14-rc3' of git://github..
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=e6741b97d5552f97c24d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e7d8b2300000

