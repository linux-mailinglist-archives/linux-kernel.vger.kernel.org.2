Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD91A3EABDE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhHLUgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:36:35 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:52004 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhHLUge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:36:34 -0400
Received: by mail-il1-f197.google.com with SMTP id g9-20020a92cda90000b029020cc3319a86so3811703ild.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sBYzu++XtTyiMNxgm0IaBQVBwqzw9O6kfSOlaQ8ZUzI=;
        b=ZV2fZw/kZuK5tmV0TLy2lq0joqKBuuE/OkEtKBqPl+z1CqWQBEgxQ3pIQi2bwH/IoG
         Ttq4joGNpVjjS8uCRQwWhsHO6Nt7bqCY38JWvlpSbLLrsYh8gaQzTL3KsYukEEV1/3eY
         rsonSxfDN6m3Eh70Ws+s55sXwOj3upQV+ccb3dbjjPYK/vJQE+STyw7x+Hhc63qOCH8j
         m0k6UJSOxX5OzbPxlhIgWdK23s7mdiJWR0Mkje8Ecn9CUOk2PvwLdJ/stJhiRooGbA5J
         n46FGpFmnkNbz76HPzMRS99GkoaNaahZNAOqEU1eJGKHtH0l3/oKrUTLN9y3EurufE1F
         oCPQ==
X-Gm-Message-State: AOAM530OM5yYPp0Wjpom5oPQhWoh+Z6R3uH//QhUVlMpQZI0YFBdJqbp
        iK2BP7c8Tqg7JOuwXuRgMqcgsWDTA1UzoNlCXJaSha2J2hUG
X-Google-Smtp-Source: ABdhPJw3XIRV+yx+RFhY33oFm2MfAtk/nwcxE0vdHJIYzGW+3k2IatJ4phFZ9UIf7JXcgVp/MEmL09rGjcQb9UcVNC5Ho6FryfrD
MIME-Version: 1.0
X-Received: by 2002:a6b:ba02:: with SMTP id k2mr4427251iof.164.1628800568256;
 Thu, 12 Aug 2021 13:36:08 -0700 (PDT)
Date:   Thu, 12 Aug 2021 13:36:08 -0700
In-Reply-To: <6f7d4c1d-f923-3ab1-c525-45316b973c72@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047f3b805c962affb@google.com>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in iov_iter_revert
From:   syzbot <syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com

Tested on:

commit:         bff2c168 io_uring: don't retry with truncated iter
git tree:       https://github.com/isilence/linux.git truncate
kernel config:  https://syzkaller.appspot.com/x/.config?x=730106bfb5bf8ace
dashboard link: https://syzkaller.appspot.com/bug?extid=9671693590ef5aad8953
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
