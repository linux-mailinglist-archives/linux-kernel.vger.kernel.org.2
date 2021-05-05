Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14057373909
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 13:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhEELJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 07:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhEELJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 07:09:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E53C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 04:08:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x20so1990464lfu.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 04:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=G5vc6WFcuA4Ved0s3f7uwaDCkdixE7ycKFQEB/WCSC4=;
        b=Cci3Sa0VqW6/hPfN1FJvFUfq7mP3GN3WqAc313s02iQLWFHDceYE83Mgo/6wGm/MAR
         8alY6SlTFMrJHrzHXUbvNtrHZY4Xn2787DMlWsypRItb4sBZG9I0TQkS7WBOiEBaAMtn
         Bp4MmV1sXTm8crDATtE6zXTPi42mIwFFzfdetBUDc+7917zwsvPv/xwrcxYhpWTScO3l
         5DlaZJSaMjo2gxmVYulYa8Xi7r4W0E3zBi9KWK/5rKCnKplZEwW0nCA/mML4x5XhloSY
         GEyiCi3O2iK4lajuim4tKVm+silaKKRo9Os6wpjHegw6yV5L4FThxps+Bb1Owlsb6zII
         6I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=G5vc6WFcuA4Ved0s3f7uwaDCkdixE7ycKFQEB/WCSC4=;
        b=aBYPj10WEOeYtot1i7bXlfmrvQrmFmlDvtbf9+4Q27bAydza+dOEGmDAQ11hKiJZyN
         71VHbfM9P+hiIk0/A2QTZ5yUySj+GVpJ60uHyjeOGCkiHDlq9z5FWBU2/tFMKrTxtI7m
         DTUisffd01Pmj6Wx87rBJxJHfCrKwLiA/xnC4HcCPOT2+MqDXM1EJREjWYX3yhs39hNI
         A2EYlVrLP3N+jIL4WaSUNguHL0URAuhzwvIAGQxdG9BJ+E3p/J44akY6vcY0UcTpG4b2
         IlyXQFvcPad3ZTsIuSEDF0cDpythlobWUfcJU7AF4UttjjXc73L0VVbZoMzbZDpxnh9L
         5nQw==
X-Gm-Message-State: AOAM533pgjugFU3V/SMGxLk3cyV4pOro70muiaJxNj0iN1l5tAY3RSaO
        KGvuiE1XxmmeBp8Rq5IvJZPDYA==
X-Google-Smtp-Source: ABdhPJzZ0u06G2GPbeSnqfz+Akzps6QZxvjdetUSSSdcBG0Ab+DLj5ImBZLje+dgx3KC9QqXvcUGwg==
X-Received: by 2002:a19:c17:: with SMTP id 23mr20632058lfm.602.1620212931893;
        Wed, 05 May 2021 04:08:51 -0700 (PDT)
Received: from jade (h-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id a20sm1973943ljd.105.2021.05.05.04.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 04:08:51 -0700 (PDT)
Date:   Wed, 5 May 2021 13:08:50 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>
Subject: [GIT PULL] AMD-TEE fix for v5.13
Message-ID: <20210505110850.GA3434209@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this AMDTEE driver fix which adds reference counting to
loaded TAs which is needed for proper life cycle management of TAs.

Note that this isn't a usual Arm driver update. This targets AMD instead,
but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/amdtee-fixes-for-v5.13

for you to fetch changes up to 9f015b3765bf593b3ed5d3b588e409dc0ffa9f85:

  tee: amdtee: unload TA only when its refcount becomes 0 (2021-05-05 13:00:11 +0200)

----------------------------------------------------------------
AMD-TEE reference count loaded TAs

----------------------------------------------------------------
Rijo Thomas (1):
      tee: amdtee: unload TA only when its refcount becomes 0

 drivers/tee/amdtee/amdtee_private.h | 13 +++++
 drivers/tee/amdtee/call.c           | 94 +++++++++++++++++++++++++++++++++----
 drivers/tee/amdtee/core.c           | 15 +++---
 3 files changed, 106 insertions(+), 16 deletions(-)
