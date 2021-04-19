Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C078B3646A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbhDSPCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:02:36 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:45049 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbhDSPCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:02:35 -0400
Received: by mail-il1-f200.google.com with SMTP id q7-20020a056e0215c7b029013ea7521279so11607211ilu.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WMrYoKskNr7U70R71k3smKLM3Le7PTj2L2OFTVziLOM=;
        b=IAOw3xTaLxkUG0FmUjzTzs8ekE91qFbEolZAcDU5BTdjjAtICB5FIFQA9I3/NQMSTP
         eBDfq0mRfQUaIe2d5dpAF17fo0OJfmHcaeFKbw2CuWOnXYtlO6ih22GiZ0IQC/XIdAD4
         yst5TlzKMt825Kn8D9ktiJlIxLFP+rmkENNcjFnhmkdvjiPxGC36Ajy7+djQ4WXPjQKm
         cy/xMgHXjulyXXZTMOUyjxrfDwqhC5mLpx9vjxVlVEJa309crOma4DZrlqLgSzu/ZSL/
         U5uv28EHtIwcb305ME2841sH4O6XqdmgVsJcSxZRVqCPaeZbY4poXHGnpdEa/ub/pm3B
         H3ig==
X-Gm-Message-State: AOAM532etxRwyBAtBznoiVBjUT8v5K66o9GJnVCCo2Ed4ojmrEwDTxgb
        TtxzA6Jl23Q5EA611cXYahVboFcMMp9My6tTfjV64R++vGa+
X-Google-Smtp-Source: ABdhPJxYspjPxbt+oEACm+W93vLXmTGM6mpe1oQlCLjG/LKWOtqLnPpBqJY/Q6iaKq+tNonPoDwvDyRgWFknhroP/xGQrazCyEeB
MIME-Version: 1.0
X-Received: by 2002:a02:1c07:: with SMTP id c7mr16825882jac.111.1618844524745;
 Mon, 19 Apr 2021 08:02:04 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:02:04 -0700
In-Reply-To: <c12b0100-50be-907b-503d-3aa00223194c@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc7eb305c0549c1a@google.com>
Subject: Re: [syzbot] WARNING in __percpu_ref_exit (2)
From:   syzbot <syzbot+d6218cb2fae0b2411e9d@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, hdanton@sina.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d6218cb2fae0b2411e9d@syzkaller.appspotmail.com

Tested on:

commit:         75c4021a io_uring: check register restriction afore quiesce
git tree:       git://git.kernel.dk/linux-block for-5.13/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dfd9a1e63100694
dashboard link: https://syzkaller.appspot.com/bug?extid=d6218cb2fae0b2411e9d
compiler:       

Note: testing is done by a robot and is best-effort only.
