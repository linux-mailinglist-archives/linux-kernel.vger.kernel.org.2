Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB8F3C6D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhGMJWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbhGMJWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:22:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1027C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 02:19:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f30so49125161lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 02:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=W4tuK+mg0LJB76V5MiaLNKMBx2WUHN3nWM4vCRmmiis=;
        b=Jjt4sHXOWbQbEjVrO59k/29cFETj57C3V5SW/ptELn7R1GF99dwfJOnwb0WqhZ11G7
         5qlCxqbQDBc0rxrEepxZmGtcfeQfJw2PRMw4WIs/TKnU+hEY1DX5AO3zdEZPNIr5wGtk
         APEZHGLV5mFMmm7cZiCE7yPVQ2qVApGjgH1GxisX3CuEnHDmtTS2Roo8oKo+bz8o6+6C
         Ae4OqyvXqwOVehuDZpxWGFIaeqwHjix7oNxG+n0FqHyRw/jXVIv+Cs6aUPAJwur92iGO
         M/bzUAII7eV5AZs6cNnOD4F0Jwfaq8l/FILayTc7cAPTMCzwbHWO4Y6qU5mRQ6IZkMDZ
         SCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=W4tuK+mg0LJB76V5MiaLNKMBx2WUHN3nWM4vCRmmiis=;
        b=qXEBukVjrlpcuuNr7JrGzi6FfeVSz6UdnQgPPp5v0OtWSPJRYvBXIZO2I8Y1RgLYcw
         8U0rMb+4kQoMrGZb8BM7vW7or6QS7znisNWfNz8XsnCaQfos1jrA6TRKwMEMkJo3wlQT
         t6Z13NbW248K2zdUaIoTltP1svMVeELtMZZuV6Hy0G4QIBovpehyVDK/5QqAXnz2f3bF
         WbpFV4llvBLfjCcxg7MG1LD3AwdrjozDUZIVxYMZ4a7dWmeWod2uA28G+Mluf+VuJKnn
         ViDLbIP8Nrwvgsad+TJJUVR36qYoCEpjQjLqpjg7CKOJBwVezzpb/dcO+6Zq28zZJR/Y
         xS2Q==
X-Gm-Message-State: AOAM532uZ9dJL/7bi4MssC0yppb7Mt6d/J5ZPdluGsUIUrOf4ZmK7wwj
        YcAb0ccRKxl1HFgWfX5BVo0=
X-Google-Smtp-Source: ABdhPJw3vF2sgkC8iZi+tiOHRAnu294bhBWG+D+uonK9hlHmecCXYb7ArwOCXOldRZmon+JqpVRv3Q==
X-Received: by 2002:ac2:593b:: with SMTP id v27mr2681378lfi.234.1626167952932;
        Tue, 13 Jul 2021 02:19:12 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.115])
        by smtp.gmail.com with ESMTPSA id k9sm1035469ljn.24.2021.07.13.02.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:19:12 -0700 (PDT)
Date:   Tue, 13 Jul 2021 12:19:08 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     syzbot <syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com>,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        hridayhegde1999@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, rkovhaev@gmail.com,
        straube.linux@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in r871xu_dev_remove
Message-ID: <20210713121908.181cb183@gmail.com>
In-Reply-To: <CAD-N9QU3jHw_gOiwduF+eATJ_sxcUcMiiBDESBYmZ8NdGH5RCQ@mail.gmail.com>
References: <00000000000087b4c305c6f8a243@google.com>
        <20210713115546.34c99ea8@gmail.com>
        <CAD-N9QU3jHw_gOiwduF+eATJ_sxcUcMiiBDESBYmZ8NdGH5RCQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/3wShYljTxV0=fP0sSRLP4nK"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/3wShYljTxV0=fP0sSRLP4nK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 13 Jul 2021 17:04:28 +0800
Dongliang Mu <mudongliangabcd@gmail.com> wrote:

> On Tue, Jul 13, 2021 at 4:55 PM Pavel Skripkin <paskripkin@gmail.com>
> wrote:
> >
> > On Mon, 12 Jul 2021 20:14:24 -0700
> > syzbot <syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com>
> > wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    92510a7f Add linux-next specific files for
> > > 20210709 git tree:       linux-next
> > > console output:
> > > https://syzkaller.appspot.com/x/log.txt?x=16c50180300000 kernel
> > > config:
> > > https://syzkaller.appspot.com/x/.config?x=505de2716f052686
> > > dashboard link:
> > > https://syzkaller.appspot.com/bug?extid=5872a520e0ce0a7c7230 syz
> > > repro: https://syzkaller.appspot.com/x/repro.syz?x=1639a73c300000
> > > C reproducer:
> > > https://syzkaller.appspot.com/x/repro.c?x=15fcd5e4300000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to
> > > the commit: Reported-by:
> > > syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com
> > >
> >
> > Hmm, bisection is wrong this time. It should be
> > e02a3b945816 ("staging: rtl8712: fix memory leak in
> > rtl871x_load_fw_cb")
> 
> Hi Paval,
> 
    ^^^^^
    Pavel :)

> can you share more details about why the patch e02a3b945816 causes
> this UAF problem?
> 

I am not sure, but I think, that free_netdev() call rigth after
complete() can cause use-after-free bug in wait_for_completion() since
rtl8712_fw_ready is allocated as netdev private data.

I guess, schedule() call after complete() can help here.


BTW, I send wrong patch in previous email: typo in schedule() :)

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master




> >
> > #syz test:
> > git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > master
> >
> >
> > I guess, this should work
> >
> >
> > With regards,
> > Pavel Skripkin
> >
> > --
> > You received this message because you are subscribed to the Google
> > Groups "syzkaller-bugs" group. To unsubscribe from this group and
> > stop receiving emails from it, send an email to
> > syzkaller-bugs+unsubscribe@googlegroups.com. To view this
> > discussion on the web visit
> > https://groups.google.com/d/msgid/syzkaller-bugs/20210713115546.34c99ea8%40gmail.com.




With regards,
Pavel Skripkin

--MP_/3wShYljTxV0=fP0sSRLP4nK
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-staging-rtl8712-fix-UAF-in-r871xu_dev_remove.patch

From 4c25accd0fc806687142aadeaa5b19805289ac74 Mon Sep 17 00:00:00 2001
From: Pavel Skripkin <paskripkin@gmail.com>
Date: Tue, 13 Jul 2021 11:52:17 +0300
Subject: [PATCH] staging: rtl8712: fix UAF in r871xu_dev_remove

/* .... */

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/rtl8712/hal_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 22974277afa0..e81c66cc8580 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -43,6 +43,7 @@ static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
 		r8712_free_drv_sw(adapter);
 		adapter->dvobj_deinit(adapter);
 		complete(&adapter->rtl8712_fw_ready);
+		schedule();				/* to not trigger UAF in wait_for_completion() */
 		free_netdev(adapter->pnetdev);
 		return;
 	}
-- 
2.32.0


--MP_/3wShYljTxV0=fP0sSRLP4nK--
