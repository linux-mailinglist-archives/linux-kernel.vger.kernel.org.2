Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A929F44D8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhKKPOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhKKPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:14:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F606C061766;
        Thu, 11 Nov 2021 07:11:30 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so4850658pjl.2;
        Thu, 11 Nov 2021 07:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmF8oaKXdehvlU7w3N66ru34AoYsrAlhOIntXiiS+Ig=;
        b=DNsXpaoD8pIkk7y1aw7Ej5nRrTbVd0emPHCb9lAINzZTrOvHt3lKTKZV4CAvlkJaCS
         suAKTAJVBIZc2GlWC5wJ2WGklNZe9oe7SJrH65Yn1VIqnLP1mWdwRmkuxp/3ERUDaTHY
         kggzoWZi7gv2JLgvmqQa5o12WeHkmoDT5iQnRpgiWnZXVJHhosgxiz+2T3Y5ze851nj8
         MibYwgm9o/S7R0otE3I4PXgz0KquYJRbilt+CGFlOi7R2aMJAIpZqb3CEBwero6H6pcJ
         u/tafsvDIsP0nHSCIuYDnByeGVkZOv4N8a48vKqsGtuH1CtyMXDMyo5jCDltQPHHK1kj
         7zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmF8oaKXdehvlU7w3N66ru34AoYsrAlhOIntXiiS+Ig=;
        b=yuh20ywRjDbKtAcNX1ZblIiHFptwQa4HvHfUmoD6QWuSqQ2NFCUi1Mfn+Doa7tXr1T
         n/l+74Q0NtsckisCBl6ZoVSrFSjK0PT2d7OivsFJL+w7n92hvXIsJfaw0P+KHJP5D3ej
         3A4DutVuU9tA1Faz2fxf8hsaqS4imbLeGLoE0AVxR2aq/BPNvYy/DU6ruvy+0FzJJ4/X
         SP/JdRqlEwaZOPCRswmx7joKYf1pfo1zm7FJnSMj7G1uftHS7QGIxRM4EQtyIED7q6IK
         t5ILJIF6/YqxVeyr4Rvi1XmiYn32ntU9OvM6nrxtroD4UPY94Ek/ow81qOcwBNOSkf2P
         xuKg==
X-Gm-Message-State: AOAM5304JU+82QbqTgsa+S9J4tW/DOzvPh37SfFXyBfSuvSlOS1f04Tw
        ipOVwOa4GdRIiysuVnFqrvw=
X-Google-Smtp-Source: ABdhPJxzxk89QuuAs3yQtOJxVIoREnik6aKgPIsAgmMeoBIi6y1rZb7kvBfYz83fidYaj3RY13sRWQ==
X-Received: by 2002:a17:90b:3ecc:: with SMTP id rm12mr8891072pjb.75.1636643490033;
        Thu, 11 Nov 2021 07:11:30 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h25sm2122183pgm.33.2021.11.11.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 07:11:29 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] USB: Delete the useless assignment to "nbytes"
Date:   Thu, 11 Nov 2021 15:11:24 +0000
Message-Id: <20211111151124.2659-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The assignment of the local variable "nbytes" in the if statement
will not be used

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/usb/mon/mon_bin.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index f48a23a..b8ba0f7 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -845,7 +845,6 @@ static ssize_t mon_bin_read(struct file *file, char __user *buf,
 			mutex_unlock(&rp->fetch_lock);
 			return -EFAULT;
 		}
-		nbytes -= step_len;
 		buf += step_len;
 		rp->b_read += step_len;
 		done += step_len;
-- 
2.15.2


