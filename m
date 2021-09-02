Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199203FF46E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhIBT4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:56:22 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:45572 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347480AbhIBT4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:56:07 -0400
Received: by mail-il1-f197.google.com with SMTP id o12-20020a92dacc000000b00224baf7b16fso1980946ilq.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 12:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=38W35ScS07g6ekDXuVTNyXmTbkWYtJNx19lDEdhawfY=;
        b=BX+Z23+9bfdqU4p0aNhkoA1+Z1ACfYhCeXEfnDa9V51W98PNTVIeXqBuGyNApfg4U2
         1qSQ03EVqFYiQQh3X2yE1Cz+ntmX5/OoGhAXBrNGRObp0V289RO4/Oa27vzXJ1IeynYx
         4nPxgiXkBYY5aAqi/DXEO126lUqzmB5LxLj3u/qB9NENd4kaNQJTEbVgYOqMcHpQp5Uj
         HQzjQxqe6kk3Uh0WC+9Yir7usy1hE0BtARog7Hz+pLdCoetfF90GBuxvcCXVdIVXqTPq
         0XsUxs+AuVXieZCrWrjT0VmH3HxVig25YUy0zxt1CvOkUiHCz+MGblG2qPbVAoMhVFaE
         rNJA==
X-Gm-Message-State: AOAM533V2YBQevdDaZoEMlDJoZM+VLzC9m2QKAdGWdqhBf0/UJrtbTBs
        qpfUdjZ3UpZeu8ozeZdI4q/XsGx3l0uBRlFTa0Rv/1dVNMdJ
X-Google-Smtp-Source: ABdhPJzytE1DAvctVUnDlDSxsxQkuv6mjTkK8YNP2Fqo8BqktTCdgGE2jCx+TvMt+GMhWoSWTQ7WiAXzTXUXufJ9wKX8egOJtPKT
MIME-Version: 1.0
X-Received: by 2002:a6b:8b54:: with SMTP id n81mr39022iod.5.1630612508190;
 Thu, 02 Sep 2021 12:55:08 -0700 (PDT)
Date:   Thu, 02 Sep 2021 12:55:08 -0700
In-Reply-To: <fd90b222-4394-946a-24f8-fe3943e840ab@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000512e2405cb088fc1@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in __pm_runtime_resume
From:   syzbot <syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        paskripkin@gmail.com, pavel@ucw.cz, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com

Tested on:

commit:         4a3bb420 Merge tag 'dma-mapping-5.15' of git://git.inf..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e782839f57ad47e
dashboard link: https://syzkaller.appspot.com/bug?extid=7d41312fe3f123a6f605
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b6fc2e300000

Note: testing is done by a robot and is best-effort only.
