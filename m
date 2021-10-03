Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AFB42043B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 00:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhJCWJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 18:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhJCWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 18:09:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483DDC0613EC;
        Sun,  3 Oct 2021 15:07:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id l7so33640664edq.3;
        Sun, 03 Oct 2021 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+zfN8c5xt2vdVy2ldqN2FzfEzIZMzL2oB0grlacJ+c=;
        b=WWUitL54IQsvd5vbR9xZi8MJcwF1ITohE4FFpcPuUFsW+DwvcGctwofvxeVirDrXN7
         PcGQX4ftIdWB3VR4qaoKGU53ej2/SXUkmNgWAkYPrYRUohZSykaMYXQGWy2khY+zSjZR
         dEJQcqJWtnBVYctJiLeDATkF/MXvBcoKfHnYsn9Ix6UqzX+6fYeedRTrq0QfBBcRGM+h
         E1rL9vKfa4Al0Ui88mFS82Mimcd5oixSk/Fb/o+mj45JASBqkq9CmqeivQAoC4FbzNUm
         dozniYhwWKPhTbwju4VtHwA8139yEP9yDMVlMmsWi87aVivpHD7zVHptoGA5UrB9T9HH
         vPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+zfN8c5xt2vdVy2ldqN2FzfEzIZMzL2oB0grlacJ+c=;
        b=CWrxNFp0TUQojnHI/RzfJZVrzwphOYypkTSbh4L9DL6pFkEseik/GEKp5AoY6l4tC6
         oaHQ9yk+LA9S47OgK/vPdEol3+wLX+7afqhYnMt0glknEWj0MqJuqW7YjnjeNR26MNA2
         5/bZHe4TeNdnAQkhJA7TyiJHkZUmehqLM3rQzuVV38e1EFCiZR9+pfvZOvfDsiCk8p5r
         +NuQDa8M9Gm3KNHsHV8Q6TPdc7gps8b8QFR3l8uOGMKrJwGYhMSagup18A+Mx6UBNOqe
         +3JiLal+fZvUjFyIQrAQRQ7tqKVeGNJ/cWtMrUCdKy6UeJezy0A4lOVqZ1RA7vGz/EEP
         tZyw==
X-Gm-Message-State: AOAM533zdTiwOwLrPDnYBoqvma3AoMvspDmSzmYSH6Ff2jIZhfoH2Xjr
        kM/M9vHEBUlabEhMiFsyckI=
X-Google-Smtp-Source: ABdhPJwcEjZHbb+i4MoySgtqmwdAwNLoEBlcDprkT5Z3GDVoW2QLHSZllQ4lr4cCBlRg8KN60adQIQ==
X-Received: by 2002:a17:906:cc9b:: with SMTP id oq27mr5987560ejb.17.1633298838643;
        Sun, 03 Oct 2021 15:07:18 -0700 (PDT)
Received: from tom-desktop.station (net-5-94-68-71.cust.vodafonedsl.it. [5.94.68.71])
        by smtp.gmail.com with ESMTPSA id dh16sm6246702edb.63.2021.10.03.15.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 15:07:18 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: update file link location
Date:   Mon,  4 Oct 2021 00:07:04 +0200
Message-Id: <20211003220706.7784-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix web error: this site can't be reached

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 Documentation/process/submitting-drivers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-drivers.rst b/Documentation/process/submitting-drivers.rst
index 3861887e0ca5..8413b693d10d 100644
--- a/Documentation/process/submitting-drivers.rst
+++ b/Documentation/process/submitting-drivers.rst
@@ -185,7 +185,7 @@ Linux USB project:
 	http://www.linux-usb.org/
 
 How to NOT write kernel driver by Arjan van de Ven:
-	http://www.fenrus.org/how-to-not-write-a-device-driver-paper.pdf
+	https://landley.net/kdocs/ols/2002/ols2002-pages-545-555.pdf
 
 Kernel Janitor:
 	https://kernelnewbies.org/KernelJanitors
-- 
2.25.1

