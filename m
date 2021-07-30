Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45FA3DB22A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 06:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhG3EQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 00:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhG3EQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 00:16:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41953C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 21:15:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so9488866plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 21:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ps4IOmc17WySeTSgvo3uD/BUf6CSyI+vUb3e7yZqyFw=;
        b=OUrY581BKpj1tZ35umAHWh0e42+XyE080rD3dk0rmx2YEf+L22+XObDcnJWZOf4+bB
         F4RVXAVGzALNEvXX5aKZSdADknVAT+gVJfBSmZJbL1jRpQ8cL5uiM0JVZWBdBAj06BNy
         1YiEUvKctStw3zvAOm/wS0Axwd6ExSoyNsGPuBWoFA0Hr1q0osa0+2ImFTtTv78Wn9On
         1pYLoNzShbUfviuLZxRdMeMar2lVVfkocmFkDP/1tnn8kWPvNLZZ8b6gEkMFs3hL0mC8
         VRC9zMg86AQAoFNtjwGVrpO9fOUg942dJ9jQQ8Vip4+6LCEXCUUjui5/suNmQvvjjlaK
         Xzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ps4IOmc17WySeTSgvo3uD/BUf6CSyI+vUb3e7yZqyFw=;
        b=Am6ZeeHl5jyFi/n/FqWBU1U/0Roy4h4d6tPidkCrljUHSKLH/5SDuDdLrO3EUuZwVd
         N2cQxFQpG6hQPytEiK3aDJ6E5yaoi08fjal0ktJdtNuShLrV8c5chMAQ1P+q7+7os/e7
         I+xai71TGmvbv+YFUDmmEBtAUDnFSU+Tbs9eSNLH8lhMPuUlXGMs8wGByHnaW6T0rlXx
         aAgSg2svnPXPy5izB5YO0ovli4U5qxDt75534EsP6Zhtb7iasvKuPhQoxqCYlgaXeLOx
         hHYIFwV5GC1GUfI3wYhnyh15Dyjz4dCOyADHrXK8U60yFdr5JRJNX2OOiKfxJ5MAS8Fi
         s8/g==
X-Gm-Message-State: AOAM531g99Q7OkiSE6eH/P765PEgOBMpKj6RyoGiuIiVilpYOBzsQEfH
        Nmtwqp+WdUh6WW31WLIDvTo=
X-Google-Smtp-Source: ABdhPJybNXzwf1afATACd4SoNNQWUK7gXTndoS2hYEHp5ijscoZl7YjagXGkzLzBsdMgVdCBa96Beg==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr1012698pjt.136.1627618542716;
        Thu, 29 Jul 2021 21:15:42 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id t19sm439322pfg.216.2021.07.29.21.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 21:15:42 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/2] locking/lockdep, drm: apply new lockdep assert in drm_auth.c
Date:   Fri, 30 Jul 2021 12:15:13 +0800
Message-Id: <20210730041515.1430237-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following a discussion on the patch ("drm: use the lookup lock in
drm_is_current_master") [1], Peter Zijlstra proposed new lockdep_assert
helpers to make it convenient to compose lockdep checks together.

This series includes the patch that introduces the new lockdep helpers,
then utilizes these helpers in drm_is_current_master_locked in the
following patch.

Link: https://lore.kernel.org/lkml/20210722092929.244629-2-desmondcheongzx@gmail.com/ [1]

Best wishes,
Desmond

Desmond Cheong Zhi Xi (1):
  drm: add lockdep assert to drm_is_current_master_locked

Peter Zijlstra (1):
  locking/lockdep: Provide lockdep_assert{,_once}() helpers

 drivers/gpu/drm/drm_auth.c |  6 +++---
 include/linux/lockdep.h    | 41 +++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.25.1

