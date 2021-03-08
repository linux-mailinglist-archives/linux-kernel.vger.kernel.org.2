Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F433306A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 04:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhCHDyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 22:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhCHDxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 22:53:47 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C541BC061760
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 19:53:36 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i18so7592865ilq.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 19:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jfBcYPaGqJRmNnRXl3kKKp++fKO4JboST8Ge5jyVPcc=;
        b=iP3vnqBgO6g6UBsdc6FNQ+TgtCTXWzIxph2blsbQPe1q30swpPVPYVEQl0rTYoIYBt
         BlFHVhYXfTLbMtmmMc8e9+am1JdGY3Xco4L2nt6ZYwb0q99AgZxbdBBzVEosDCxYBulw
         SV1z3TJfcBQ19neLuD9ikHlZPOOH1BHV0SvGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jfBcYPaGqJRmNnRXl3kKKp++fKO4JboST8Ge5jyVPcc=;
        b=g+16JdPsTuKGTanjPuz6rG5TMaLQdG4U7cod2HWmtbET9wAngrseR6ryqdfVU264XS
         n4uXd2nWFC+dQQ8qFtCPqzLBdGAHIQ6kb1j0iLf0jtpFp/CcOrfjhCmkwj+8fcBIb8HP
         KtRV8NiHwIglRRC+Pl0Co47qYp/U563fkBLXRvpdXHcQq8mtJoAEZYQaG4sIVVNB2yL2
         wKrxtu9YMNaEmFqrmvMHJIQtUf9bVJRb1ZCw6aBO1URJRMwkQhvERjb3laJvuRFtKjOL
         eHKtI6uzyr6F0W+dx1+gYBSqOSuoBb9/0TURheVLUL5IOeTgN6S42Vjj9ibf/o4r0HU6
         i7Ug==
X-Gm-Message-State: AOAM531oFrvYAdWDglKuIIUmJYdFmYCSbgTkXfWvKpdLpEq0LP0FH8Ky
        LmlJY+xyin6RHJH/1VDAcrsYxQ==
X-Google-Smtp-Source: ABdhPJwhnJ6mKBfzTVpwyXBlLAIHmtw5dq2N8RMO43ddhwsVBSTwEgp0dMD0+FChqHM1OXs3mLx7uw==
X-Received: by 2002:a05:6e02:e87:: with SMTP id t7mr18241869ilj.211.1615175616357;
        Sun, 07 Mar 2021 19:53:36 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g6sm5605242ilj.28.2021.03.07.19.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 19:53:36 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        stable@vger.kernel.org
Subject: [PATCH 3/6] usbip: fix vudc to check for stream socket
Date:   Sun,  7 Mar 2021 20:53:28 -0700
Message-Id: <387a670316002324113ac7ea1e8b53f4085d0c95.1615171203.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1615171203.git.skhan@linuxfoundation.org>
References: <cover.1615171203.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix usbip_sockfd_store() to validate the passed in file descriptor is
a stream socket. If the file descriptor passed was a SOCK_DGRAM socket,
sock_recvmsg() can't detect end of stream.

Cc: stable@vger.kernel.org
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/usb/usbip/vudc_sysfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
index 100f680c572a..83a0c59a3de8 100644
--- a/drivers/usb/usbip/vudc_sysfs.c
+++ b/drivers/usb/usbip/vudc_sysfs.c
@@ -138,6 +138,13 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
 			goto unlock_ud;
 		}
 
+		if (socket->type != SOCK_STREAM) {
+			dev_err(dev, "Expecting SOCK_STREAM - found %d",
+				socket->type);
+			ret = -EINVAL;
+			goto sock_err;
+		}
+
 		udc->ud.tcp_socket = socket;
 
 		spin_unlock_irq(&udc->ud.lock);
@@ -177,6 +184,8 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
 
 	return count;
 
+sock_err:
+	sockfd_put(socket);
 unlock_ud:
 	spin_unlock_irq(&udc->ud.lock);
 unlock:
-- 
2.27.0

