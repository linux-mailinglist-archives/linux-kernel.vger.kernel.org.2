Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CE23EE533
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhHQDun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:50:43 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33355 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhHQDum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:50:42 -0400
Received: by mail-io1-f69.google.com with SMTP id k21-20020a5e93150000b02905b30d664397so4756997iom.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 20:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Fmzbu0SFDXh2Dg+PWBp1e31sM7UnYc4n5FDt0nlapDM=;
        b=B2rX9w9JsLk5zh4Shkt5e3J2rH7Se4d78L1ku5AXwdqEyhr1YQBFXdIhLsZBk8SPkK
         nNj/xI/Qvw7MZfCiVU8XKGSIxXcBjaTkVC5sEHgxCe/pSCaYSMsjVJIHuiJO8q0GfkgY
         k6UgANK/TdfqJLEeN3VF31n3xzrQWmUQCfQT8B7lg/dEsfR6dV8A5SFbFGMoNrdzKOwE
         fOmdgdQZTE2M+Otk1SjbK4bhFrBgDB/3u5ztqUxqIUJB9Zb2ewUWhgMV9eqTdGa+0/72
         wwSDkEhFX3jIw2MVdq0tkly6vYYytDiB4AbazMub8hQ+IyZhJwkXUEZ8/mEo+LgpGshv
         LzoA==
X-Gm-Message-State: AOAM531/xgCCKGlT5BroLuqKBsURpI7o13uKwYxXIqs6wgprIihQ1Kre
        TFhG6TjUok+PlzMHh2KE4donDbmop9qTyjTeWxBSxeMBykEr
X-Google-Smtp-Source: ABdhPJzFKLbgYkO4NO4IB3wMusTphhf8Fr7ByRK/bLbrWWNTuOexjXInxkN1IaI1LHp/wtuVHitVRLYN5+PbAgk9W4HftEBBUtwO
MIME-Version: 1.0
X-Received: by 2002:a02:a619:: with SMTP id c25mr1115878jam.1.1629172209472;
 Mon, 16 Aug 2021 20:50:09 -0700 (PDT)
Date:   Mon, 16 Aug 2021 20:50:09 -0700
In-Reply-To: <d13c4e6b-b935-c517-f90d-d8201861800f@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2d86305c9b936e4@google.com>
Subject: Re: [syzbot] general protection fault in __io_queue_sqe
From:   syzbot <syzbot+2b85e9379c34945fe38f@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2b85e9379c34945fe38f@syzkaller.appspotmail.com

Tested on:

commit:         16a390b4 Merge branch 'for-5.15/io_uring' into for-next
git tree:       git://git.kernel.dk/linux-block
kernel config:  https://syzkaller.appspot.com/x/.config?x=605725d47562aa78
dashboard link: https://syzkaller.appspot.com/bug?extid=2b85e9379c34945fe38f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
