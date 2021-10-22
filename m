Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785AC4377C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 15:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhJVNQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhJVNQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 09:16:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26B8C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 06:13:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o4-20020a17090a3d4400b001a1c8344c3fso3570172pjf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gthT7Vq77opBc/rSgVQR3VqXY4Alj06CFLF17FWMuIY=;
        b=En2gcfJ9Ru+zVl0TwpHEs5pyKOGRbt1GMa7imWuY4HgR3Yl9auatghwvmBLRFEkmLb
         Sci9S6TlpqOLHMeusZ9UngOP3p7qHuAhKCAIPKZYttR1rQVAv46ZDJ/Y3W/VH9zrZWfK
         cqmB0YpE9d8IdqDwQNstkODz/1kpCcLDt1AhQrCftVBsgyDy2DySzoXP3DhvEtnD9GdG
         Sn9rF/9eTCoPQkF9L4FZG94aWdMyiJnSIIBHtJzWze7/Jo9w/EL3ZRbfoEeBoKwYwT97
         oC5AIjUXacawMexdTVNnjEi2kqUm8csbhKJugHm1EE33AF6spmmtcLQu8ZbzBDHTUipa
         EvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gthT7Vq77opBc/rSgVQR3VqXY4Alj06CFLF17FWMuIY=;
        b=RnYhy2VUN80xso7RBQy9JXZoYvl6bkKnVJl+f+Mb6UvFJ5YmOjuO9jOwoOSysei/cC
         IiL3w/06t56QjdlcfeBdUtsRijJzBKnsl0UkfllpwvPf5ZB8SeWfFfV9gCOBGX2dIrIh
         mOiRN+68/0Ov/l2/zZu3tJh3lpoy1L7IF4ZAk8n7f/8umJrYc7Ryqq+so23V3aTvXU/x
         h5XJXrzUlDm4oHeDXVMe2mwF4thpFQE0aZ/S+dcp/ZUVpAwPAH57WzJjUEDyhNSPwVsI
         VYva5J8H/bFMhEmOqYFzTlCH1RUNJNInX6lNpcJAl5g0162jCsfrbvEJFUUPjPe2/Bgv
         4j+Q==
X-Gm-Message-State: AOAM530xNx/QYp5XR9KxamYUXP6govpIdZG3SrVRjyykKEGy/lcPBXis
        ggjzNs45cj12VMmgQ2Wmb7k=
X-Google-Smtp-Source: ABdhPJxrMM6Ff65aYDgRfbdlr6m89hp34LDzrCVzxEHOGVdkhNvkQ9rUXGQN9hEdMcmqXdyIIETMHA==
X-Received: by 2002:a17:90a:784a:: with SMTP id y10mr6678931pjl.211.1634908423193;
        Fri, 22 Oct 2021 06:13:43 -0700 (PDT)
Received: from localhost.localdomain ([115.96.219.100])
        by smtp.googlemail.com with ESMTPSA id mq3sm11932413pjb.33.2021.10.22.06.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:13:42 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     kushalkothari285@gmail.com, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com
Subject: [PATCH v3 0/4] staging: rtl8723bs: core: Cleanup patchset for style issues in rtw_cmd.c
Date:   Fri, 22 Oct 2021 18:43:17 +0530
Message-Id: <cover.1634906059.git.kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches make changes to clean up style issues identified
by checkpatch. 

Kushal Kothari (4):
  v3 staging: rtl8723bs: core: Remove true and false comparison
  v3 staging: rtl8723bs: core: Remove unnecessary parentheses
  v3 staging: rtl8723bs: core: Remove unnecessary space after a cast
  v3 staging: rtl8723bs: core: Remove unnecessary blank lines

Changes in v3:
Enclose the version number inside the square bracket in all the subjects

Changes in v2:
[PATCH 1/4]: Moved unnecessary parentheses change in PATCH 2/4
[PATCH 2/4]: Added the extra parentheses change from PATCH 1/4 here.
[PATCH 3/4]: No Changes
[PATCH 4/4]: Fix whitespace error. 

 drivers/staging/rtl8723bs/core/rtw_cmd.c | 94 +++++++++---------------
 1 file changed, 34 insertions(+), 60 deletions(-)

-- 
2.25.1

