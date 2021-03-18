Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62B3403C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhCRKq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhCRKqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:46:48 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B0C06174A;
        Thu, 18 Mar 2021 03:46:48 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j7so3663789qtx.5;
        Thu, 18 Mar 2021 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhUQnpQN5W/tA9Wcg9rEDDeKuG8HI0NowlOsbYyX73M=;
        b=gw/bd6B/y+5rYoX8wrkX7aPu1rvous/7chlMKJlUVROit+etGoawRuOVK6WsGPbnlu
         7WMoQqUGkfsVTfUskGWqTo4Ysb5MknXJXfB70C5ZowQkWG+kyCrklQU7PiEthDYs0mew
         vBtKg68fgiJwPxOeBy0UiG8N/3YQ4fmCvpkKHJVb0xm8hrmNFJO03xk+e7mu6f8uLgvv
         lv64p2vQieGtmDdFSqJ2VS4p5oW2stc2SqyM8hgXDo1+Eadu0YeDkMT1ALFT7A4GauEB
         GWpzGrSfgzZX9c1vpxTJJcZ1jzfRhAjoF73w7QENWMIy14XnvAkA7vJrzE8+njER//Me
         WE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhUQnpQN5W/tA9Wcg9rEDDeKuG8HI0NowlOsbYyX73M=;
        b=oDI447dU7W9a/YKEgyHoiuL0c7kXby0QFf+AKi6KJLYD52j/waJhWPVahy9uVEkZJY
         ROuYH8TsC1JGtGkCpKZKTiIzDUeylJ++je7MWvjcedsUmPq7gwsYS+Ug+/K2B0s6hp9q
         G1RNJj07BNxZ8KQK2lI+I5RKDLN7Ip37SQ1zXcdlXgSAnFjwWhLRtpEWtwh1U6j5WOdw
         WEp5aLxkSb9DZhE7YOP/FeZECxkqM5p/7e+acx4z9chYn3yLxAUG9nHTetYXG+F9oBnf
         Gvag0eqcXXV6rhMHXLDTTz7l35IwGxRiGz/CZzT7vS/N6yXRnDJ7NgCj0A55zP69O5A+
         1sog==
X-Gm-Message-State: AOAM532jLakg+o+c0gErnw6IfKFunGWmLFOmWO8vsqh+uwSJjIOS2zEC
        rH3uPJA4t4DtcROD7R4IN8A=
X-Google-Smtp-Source: ABdhPJxNYDSuqVaPiGOjr4bLR3exGbz9HyB9Acn8xML+XqvG0/J5wqbtCrnBcna0aK1ot7AuitArVw==
X-Received: by 2002:aed:3023:: with SMTP id 32mr3041059qte.173.1616064407217;
        Thu, 18 Mar 2021 03:46:47 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.246])
        by smtp.gmail.com with ESMTPSA id z89sm1129783qtd.5.2021.03.18.03.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:46:46 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org, unixbhaskar@gmail.com,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] sh: kernel: Fix a typo
Date:   Thu, 18 Mar 2021 16:14:37 +0530
Message-Id: <20210318104437.21793-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/archtecture/architecture/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/sh/kernel/relocate_kernel.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/relocate_kernel.S b/arch/sh/kernel/relocate_kernel.S
index d9bf2b727b42..deda2f60a8f2 100644
--- a/arch/sh/kernel/relocate_kernel.S
+++ b/arch/sh/kernel/relocate_kernel.S
@@ -3,7 +3,7 @@
  * relocate_kernel.S - put the kernel image in place to boot
  * 2005.9.17 kogiidena@eggplant.ddo.jp
  *
- * LANDISK/sh4 is supported. Maybe, SH archtecture works well.
+ * LANDISK/sh4 is supported. Maybe, SH architecture works well.
  *
  * 2009-03-18 Magnus Damm - Added Kexec Jump support
  */
--
2.26.2

