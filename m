Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8573A351CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhDASWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbhDASDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:03:09 -0400
Received: from mail-io1-xd48.google.com (mail-io1-xd48.google.com [IPv6:2607:f8b0:4864:20::d48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A871BC05BD1D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:00:41 -0700 (PDT)
Received: by mail-io1-xd48.google.com with SMTP id t25so3911277iog.14
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 06:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jQVQMiS1LEWH5WtHi83sZSFNvCzxIq0JJNYo0pCyIds=;
        b=ACiicDbRosMziuDG+lV6UqKQLCnMIdm7l45Zc08xeaoBCnHIkssUpei2GCe2G2T9rx
         Yem6pJUb1WVyQ4rFBiZMjAZCBjWp19bOoG8bu0yAoKFOpvSYOshmrzr12oxicNYeSlHf
         bAnHpmDQ/dwLpYYLwOFdx1EdNorH54GD3qvVgzIC2r61mssjGCCLmXomFFjZ6CESa8cC
         sSNdsZTA9xtnC/ksEo1gNSE6V7N44ULaB2KsNCwKbv52tnYGShsIwfRwqPDiK6eHbTWz
         fC2nJzhbPhErKbMoC9SV5LCFv2WhqR8nunpbagl7ZtE2cIkGxvxc9OxQQ9FjMMsH1fxX
         VTgA==
X-Gm-Message-State: AOAM530EeTANEOWPjuLdMjhk7gEpRNd4Ws7hRNz2iob3M8PSI4h1Gbjj
        jKHUQ5LxcOoYa1/SGs9OGwQlhr7TwRdQJw9xyg3/C2FVjk+o
X-Google-Smtp-Source: ABdhPJwmxPi+IqOqqtvOaUuRwBvbO+Ll6B4LsWsA1DP5XCim1o0fOyk+c3GiRfbw6RMMWfUWK190yHSmAtKCH+A6sc01ISQtwEWH
MIME-Version: 1.0
X-Received: by 2002:a5e:841a:: with SMTP id h26mr6461960ioj.179.1617279363658;
 Thu, 01 Apr 2021 05:16:03 -0700 (PDT)
Date:   Thu, 01 Apr 2021 05:16:03 -0700
In-Reply-To: <0000000000003a565e05bee596f2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9391c05bee831ad@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (2)
From:   syzbot <syzbot+c88a7030da47945a3cc3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        hch@lst.de, johannes.thumshirn@edc.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7
Author: Damien Le Moal <damien.lemoal@wdc.com>
Date:   Thu Jan 28 04:47:27 2021 +0000

    nvme: cleanup zone information initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1440e986d00000
start commit:   d19cc4bf Merge tag 'trace-v5.12-rc5' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1640e986d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1240e986d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a3d65a48dbd1bc
dashboard link: https://syzkaller.appspot.com/bug?extid=c88a7030da47945a3cc3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f50d11d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137694a1d00000

Reported-by: syzbot+c88a7030da47945a3cc3@syzkaller.appspotmail.com
Fixes: 73d90386b559 ("nvme: cleanup zone information initialization")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
