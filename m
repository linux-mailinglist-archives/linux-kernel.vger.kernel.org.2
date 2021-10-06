Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE7424031
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbhJFOhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbhJFOht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:37:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78636C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:35:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t8so9612590wri.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swBUCmeg1qH7jXbLR7SkXwRdMm/6iWVeRgPD0Zy2bGY=;
        b=FTfzi3XwdGDoWa3eZLmdTyR1CUdXJPwNwQAdreJLzMDRbkhLKBsXbsa1V8A3ioPPLl
         w3T+u9t3NIurSjQmhvXJENZNHAK8fwHmgv2+AYwG2fK04Jk4B7vTYUlrSxhRq8JrCL7g
         f8mLCvsOCUDUAwpZqhXSbIZklOCLY08MZVCZnG2s0sjo9wOEJaysM4h2Qk5niBYhshIH
         m6XY+kAzbEKtf/eTuIeeOnFuTTeXqolYZ/w1mc4KF0M0bRZjhAS0NhDJy0Z4gHf5aHWT
         T4OPFPnH+NzRivBN7VP1zS5g6zq+45xquYQeSec1238mXmDIs0XHlsU29wm2MwKC9E5X
         agxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swBUCmeg1qH7jXbLR7SkXwRdMm/6iWVeRgPD0Zy2bGY=;
        b=cgC4ncap3tEgzEroEPFBCXppAscL6c7MUv6Hxu2P0neg86+yfsybkLq4Qh4oJRfaGD
         8k5L7i6baef1Tc6AdD+jO03/g/HGHfbhREotqrYrpbXbI6+vE2ulTXmVQ8WY0mUIUfQU
         5zNcy8NDQ04EnVw3NgUv7YGyQAcDzMdoVvADmnExQGluORo80uTXdLi6WUR7VvDypCdE
         Yk3MlF2chR9MbTyfUO+60EXJ4x7UU7nEfR9uZzx0iYlJCtRtLOz50hNsAuJsFgmitPGO
         t5epCTd8v9ApnzqNh3aipMe8zWEGhcVNR9GOL+X88kPq1/qNn1bT8n7hQehecKKoQxMk
         QRNQ==
X-Gm-Message-State: AOAM533NISWFrYMyEcI8d3WBfuxqn9oA/m6dAYvhsY6XLiuGI0Fburhf
        W0U9kHd2OyOOEaDQbzxlkfg=
X-Google-Smtp-Source: ABdhPJzT+tBPHS539udaKVu5Aih+dodmlZiBCWtye4CUzLqRdOmhFjlvpEqxpI2npe/r7aex7oRw3g==
X-Received: by 2002:a5d:5744:: with SMTP id q4mr24856890wrw.21.1633530956060;
        Wed, 06 Oct 2021 07:35:56 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id q18sm5486657wmc.7.2021.10.06.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:35:55 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in sysfs-devices-power
Date:   Wed,  6 Oct 2021 16:35:53 +0200
Message-Id: <20211006143553.129513-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated world: "the the children"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-devices-power | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 1b2a2d41ff80..54195530e97a 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -303,5 +303,5 @@ Date:		Apr 2010
 Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
 Description:
 		Reports the runtime PM children usage count of a device, or
-		0 if the the children will be ignored.
+		0 if the children will be ignored.
 
-- 
2.25.1

