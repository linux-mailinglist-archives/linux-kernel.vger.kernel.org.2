Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB013805C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhENJFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhENJFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:05:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE97CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 02:04:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b25so43617731eju.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 02:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zonYf+ym9M80iJYhRH5I1YOvTHlXqpjZLYOjK1Xm4rw=;
        b=akQwl8cpf4FaZIcoZDskIeOPbDGNFoZ0erc26W36qCJb/qAEHKU7tkecYk+ZPlgHKu
         tHEq9PRABMpT+qHun3KknIycWvCJtDjZkFNSJO1G2M0+IY37JgRAn/ucgfSVo1+ps0Q5
         isRldiQ9GHogD66gOy82rDxLeJHIxbk91krp4eypG7UeX9PSySB6YiJV0UttspZDJT/X
         sFxH5WunPZcHsjeoh12NnbNiMjLUkIou5AEMjRcB8DtRUQMacu6rbDVju452PLXqhWtd
         Cy/Mkbp+XOlzy4kXyBb7JbHxQywLEcnzKzoB5xicJy6E1HS09h9uEhvElw8lowQSvMWd
         Uu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zonYf+ym9M80iJYhRH5I1YOvTHlXqpjZLYOjK1Xm4rw=;
        b=jVt+MKu1g5qqcSjQ1XZmspF+2vlKX0L+9HH5UxVb75eXcoX/zr/L24r/Iea1OeCPda
         d0vpS9NoWIwuxtK7M5mgPZ8Ak+aWB9kB49Qt3e5u8hIP2AqIY8/MV8nycEH3P6zaBFKq
         OKmrw04yBdzEhwhFjSGYdk8hM8NqrgxP2seM7VMtx0AhQXgp/BXlt0R4LcySfnpFdBVb
         YjNC+aEIQcbXuH+i5l6VMhNRJKL8NDJMSe5FaZ8UYYQVg8lLk0UPgYKjGqagyoCGaKS2
         OYPBW1IsJYyNZ64NsTvMXVWAxk1IT1FP7Akqfr9Nd6cv6oKztR+O+xjzcnLWs5B5U6cw
         mrlg==
X-Gm-Message-State: AOAM530Gjg0SvS9Yz8GN9dfbbF6my0S9OT/c6boZMkKv2xAIiUaT7gIs
        TgANUNb+yYcGsa0EdlbQZhy3guj2lwM=
X-Google-Smtp-Source: ABdhPJzubRxQvD5jfH/PjLFmVWZ4LtXPrTyz6F3htzb0b0qWtPpkVDCP7BTjZ7K+zAaiDeJK225z6Q==
X-Received: by 2002:a17:906:a84e:: with SMTP id dx14mr10114483ejb.220.1620983046701;
        Fri, 14 May 2021 02:04:06 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id cq9sm2446395edb.44.2021.05.14.02.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 02:04:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        lkp@intel.com
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 0/2] staging: rtl8723bs: hal: Remove set but unused variables
Date:   Fri, 14 May 2021 11:03:59 +0200
Message-Id: <20210514090401.16123-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed set but unused variables. Issues detected by GCC while building 
for x86_64 (patch 1/2) and by the kernel test robot (patch 2/2) while 
building with GCC W=1 for target PowerPC.

Changes from v2: Corrected subjected lines that didn't match up with the
patches. Issues reported by Greg K-H.
Changes from v1: Added patch 2/2 to remove an unused variable detected 
and reported by the kernel test robot.

Fabio M. De Francesco (2):
  staging: rtl8723bs: hal: Remove three set but unused variables
  staging: rtl8723bs: hal: Remove set but unused variable

 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

-- 
2.31.1

