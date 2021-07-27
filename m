Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3BE3D806C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhG0VD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbhG0VDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:03:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36015C061388
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:02:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g13so24041244lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SRhrl1dY7Zmj23JZP8iHYjTGBi8o5s7C/ervl/2+lA=;
        b=ptZb+eA4iVbcRohF2UUIk+NGgmW17miPYMMAtuoyHkk/RXvYxAkOgE3XHUVCC/d3Pv
         Iu+njylV9VMKCA8vGo1/u2uIvYfAjkX3CyMdyYQCuid/Yuev7W/0c1T7yTj/C6N93Iai
         kXDMC2NrEtGA8VxFaliZsL8QP96xc6iiWd9q1330x+s/0rpOaRVUAMFcQLN5tzrnhrAp
         zGJC62rBkRzpp+oXqH9VpuZUNxLdyYtz+JPLqiIZ01kmQSPPasjD/qkrBRqyVB+BesuW
         oVpJew2q2i4l0AVQfYZubipT0hPwo0HtKNQiV02JH/Whbg9t532kLNXjvi6vlLJssiL7
         90bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SRhrl1dY7Zmj23JZP8iHYjTGBi8o5s7C/ervl/2+lA=;
        b=NswfdhaXFhyH7Ucjoa7x6q+kREDGN2R+KHT0SidhPgzW7YK/IIMba3OCWP20U9NEWu
         qwE3zS84HQDoI8CYXg5ut/n2R7ncockvVxzr8nf1iwdWjz0GvmMg2PdERB9RxtD8qtqf
         Idi2xLWlDrgMhBWeKvmr6Uai0HvfaXagWqCNYpPWnGpCm1H+jaC2nSyNzae9mjNj4Rh/
         cVFUoo2j3HH8dSraXob9/PldSDSWrrRprLhCGQ3/HsE530nTUAQrbX1gkogZQyA8Y6Xf
         xpXzG22J93Mhii3R6NuYz7zXV7ZDyyxNqmi5CM+JLzEAcnf3tJJP8QYN5VVMFdJPyZnl
         Svkg==
X-Gm-Message-State: AOAM53284ozcXCNa2yc6CrCCQpIzAU+tOjwig6WP7OdaN+heYzpBBvtU
        aSAQPhBhhATLWlV2PptSPpwTDQ==
X-Google-Smtp-Source: ABdhPJxfxipZuDA/TpSp2Sn/kaywKOku9ZKbI4xJSyoOwXsZ1bj5O6tSQsb0eET9PTXPIhdd/FZqPw==
X-Received: by 2002:ac2:5933:: with SMTP id v19mr18426066lfi.85.1627419774543;
        Tue, 27 Jul 2021 14:02:54 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m5sm355680ljq.22.2021.07.27.14.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:02:53 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: PM: add two device managed helpers
Date:   Wed, 28 Jul 2021 00:02:00 +0300
Message-Id: <20210727210202.717181-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm clock controller code (and most probably other drivers) would
benefit from having devres helpers for pm_runtime_enable() and
pm_clk_create(). Add those two helpers.

----------------------------------------------------------------
Dmitry Baryshkov (2):
      PM: runtime: add devm_pm_runtime_enable helper
      PM: clk: add devm_pm_clk_create helper

 drivers/base/power/clock_ops.c | 17 +++++++++++++++++
 drivers/base/power/runtime.c   | 17 +++++++++++++++++
 include/linux/pm_clock.h       |  5 +++++
 include/linux/pm_runtime.h     |  4 ++++
 4 files changed, 43 insertions(+)


