Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F140419C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 01:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhIHXLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 19:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhIHXLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:11:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA144C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 16:10:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so44887wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 16:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUNSeceQctNpOtv7NxFjjx9adbKFkGaFzjaK9/lF9t0=;
        b=BYvtVaktqt3K7oTwqBwBpTYQzLL3zGuHTPp8DNHdfH/VllkaptRMyRQUTE9MfBx7Mx
         KDFg3PMZwsmWUuC1VgH87KszujVckGIib3H5gZVend6ObY0PRgxgagAplD/3EYUf7COU
         w6wb+P1VFxzQC9d9sqsFs1WOqIF7C5gYSYa72dG3YCz1DnEiBrpPQOHr0F/ME9vW60Kq
         50TGwzjeuD3lSJ4iI+3qHdbPPZSBAsXqSr7erjHZNxzhCwYbTZBLACVforLxXyUtAvB9
         omg7M4UFaeMAQrhbOAoUE9hnxSRQxFPd0oVOlIJ600Htro/C52rG0bLub0iHwDaGy2x6
         czcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUNSeceQctNpOtv7NxFjjx9adbKFkGaFzjaK9/lF9t0=;
        b=K0SvlrIl/iR8IRzgzl088VLo5Xj59JJV+xJthqM4FzBOxhCK3rEpY0jpMMSnfX0f6f
         Tvm5IwoB/ciuLIw4zY+rtXVcAwjrMve6daE5+jxS3YUQXoCA/Y74SyDZMQ0rGGKBpwwK
         GhceRb4+xLgrltdntjY6RjvX7oZU/8zhoobBAifwvBIS7S2k3po6owD2qLRCgdvcdwkj
         p4LQjp2FsYArCHfaYyL+wTMNfl47ktB0etqPKF03C8U1XT5sc8I46mxPnaCQ2VxKLd7h
         AQAjAWndwBra4/ojtMv5ffSakySRudNTtsJ8x9w6VHUr4nt7frntCRcEXx2I2sSnYsjH
         YTJg==
X-Gm-Message-State: AOAM532/mLWwY/PnEB6aJ3HxLqyC8nZ21JcbQESY5eb4ShJtQW1gDU3w
        fiun81oEBvtwPgy9ncmdook=
X-Google-Smtp-Source: ABdhPJyE8KVuqMh21000QXanMwVC7iyKkyF9ooc4XvHiAWRiffM6xGojB7eBWfI/xG9K/Lv0TOh54A==
X-Received: by 2002:a05:600c:4e93:: with SMTP id f19mr5821303wmq.185.1631142614209;
        Wed, 08 Sep 2021 16:10:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id l21sm348393wmh.31.2021.09.08.16.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 16:10:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: remove unused functions from hal/odm_HWConfig.c
Date:   Thu,  9 Sep 2021 01:09:51 +0200
Message-Id: <20210908230953.16931-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unused and empty functions from the file
hal/odm_HWConfig.c.

Michael Straube (2):
  staging: r8188eu: remove unused odm_Init_RSSIForDM()
  staging: r8188eu: remove unused ODM_MacStatusQuery()

 drivers/staging/r8188eu/hal/odm_HWConfig.c     | 12 ------------
 drivers/staging/r8188eu/include/odm_HWConfig.h |  9 ---------
 2 files changed, 21 deletions(-)

-- 
2.33.0

