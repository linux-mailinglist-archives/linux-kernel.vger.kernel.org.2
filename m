Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551134309C0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbhJQOao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 10:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhJQOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 10:30:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED32C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:28:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i20so58965820edj.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GcnZmPhYZ4EKSXWrlwtHmKjB5xxunTLFlUoYIZsuugc=;
        b=ggr7K/NPPlN9hbbLxjlJIycROVMc8i+e43DP9sp3J76bc9rVpgu1fxc9mYlIiTAwXo
         k/ZNZzxwcS5dKq/xO9tTX8GZWu15vDh/O0bbkDHqiG0ygj1XdSZOW/rYykr7UMtCF/GK
         twMqJLPW7cV34rkySCdwE6eoBEjTwYWfFCHDbAEYEYGaGm8//TjZrCAKin/5WSqZkJ8g
         UjFBhQPHzO4T8r+wJPpvt6Ge0euhAAmg58oWj1+eiNmBYjl9sch0pakCtVmnV7CbEu/L
         8YfPfsFiljgLHeV+WyaMuAglWvcYawmZxHA+ucf6POiM4DomHZIlpkxl3M5Ar9blls00
         6G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GcnZmPhYZ4EKSXWrlwtHmKjB5xxunTLFlUoYIZsuugc=;
        b=AUBzZPwy6fQOpt0psqf20/7jgOfoLnyZwVdimYs34xhv3itvg8JP/Cw7A/NaXBWGvk
         S/V59igDc84QUuXpIuvbNEDjKKIbmtkIFGRJkH0GEf0hpWYDWzykjtKzW1Abp7lJZ/en
         k+JXEHgRiJamddrJIRo5tj4YkWu6DBe6fPFvelmNHdTMO44v6Or7v6upfZ+r5ptIAx3A
         vWp+vDvL4knFW0OjUKz5VsqTudjKeN4NTVJF1i8cW5ADd8DG7t+b0rPXpzo0/fKYAh1w
         /zPbo1jS3uZuepEGMiSzbuaA2Z4Q+gK+BGyiyfsQ8KcD5bn/y8/nC3K0cIKB/lrd62Zn
         X0pQ==
X-Gm-Message-State: AOAM530gqzNHSFLQ8HeApPVeKK4+5dHB2Pr+SsoXw9zp6Uo83qm98hlD
        adX/RyaBCuhHJItvstwYOqE=
X-Google-Smtp-Source: ABdhPJyRhbArPHVFmNmjg6zHsifsRuSwrKaO+aFocPVgCCTSKwz2frUYDQxObFi+0aiz6g/MbUx5RA==
X-Received: by 2002:a50:cd02:: with SMTP id z2mr35459438edi.241.1634480911442;
        Sun, 17 Oct 2021 07:28:31 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id p23sm9094537edw.94.2021.10.17.07.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 07:28:30 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 0/3] staging: r8188eu: use completions and clean rtw_cmd_thread()
Date:   Sun, 17 Oct 2021 16:28:09 +0200
Message-Id: <20211017142812.4656-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replaces two semaphores with three completion variables
in rtw_cmd_thread(). Completions variables are better suited for the
purposes that are explained in detail in the commit messages of patches
1/3 and 2/3. Furthermore, patch 3/3 removes a redundant 'if' statement
from that same rtw_cmd_thread().

Tested with ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano]

Many thanks to Dan Carpenter <dan.carpenter@oracle.com> who helped with
his review of the RFC Patch.

v1 => v2:
	Patch 1/3: No changes;
	Patch 2/3: Replace wait_for_completion_killable() with
		   wait_for_completion() because killing the kthread is
		   not allowed and so there is no need for killable
		   wait;
	Patch 3/3: No changes.

Fabio M. De Francesco (3):
  staging: r8188eu: Use completions for signaling start and end of
    kthread
  staging: r8188eu: Use completions for signaling enqueueing
  staging: r8188eu: Remove redundant 'if' statement

 drivers/staging/r8188eu/core/rtw_cmd.c    | 20 +++++++-------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  5 +++--
 drivers/staging/r8188eu/os_dep/os_intfs.c |  8 +++++---
 3 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.33.0

