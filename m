Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEDC3C6CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhGMI6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbhGMI6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:58:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345EBC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:55:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r16so28855651ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=sCcLgRvJkR9iKJtE0TZM54SNoR36AJtTDJVyDy1EBvU=;
        b=jpo5cchSZeXcl0k7FRrU2Z0cqs7OHA5O58GKT3ZgQvzf4qGriyzgz+bB5IPBnGoEK4
         rUbXAgyne2TNrdMSxHjrukAMg+BkLrAgYeW3UnTFTRctd9rwH/SxohfRAVBGQVB3v0yU
         vFCB58ihDiFNPsSeGPkBUWGz6TVU/2iQU2X/GttHXVpuSITgqC4GDlbAloQNwVIe2Utj
         ySbL7KPiaPPZ08Q08NHUscGBqQHparjyJsaF0BOJZfyb+S0TCNZUywO8s65141u/8BmU
         ToH5fASJwe7ONSVsmbPJeIMpyex6lblpy5zCR374Znx8sTJcsbvM4NTaju9jjgv5xyzF
         B9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=sCcLgRvJkR9iKJtE0TZM54SNoR36AJtTDJVyDy1EBvU=;
        b=TAEyRiCHYJvVc2FahS+HC3XOQqFfWkf0FdZtMtZhSpd2yxXOhC9EFfQ0KMQkluZVoT
         pHJKUVAwIwqpB9omsoSX47tDevzrtP2AWKowDZs+wMkrhqLhhZ8lNFiXEQnfCnVl1/mJ
         q8a3wNtBcHYoVNXaYS02Ohc9hZh8eifEvQZMitBMaknhKPOpY4iYht9KB8l+tzhoyZO2
         ok0y58ujePM/kCKE3Y6WlP2l2acBBJOwIYjsfqO/Ei6LuCzQrbikAs1R5wvLX0JVUgik
         uDpgbPCVK5vPxscQ46eHkFkMqWs1fh4WuzFQil7kRxd0eva7viFhE5NVH4pakUeMrMXv
         3NUA==
X-Gm-Message-State: AOAM533gd9Qu2VIPPv7OaNsuP3u8DB55L+0ndcBBdLceWKWv92we9fJT
        NBbD5G4UbHwW7Eyb5x5iPMs=
X-Google-Smtp-Source: ABdhPJzA5YMCxqv8RW16fmfOS/+n2kCTf5c6JnAcc+y7+DRGvciQPj/CDujwL1iiJSMUWdyxa8DAmw==
X-Received: by 2002:a2e:b80e:: with SMTP id u14mr3289392ljo.204.1626166551528;
        Tue, 13 Jul 2021 01:55:51 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.115])
        by smtp.gmail.com with ESMTPSA id z13sm1516882lfb.40.2021.07.13.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:55:51 -0700 (PDT)
Date:   Tue, 13 Jul 2021 11:55:46 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, hridayhegde1999@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        rkovhaev@gmail.com, straube.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in r871xu_dev_remove
Message-ID: <20210713115546.34c99ea8@gmail.com>
In-Reply-To: <00000000000087b4c305c6f8a243@google.com>
References: <00000000000087b4c305c6f8a243@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/1xeXNtIU994YuIz1.xGs_4k"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/1xeXNtIU994YuIz1.xGs_4k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 12 Jul 2021 20:14:24 -0700
syzbot <syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    92510a7f Add linux-next specific files for 20210709
> git tree:       linux-next
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=16c50180300000 kernel
> config:  https://syzkaller.appspot.com/x/.config?x=505de2716f052686
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=5872a520e0ce0a7c7230 syz
> repro:
> https://syzkaller.appspot.com/x/repro.syz?x=1639a73c300000 C
> reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fcd5e4300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit: Reported-by:
> syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com
> 

Hmm, bisection is wrong this time. It should be
e02a3b945816 ("staging: rtl8712: fix memory leak in rtl871x_load_fw_cb")

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master


I guess, this should work


With regards,
Pavel Skripkin

--MP_/1xeXNtIU994YuIz1.xGs_4k
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-staging-rtl8712-fix-UAF-in-r871xu_dev_remove.patch

From 954ffa9067907a5f6d4d6d2b72a98b8773cac11e Mon Sep 17 00:00:00 2001
From: Pavel Skripkin <paskripkin@gmail.com>
Date: Tue, 13 Jul 2021 11:52:17 +0300
Subject: [PATCH] staging: rtl8712: fix UAF in r871xu_dev_remove

/* .... */

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/rtl8712/hal_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 22974277afa0..c06d31784cd4 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -43,6 +43,7 @@ static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
 		r8712_free_drv_sw(adapter);
 		adapter->dvobj_deinit(adapter);
 		complete(&adapter->rtl8712_fw_ready);
+		shedule();				/* to not trigger UAF in wait_for_completion() */
 		free_netdev(adapter->pnetdev);
 		return;
 	}
-- 
2.32.0


--MP_/1xeXNtIU994YuIz1.xGs_4k--
