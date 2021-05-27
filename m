Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859913924B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhE0CJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:09:53 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:54900 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhE0CJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:09:52 -0400
Received: by mail-il1-f199.google.com with SMTP id h1-20020a056e021d81b02901bb694b89faso2110323ila.21
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6ZocTATEcFRpOEeCTatSsV4k9iWzpPmF4wHMKAlnV/8=;
        b=E7PwCDWawmcm97rtb7PiC5OxKQAYGk9KEV+ZeZLSQEfGI4P+euNJLDqcwU5dF4IsdZ
         kGVIlekqY4SoTyK1d8A2Np3P4mfiSo7sSRr4F61tITDW/Rz47EPqJYpLnxK+fONGNR2X
         Jouxjzm85t7HkjOxOIRImfUQX9jmfPp5ww0tx8muB/5dkvJ766ymwbX/odlrDAh3vxP9
         KO67g4N4ef5+biDSL4B4wHStOYEhB9J6wzhORMdz9zcbK6LHr9b+XAcKyloBsxvfr3x+
         p2Aj/QAt4M1WkIwm3a/1zOs6kvVBzh2IRPhzYiLFzmoHWFsxB6L/PJqhpU6C7HtgLty1
         86HA==
X-Gm-Message-State: AOAM531iQcEAXIpp59xcZqtrx+1ZF4RODWfhnzFtuJ33nUgEgvaOw8Kw
        qP78pyS2DFp6DwR2fdBWV9aVU/XvnxcLa2SU5lcjimj2StuN
X-Google-Smtp-Source: ABdhPJxvJBYg3t8IHIL8bQOGjhiCLSlQ8XwXtLNXlw6TRNTGok1e6JFPU993UO3MT5vCNbYVt5RnUZYZggFbYQZjylIdS1DmemNr
MIME-Version: 1.0
X-Received: by 2002:a02:bb98:: with SMTP id g24mr1142823jan.19.1622081298889;
 Wed, 26 May 2021 19:08:18 -0700 (PDT)
Date:   Wed, 26 May 2021 19:08:18 -0700
In-Reply-To: <000000000000b808c705c345b35d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009dfd7c05c3463b32@google.com>
Subject: Re: [syzbot] unexpected kernel reboot (5)
From:   syzbot <syzbot+6fb8ff5211d3e821398f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174ba76fd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266cda122a0b56c
dashboard link: https://syzkaller.appspot.com/bug?extid=6fb8ff5211d3e821398f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10772527d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1072f98dd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6fb8ff5211d3e821398f@syzkaller.appspotmail.com

output_len: 0x000000000e7f5b68
kernel_total_size: 0x000000000fc26000
needed_size: 0x000000000fe00000
trampoline_32bit: 0x000000000009d000
Decompressing Linux... Parsing ELF... done.
Booting the kernel.

