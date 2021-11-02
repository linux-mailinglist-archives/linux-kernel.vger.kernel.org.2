Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D643443A0D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhKBXzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhKBXyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:54:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DDDC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 16:52:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y20so545549pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 16:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6UQroqUYGrr3QJudzaw6yU4iYpr07JScEfScZXkT+UQ=;
        b=IPdFYP2AyCzzjQhudRVvUZQ+/SAentjIBNjA1o9mRfK1gt1G3CYaffPElFKNIIfcl/
         WaDUhR0f+idyQvzNgKaDM+QkWZNGcos34w/J3BBL5DLNMsLwzdjd0f9DFeS0RPWokcDb
         1lDYAS3J/VohAT7jV+WaZQa6rHmB52JgEVkqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6UQroqUYGrr3QJudzaw6yU4iYpr07JScEfScZXkT+UQ=;
        b=5m15ZGpOzcSk+7MrGUUxFDOWJ7jDV+f5bOsiJvX20OG2fVqk5mLrj2huvV1tWgnlL/
         ItRufKI079Bn5ouOvn+9ujNVZ2BH1mLSCdB/8BbY+iNWzMopEEX1+9xZUzev9+BBc8nh
         7VjtJ2ynI4/yidzDcf1slzsWmptXAl3RtPRFW4z7/QFeaH8v8sJ95jYm2g6Jv35q1V9A
         QsHbe/K1gwXYRmoUZezR8pvQqI1BZ8k6+U8sO8Yj1YdAYXqkZuFOqF94oDvR9IGaL3Wm
         99zK5G6BojLnMoNWm+b4Yx2BTL4lwQPGr31OfX8xxOsN03yj8kducs2Dkqk4tqeJW7dk
         gODQ==
X-Gm-Message-State: AOAM533nbul6q1YO0uoKe0XJQJfOoCOnWOW04xqIWhjOyr/uUxi9T8aK
        uB9C3ohoihPe7E3fRA9W2z/P5w==
X-Google-Smtp-Source: ABdhPJxyMhVeuKF42P9cfTErk6OuOI4qow1gw/KJl6Tb6Ve2xhsLm2wmaY+gee6fTO32o9lMf8bsHA==
X-Received: by 2002:a05:6a00:8c7:b0:44c:a7f9:d8d1 with SMTP id s7-20020a056a0008c700b0044ca7f9d8d1mr39918248pfu.49.1635897138571;
        Tue, 02 Nov 2021 16:52:18 -0700 (PDT)
Received: from sujitka-glaptop.hsd1.ca.comcast.net ([2601:646:8e00:b2f0:c31d:1b47:2691:7a67])
        by smtp.gmail.com with ESMTPSA id z73sm176381pgz.23.2021.11.02.16.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 16:52:18 -0700 (PDT)
From:   Sujit Kautkar <sujitka@chromium.org>
To:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v3 0/2] Fix two kernel warnings in glink driver
Date:   Tue,  2 Nov 2021 16:51:47 -0700
Message-Id: <20211102235147.872921-1-sujitka@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes addresses kernel warnings which shows up after enabling
debug kernel. First one fixes use-after-free warning and second fixes
warning by updating cdev APIs

Changes in v3:
- Clear ept pointers in patch 1
- Remove error check in patch 2

Changes in v2:
- Fix typo in commit message

Sujit Kautkar (2):
  rpmsg: glink: Fix use-after-free in qcom_glink_rpdev_release()
  rpmsg: glink: Update cdev add/del API in
    rpmsg_ctrldev_release_device()

 drivers/rpmsg/qcom_glink_native.c | 12 ++++++++++--
 drivers/rpmsg/rpmsg_char.c        | 10 ++--------
 2 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.31.0

