Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233BF3680C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhDVMpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:45:42 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:46885 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbhDVMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:45:40 -0400
Received: by mail-il1-f199.google.com with SMTP id l6-20020a92d9460000b029014a4305aacaso18293886ilq.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MBoWTyERxFkVDTqj1W2YjlvsjGkP+FMvMXQ4/+ef/wM=;
        b=K/esdNL8o8SxjYo9ShKV/fJeDJr9xkoIJEsfWBsA0Dg7lTNuLnmyNDNGTNUihQLRUB
         572vaMBb/Ubo8UFOepST2SbbjE2exIo6PtoCj+vkiX6tfa8/8wCGP7gfhSjWM2ThOElw
         ny41RBck3KtriURyo+cMPW9l3Uqh/fx1ZSVnKcdMRWwY9Gxthu/8avJJdpoRrEF0H56p
         agTNRNRZpzH0R9JxykdAvX1vZkrzRJH/o0HJKIt6cuuYVbIWZxGrexnCMZvGXEaJWe0F
         Tlbl/Ol0WvsGVoga2R1W5njJL//jxafdKSRtYytd05v+W2jGmnA5hJcYQ+z3KE9GKxoB
         nd5g==
X-Gm-Message-State: AOAM532IeNKbpi586mXUmVgkGFZm11mRH0ugyKfIkNumSTlwz3BqNCA7
        uC1V3a1aaU/lgf+oq8dfqyrdzEthaoyN8RltqddrmNB6T8TU
X-Google-Smtp-Source: ABdhPJyuN0BKB5Ti+jqSeP7iOBlhpvVRArVK5O0qvZ4zHfzGvQ2tuERMiugAJexNtsJ8Ew+33+T6hNfxGhe9A8lMfvbDBd3edu3v
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0e:: with SMTP id i14mr2341220ila.230.1619095505244;
 Thu, 22 Apr 2021 05:45:05 -0700 (PDT)
Date:   Thu, 22 Apr 2021 05:45:05 -0700
In-Reply-To: <94aa3e7fcbb225da66961a21c940406ada2bbd0b.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000729ab405c08f0c16@google.com>
Subject: Re: [syzbot] memory leak in usb_set_configuration (2)
From:   syzbot <syzbot+d1e69c888f0d3866ead4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d1e69c888f0d3866ead4@syzkaller.appspotmail.com

Tested on:

commit:         9cdbf646 Merge tag 'io_uring-5.12-2021-04-16' of git://git..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=f23c86207baa4afe
dashboard link: https://syzkaller.appspot.com/bug?extid=d1e69c888f0d3866ead4
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1699cf75d00000

Note: testing is done by a robot and is best-effort only.
