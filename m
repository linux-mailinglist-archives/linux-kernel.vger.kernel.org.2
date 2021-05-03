Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCC03718F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhECQKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhECQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:10:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E83C06138B;
        Mon,  3 May 2021 09:09:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m11so4475740pfc.11;
        Mon, 03 May 2021 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUYBn+OTNN4XwS0aZ2myRI9DCSukHpwMPNNUN+38vZA=;
        b=GWFUGV0gR/b6H5JEnNxwqyOS4/i3m+9yZFMp8uPxS9vPrYl9at930xWWr4KxGqPm1b
         H+hssjNnyXZljkxFe+BuBtQSO6WqjIE50KXdG4sX7rgEeSaRP7zn1dE56vYvOudxEmM1
         Ry7oFhsn8jjd7+YVcf9fQiDjYIW+UQnSk7xU7WAhADjmDX5hPIeEFYrPPaoJlc0hV9Gl
         xTGrF36XzUmZn12l2/IqpHzYsIXWirx9sRfanaap+N3F4Rit1vdSuxmfewZSMgDImNeI
         EExroDMd9nYAi9bdH1hBYfDlp/+MIrad9u7YGJVg0D7pFctolUH4I2oWiXDgNAuzQSii
         e5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUYBn+OTNN4XwS0aZ2myRI9DCSukHpwMPNNUN+38vZA=;
        b=YJ4gleW/Oudz15EGtHqtKefSFZVjt1x3gg9DqYJHTCqZDC3AB1dhb3i2v/Ud+xz4bo
         Zz8KksMAvTGNHXWKSJVCP6DaJTVNTI8HW4aNGjmycaICpyeM47k7pLXEQMpVluTGSArv
         ljwiS+Gkfp4upx9xd/DOg50X93wn9pGdTAkl4P3Kx8HgI5hYit6dNgcQyfUCvzwpt3YQ
         jUnUI+fFwo6r/7aBWxzkOE4pYIpif7qcUKhRXCS8fDwGniZGRsadcriRaINfbjCHPse1
         1P8OOAxVOoKdW4ObVLxmp6EgfXp2hDla66TB77lbOJ1ih/vHeWWOK565NIUKMhs1kv3C
         F7/g==
X-Gm-Message-State: AOAM532nkrTig+yKzOQnLkm5yN1nWtuS3Dx2VToJfY6dxV8clfbRrpzW
        RTFmLKEXKK17KUjxHNlpx535CXhndcjNpgmn
X-Google-Smtp-Source: ABdhPJwwQ4SEfJncS3DjFky0jrtAzabFr/NwGRIk+x6cUIS0pKjHWg2e9HNk4xF83fmQn3htuPaNUg==
X-Received: by 2002:aa7:8198:0:b029:274:8a92:51b5 with SMTP id g24-20020aa781980000b02902748a9251b5mr19595593pfi.5.1620058176881;
        Mon, 03 May 2021 09:09:36 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id i14sm41758pgk.77.2021.05.03.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 09:09:36 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] usb: gadget: function: Fix inconsistent indent
Date:   Tue,  4 May 2021 00:09:27 +0800
Message-Id: <20210503160927.6482-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove whitespace before variable

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/usb/gadget/function/u_hid.h  | 4 ++--
 drivers/usb/gadget/function/u_midi.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/u_hid.h b/drivers/usb/gadget/function/u_hid.h
index 84e6da302499..98d6af558c03 100644
--- a/drivers/usb/gadget/function/u_hid.h
+++ b/drivers/usb/gadget/function/u_hid.h
@@ -29,8 +29,8 @@ struct f_hid_opts {
 	 * Protect the data form concurrent access by read/write
 	 * and create symlink/remove symlink.
 	 */
-	 struct mutex			lock;
-	 int				refcnt;
+	struct mutex			lock;
+	int				refcnt;
 };
 
 int ghid_setup(struct usb_gadget *g, int count);
diff --git a/drivers/usb/gadget/function/u_midi.h b/drivers/usb/gadget/function/u_midi.h
index f6e14af7f566..2e400b495cb8 100644
--- a/drivers/usb/gadget/function/u_midi.h
+++ b/drivers/usb/gadget/function/u_midi.h
@@ -29,8 +29,8 @@ struct f_midi_opts {
 	 * Protect the data form concurrent access by read/write
 	 * and create symlink/remove symlink.
 	 */
-	 struct mutex			lock;
-	 int				refcnt;
+	struct mutex			lock;
+	int				refcnt;
 };
 
 #endif /* U_MIDI_H */
-- 
2.25.1

