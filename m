Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245DE330860
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbhCHGnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbhCHGm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:42:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51AC06174A;
        Sun,  7 Mar 2021 22:42:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s16so4373570plr.9;
        Sun, 07 Mar 2021 22:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODgkqx4pNeJ6A9xIx1+aI4dlTAb9Gpe0ejgF29HEIfk=;
        b=LM8gwnrjgswn/vWyVxVAEljwIlFgjuQFE/1uxZ4lzYO5Lr/DZ319KAz2ixUuVy6Xf3
         yztij+p69jUhyp75XLlnQola2FEvFtk/nerfjwh4kJmWsv/ZKGlXPPJigG5RRLfO8Mph
         e3j9Qfjkx3OsQdDr7pdFj/U/NifroFGWbssHxz1D8MQ00CvbNjSyIs/KsSxvZKjGRsds
         PDbC4GZ19+EiFp37E/PbvGmbd0QFGWoCAyDjFNCVC5fSFn+HrReThhXxIGM2/pdxUKaN
         qN4d42Jgv6lSQr1/jwCCFbO+UPREelCwZtZMd6ORNpVyJi2RPYD+WoPw+UiY83QmCh3h
         H/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODgkqx4pNeJ6A9xIx1+aI4dlTAb9Gpe0ejgF29HEIfk=;
        b=pAWdW3QoLaJx+U8TylhcRRS7JHhSiFlhB2WAgipd7A4LozxTjVD9q+ZS8uPR7S/5mZ
         iWJKvDWfjELeWb0hsdm+tnu573EIAgwZ8f/zQY+XzZGCcFJPaDfcLHmkB1zpXdvBEVik
         VO/9qZZBNKAi++C7XkIwttw9lBjFB8RTDX9i2qY12UBDT5TcUooVKMNj7d2PI0liufpq
         msIjphY4nsHTVVPvHhiGN/q33y1Fv3wFgIH530PHthnE1zFRQgoe/P4Y5Zjfu8HgbrUL
         XUWJmEPkTnx8GCPbIYkk1P7g0RRq8+k+vKylr6suFi3doYN+vW8nsW6JTyLz2xkq139D
         Mo1A==
X-Gm-Message-State: AOAM530MCBqGQEYScsDZ5g8VLCr4JPywcAdPkgLb6SLC5vs6ER4Y/Es3
        3qrtkkGXXsT2u1ETLn4L85XCr2jsrScI0o92
X-Google-Smtp-Source: ABdhPJxbJGuwvYp5m37Td+Zd9pm+Y8TY9TO2AIXXXeV5YlTVQpVuoVoDcqLXAPXsL8YFMzTAPU7Gfg==
X-Received: by 2002:a17:90b:1105:: with SMTP id gi5mr22931041pjb.26.1615185777606;
        Sun, 07 Mar 2021 22:42:57 -0800 (PST)
Received: from localhost ([113.92.199.103])
        by smtp.gmail.com with ESMTPSA id n126sm2972018pgn.66.2021.03.07.22.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 22:42:57 -0800 (PST)
From:   Jianhui Zhao <zhaojh329@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jianhui Zhao <zhaojh329@gmail.com>
Subject: [PATCH] docs: gpu: fix typo
Date:   Mon,  8 Mar 2021 14:42:50 +0800
Message-Id: <20210308064250.3681707-1-zhaojh329@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
---
 Documentation/gpu/todo.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 40ccac61137e..b7f1acb355f5 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -700,7 +700,7 @@ Outside DRM
 Convert fbdev drivers to DRM
 ----------------------------
 
-There are plenty of fbdev drivers for older hardware. Some hwardware has
+There are plenty of fbdev drivers for older hardware. Some hardware has
 become obsolete, but some still provides good(-enough) framebuffers. The
 drivers that are still useful should be converted to DRM and afterwards
 removed from fbdev.
-- 
2.25.1

