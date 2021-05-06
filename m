Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE7E3753E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhEFMcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhEFMb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:31:59 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3295C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 05:31:01 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m190so4644005pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 05:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RR3dZdp/VK2Muje3bXWm6Lpe9EE0E2zXFsIAZLskmB4=;
        b=X3ybHLVLqun3UNpMR2ZigkNgfp6Dh4xJr/KOtrlTfVvYkuyWPUqINqE9SFQE1ldLkj
         1D8PvIWOeqCphKbLAk3cye2lu+9J7lCGkJfs6XyxIcjYoROD5IQN8pd7c1wqYEqVciin
         fUsZwr0A9xoF97oGQTcUrJ8SOw+1tVS9Sifz7CyUOKArly0t/Wja1Mn1GWSYB9yXEy5k
         IbZZ5v/E/eONkbnqLtgdl1T/6mcsSkPr+tpeEJhR0hoR4+Xi7BVi6Ykp1aNlwKVM63+M
         ms092QJF8k4iRX7T/KxTz2AMgXPpkabC58HgkgYdUMl0GNKCRSsIF1/LGrxPhxKUvW17
         gH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RR3dZdp/VK2Muje3bXWm6Lpe9EE0E2zXFsIAZLskmB4=;
        b=FuPadQplt7k5DLc3Ok/LGE/GFdewoXC3DAUDQbWZ5iR0/BMALN2ZPfEusxcgOuvKIT
         ymPtc4IgNayJHI6EsgT1VHq+rxZBFnkTTk+ZvkjZp9syyP1kCt5Lgpjeu2IvGBX7MLSq
         d5c32fX21AM+qo7uz2HdHjaHHKnZvyGaUpuTgIWB91f8PwqrZ2zqVoNQOnB8ngUGmOms
         awJcazXJTK6S1CiIcbb6R25n4P3D6GS5MNGzb0LzKAv65T76c6wSiVsSzTJsxqljsM8+
         2IU5qVA+kaaYbXFIXYBe+PYj9nLjlsELANqtLq7Xj8OXUqjvldk2GTCErxmk/MIlvh26
         2pdQ==
X-Gm-Message-State: AOAM5324DJG471oeUC7l6H/TwUfPR7JIGYtjwbGSMzg7+WvUEw3XF46O
        +OdX8tXYJGtSOEUl6KRvj9fWPKACa+LoZVjgvrI=
X-Google-Smtp-Source: ABdhPJwTcoA/YJGQPg3mXQZqfBoxEbeUfx2UAWdxPHocOUl1pny5Sjx9UG06zKFToQJn1cfcUI5b0A==
X-Received: by 2002:a63:160c:: with SMTP id w12mr325002pgl.236.1620304261255;
        Thu, 06 May 2021 05:31:01 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id n30sm2039470pgd.8.2021.05.06.05.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 05:31:00 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ojeda@kernel.org, Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] Compiler Attributes: Add continue in comment
Date:   Thu,  6 May 2021 20:30:51 +0800
Message-Id: <20210506123051.7414-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "continue;" for switch/case block according to Doc[1]

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 include/linux/compiler_attributes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index c043b8d2b17b..183ddd5fd072 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -199,6 +199,7 @@
  * must end with any of these keywords:
  *   break;
  *   fallthrough;
+ *   continue;
  *   goto <label>;
  *   return [expression];
  *
-- 
2.25.1

