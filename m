Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A0533C747
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhCOT7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhCOT7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:59:24 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B572C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:59:24 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id l132so32972212qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jd1itG+6TUw6q8b36SZco9wrJWxHOwGWk3FWOJYAGNE=;
        b=SeN/Jvy8tR5ZKrKN/+F/dGjUsysy0IxYv0z+fi74xgna+4MDRtUfQSDnO5CUzjxVo5
         /d72FFQFVClkjooLU/vyqJpZzt+1NwWkpbwWI4EkMR3b0aSF7p9COu9cXRPImiUxhrIj
         srVKn8OBCvkUSqHTlqbu++CS55ooT216XOSOud/eQFewQkssvpz3F6xAtMd8g7ZHhekc
         Crxxtrs2YmDbOHW/avvGt67HCyd32MyEwGvlPYFnVRrCbz3tJb120kbytX7zgZ6Nc/Hm
         ePmCEz5va+ms33jp5pmsbayifndx+QiJjO+rWP53YntSMo0fHe6oHN7xElEP8AZf0psL
         VKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jd1itG+6TUw6q8b36SZco9wrJWxHOwGWk3FWOJYAGNE=;
        b=o/51+vdTLwuRMHtDAuCQRjDI3TfIrfAC8j1ex4JkkYijBntJa6yZ34twFqax4lm9Ae
         hzQ5hbWqnaYu3stfKkNcC1L9Sj3TXAWlmbhJAJPXzySxUOrWgT17pFXLk2n4wwIzPddI
         FoEKGjeYShjZ16d8O/eg6oVFtH82nRDl+vjplZV9IHNIyJW8N3mE/GOTISntEOlRsU0L
         91aoJmoRlVk2rPgqzlPwHmmIRFayL1JK/sLies2T6ufeyCcyKeGv1tS6T+En7GTRbrqD
         cVstQOTrdxRXpTjYq32qWqVDu0Q0VU+4/Gkmmc8pqP7vB/WMOa0wIr9GBjhSItjNasWD
         kOug==
X-Gm-Message-State: AOAM5302am3IM2AI4Wz84iQoCqnJY6Y6PL5I7UfW7/A1z9XNudp5TWsk
        O8RQwFJjvbfyvFa/6tC15JE=
X-Google-Smtp-Source: ABdhPJy7bAy99n+PL2rfEcT8aqM6nZdBlRf/rSV0J1+2Bu6teVHqoftDGrUgPGGnhE9VoIV5xhR7tQ==
X-Received: by 2002:a05:620a:15d6:: with SMTP id o22mr27274475qkm.181.1615838363717;
        Mon, 15 Mar 2021 12:59:23 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:74e5:7488:fd7b:4bf2])
        by smtp.googlemail.com with ESMTPSA id l6sm13741352qke.34.2021.03.15.12.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 12:59:23 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: comedi: cb_pcidas: fix request_irq() warn
Date:   Mon, 15 Mar 2021 15:59:14 -0400
Message-Id: <20210315195914.4801-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <393f3925-9dbf-72e5-4d9b-2e213a6a71cb@mev.co.uk>
References: <393f3925-9dbf-72e5-4d9b-2e213a6a71cb@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() wont accept a name which contains slash so we need to
repalce it with something else -- otherwise it will trigger a warning
and the entry in /proc/irq/ will not be created
since the .name might be used by userspace and we don't want to break
userspace, so we are changing the parameters passed to request_irq()

[    1.630764] name 'pci-das1602/16'
[    1.630950] WARNING: CPU: 0 PID: 181 at fs/proc/generic.c:180 __xlate_proc_name+0x93/0xb0
[    1.634009] RIP: 0010:__xlate_proc_name+0x93/0xb0
[    1.639441] Call Trace:
[    1.639976]  proc_mkdir+0x18/0x20
[    1.641946]  request_threaded_irq+0xfe/0x160
[    1.642186]  cb_pcidas_auto_attach+0xf4/0x610 [cb_pcidas]

Suggested-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: revert changes to .name field so that we dont break userspace

 drivers/staging/comedi/drivers/cb_pcidas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas.c b/drivers/staging/comedi/drivers/cb_pcidas.c
index d740c4782775..2f20bd56ec6c 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas.c
@@ -1281,7 +1281,7 @@ static int cb_pcidas_auto_attach(struct comedi_device *dev,
 	     devpriv->amcc + AMCC_OP_REG_INTCSR);
 
 	ret = request_irq(pcidev->irq, cb_pcidas_interrupt, IRQF_SHARED,
-			  dev->board_name, dev);
+			  "cb_pcidas", dev);
 	if (ret) {
 		dev_dbg(dev->class_dev, "unable to allocate irq %d\n",
 			pcidev->irq);
-- 
2.25.1

