Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B83D8484
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 02:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhG1ANM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 20:13:12 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48892 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhG1ANL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 20:13:11 -0400
Received: by mail-il1-f198.google.com with SMTP id p6-20020a056e021446b0290205af2e2342so515252ilo.15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 17:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+kXQhJa+fJj1oLGUaLeoaXrUy7DzmhQ5FyS3er5MIC8=;
        b=bsqYL1ukSkVZ1UJPQh4MicPgmuY1zMeNIzhf7silPAdBZG+C3fKHjTFsO0o781qHJp
         efhDW4T+dm1Dpbqe+izgq56ymu/qiqRE+ek3snsfNRc/LmUEInLtsKWlOxle9LPK9erO
         Ndyv4m15Xcj4gmNJCMs9NSM0RjBb3w/D+jzoXlYV2kF4PZ23V6ReFOUksQrYcsWuw+Si
         dtdunIE+nu/rYyRo35JVuG+Kg/IQLzsH86tsUdvssVVISe9UkIyaGzLwzOpmQCklaZGe
         ST8ydvEsyoAwgWucURVUVct0q65hOcAdk94H8DPqRUi71JiCpSFT8Sk9Lc40Mo2E7mem
         oDoA==
X-Gm-Message-State: AOAM532llL4eSnmu5wxXFJeYMWrkzNN6JYlJqOcQVru2fr592KWDV1+H
        mY7JVSMWU48FcsVW3Sgzd7fxxR635kHz1Af3KdsN5Qf3bb7u
X-Google-Smtp-Source: ABdhPJxKS7QBzWGLOfZKapxMWPpUocrSoWL/uXDgGoIM7MGcSrCjlkUKBMdEtGUhsfsgUxCbkO1MlyvpUq4TyxLB0952Sgcc/mRX
MIME-Version: 1.0
X-Received: by 2002:a92:d912:: with SMTP id s18mr18841949iln.172.1627431190997;
 Tue, 27 Jul 2021 17:13:10 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:13:10 -0700
In-Reply-To: <20210727203056.377e5758@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009346505c823da46@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in xfrm_set_default
From:   syzbot <syzbot+9cd5837a045bbee5b810@syzkaller.appspotmail.com>
To:     clang-built-linux@googlegroups.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, kbuild-all@lists.01.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        netdev@vger.kernel.org, paskripkin@gmail.com,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9cd5837a045bbee5b810@syzkaller.appspotmail.com

Tested on:

commit:         42d0b5f5 Add linux-next specific files for 20210727
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5bd567a6f50f462
dashboard link: https://syzkaller.appspot.com/bug?extid=9cd5837a045bbee5b810
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1204e0dc300000

Note: testing is done by a robot and is best-effort only.
