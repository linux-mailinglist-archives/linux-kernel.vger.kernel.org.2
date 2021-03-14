Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366FC33A2CE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 06:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhCNFV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 00:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhCNFVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 00:21:49 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78703C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 21:21:48 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c6so6982823qtc.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 21:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZ8gA0l8bgFNybFsmoII2WWhDw/3OIQuhwpuA/ILOrE=;
        b=A51uAe/KW2kHodP+64FzZs/ft3d0/xbdP6JW923HvG7xr+JUyH3hVTAYTif2JGYU7M
         8+s+BndnuZJeDY3yf5DmDfxEyiqN6wGJXqg8dlwqum8Ib5sv36jJWNSF9aVOLEu7v05Y
         dFEgKeqPLWyQwTvOHaD4vTK18XBunUoVKWuGVA7XPo8IELfQTdJJosPxO8aIToMPA6Dz
         6OPnbLbwbjY5I9ZPrgYGB3Vz8B5/QDEep9wKTVhyfj0FcmdyiSpmv3FmToHOLO5RA98A
         9Vjb5niBzWctqZaI5gHzwQ2bdqKL/hQoOPPzVq85nD+T0bpBse1/ieYzJi6cCYEGt0qT
         VmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZ8gA0l8bgFNybFsmoII2WWhDw/3OIQuhwpuA/ILOrE=;
        b=Tpn5DsX4FzbSPUWD5Ne0QS1SfDXhV9izmpLa7GbrsMK/erxeffG0QlzNcsyOcfy0F/
         dNh1qZpDQA9xUcysqu1cCg82pQ3eeHuk9mWY1Z1lNhUAxat+PqRLDEZXbEIfiwZuSgyx
         2oubDW3GROSqyEMWq1fnTbnfcH8h3han/jlevy+vZy6zr+qcUeSFB9MWXMR8QkPtd2LX
         zf6Du2dkfSf3fsEIK8OvZ8bxqTFABRt9aw+LXQp7x/YD46pX0Rv861Rb7oxvT7CcusIT
         W6/zB0I6Xwo9SPX395/b3bYD82f94ubmIZ/ByGc6UfdR6yhuuHK7ZRWOVdwARtwCRwpq
         fMfw==
X-Gm-Message-State: AOAM531ScsGEJi08YmYKwCPO310NpN+shqF4+IJC74klv2u/wowwmytI
        ZBn2q4Ovu6J8XT86AIR55rcEreq0uk6qbZhd
X-Google-Smtp-Source: ABdhPJzF71+ZuhXNoLR9rshlgYVuuSD8HwsNbRjpZv5TBF7oOBr6ttInFYCyb1ZZYHvfKeQlhwuBQw==
X-Received: by 2002:ac8:4e51:: with SMTP id e17mr16438105qtw.204.1615699307642;
        Sat, 13 Mar 2021 21:21:47 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.30])
        by smtp.gmail.com with ESMTPSA id 131sm8725594qkl.74.2021.03.13.21.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 21:21:46 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     ysato@users.sourceforge.jp, unixbhaskar@gmail.com,
        uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] h8300: kernel: Spelling fix in the file irq.c
Date:   Sun, 14 Mar 2021 10:49:31 +0530
Message-Id: <20210314051931.6378-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/writerble/writeable/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/h8300/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/h8300/kernel/irq.c b/arch/h8300/kernel/irq.c
index 834e4d7b1bcf..4afa13db6774 100644
--- a/arch/h8300/kernel/irq.c
+++ b/arch/h8300/kernel/irq.c
@@ -43,7 +43,7 @@ static unsigned long __init *get_vector_address(void)
 	/* ramvector base address */
 	base -= EXT_IRQ0*4;

-	/* writerble? */
+	/* writeable? */
 	tmp = ~(*(volatile unsigned long *)base);
 	(*(volatile unsigned long *)base) = tmp;
 	if ((*(volatile unsigned long *)base) != tmp)
--
2.26.2

