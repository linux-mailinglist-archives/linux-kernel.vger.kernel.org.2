Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D621236DE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbhD1RgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241924AbhD1RgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:36:11 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9753CC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:35:26 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u16so46512283oiu.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Bch1oq78dAKG4OuGE0cpushN9U1V2L83n1Hncb6KNXs=;
        b=CKZmEMvLLQPT2T4K/7ACKFBrXF7Dhdf380FQNA5cqQe2irjZ403gMdDlBX+1W1xC9k
         +VOkxWalv8VgGr2ROCyoY8e3Fh6wGVkbIl5wUhoKy2BUfl77SzXazI9cTUDh/4lx9FBx
         NhNHj8hpxlEVoyIAK1PkDcGUdomELhUJffyng2SPlDZsWUew8rVgpV1sedEuEBSOBhE5
         gJnsYf6awNVs5XIqjjxh7FF+gD7fHuD1oOeOx/p4mBSBl/SRUqokGX6QwJuluRRJ3+TR
         vby1TYffahtl48jVCMGdyjUD6g+ecCRIJLRhy0GXJPEC931CMqGu4O//P7iWw3l6ilaE
         OJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Bch1oq78dAKG4OuGE0cpushN9U1V2L83n1Hncb6KNXs=;
        b=CjuyYWvo7yL9/e15TE/uhcaol97rRpFwzQBPLcdzvUwsOSyAby1xd1rqwtma8t49Gx
         aHBJlTT5OBA6omxPUo8wX8MhAr29xbTCwtdN2n3rNpp9SiWlD7auDvQtNyGhDdBiZIBk
         v5B1B0l+k3Ur4HvCRUpiXa+aEI10xxh1m1dLwntYp0WAztUI95eLobDmrNtGzzC0ruD2
         aKQZc786592FwZTDFCd0K6UZFqy9ld6LZEFDH6q3qOiqSITiYQIjTr75Y7eZEymdjG5q
         1dMW4CHNKP0c4EzHI9JWId/UamqUV50g6w6QBBirUB7i76HsnuVrmpQ9MZ677MWrD4N3
         7lMQ==
X-Gm-Message-State: AOAM533FmsjxDsO5elh0tqKh4rL5aFnIFIa3fMST4EP2BsMLWaypr3on
        jR3yt+7976vzZNx0fibeNFk=
X-Google-Smtp-Source: ABdhPJw0Z1soQrHdhdkaW+wEPDLB2epqNABhfB/3YssWKPvMAlY7jlCBUvm5+BDwJlbJ0Qv/t98yvA==
X-Received: by 2002:a05:6808:1393:: with SMTP id c19mr8850865oiw.149.1619631326062;
        Wed, 28 Apr 2021 10:35:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a11sm107487oif.52.2021.04.28.10.35.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 10:35:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] staging: rtl8712: Use list iterators and helpers
Date:   Wed, 28 Apr 2021 10:35:23 -0700
Message-Id: <20210428173523.149958-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use existing list iterators and helper functions.

The following coccinelle script was used to convert the code.

@@
identifier v1, v2, v3, v4;
symbol next;
expression e;
iterator name list_for_each;
statement S;
@@

<+...
(
- e = v1->next;
|
- e = get_next(v1);
)
  ... when != e
- while ( \( v1 != e \| e != v1 \) )
+ list_for_each (e, v1)
  {
    ...
-   v2 = container_of(e, struct v3, v4);
+   v2 = list_entry(e, struct v3, v4);
?-  if (!v2) S
    ...
(
-   e = e->next;
|
- e = get_next(e);
)
    ... when != e
  }
...+>

Compile tested only.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index ba4a71e91ae0..92b7c9c07df6 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -139,10 +139,8 @@ static struct wlan_network *r8712_find_network(struct  __queue *scanned_queue,
 		return NULL;
 	spin_lock_irqsave(&scanned_queue->lock, irqL);
 	phead = &scanned_queue->queue;
-	plist = phead->next;
-	while (plist != phead) {
-		pnetwork = container_of(plist, struct wlan_network, list);
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		pnetwork = list_entry(plist, struct wlan_network, list);
 		if (!memcmp(addr, pnetwork->network.MacAddress, ETH_ALEN))
 			break;
 	}
-- 
2.17.1

