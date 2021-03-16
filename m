Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10F433E196
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhCPWnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhCPWmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:42:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17351C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 15:42:49 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 130so37011882qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lqIWtl2xp+e+AddUQXVvackBapj1JOoVjO6xEMxFDvE=;
        b=OLuyXVyY/gjw2H8U3mPr8kQd+klVqZJYIsH3OnyaRc5Mvbmalpu89rXgMrJEDJejUR
         zJdX2pcJQFrXZpQYkG9FoVAEOrCtzgyrOjphkKMsx/SK8WxSxkZuNejAME1+QNqQMkxc
         vRHqT/kd3MuP/QGcaVVRnO4y8ADBcm5KIOBwYWeZ44T5gQXLekY+Yj7QT5Q6LnEDnQuw
         oMEoHFAGFDZY/OqYcmCMpZvrwLR7PvCOTCWzeYXLiZQmk3YgWsS3N/DBZiN8xswiGJDI
         I2rX1MzMaPX5wGQrgABqdo5TTRWRSwA8mv+k4TTVMLNLnDsp4M3DmSepEtNFwja5qPhi
         dKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqIWtl2xp+e+AddUQXVvackBapj1JOoVjO6xEMxFDvE=;
        b=NmUM8CHB/Krl8Y6m9fLeRR8G22hVFcbns1gUr06cMF4XiIackC/2B2SVl/lA1XkdgM
         lpAY3fUxUHUBSpjvFhxoDRYZ2LvW9FVAQcoYUEr08ige1eUdy22DfH+/JO0VqcareLRM
         xvY/DWApI3t6+W7LmQINrLtKbIYc3y+FUFSQVWgzms+HQjToP5BgIa5ffsrvBRfv6nLm
         FNFdKtLHWpgV5gpgS8WWiISkCVywUc67AFsD6ueWa6QTLz0D+mUo/w/K/G48M2wuV9Ra
         czcNSiH0f5Jjc0E1AruHp7i2gZASMnaDQQhj6o2YR+tjDPLRBo4coQ7hS93rQW+RC/a9
         FByw==
X-Gm-Message-State: AOAM533O/dzIx/BVmeroCBO1E4K9bjiZKhwcetJYQ4/MJOag1oX7JG5Y
        HYZEQSNaxFl1FOnFFByC9e4=
X-Google-Smtp-Source: ABdhPJz79rOT1uhDyZDcaPJd5ysjnwFbB02Wr0OLc/GTAa1Yxlkw25PqAtnwJwo0WDFMTv4MkxdYtA==
X-Received: by 2002:a05:620a:1323:: with SMTP id p3mr1433214qkj.175.1615934568309;
        Tue, 16 Mar 2021 15:42:48 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:ec35:b39e:95f4:3370])
        by smtp.googlemail.com with ESMTPSA id e15sm14444880qti.79.2021.03.16.15.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:42:48 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: das800: fix request_irq() warn
Date:   Tue, 16 Mar 2021 18:42:26 -0400
Message-Id: <20210316224227.348310-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <92b7c57b-b645-9965-8157-4ca76a803cba@mev.co.uk>
References: <92b7c57b-b645-9965-8157-4ca76a803cba@mev.co.uk>
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

Suggested-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/comedi/drivers/das800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/das800.c b/drivers/staging/comedi/drivers/das800.c
index 2881808d6606..bc08324f422f 100644
--- a/drivers/staging/comedi/drivers/das800.c
+++ b/drivers/staging/comedi/drivers/das800.c
@@ -668,7 +668,7 @@ static int das800_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	dev->board_name = board->name;
 
 	if (irq > 1 && irq <= 7) {
-		ret = request_irq(irq, das800_interrupt, 0, dev->board_name,
+		ret = request_irq(irq, das800_interrupt, 0, "das800",
 				  dev);
 		if (ret == 0)
 			dev->irq = irq;
-- 
2.25.1

