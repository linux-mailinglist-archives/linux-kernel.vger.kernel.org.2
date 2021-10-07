Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CBF4254B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbhJGNwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:52:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52789 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhJGNwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:52:01 -0400
Received: by mail-io1-f71.google.com with SMTP id w9-20020a05660201c900b005d68070ebc1so4789100iot.19
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=k96NZorIcc3w71vpZVSD9lWX/QFgQw0ZG/aaQMm0TMQ=;
        b=okiQh9Qgs/TIWhMPG8p0OVtfpDfFl8xP7ghR3q1JoXcxbsUBKFfQUoNSKJRj9IsLkE
         YJo9Y9VW/do6wtPuyU5xtKCMfC2Y8MIrm0t+dbU792y8iPanbFHRh3jR+9ZlLp2ARn8d
         Zxr6PfwtI0pCfH6Yc0zL93lr9tmUx386FgSz1oCNqFOBC/Tj+6+Wb4gyQBlJ9pRTKvLp
         eRLq1uNiliPFJAp4R9ilybxQBtCRNuMeSnIBbAdevLTm1WydFw1kRLsQYlVqfv4w9sr4
         IcFf3vluVTuIr2UxWxwgP1UhhFEQdP7oGc5KpxclEe1Bv+kNLzmYmkVfGTXuraF3Y0Bw
         zJOQ==
X-Gm-Message-State: AOAM533i0zUgqN85angcYbhexvsgPUIMTwkW5ILG47FLMmFzh8nmTgDR
        5k9eSQeBg4IeoDFYN2Vsd0QXz753/dDQJkSB4du4ukdnZfDi
X-Google-Smtp-Source: ABdhPJwSdYT/KZX9b7DMZi36pqexZv4ngmaTOo6qOr7oUOLCmvYCI9HUopoBHPIFOz40qntP3STam7TV+bl7r8Q8LTKxf2DB9sFu
MIME-Version: 1.0
X-Received: by 2002:a5e:db44:: with SMTP id r4mr3234965iop.56.1633614607282;
 Thu, 07 Oct 2021 06:50:07 -0700 (PDT)
Date:   Thu, 07 Oct 2021 06:50:07 -0700
In-Reply-To: <20211007084449.GA12712@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005dfa4805cdc38a2d@google.com>
Subject: Re: [syzbot] possible deadlock in dquot_commit
From:   syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>
To:     dvyukov@google.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com

Tested on:

commit:         60a94835 Merge tag 'warning-fixes-20211005' of git://g..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=74f6ab826fb913cd
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6f9218b1301ddda3e2
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162860d0b00000

Note: testing is done by a robot and is best-effort only.
