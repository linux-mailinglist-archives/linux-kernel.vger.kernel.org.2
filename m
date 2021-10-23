Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3BE4381E9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 06:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhJWEwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 00:52:36 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36710 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhJWEw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 00:52:29 -0400
Received: by mail-io1-f70.google.com with SMTP id x21-20020a0566022c5500b005ddd625f399so4655548iov.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 21:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mvePd5L1eky6kii+wlkb5JDOZo/0Hv/Enm522ESKj7E=;
        b=qQ5659gaSvy+rxhcPn/48oVHmdIxMK/Qpbi32YrnDIjQYQ4Y1UVRb2fFb9CK87t7F8
         sXInUtRSBpFlCiIe03zau++8aStDIfksIB7RztAK74um1o1NIN1euuttXwbfk5QVNeLW
         UrPgj6V/al4nBTsLP0LJrThL+i4tY7J3HQNxty/Gc+LBsjEbTUDPXVv4ESWLONwhC9Vx
         Nzg/L7/lH7jNUmUXOwdSDsKemYHyZoV/S5PnFvQGc0PKTa7PBJNe1lvKRfOYyU25yXQR
         H7iyVOE7+eHXyG97ABkggfRo+HqlsLIhkVUffTe/0zDxiGDJCSD9dknhAEKYTt97V3L2
         OB3Q==
X-Gm-Message-State: AOAM532DEIsD+I72L7pf7sqIT3hkbeGlyCnlq78P8ib5KezW7LdFBWsP
        7rGJ9NbDb4BOUAD2J6YUQ97UqYZduskFCSoMGSPSKHSN2AKl
X-Google-Smtp-Source: ABdhPJzRejzoVuLjfxevXfIloGzhEE6WWMlDeOnHot44VK+A6KSR1zzyIrdx+0ZzffS+srM4B1JAZTs2vGvwqF8jcfAbuC1g48SW
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1504:: with SMTP id g4mr2343090iow.133.1634964610411;
 Fri, 22 Oct 2021 21:50:10 -0700 (PDT)
Date:   Fri, 22 Oct 2021 21:50:10 -0700
In-Reply-To: <5e29e63c-d2b5-ae72-0e33-5a22e727be3c@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2f5fa05cefddcf0@google.com>
Subject: Re: [syzbot] WARNING in batadv_nc_mesh_free
From:   syzbot <syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        paskripkin@gmail.com, sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com

Tested on:

commit:         9c0c4d24 Merge tag 'block-5.15-2021-10-22' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d95853dad8472c91
dashboard link: https://syzkaller.appspot.com/bug?extid=28b0702ada0bf7381f58
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1553d4c4b00000

Note: testing is done by a robot and is best-effort only.
