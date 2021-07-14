Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3D3C85E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbhGNOTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:19:05 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41807 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbhGNOTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:19:04 -0400
Received: by mail-io1-f72.google.com with SMTP id b20-20020a0566023314b0290523c137a6a4so1310611ioz.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 07:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=o7vzzn8Fdqo6mJv/pLO3d3/VK2CXYs/bZovvWQfPikg=;
        b=D6ye+7MwDY8Nb1mdEeittIGx5aj1XbKE8GQCxPrd+X0eMhW1R1u9lx75+Y6jWzUIYV
         uTxENf6AJTfW2wUrWLbEf+q/Y1oFfxkeEo7XUQKH4+lpcDH2ci7WsAW/DB+xyh8522Lx
         sjOpDKu4ByLxK6+B5zl35Fbu80aI5eOv1EnowmXHSq87BijA5jexETFoYl9tGG02RKDr
         eVtQTXOx874heeLBUCaPvOl/rzjZTnKUL+PK11jjG9pSD1GzZn2NDE4Z4dzqgMdCI7aK
         QLRZTG1SpAw+XjsELuH32LHJZaflF2d+RksUAWHYYNPdZuY937KteTCqrNmvcE9wWMZa
         eFew==
X-Gm-Message-State: AOAM533HelkiVN57b0L4FlO3NmgHv381NqRIKBK8cQ2sD9Z5CqUHtq2+
        0S7HvC7Ze7cBuNwcbef4g8n2hXi9vwaUrIiW9RrjdaYYfOwp
X-Google-Smtp-Source: ABdhPJyn5tnlHP/kmIUxY05yxnh++4KY2h8hZkCs4WMGvpSLvMoszqGmE7eJ+eEIVEap1ROsNTlb3lNO/a43b+1kLs7gtu5pRZC4
MIME-Version: 1.0
X-Received: by 2002:a92:d3d1:: with SMTP id c17mr6620254ilh.86.1626272172775;
 Wed, 14 Jul 2021 07:16:12 -0700 (PDT)
Date:   Wed, 14 Jul 2021 07:16:12 -0700
In-Reply-To: <20210714135756.ammzl2vfiepzg3ve@wittgenstein>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002aa03b05c715ff73@google.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com

Tested on:

commit:         595fac5c cgroup: verify that source is a string
git tree:       https://gitlab.com/brauner/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=20276914ec6ad813
dashboard link: https://syzkaller.appspot.com/bug?extid=283ce5a46486d6acdbaf
compiler:       

Note: testing is done by a robot and is best-effort only.
