Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B1443761B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 13:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhJVLkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 07:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhJVLkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:40:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4276EC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:38:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id om14so2727731pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jy4A0xld4cnoSeYnYltPRwIoXa2YiW35xmuIijSpqiM=;
        b=QtCI5q6lSrZGoZglRRmuMJMG5nwV42u1uVft1BqwOYfEVFeTe8YvuVxHzib5n7ssrJ
         sjGTEGZAO2W83XHupV+epq77AnNI828PmmeE6WczTyN1teSzg84/BGLxgov5bB8vr6Xi
         DQqV25+pGxsTOR9eG4wv8d2kBzvyx3imQOOiuYtMUtrTrR/OBDTV3URIM0aKnwa8isYG
         VfIpcyLvJ4gg+7SzelTseXbVUbGZIHfmP7jEgKm1KR2KbLWiNlkem1KUzWfZLc/mEjse
         bKNgfhgHxF5pmND0FNctzmqt+Bpv8QUPs+9s9hfqpcXNhdjqTMa3K7KHelt30DdPFAI2
         zrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jy4A0xld4cnoSeYnYltPRwIoXa2YiW35xmuIijSpqiM=;
        b=44w/IsWgW0is4sIyYGIl61B+A3rpx8wYEHEP5+qxNDwS3oiyj2prN5B3nfpr2b5+TC
         idzeCSo6bgDARVPlRNhD8q1p8zgwSYLwLkpzfCvjWUVtIa4vDs52sfZ9QzapltMS2IY+
         ZfodF15Z+BE62LOueim+XoclN+tGXbWD6k4sHsH77fWkFBrvQXbiaM2kcAc6M2HQNSoD
         weGVFbsM1IEbXuwHBrOpR1sh6gODtmHeL8V+IrKnt87nVMSBhElfotWebUt/Z8TO6mB7
         +wcrIzY3I+m7Ncku6yJlY7yAhKDPwsMwoIX4tJ9XF5SUMbpTbulAvYjW2GbiSG2LpAOY
         /N9g==
X-Gm-Message-State: AOAM532vpcUcUWmkCPHhR0RQpPqphHGzBX323iR28hmJVkHiTKC2bKX1
        C0uCpAJUczaQhe2BPSZPQT4=
X-Google-Smtp-Source: ABdhPJx9S4u/WGe9TJCFiETqYHqSttLKWDlzjeCvRsZsULYgBzw3HKvzk6yhwBzTVOmKlEn2Q4zPpA==
X-Received: by 2002:a17:90b:1806:: with SMTP id lw6mr13947074pjb.222.1634902686626;
        Fri, 22 Oct 2021 04:38:06 -0700 (PDT)
Received: from localhost.localdomain ([115.96.219.100])
        by smtp.googlemail.com with ESMTPSA id t22sm10946224pfg.148.2021.10.22.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 04:38:06 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     kushalkothari285@gmail.com, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com
Subject: [PATCH 0/4] v2 staging: rtl8723bs: core: Cleanup patchset for style issues in rtw_cmd.c
Date:   Fri, 22 Oct 2021 17:07:34 +0530
Message-Id: <cover.1634899405.git.kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kushal Kothari (4):
  v2 staging: rtl8723bs: core: Remove true and false comparison
  v2 staging: rtl8723bs: core: Remove unnecessary parentheses
  v2 staging: rtl8723bs: core: Remove unnecessary space after a cast
  v2 staging: rtl8723bs: core: Remove unnecessary blank lines

Changes from v1:
  [PATCH 1/4]: Moved unnecessary parentheses change in PATCH 2/4
  [PATCH 2/4]: Added the extra parentheses change from PATCH 1/4 here.
  [PATCH 3/4]: No Changes
  [PATCH 4/4]: Fix whitespace error.



 drivers/staging/rtl8723bs/core/rtw_cmd.c | 94 +++++++++---------------
 1 file changed, 34 insertions(+), 60 deletions(-)

-- 
2.25.1

