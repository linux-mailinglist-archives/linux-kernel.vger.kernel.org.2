Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED41D430169
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbhJPJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbhJPJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 05:13:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557BDC061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:11:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 5so17551872edw.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4EM98EaZ2W2/VutwjhCwiL722S9g8c/C9oXvcE2zIU=;
        b=o0m3TEk9IwXY7geF5+TdJLR9GuOY5//qcCPBZYMRN1NbI/htqkuCovzt5p7uFKuOPl
         Z90b2BCMTj1n3wtjcCop5X/WHHQPXoQChoPYfPwT3f9ljACdfJC36SlfpD0QtXMFSyT0
         R4r9e2uuipJvUUH8ToToGwYGz53fUnHFWH5U+OGVHjLvPNvNciTJ7LyD0HkwNDbCrr/3
         pQUOg0NAvT6nsYnyk316BeHRvt368Vprd6Ci10XCFn9+XJl05A7tEhK2TvbNlYEzzy/Y
         JqgOEtwMjabRRQ0eevhvDxETM7nMyNQx3ODOo+ZH/JzLfpwKTowE79N/7lgxcry9lrO9
         H/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4EM98EaZ2W2/VutwjhCwiL722S9g8c/C9oXvcE2zIU=;
        b=rQHfoUgLfJ6nNNW9qTvA6eMx1AXAw9NZtbez20zRVOAt2VDNK99i189F4XW5pnNjIJ
         sncsFwVj4oFUV+COhMsOcdUbQ7tzx/MQLR4OFRZQ6nKFzOd97ei+uHDgiZVnKZ6GHKuu
         B0W9M3y2/Jp/5GRjFdBreCUQXNh8tHTbf+avplRyO3mdzVktJQV45/srO9M7aiTSq0Fu
         hezb3T6udbf88W96wt+YfOJJ+NMGQfFHqXIdJGLcbILkeLG7yMObd1a70e1XAWRBxZ2l
         uct8yCqe3jd3pR1hO6K7dPqq69Ri1IrCg/b67uRL8UObS5iOm2LNMR2Ilg4YQy2Mhi0L
         4xZg==
X-Gm-Message-State: AOAM530EKQQtuEq8DyJEVexjuG/ksWvgax8a0cgznNh+YGuze+EQIdYx
        hNotxOB+XCQQGl2Yn8+hZ24=
X-Google-Smtp-Source: ABdhPJzZvX38bar/yqVJ5b1UDM5lXr2bcAsSsr7fngrhFgHxr7voDwbFNlw7WVWikWF0Tgv5dHcOTw==
X-Received: by 2002:a17:906:6b1a:: with SMTP id q26mr12507273ejr.185.1634375471820;
        Sat, 16 Oct 2021 02:11:11 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id o15sm5934723ejj.10.2021.10.16.02.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:11:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: use completions and clean rtw_cmd_thread()
Date:   Sat, 16 Oct 2021 11:10:39 +0200
Message-Id: <20211016091042.19614-1-fmdefrancesco@gmail.com>
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

Fabio M. De Francesco (3):
  staging: r8188eu: Use completions for signaling start and end of
    kthread
  staging: r8188eu: Use completions for signaling enqueueing of commands
  staging: r8188eu: Remove redundant 'if' statement

 drivers/staging/r8188eu/core/rtw_cmd.c    | 19 +++++++------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  5 +++--
 drivers/staging/r8188eu/os_dep/os_intfs.c |  8 +++++---
 3 files changed, 15 insertions(+), 17 deletions(-)

-- 
2.33.0

