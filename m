Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7640436BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhJUUAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 16:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhJUUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:00:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9090C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:58:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ls18so1298645pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HtAnGb9XvJP+SUKtVNc4/aYf5/Kl26imun3S9nDbKeo=;
        b=qeWR2w7jUQwHd/Sf/jNXm6upvsSuphLttWjerFG8fsYDXifng/VYjAFD0r/W7dtlWl
         wLL9TX0UKjsYyinNj58nCHIpPDxTcRGVeEihR5L0+5dfk6aSUfzn8B87jQqb059Zr/DB
         T2pWhtmJIXSYArsUCQEGI7JLdFGmUttQWmxyZBWYhkgx9p/dzrDs9gpReEznVBaoYm+Q
         e551KCBCiuS7NOb2UHKMxIB6sc2lU0ZoRn+drnoe8f6H9eE1QyW2Jv4fgEWmkskHDP++
         p3nuQjOBHU4qw6yXWg8SvFd3YHN16piL6SU8Ze+p2PV0NVgMPvFQFYR0Nu9x3/mcbeOA
         OCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HtAnGb9XvJP+SUKtVNc4/aYf5/Kl26imun3S9nDbKeo=;
        b=W59oL0OEpWGPE2PKGBz+21lr5dCOREdoXZXz/kD4eQHGAcxpI+QmXehIUgHIpYIgzd
         YUHf3PvXssPQhAp0DBznrfpWZUyTzFOJ2cakRfB+JnjD6t4l1j+YpojXFaL3VZoZhMxE
         bLtXVlmhvRCxmXhlUxEgdLU29ph16Wm21fBgKWU/HvljTb2UzF49YTAKp6Ss+K1KeeHE
         QnOx4Tv1HelyEJyuuWgXBdOk8QTW7vlFNDmKPh8Kl4FRfUJYMLfufVf4Mz2+XpKgzBAS
         xiibhWff4VVteRQTAIAwouYDkRI9U8fGThKtH5jRk1xvan34QJLSaAt0Vt0F6sWGpaFI
         iBUg==
X-Gm-Message-State: AOAM530Ackficra29FC1Wc3lN30dvqSadzHnLg8/Cu7rB3bZXaPOWVLS
        YinO/Av0pp61xobVldOnEko=
X-Google-Smtp-Source: ABdhPJz01i1ABc8WWSYIUSF7MS3R4eN6tYdC8edzLdQD2c8THGdZzSKi2kjM+2UsexItK3Tzpdeq1g==
X-Received: by 2002:a17:902:c40b:b0:13f:68f:6750 with SMTP id k11-20020a170902c40b00b0013f068f6750mr7099779plk.58.1634846308278;
        Thu, 21 Oct 2021 12:58:28 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1fee:e3e7:7dfb:56c1:efef:3c0f])
        by smtp.googlemail.com with ESMTPSA id v9sm7198898pfc.23.2021.10.21.12.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:58:27 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     fabioaiuto83@gmail.com, kushalkothari285@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 0/4] staging: rtl8723bs: core: Cleanup patchset for style issues in rtw_cmd.c
Date:   Fri, 22 Oct 2021 01:27:49 +0530
Message-Id: <cover.1634845504.git.kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches make changes to clean up style issues identified
by checkpatch. 

Kushal Kothari (4):
  staging: rtl8723bs: core: Remove true and false comparison
  staging: rtl8723bs: core: Remove unnecessary parentheses
  staging: rtl8723bs: core: Remove unnecessary space after a cast
  staging: rtl8723bs: core: Remove unnecessary blank lines

 drivers/staging/rtl8723bs/core/rtw_cmd.c | 75 +++++++++++-------------
 1 file changed, 35 insertions(+), 40 deletions(-)

-- 
2.25.1

