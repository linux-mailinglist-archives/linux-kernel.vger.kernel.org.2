Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA78441190
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 01:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhKAAMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 20:12:42 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:35646 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhKAAMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 20:12:40 -0400
Received: by mail-io1-f69.google.com with SMTP id g24-20020a056602249800b005db75d2a291so11504067ioe.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 17:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Afp5EW5NkKvo/CTFXhPj0ythG6Ja27sM8OR5KgU1Xu8=;
        b=Sz1MfLnIOAMUUSPMTqDWQBG+D6rb0EZaXSqnd+5BLrXdNmZV99KXp4R9iA0s+5rAAW
         MCMWrol49toG7Z/jMe+dEx1hn0ChaeRlcwJ+30KIvRmTOwnMRuirAmV9E1ZTqdNpmPq+
         u4FbDc0JYf6KN6vqzatRnfNWPxPkW+op2fb8RakHHGwoVmeYYWE1N+Z5+vIk7hi5Sgdt
         ilSr6kb4GXxBdFOiqGbwzrJbeVcSjpmavLrPlLHI3p0Noo/DB5UrUtG8mBN9+z4gEz0W
         TrC2OtbeIyEmkxaR/oorKilXz3gMCDH4mh+Qk9p8UBkTPD02PLPyCxTz89s67xsssHd4
         vuDg==
X-Gm-Message-State: AOAM531OEOscfWzu/8fr087tJkFk9kbp70tkpFQCzB7nsStm2hEUsObs
        SiObIUqEPh1l8kVsl8hRi9Do/lRtV87XQORf1fctRnjJz4Dg
X-Google-Smtp-Source: ABdhPJzvDiSWpENrfpgFn60q4qjm7mMvncZKK3Plr617y0m1LtDCp5/53EwucWc1koNxoVvq4ESrYzdTCQ+mYziVq0qcr6T4SxXP
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3488:: with SMTP id t8mr4452286jal.139.1635725408206;
 Sun, 31 Oct 2021 17:10:08 -0700 (PDT)
Date:   Sun, 31 Oct 2021 17:10:08 -0700
In-Reply-To: <4b2b9c55-e2e0-a149-7dfe-ca36244d2245@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e805e605cfaefff1@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in hci_le_meta_evt (2)
From:   syzbot <syzbot+e3fcb9c4f3c2a931dc40@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e3fcb9c4f3c2a931dc40@syzkaller.appspotmail.com

Tested on:

commit:         8bb7eca9 Linux 5.15
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=afe4479d781b5f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=e3fcb9c4f3c2a931dc40
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bd0e6ab00000

Note: testing is done by a robot and is best-effort only.
