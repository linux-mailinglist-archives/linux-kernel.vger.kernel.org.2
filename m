Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016D135620F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344524AbhDGDpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbhDGDpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:45:09 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A8BC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 20:45:00 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g14so11197357qtu.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 20:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WkPRAEKQwKtnKMqu+pBgPjyw5DvsfDt17v5kQaXECno=;
        b=b3hmtr0mw+jBDREyzsEDnRIFrjnQfCM8VR/IjvFXjuEZz4w6r2IRdsMxZH49khr2RD
         5WwYe7quHcUdiOSy/KWLDMwRqD0vFXSi8ztr+FkWz/VX8/A5ZS0ZuqoHIfcoSnuAqPm7
         kEyqCN8szv/ubiygRj/axiDFXbfHzd4NwMEWm1JjEDk/uhxMn6DSzC98h6iZlzF17Fsj
         oG5W7m7It+bxYx9FTznk99aUHU0oiJd4BO+N4cfTO23HWrTUnwKEWcL0fIkkYpvNL+yX
         rU97YriUkQT26DRsWrkUOsdBSBWPAi6KlMN0aFwWKslQ1qBLESXDC/utQxE8fJPxDi3H
         eGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WkPRAEKQwKtnKMqu+pBgPjyw5DvsfDt17v5kQaXECno=;
        b=UzZDIbUACAF6BJ/SiT94MLwdXcuHVm+cW/F2V3dYMpjFuXVda8b+KRDNyiSTlBj7Rq
         e0iUxROVeBZkm3PLatnPoA2A5165fU8x+D8AXicfy1jez6S2cK5wrCv4O9Or93JnuJtJ
         h9ayFjrevkQqTMcepSwnxUFnhc9C/8BAn5GcWCAQpzZaCPIhqfcmnpJEQVApJJITbqcO
         MNa6lW7AHL/y3XyvzDpTMGfSIiNt7DjLMcM+Sak2cHWc+3QFRQD5xiIc8AuSeFXsietF
         /6rSyrZ8etWJS+6nIXTCpQcqFkbX5akK7qhFHHZS5THTcpvGv//gNE1vL1GYABtgMyWV
         8cYA==
X-Gm-Message-State: AOAM533g3rBOWxaF8YzeuaAsULzd348ZZaKrhP5nM6UYkkfNFEIX75JF
        J7cPoH45h0eIObbtX/nLLEwTiR6lS2PWNvE=
X-Google-Smtp-Source: ABdhPJx3Jno6k4W07F4UPLHx0TiI197HKqsvqb4jQdJbWHhWyYmsZG713G5LM/frA1Z6dd30fNEYKaC3y/mgWmc=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:2dae:f92:7d76:4244])
 (user=saravanak job=sendgmr) by 2002:a0c:a5a5:: with SMTP id
 z34mr1731742qvz.4.1617767099615; Tue, 06 Apr 2021 20:44:59 -0700 (PDT)
Date:   Tue,  6 Apr 2021 20:44:53 -0700
Message-Id: <20210407034456.516204-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v1 0/2] Add sync_state() support to clock framework
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

We can decide later if both these patches land through clk tree or the
driver-core tree. The meat of the series is in Patch 2/2 and that commit
text gives all the details.

Saravana Kannan (2):
  driver core: Add dev_set_drv_sync_state()
  clk: Add support for sync_state()

 drivers/clk/clk.c            | 84 +++++++++++++++++++++++++++++++++++-
 include/linux/clk-provider.h |  1 +
 include/linux/device.h       | 12 ++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

-- 
2.31.1.295.g9ea45b61b8-goog

