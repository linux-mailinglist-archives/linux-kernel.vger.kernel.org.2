Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDA63F88F6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbhHZNan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhHZNam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:30:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09350C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:29:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y11so2747335pfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o7mbhfLOAXvYyxdq8BjU71uPFdXWXrwGMZ1rikOJA54=;
        b=ADkVwjd0EglO5ubUi6W+EKavDbzb7iMnEr4q+I4AjeqcVoOuhUVdQl7FMFwp+uaPSM
         iKfPQ6cj8mUbOgMq6cV6fJcVL//eLPolwEn5I0C5KpbBlFg+qPvKYh9lyRenHE93lRqm
         pCbU3gxeIOfHpDO/FmfyaZxdGHEYQWNKZZkmdjJ2DeE+gD5aXeTwSS8SYGJjGJy8lTgu
         uHJXXuHpixix/YZN0s6FjuoxY3Uc9HwyflVBRYKsV8WdJHMNWJMiPYVjnBsHaFaJzSQz
         KuZFTWrsFPacs1QETBOXPKmgdqVNjs+TSyMLOCbHjjSwsAWigVbszNrYO0SXAIU3S9I1
         DEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=o7mbhfLOAXvYyxdq8BjU71uPFdXWXrwGMZ1rikOJA54=;
        b=ejmw35Kh6MTwUsXW2OK7WpqhxF5HeV5gWGOcO3aVa0bRp7UBUcW+CQfMoeSd9a5uus
         Md2RQM6mp90o79Q3K1k5Le5jS23/MUSP5J1jYdszXtAQtvP0Q4m3OnE3vmK6q06YPI02
         vHwLYXTlUYMqj9I2cJlmVai8FMzw84eKL3L8VKSgPFsQUtGmlaTanadVCUojOlLozTZl
         ZceyGxYM5Sc6SNnRLaysuXsvkwrtkzO81lSPsqvFCgjaa2zkrTwvJ37gmM7DlPeM3Hxe
         Yja/Auo3qppFu4L6ZKzz0vbcFicoOe2W8lBzjuD75P8X+Q/rRC4NNfFm9knZqaa0pwZk
         cLTQ==
X-Gm-Message-State: AOAM5323wuINgeI85mSTTC2Gmtgn9Ih8fnI7HPRLfGcZHyh/o1taIehg
        wAjsXv9NdTJEP0ZyZlQBOM3oVrYkIvY=
X-Google-Smtp-Source: ABdhPJwrLueRWj30jqW87Ll3BnY9kEUGZkKkOToiqI6g/PSfvOdCfpAIcVvAtmAmBF9KSO6H0U2Lpg==
X-Received: by 2002:a05:6a00:2142:b029:3b9:e5df:77ab with SMTP id o2-20020a056a002142b02903b9e5df77abmr3951650pfk.52.1629984594401;
        Thu, 26 Aug 2021 06:29:54 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id w186sm3359693pfw.78.2021.08.26.06.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:29:53 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] openrisc/litex: Add liteeth support
Date:   Thu, 26 Aug 2021 22:59:43 +0930
Message-Id: <20210826132946.3324593-1-joel@jms.id.au>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stafford,

Here are some changes so that the openrisc kernel can boot with ethernet
support with the in-tree device tree.

I have also updated the address of the serial device to match recent
litex. I realise this may keep changing, but it does make it easier to
test upstream kernels if the basics work.

Joel Stanley (3):
  openrisc/litex: Update uart address
  openrisc/litex: Add ethernet device
  openrisc/litex: Update defconfig

 arch/openrisc/boot/dts/or1klitex.dts      | 13 ++++++++++--
 arch/openrisc/configs/or1klitex_defconfig | 26 ++++++++++++++---------
 2 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.33.0

