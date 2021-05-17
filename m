Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923FE383C42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhEQSb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:31:28 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49962 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbhEQSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:31:27 -0400
Received: by mail-il1-f197.google.com with SMTP id w11-20020a92db4b0000b02901bb97fba647so726789ilq.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JtPCeZ2TQZracTcPpDU9nceWBS01kuUCgMEVpXDuEo8=;
        b=PlU6rrJSwjMGRCJzCa0P5hwLAJcX3f2LTMvv6DoNZyft28YdOUqTME8D8afsUhpluW
         aBfZ+slcpgc9t3NgTs+VkuGLt9SjBEwud1qpJY2iyEL8MUBncDsme91XJxNUrGBv8Q/+
         X1wf99EUe4Nsdc0pEFRy+WfWrUe5bGcPFhbPowDJArhglmac0L51pxAv4jJ5N/Xz1U/m
         kW7r00/5m4CymfTeRp8KgYxSE3RXZ8BhdV/N08JI/ZupAArBWwUsugjzX0HtkQ1jM9bc
         yzKoGinyXS5m667wHbLCbaiTVH/oU/Cz6d8cZZIMhR9UcOc430J1m6LexPbOCDnzVhkD
         Z10A==
X-Gm-Message-State: AOAM5307XX+HeRaDTA1diAOIGExOgql5NQiDF+p0DCE7Nz0t5ss40ueY
        cGnB+ZDoNiJleLCY5imkDSkcQCnFCkSuAW/Uoxptr8lrjhWQ
X-Google-Smtp-Source: ABdhPJwSuewU7PXBTmnTU+Itz5Npi5zVGVCyYZmzWJzpxKPI2SfmG/az4x7T0qY4uqr3/AtH1FStPG3vGEXm1TedR+pZvhcwX3td
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dcf:: with SMTP id l15mr852350ilj.227.1621276210830;
 Mon, 17 May 2021 11:30:10 -0700 (PDT)
Date:   Mon, 17 May 2021 11:30:10 -0700
In-Reply-To: <20210517210953.389f086b@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1244a05c28ac833@google.com>
Subject: Re: [syzbot] INFO: task hung in ext4_put_super
From:   syzbot <syzbot+deb25600c2fd79ffd367@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+deb25600c2fd79ffd367@syzkaller.appspotmail.com

Tested on:

commit:         760537ca ext4: fix memory leak in ext4_fill_super
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux refs/changes/76/10176/6
kernel config:  https://syzkaller.appspot.com/x/.config?x=f54fe79f2945506f
dashboard link: https://syzkaller.appspot.com/bug?extid=deb25600c2fd79ffd367
compiler:       

Note: testing is done by a robot and is best-effort only.
