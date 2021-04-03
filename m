Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0730135358D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 23:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbhDCVKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 17:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbhDCVKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 17:10:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A4DC0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 14:09:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mj7-20020a17090b3687b029014d162a65b6so186128pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 14:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IWVLq4cGetylmYeeCZo39PJuYByM8tFivG4dPSxGTKE=;
        b=VDI1CPOgECenibvItdnb1mxjiv9HsuQPF7RJ6a8Fvkj46Ud3O9wVXJaHiGN7pJAHfb
         zrIPl0YqF85Xo4OJdQEM3RI/+IMHlSyLlpKu7HiORc9jATk1TsqaPrNrT6GCO7IkA8Ie
         J4aYwyqhaK9ztY+k3J35iyfizTJLYQJCettOhK3jOTmBlyYlvRPIfEXBVdnP/4YClsbQ
         PLVklhuYJpfgc/sYlrZq3sm5z6XEUlgo2WDwfcX169H/J9lnfGYvIVaJJSsFiFEODldU
         iYoMNwjZO6WwtaZjVRpkdTP7FyTzvLc4YdIxlHzPfb5+iQ78UPmf4I4bMkrwjEFo92C+
         zQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IWVLq4cGetylmYeeCZo39PJuYByM8tFivG4dPSxGTKE=;
        b=eALFF2+TFX/Lan3cqnCpST5NMqfZQuJwzOSPLDhY4deNYo5zmz0QWYVGvUb+O9VY9v
         jztq1pYK7j0cYO8zqQxRP5wHA+TVgfp6k3ez0SxoLtr5RKJXtpeTbvACbd/7QdZMJVFj
         YmUTtpG1p7+2yNvZ/wtJjDbUaGcOE3UrdfbEUANVBgaKZdjzDsU1TTWxnjbOz+zcb5F5
         ITTbONxZZJOjymccL5nhal1Y+F5c9lKBYtxarwaJWonN2REVQxVKkaGlokvmG6hKsHWa
         dbh16ZPLxeouZtoxHvsISco1jGJZg3L8nR/n8UXvAYormNULfbCB5WR+V4RQWFY6P0Ko
         YZRA==
X-Gm-Message-State: AOAM532s2FpWlPy+V8wEKYK16PAMI71f7to2Mz4lCc7LQWvzmyOI3c0a
        UG2Hm5cqhpNNU88bPBWG1gk=
X-Google-Smtp-Source: ABdhPJxhE5EJ9rfWUx1ZpiMrI8xHdQd5ciCxdftyndGRFA/YTc6IS/33qX3EY71OOLDKk8fNGobvwA==
X-Received: by 2002:a17:90b:4b92:: with SMTP id lr18mr20181032pjb.86.1617484196282;
        Sat, 03 Apr 2021 14:09:56 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id j3sm11628447pfi.74.2021.04.03.14.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 14:09:55 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        insafonov@gmail.com, martin@kaiser.cx, simon.fodin@gmail.com,
        straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH] staging: rtl8188eu: core: add comma within a comment
Date:   Sat,  3 Apr 2021 14:09:30 -0700
Message-Id: <20210403210930.17781-1-deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comma to separate repeated words in a comment. The comma preserves
the meaning of the comment while also stopping the checkpatch warning:
WARNING: Possible repeated word: 'very'.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index ed81cbc5e191..99e44b2c6f36 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -1243,7 +1243,7 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
  * If we turn on USE_RXTHREAD, then, no need for critical section.
  * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
  *
- * Must be very very cautious...
+ * Must be very, very cautious...
  *
  */
 
-- 
2.17.1

