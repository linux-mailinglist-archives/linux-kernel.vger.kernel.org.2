Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4FC324482
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 20:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbhBXTSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 14:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhBXTSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 14:18:05 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B49C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:17:25 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id o3so3524161oic.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I8Pi+N3izjvLgN9WH2B+20tIF94LSgSHMSIUFc4Ty8w=;
        b=SARxZf6g0HBHC74fcmKG4XIyoQrIdJHeIzfJS4Uu0lrB+H2fG4v/3UQfSF4MmXXRSF
         Cid7wLKki5Y+qVLMyZQTvB7a04R2PP9huqmtzYQwX04XdbgZ3sMXU2y82pkb3hxBtGW1
         xvRoh6IxMJFhI4K44E9joQLN1kGoDREF2KUZjPekCVKCl0WKZvjeHcWfu/1n9J/If3+s
         u67/kBxLg0gEm2aBmfRQSIbuDIlSfxvFm0aGfDnPPxQ3GZPZRVdaLQ4WxrlYTPsQET5k
         lAqK9aeQ1DBjs0SlD6OH9dhncGs4RnkNsBw4I1M04v+uqgJjnkZ9CKPrzGJDdIRlMVTy
         HisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I8Pi+N3izjvLgN9WH2B+20tIF94LSgSHMSIUFc4Ty8w=;
        b=g4tTptgI/cQjev8d+enUewj0jK1JuRc/Og1Qq2Lk9Zee0WQNL1l6nSOsUsVbV6eCKu
         q5WezRx2i851cAMvs8EZsdDavSiK2ay40ANf3OHguTpW+Na/+Vms3UObq0MNU64CJC85
         SnWMjU/qLorvj79tJZnEvCvZNh7TGIMFiXshsvUauQml1+c5P8uqesWeCZUXvCnZH1bA
         w1u8UaL0p0CojJZo5qAyCF2NvZzbQcPureZrj2Ayp7QsO7hfoM6eMoptQNB5vm4b8w/L
         Im7R/Z4stqfIuRQBTMDGw4pqJYG1o9rIMEcgv61XAoY4R+qG3zajpU8xaPXZeq0ha7Ee
         5+Jw==
X-Gm-Message-State: AOAM532bscE+C+W48qhfZ/XqgGFKGxqkb/NXzGof2zumcxOs93YxYl4d
        FY+PXj6PUkil0IoY6tIDTlr77w==
X-Google-Smtp-Source: ABdhPJxXMwpDIdouaiwB6M5ABCQNrEngwDXUvkUo+X1fy9IfVUb7bPHGFeWnkdBzdQrygyBntDwzrA==
X-Received: by 2002:aca:b286:: with SMTP id b128mr3751243oif.126.1614194245064;
        Wed, 24 Feb 2021 11:17:25 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h2sm575793otn.43.2021.02.24.11.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:17:24 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>
Subject: [GIT PULL] rpmsg updates for v5.12
Date:   Wed, 24 Feb 2021 13:17:23 -0600
Message-Id: <20210224191723.192631-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.12

for you to fetch changes up to 3e35772bc1e42287c8f4c70055deb5e3f5a3e8b5:

  rpmsg: glink: add include of header file (2021-01-05 22:22:40 -0600)

----------------------------------------------------------------
rpmsg updates for v5.12

This fixes two build issues in the GLINK driver and corrects some
kerneldoc in the same.

----------------------------------------------------------------
Alex Elder (2):
      rpmsg: glink: fix some kerneldoc comments
      rpmsg: glink: add include of header file

Bjorn Andersson (1):
      rpmsg: glink: Guard qcom_glink_ssr_notify() with correct config

 drivers/rpmsg/qcom_glink_ssr.c   | 17 +++++++++--------
 include/linux/rpmsg/qcom_glink.h |  8 ++++++--
 2 files changed, 15 insertions(+), 10 deletions(-)
