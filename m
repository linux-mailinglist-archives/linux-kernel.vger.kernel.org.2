Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306513C85A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhGNN5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 09:57:03 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:55958 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhGNN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:57:01 -0400
Received: by mail-il1-f197.google.com with SMTP id a15-20020a927f0f0000b02901ac2bdd733dso1135782ild.22
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 06:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5iBy0lYSGa09oNnLjcIT0TpubGTNL6rsWEE+k4WZlK0=;
        b=LSDy6ePr2aecrUKVcetERAXD+V8nsS87qwN1ZbYIbx+J+vyY1cMmou3gR3+2mO7z/J
         Dwap33A3RisTXSQIX4rvDp4lQ5ggKWxhkEBHWxxcuLUfvrLNhuFjvgZCSEBitVnyYqNM
         gEU7PNAkYGHm4U11mpbcxQMWZ+y+aniExh8Mmc/IABxBSAHfuTpX60IgiibbeYkRoFVy
         KHbEBsD2Ps/Oh4KE4QVbs5gzCKrjr0aCio95PfWgSWNoof+05gy3kF+86XmkxvJ5mrcD
         yNGQAknq0qVSPpgxqgf9nUVontrwZmrK71TX4LAhdQV50+Tsgb2EwdhcBYLHkTqU2WRW
         rVCw==
X-Gm-Message-State: AOAM530iVJvX7XL00sG+IjV+bIhRYTcIOU0hbVdW0/dSfOlCw8SV5W/D
        +j+bptVxEHBUoeAyT64LmQ9kRzX0hc5/7sBA3HZKOdyriGnH
X-Google-Smtp-Source: ABdhPJxdriFY6cRso6foqyHhWvZJZlr8sMQZFvXXGupXDK0NKiVdeKKS73K8wdaZOOY5jX5ldI66/IVlGmnDFv2tDrcjXqj1djd6
MIME-Version: 1.0
X-Received: by 2002:a92:360b:: with SMTP id d11mr6696974ila.111.1626270848535;
 Wed, 14 Jul 2021 06:54:08 -0700 (PDT)
Date:   Wed, 14 Jul 2021 06:54:08 -0700
In-Reply-To: <20210714135157.mz7utfhctbja4ilo@wittgenstein>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c529d05c715b0e3@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
From:   syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>
To:     brauner@kernel.org, christian.brauner@ubuntu.com,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        gscrivan@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org,
        stable@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/ on commit 595fac5cecba71935450ec431eb8dfa963cf45fe: failed to run ["git" "checkout" "595fac5cecba71935450ec431eb8dfa963cf45fe"]: exit status 128
fatal: reference is not a tree: 595fac5cecba71935450ec431eb8dfa963cf45fe



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/ 595fac5cecba71935450ec431eb8dfa963cf45fe
dashboard link: https://syzkaller.appspot.com/bug?extid=283ce5a46486d6acdbaf
compiler:       

