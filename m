Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB436EC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbhD2OS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:18:58 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:35380 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbhD2OSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:18:55 -0400
Received: by mail-il1-f200.google.com with SMTP id x7-20020a056e021ca7b029016344dffb7bso35189897ill.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ol3FICnYJQdFXP8aGYDo9pndJt2yyzEHkFMgQR8y69o=;
        b=VvWt1uMX9YuMs9E9bLVhdl6zKB0R+iwH/rsz3WXUbdaboFyCxHdV7vDVQjRC27NM+c
         3ChnzRMg/GRdlT2EVQVMitWDZZM1Jddw0Wq6jFAXuEeZkcQKe4Zn7sTYiJr6ZG22pXDV
         ihq7PjC+kizCGZfjXqrob20tNYDHhe5Ty2JeoM0MPmd/gRiYodO3e21iKDGZVEgVi2pG
         P3iSsLK8CEyjsmllDSzDXOaYMNeVVFbLoVBTqG/dwCfUSrZBeXnzX5rTCKdnS28ouggD
         bDbjFp+/fTHgRRHvB00CDQ1nlw9jw+FFgaClXOyQjFgosJivD02kY8Qo0SlnnkgxOtM/
         bbZQ==
X-Gm-Message-State: AOAM530HoeuG43tmTdyIiK5H+/zxEGPqYn5CA9vo3+eanLigHJeYd1md
        7kAC/IPgCr26jWhZDNgSCGE5b3G1VrlLOQ4x/KzNViusK0lP
X-Google-Smtp-Source: ABdhPJwNDr/qiNG74QRIq6/oPCyd607LZke6i+enHOPBDanqDiOuDmiArvw8Ojk8rH8fewVJ6bL5aEd0TuiEOR4nZywQFl37x0HF
MIME-Version: 1.0
X-Received: by 2002:a02:a695:: with SMTP id j21mr88590jam.29.1619705888636;
 Thu, 29 Apr 2021 07:18:08 -0700 (PDT)
Date:   Thu, 29 Apr 2021 07:18:08 -0700
In-Reply-To: <311be205-e56a-cc06-dfed-df9aef527268@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002202fb05c11d2a78@google.com>
Subject: Re: [syzbot] WARNING in io_rsrc_node_switch
From:   syzbot <syzbot+a4715dd4b7c866136f79@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a4715dd4b7c866136f79@syzkaller.appspotmail.com

Tested on:

commit:         ccb5e40e io_uring: Fix premature return from loop and memo..
git tree:       https://github.com/isilence/linux.git syz_test4
kernel config:  https://syzkaller.appspot.com/x/.config?x=601d16d8cd22e315
dashboard link: https://syzkaller.appspot.com/bug?extid=a4715dd4b7c866136f79
compiler:       

Note: testing is done by a robot and is best-effort only.
